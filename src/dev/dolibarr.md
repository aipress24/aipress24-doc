
# Aipress24 <-> Dolibarr Integration Plan


This document outlines the planned integration strategy for connecting Aipress24 with Dolibarr ERP. The primary goal is to establish Dolibarr as the central system for accounting, invoicing, and financial reporting. The integration will initially focus on utilizing the PSP (currently Stripe) for payment processing, with the intention to incorporate GNU Taler as an additional payment option in the future.

The "Taler" part of this document is tentative, and will be refined if/when the decision to use Taler is taken.

## Goals

*   **Centralized Accounting:** Utilize Dolibarr ERP to track all financial transactions, including payments, subscriptions, and potential refunds.
*   **Automated Invoicing:** Automatically generate invoices in Dolibarr for all transactions.
*   **Payment Reconciliation:** Accurately reconcile payments received through the PSP with corresponding invoices in Dolibarr.
*   **Future-Proof Architecture:** Design the integration with the flexibility to accommodate additional payment methods, specifically GNU Taler, in the future.
*   **User-Friendly Experience:** Provide a clear and intuitive payment experience for users on Aipress24.
*   **Real-time Synchronization (Future Goal):** Implement near real-time synchronization of relevant data between Aipress24 and Dolibarr to ensure data consistency.

## Deliverables (Planned)

*   **Fully synchronized system:** Payment, customer, and invoice data are consistently synchronized between Aipress24 and Dolibarr (initially with current PSP, and later with Taler).
*   **Automated invoice generation:** Invoices are automatically created in Dolibarr for all transactions.
*   **Support for Taler payments (Future):** Taler payments are properly recorded and reconciled in Dolibarr.
*   **Automated monthly invoice generation for recurring services with payment links via the current PSP, and potentially Taler in the future.**
*   **Clear documentation:** Comprehensive documentation of the integration process, including API usage, data mapping, and synchronization logic.

## Payment Methods

Aipress24 will initially support payments through:

1. **The PSP (currently Stripe):** For traditional online payments using credit cards, debit cards, and other methods supported by the PSP.

**Future Integration:**

2. **GNU Taler:** For privacy-preserving electronic cash payments.

## Integration Architecture (Planned)

The integration will involve a bi-directional data flow between Aipress24 and Dolibarr, with an initial focus on interactions with the current PSP. Future integration will add interactions with a GNU Taler exchange.

### 1. Aipress24 to Dolibarr

*   **Third-Party Synchronization (Customers and Partners):**
    *   **Trigger:** When a new user registers on Aipress24 or an existing user updates their profile, and is identified as a customer or partner.
    *   **Action:** Aipress24 will use the Dolibarr REST API to create or update the corresponding third-party record in Dolibarr.
    *   **Data:** Name, address, contact information, company details (if applicable), and any other relevant information collected during registration.
    *   **Methodology:** Using the `uplink` library in Python (https://pypi.org/project/uplink/ - or something similar), making direct calls to the Dolibarr API endpoints for third-party management.
    *   **Frequency:**  Initially batch (e.g., nightly), with a future goal of real-time or near real-time.
*   **Order Synchronization:**
    *   **Trigger:** When a user completes a purchase on Aipress24 (initially via The PSP (currently Stripe)).
    *   **Action:** Aipress24 will create a corresponding order record in Dolibarr, including details about the purchased items, quantities, prices, discounts, and payment method.
    *   **Data:** Order ID, Customer ID (Third Party), Order Date, Total Amount, Payment Method (initially just Stripe), individual items with quantities and prices.
    *   **Methodology:** Using `uplink` to interact with the Dolibarr API endpoints for order management.
    *   **Frequency:** Initially batch, with a future goal of real-time or near real-time.
*   **Invoice Creation:**
    * **Trigger:** When a new order is created in Dolibarr based on information received from Aipress24.
    * **Action:** Dolibarr will generate a corresponding invoice based on the order data.
    * **Data:** Information from the corresponding order in Dolibarr.
    * **Methodology:** Dolibarr's internal invoice generation process.
    * **Frequency:** Immediately after order creation in Dolibarr.

### 2. The PSP to Dolibarr

*   **Invoice Synchronization:**
    *   **Trigger:** A successful payment is processed through the PSP (currently Stripe).
    *   **Action:** A cron job (running on the Aipress24 server) will periodically retrieve new invoices from the Stripe API and import them into Dolibarr.
    *   **Data:** Invoice ID, Customer ID, Amount, Date, Status, Line Items.
    *   **Methodology:** Using the Stripe API to fetch invoices and the Dolibarr API (`uplink`) to create corresponding invoices.
    *   **Frequency:** Batch (e.g., nightly).
*   **Payment Synchronization:**
    *   **Trigger:** A successful payment is processed through the PSP (currently Stripe).
    *   **Action:** Similar to invoice synchronization, a cron job will retrieve payment records from Stripe and import them into Dolibarr, linking them to the corresponding invoices.
    *   **Data:** Payment ID, Invoice ID, Amount, Date, Status.
    *   **Methodology:** Using the Stripe API to fetch payments and the Dolibarr API (`uplink`) to create corresponding payment records.
    *   **Frequency:** Batch (e.g., nightly).

### 3. GNU Taler to Aipress24 (Future)

*   **Payment Confirmation:**
    *   **Trigger:** A user initiates a payment through their Taler wallet.
    *   **Action:** The Taler exchange will notify Aipress24 (via a webhook) when the payment is confirmed.
    *   **Data:** Payment reference, amount, exchange rate, timestamp.
    *   **Methodology:** Integration with the Taler exchange's API using webhooks.
    *   **Frequency:** Real-time.
*   **Refund Handling:** Due to the nature of Taler, refunds will need to be handled on a policy-based approach, potentially involving manual intervention or store credit. There is no direct refund mechanism via Taler.

### 4. Dolibarr to Aipress24

*   **Invoice PDF Access:**
    *   **Trigger:** A user requests to view an invoice on Aipress24.
    *   **Action:** Aipress24 will fetch the corresponding invoice PDF from Dolibarr and display it to the user.
    *   **Data:** Invoice ID.
    *   **Methodology:** Using `uplink` to interact with the Dolibarr API, retrieving the invoice PDF based on its ID.
    *   **Frequency:** On-demand.

## Technical Considerations

*   **API Client:** Instead of relying on Swagger/OpenAPI auto-generated clients, we will use the `uplink` (https://pypi.org/project/uplink/) library in Python for direct interaction with the Dolibarr REST API. This provides more control and avoids the issues encountered with the auto-generated code. (Alternatively, we could use: https://github.com/JonBendtsen/dolibarrpy).
*   **API Key:** A dedicated API key (e.g., `x05OAJiux23K4c`) will be used for secure authentication with the Dolibarr API.  The key will be provided via a secret management system and and environment variable.
*   **Error Handling:** Robust error handling and logging will be implemented to ensure data integrity and to quickly identify and resolve any synchronization issues.
*   **Data Validation:** Data validation will be performed on both sides (Aipress24 and Dolibarr) to ensure data consistency and prevent errors.
*   **Security:** All API communication will be secured using HTTPS.
*   **Exchange Rate Handling (Future):** For future Taler transactions, the exact exchange rate used by the Taler exchange will be recorded in both Aipress24 and Dolibarr for accurate accounting (TBC).

## Future Evolutions

*   **GNU Taler Integration:** Implementing full support for GNU Taler payments, including payment processing, exchange rate handling, and reconciliation in Dolibarr.
*   **Automated Reconciliation:** Implementing a system for automatically reconciling payments received through all payment methods with their corresponding invoices in Dolibarr.
*   **Advanced Reporting:** Developing custom reports in Dolibarr to provide insights into sales, revenue, and payment trends, segmented by payment method.
*   **Real-time Synchronization:** Transitioning from batch synchronization to real-time or near real-time synchronization for a more dynamic and responsive system. (But it is necessary?)
