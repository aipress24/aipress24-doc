# API

AIpress24 exposes a **versioned, OpenAPI-documented, token-authenticated public REST API** at `/api/v1`, meant for third-party integrations (publishing tools, newsroom systems, PR/agency back-offices, dashboards). It is the "interesting" API and the subject of most of this page.

It sits alongside two much smaller, internal surfaces — a session-authenticated `/api` blueprint that only backs the front-end, and the webhook/media/CLI entry points — described briefly [at the end](#internal-and-other-entry-points).

!!! tip "Interactive reference"
    - **[API reference](api-explorer/index.html)** — the reference, grouped by subdomain (rendered with [Redoc](https://github.com/Redocly/redoc)). A [Swagger UI view](api-explorer/swagger.html) of the same spec — with "Try it out" against production — is also available.
    - **[`openapi.json`](api-explorer/openapi.json)** — the raw OpenAPI 3 document (also served live at `https://aipress24.com/api/v1/openapi.json`).
    - Each running instance also serves Swagger UI at `/api/v1/docs` and ReDoc at `/api/v1/redoc`.

## The public API (`/api/v1`)

| Concern | Choice |
|---|---|
| Base URL | `https://aipress24.com/api/v1` |
| Framework | [flask-smorest](https://flask-smorest.readthedocs.io/) (marshmallow + webargs + apispec) |
| Spec | OpenAPI 3.0.3 at `/api/v1/openapi.json` |
| Authentication | `Authorization: Bearer <token>` — no session, no cookies, no CSRF |
| Format | JSON; UTF-8; ISO-8601 datetimes |
| Serialization | **Allowlist** schemas — every field is explicit, so PII is redacted by omission |
| Pagination | `offset`/`limit`, wrapped in a `{ items, total, count, limit, offset, _links }` envelope |
| Hypermedia | HAL-style `_links` on every payload; a discovery entry point at `/api/v1/` |
| Errors | Consistent JSON envelope, scoped to `/api/v1` only |

The module is deliberately isolated: it depends on the business modules but nothing depends on it (enforced by an import-linter contract). See `app/modules/api_v1/` and its `README.md` in the application repository.

### The governing principle: parity with the UI

A token authenticates **as its user**. The API returns and accepts exactly what that user could obtain or do by logging into the web UI — **no more, no less**. It is never a side door onto data a user could not otherwise reach (including drafts, private items and paywalled "for sale" bodies).

This holds because the API **delegates every access decision to the domain** rather than re-deriving it: the same visibility predicate the website and search use gates reads, and the same authorization checks the newsroom/press-room enforce gate writes. The API cannot drift from the product.

### Authentication

Every request (except the public discovery root) must carry a bearer token:

```http
GET /api/v1/articles HTTP/1.1
Host: aipress24.com
Authorization: Bearer a24_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Tokens are dedicated `ApiToken` records — **SHA-256 hashed** at rest (only a `a24_…` prefix is retained for identification), **scoped**, and **expirable/revocable**. They are minted from the CLI; the secret is shown once:

```bash
flask api-token issue \
    --email editor@example.com \
    --name "Acme integration" \
    --scopes read:content,write:content \
    --expires-days 365
# → prints the secret once; store it safely
flask api-token list
flask api-token revoke <id>
```

A missing/invalid/expired/revoked token yields `401`; a valid token lacking the required scope yields `403`.

#### Scopes

| Scope | Grants |
|---|---|
| `read:content` | articles, press releases, events |
| `read:organisations` | organisations, Business Walls |
| `read:directory` | member profiles |
| `read:self` | the token owner's own private data (`/me`) |
| `write:content` | author & publish the owner's own content |

### Resources

#### Public read tier

Published / active / listable content, redacted to what any authenticated user may see. Each collection offers `GET /{collection}` (paginated) and `GET /{collection}/{id}`.

| Collection | Scope | Contents |
|---|---|---|
| `articles` | `read:content` | published articles (paywalled bodies truncated for non-entitled tokens) |
| `press-releases` | `read:content` | published press releases |
| `events` | `read:content` | published events |
| `organisations` | `read:organisations` | active organisations |
| `business-walls` | `read:organisations` | active Business Walls (public org pages) |
| `members` | `read:directory` | listable member profiles (contact details redacted) |

#### Owner-scoped tier (`/me`)

The token *is* the identity — there is no id in the path. These serve the caller's **own** records, in **any status including drafts**, and 404 (never disclose) anything owned by someone else. Gated by `read:self` (reads) and `write:content` (writes).

| Path | Read | Write |
|---|---|---|
| `/me` | own profile (fuller than the public card) | — |
| `/me/articles` | own articles | ✅ create/update/publish/unpublish/delete |
| `/me/press-releases` | own press releases | ✅ create/update/publish/unpublish/delete |
| `/me/events` | own events | ✅ create/update/publish/unpublish/delete |
| `/me/enquiry-notices` | own *avis d'enquête* | — |
| `/me/missions`, `/me/projects`, `/me/jobs`, `/me/products` | own marketplace items | — |

### Writing & publishing content

An organisation (a press outlet, a PR agency) can author and publish its own content through the API to earn the same visibility and monetization it would via the portal. Each type has `POST /me/{coll}` (create draft), `PATCH`/`DELETE /me/{coll}/{id}`, and `POST …/{id}/publish` | `/unpublish`.

Who may author, and on whose behalf, mirrors the web application exactly:

| Content | Author gate | Attribution |
|---|---|---|
| **press releases** | communications / expert / academic / transformer roles (or a mandated PR manager) | own organisation **or a client org** (agency partnership / delegated PR-manager role) |
| **articles** | journalists (`PRESS_MEDIA`) only | **own organisation only** — no on-behalf path |
| **events** | as press releases (journalists included), plus the `EVENTS` mission for delegated PR managers | own organisation **or a client org** |

Publishing runs the domain's own state machine and signals, so an API publish is indistinguishable from a UI publish — it produces the same public mirror, search index entry and rights/monetization snapshot. A few consequences worth knowing:

- **Publication validation** is enforced server-side: a press release/article needs a non-empty title and body; an event additionally needs start/end times (end ≥ start). Violations return `422` with a message.
- **On-behalf publishing** requires the caller to be entitled to the target organisation *and* to hold the relevant content-type mission there when acting as a delegated PR manager; otherwise `403`.
- **Monetization is automatic and platform-controlled**: a published item is monetizable via the consultation paywall (priced by genre taxonomy at the platform level). The API sets no prices and collects no payment account.
- Only the HTML **body** is sanitized server-side; titles are stored verbatim and rendered escaped, as in the UI.

### Hypermedia & pagination

Every payload carries HAL-style `_links`, and collections are wrapped in an envelope:

```json
{
  "items": [ { "id": 42, "title": "…", "_links": { "self": { "href": "/api/v1/articles/42" } } } ],
  "total": 137,
  "count": 20,
  "limit": 20,
  "offset": 0,
  "_links": {
    "self":  { "href": "/api/v1/articles?limit=20&offset=0" },
    "first": { "href": "/api/v1/articles?limit=20&offset=0" },
    "next":  { "href": "/api/v1/articles?limit=20&offset=20" }
  }
}
```

`limit` defaults to 20 and is capped at 100. `GET /api/v1/` is a public discovery document linking to every collection and to the docs.

### Errors

Errors are a consistent JSON envelope (scoped to `/api/v1`; the HTML site is untouched):

```json
{ "code": 403, "status": "Forbidden", "message": "This token lacks the required scope: write:content." }
```

| Status | Meaning |
|---|---|
| `401` | missing / invalid / expired / revoked token |
| `403` | valid token, but insufficient scope or authorization |
| `404` | not found — also returned for another user's row (existence is not disclosed) |
| `422` | validation error (bad input, or a refused publish transition) |

### Quickstart

```bash
BASE=https://aipress24.com/api/v1
AUTH="Authorization: Bearer $AIPRESS24_TOKEN"

# 1. Discover the API (no token needed)
curl -s $BASE/

# 2. List published articles
curl -s -H "$AUTH" "$BASE/articles?limit=5"

# 3. Create a press-release draft, then publish it
id=$(curl -s -H "$AUTH" -H 'Content-Type: application/json' \
      -d '{"titre": "Acme launches …", "contenu": "<p>Full text…</p>"}' \
      "$BASE/me/press-releases" | python -c 'import sys,json;print(json.load(sys.stdin)["id"])')

curl -s -X POST -H "$AUTH" "$BASE/me/press-releases/$id/publish"
```

### Python SDK

A dependency-free (stdlib-only) Python client lives in the application repository at `sdk/python/` (`aipress24_client`). Its typed models and collection map are **generated from the OpenAPI spec** (`make api-sdk`), with a CI drift check, so the client cannot fall out of sync with the API.

```python
from aipress24_client import Client

client = Client("https://aipress24.com/api/v1", token="a24_…")
for article in client.articles.list(limit=20)["items"]:
    print(article["title"])
```

## Internal and other entry points

These are intentionally minimal and **not** part of the public integration surface.

### The `/api` blueprint (`app/modules/api`)

A session-cookie-authenticated blueprint that only backs HTMX/JavaScript interactions in the front-end — e.g. the **like** widget and **Trix** rich-text image uploads. It is not versioned, not documented for third parties, and ignores bearer tokens.

### Webhooks, media & CLI

- **Stripe webhooks** (`app/modules/stripe`) — the authoritative activation path in live mode (Business Wall activation, article purchases, subscription lifecycle).
- **Media serving** (`app/modules/media`) — `GET /media/<sha256>` serves content-addressed files behind authentication, with aggressive caching.
- **CLI** — many operations are `flask …` commands (bootstrap, fake data, search index, marketplace auto-close, reputation, stats, `api-token`…), registered through flask-super.

!!! note "Adding machine-facing endpoints"
    New third-party-facing endpoints belong in `app/modules/api_v1` (a scoped, allowlist-serialized, token-authenticated resource that delegates its access decisions to the domain), **not** in the session-authenticated `/api` blueprint.
