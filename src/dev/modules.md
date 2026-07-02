# Modules

The Aipress24 application is structured into modules, each responsible for a specific set of features or functionalities. This modular design promotes code organization, maintainability, and reusability. Modules are located in the `src/app/modules` directory.

Each module typically integrates its own:

- Data model (SQLAlchemy 2.0 models), except for the shared content model.
- Views — Flask **blueprints** plus, for CRUD-heavy modules, **flask-classful** class-based views (`app/modules/wip/crud/cbvs/`).
- Templates (Jinja2, partial rendering via jinja2-fragments).
- UI components (PyWire / flask-super, auto-discovered from `components/`).

Modules are auto-discovered and registered as Flask blueprints, and their navigation entry is declared via `configure_nav(...)` in the module's `__init__.py`.

## Naming Conventions

*   Modules are named in lowercase with underscores (e.g. `swork`, `kyc`).
*   The code names differ from the UI portal names. The mapping is:

| Code module | UI portal |
|---|---|
| `wire` | News |
| `swork` | Social |
| `wip` | Work |
| `biz` | Marketplace |
| `events` | Events (Événements) |
| `search` | Search (Rechercher) |
| `bw` | Business Wall |

## Key Modules

Here's a description of some of the most important modules:

*   **`wire` (News):** The news feed — articles and press releases, with tabs, filters, comments, likes, and the reader-side monetisation (paywall, gifted consultations, proofs, rights transfers). Components like `PostCard` and `Carousel`.
*   **`swork` (Social):** The social network — the Wall (short posts), members directory, organisation pages, groups, and the follow graph. Models for posts, groups and relationships; the `members_list` component and its filters.
*   **`wip` (Work):** The editorial workspace — Newsroom (Articles, Sujets, Commandes, Avis d'enquête), Com'room, Event'room, Opportunités, sales/purchases and invoicing. CRUD is built on flask-classful CBVs (`crud/cbvs/`) with a shared table/form layer.
*   **`biz` (Marketplace):** Assignments, projects and the job board — deposit forms, applications, and application review; plus the editorial-products and subscriptions tabs. Components `BizCard` and `BizTabs`.
*   **`bw` (Business Wall):** Organisation activation and management — activation funnel, roles (Owner, internal/external managers, PR managers), partnerships, missions/permissions, rights-transfer policy, and Stripe subscription products.
*   **`events` (Events):** The public events feed and calendar view, filters, event detail, and journalist accreditation. (Events are authored in the `wip` Event'room.)
*   **`search` (Search):** Cross-platform search over articles, press releases, events, marketplace offers, members and organisations, backed by an embedded **wesh** BM25 index (rebuildable via `flask search rebuild`).
*   **`kyc`:** Registration / "Know Your Customer" — a dynamic questionnaire generated from a survey model (spreadsheet), custom fields, validators and renderers, community/profile mapping, and admin validation of profiles.
*   **`admin`:** Back-office — user validation, organisation management, data export (ODS), marketplace moderation, and system tools.
*   **`api`:** A small internal HTTP API for HTMX/Trix interactions (likes, editor blob uploads). See [API](./api/).
*   **`stripe`:** Stripe integration — checkout, webhooks (`checkout.session.completed`, invoices) and subscription lifecycle.
*   **`notifications`:** The in-app "bell" — notification model, service and dropdown UI.
*   **`media`:** Content-addressed file serving (`/media/<sha256>`) from the storage backend, behind authentication.
*   **`preferences`:** Account settings — profile visibility, contact options, interests, password/email, and organisation invitations.
*   **`public`:** Public-facing pages — home, health check, sitemap, static assets, login/logout.
*   **`common`:** Shared components and utilities (e.g. `PostCard`, page header).
*   **`dashboard`:** A (largely inactive) module related to background-queue monitoring — not a user dashboard.
*   **`security`, `debug`:** Security helpers and development/debug tooling (the latter only in non-production).

## Module Structure

Each module typically contains the following components, with some variations:

*   **`__init__.py`:**  Initializes the module and defines the Flask Blueprint.
*   **`models.py`:** Defines the SQLAlchemy database models specific to the module.
*   **`views/` (or `views.py`):** Contains the Flask views / class-based views handling request logic and rendering.
*   **`forms.py`:** (If applicable) Defines WTForms used for data input and validation.
*   **`components/`:** (If applicable) Contains PyWire components for reusable UI elements.
*   **`services.py`:** (If applicable) Contains business logic and services related to the module.
*   **`templates/`:** (If applicable) Contains Jinja2 templates for rendering HTML.
*   **`settings.py`:** (If applicable) Holds module-specific configuration.
*   **`routing.py`:** (If applicable) Specifies URL routing rules and registers URL generators.
*   **`tests/`:** (If applicable) Contains unit and integration tests for the module.

## Further Exploration

To gain a deeper understanding of a specific module, explore its directory within `src/app/modules`. Examining the `models.py`, `views.py` (or `pages/`), and `components/` (if present) files will provide the most comprehensive insight into its functionality. Also, looking at the `tests/` directory can be useful to see how the module is used.
