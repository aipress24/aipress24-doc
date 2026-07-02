# Financial integration

Aipress24 handles payments, subscriptions and invoicing through **Stripe**. The integration lives in `app/services/stripe/` (client, products, prices, customers, reconciliation) and `app/modules/stripe/` (the webhook endpoint), with the subscription funnel and billing UI in `app/modules/bw/bw_activation/`.

All money flows are gated by the `STRIPE_LIVE_ENABLED` flag: when it is off (development, tests, recette), a local simulation stands in for Stripe Checkout so the funnels can be exercised end to end without a real payment.

## Payment flows

There are two Stripe Checkout flows:

- **Subscriptions** — Business Wall activation opens a Stripe Checkout Session in `subscription` mode, with automatic tax (`automatic_tax`) and B2B billing collection (billing address and VAT number, mirrored onto the organisation). The Stripe customer is reused via the organisation's `stripe_customer_id`, or created from the paying party's email.
- **One-off purchases** — the article products (consultation right, gifted consultation, proof of publication, reproduction-rights transfer) open a Checkout Session in `payment` mode.

In both cases the local record is *not* considered paid until Stripe confirms it: the `checkout.session.completed` webhook is the authoritative activation/finalisation path in live mode (a purchase or a Business Wall never self-activates synchronously).

## Products and pricing

Business Wall products and prices are defined in the **Stripe dashboard** (identified by `metadata`, e.g. `domain=bw` and a product `reference`) and synchronised into local `stripe_*` tables — no price is hard-coded in the application (`app/services/stripe/product.py`, `prices.py`, `app/modules/bw/bw_activation/bw_product.py`).

- Headcount-based products (Leaders & Experts, Transformers) carry a `metadata.maximum` ceiling; the cheapest tier covering the declared headcount is selected (`Solo` / `TPE` / `PME` / `ETI` / `GE`).
- The PR product (`BW4PR`) is **tiered by number of clients**, recalculated as partnerships are declared and validated.
- Free Business Wall types still go through Stripe as a €0 subscription in live mode.

## Webhooks and subscription lifecycle

The webhook endpoint (`app/modules/stripe/views/webhook.py`) handles, among others:

- `checkout.session.completed` — activates the Business Wall / finalises the purchase;
- `invoice.payment_succeeded` — marks the local `Subscription` `active` (and reactivates a `suspended` Business Wall);
- `invoice.payment_failed` — moves the subscription to `past_due`.

The lifecycle logic (`app/services/stripe/subscription_lifecycle.py`) applies a **grace period** (`SUBSCRIPTION_GRACE_DAYS`, currently 7 days) covering Stripe's dunning retries; beyond it, the Business Wall is **suspended** until a payment succeeds. Subscription statuses: `pending → active → past_due → cancelled / expired`.

## Invoicing

For subscriptions, **Stripe generates and hosts the invoices**. The application:

- exposes the **Stripe billing portal** so customers can update their payment method, download their invoices and cancel a subscription (`app/modules/bw/bw_activation/routes/billing_portal.py`) — cancelling a paid subscription in live mode goes through this portal to actually stop billing;
- retrieves a Stripe invoice and its hosted URL on demand (`app/services/stripe/retriever.py::retrieve_invoice`, `latest_invoice_url`);
- reconciles local `Subscription` records against Stripe's view to detect drift (`app/services/stripe/reconciliation.py`, `flask stripe reconcile`-style commands).

### Local invoicing model

The application also has its own lightweight invoicing model (`app/services/invoicing/` — `Invoice` / `InvoiceLine`) surfaced by the **Work › Ventes / Facturation** page (`app/modules/wip/views/billing.py`, "Mon historique de ventes"), which lists invoices with **PDF** (`app/services/pdf/invoice.py`) and **CSV** downloads.

!!! note
    Today this local model is populated only by the fake-data generator (`app/faker/_scripts/invoices.py`), and the generated PDF carries placeholder billing details — treat it as a **demonstration surface**, not a real accounting record. The authoritative billing artefacts are the Stripe invoices above.

## Editorial sales and purchases

Separately from invoices, individual editorial transactions are recorded as `ArticlePurchase` rows (consultation, gift, justificatif, cession) and aggregated into the user-facing **Work › Ventes** (author side) and **Work › Achats** (buyer side) registers, in net amounts. These reflect the outcome of the Stripe purchase flow above; see [Monetisation & rights](../user/fr/monetisation.md) in the user guide for the functional view.

## Possible future direction: an accounting/ERP integration

An earlier design considered pushing customers, orders, payments and invoices into an external **ERP/accounting system** (Dolibarr) — with the PSP (Stripe) as the source of payment data and GNU Taler as a possible privacy-preserving payment method later. This has **not** been implemented (there is no Dolibarr client, `uplink` dependency or Taler code in the codebase); it is recorded here only as a candidate direction should centralised accounting become a requirement.
