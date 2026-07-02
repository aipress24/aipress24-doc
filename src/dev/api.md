# API

Aipress24 is primarily a **server-rendered, hypermedia-driven** application: most interactions happen through Jinja2-rendered pages, HTMX fragments and PyWire components rather than a public REST API. There is, however, a small **internal HTTP API** used by the front-end, plus webhook and CLI entry points.

## The `/api` blueprint (`app/modules/api`)

Mounted under `/api`, this blueprint backs a few HTMX/JavaScript interactions and requires an authenticated session (`check_auth`):

- **Likes** — `GET /api/likes/<cls>/<id>` renders the like widget for an object, and a companion action toggles the like state (used by the social bar on cards and detail pages).
- **Trix blob upload** — `POST` endpoint (`upload_blob`) receiving images pasted or dropped into the Trix rich-text editor, storing them via the blob/media backend and returning the URL to embed.

## Other server entry points

- **Stripe webhooks** (`app/modules/stripe`) — receive `checkout.session.completed`, invoice and subscription events that drive Business Wall activation, article purchases and subscription lifecycle. This is the authoritative activation path in live mode.
- **Media serving** (`app/modules/media`) — `GET /media/<sha256>` serves content-addressed files (images, PDFs…) from the storage backend, behind authentication and with aggressive caching.
- **CLI** — many operations are exposed as `flask …` commands (bootstrap, fake data, search index, marketplace auto-close, reputation, stats…), registered through flask-super.

!!! note
    There is currently no versioned, documented public REST API for third-party integrations. New machine-facing endpoints should be added to the `api` module (or a dedicated blueprint) with explicit authentication.
