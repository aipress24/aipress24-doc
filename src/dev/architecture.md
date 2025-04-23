# Aipress24 Architecture

## C4 Diagrams

### Context diagram (level 1)

![Level 1](diagrams/c4/level1.png)

### Container diagrams (level 2)

![Level 2](diagrams/c4/level2.png)

### Component diagrams (level 3)

![Level 3](diagrams/c4/level3.png)

## Modules

See [Modules](./modules/).

## Services

See [Services](./services/).

## Architecture Notes

### Core Framework Features (Flask)

1.  **Routing:** Uses Blueprints (`app/modules/*/__init__.py`) to organize routes. Decorators (`@route`, `@get`, `@post` in `app/modules/admin/__init__.py`) and potentially standard Flask `@blueprint.route` are used. A custom `Page` abstraction (`app/flask/lib/pages/`) also handles routing by mapping Page classes to URL paths. Flask-Classful is used for some CBVs (`app/modules/wip/crud/cbvs/`).
2.  **Request/Response Handling: Implicitly uses Flask's `request` and `Response` objects. Handles GET/POST requests in the `Page` classes and view functions. Uses `redirect`, `jsonify`, `send_file`.
3.  **Templating (Jinja2): Explicitly uses Jinja2 via Flask's default integration.
    *   Template Loading: Loads templates from `app/templates`.
    *   Context Processors: Injects variables globally into templates (`app/flask/hooks.py`, `app/flask/jinja.py`).
    *   Custom Filters: Defines custom template filters (`app/ui/datetime_filter.py`, registered in `app/flask/main.py`).
    *   Custom Macros/Globals: Defines and registers custom macros/global functions (`app/ui/macros/`, `app/flask/lib/macros.py`).
4.  **Middleware / Request Lifecycle Hooks:**
    *   **Flask:** Uses `before_request` hooks (e.g., authentication, injecting extensions) and `after_request` (e.g., performance monitoring). Error handlers (`errorhandler`) are registered. (`app/flask/hooks.py`, `app/flask/main.py`).
    *   **Dramatiq:** Uses custom middleware (`AppContextMiddleware`) to manage Flask's application context within background tasks.
5.  **Configuration Management:** Uses `Dynaconf` for layered configuration from files (`etc/settings.toml`, `etc/secrets.toml`) and environment variables (`app/flask/config.py`).
6.  **Application Factory Pattern:** `app/flask/main.py` (`create_app`) uses functions to create and configure the application instances. This allows for different configurations (e.g., testing).
7.  **Static File Serving:** Implicitly uses Flask's static file handling (`app/static`). Also integrates with `Flask-Vite` for modern frontend asset management.
8.  **Session Management:**
    *   Uses Flask's standard session mechanism (likely cookie-based initially).
    *   A custom `SessionService` (`app/services/sessions/`) built on top of a database model (`Session`) provides a more persistent, user-or-session-id-tied storage mechanism.

### Flask Extensions & Integrations

9.  **Database Integration (ORM):**
    *   **Flask-SQLAlchemy:** Used for integrating SQLAlchemy with Flask (`app/flask/extensions.py`). Includes session management tied to the request lifecycle. Defines models using declarative base (`app/models/`).
    *   **Flask-Migrate:** Handles database schema migrations based on model changes.
    *   **SQLAlchemy-Utils:** Used for utility types like `ArrowType`.
10. **Authentication & Authorization:**
    *   **Flask-Security-Too:** Manages user registration, login, password hashing, roles (`User`, `Role` models, `SQLAlchemySessionUserDatastore`), session authentication, and potentially other security features like email confirmation (though not explicitly shown being used everywhere). Decorators like `@roles_required` might be used (or custom checks like `has_role`).
11. **Forms Handling:**
    *   **Flask-WTF:** Used for creating and validating forms (`app/modules/wip/crud/cbvs/_forms.py`).
    *   **WTForms Custom Fields:** Custom field types are defined (`app/flask/lib/wtforms/fields/`) for richer UI elements (DateTime, Image, RichSelect, RichText).
    *   **Custom Form Rendering:** A `FormRenderer` (`app/flask/lib/wtforms/renderer.py`) is used to render WTForms with custom structure/styling (likely Tailwind/DaisyUI). The KYC module (`app/modules/kyc/dynform.py`) uses a dynamic form generation approach based on spreadsheet definitions.
12. **Internationalization (i18n/l10n):**
    *   **Flask-Babel:** Integrated for handling different languages and timezones (`app/flask/extensions.py`), although explicit usage (like `_()` translation calls) isn't visible. Timezone handling (`pytz`) is used.
13. **Email Sending:**
    *   **Flask-Mailman:** Used for sending emails (`app/flask/extensions.py`, `app/services/emails/`).
14. **Background Tasks & Scheduling:**
    *   **Dramatiq:** Used as a background task queue, likely with Redis as a broker (`app/dramatiq/`). Includes custom middleware for Flask app context.
    *   **APScheduler:** Used within the Dramatiq setup (`@crontab`) for cron-like scheduling of background tasks (`app/dramatiq/scheduler.py`).
    *   **Schedule library:** Used in the main `server/scheduler.py` for a simpler, in-process scheduler running in a separate thread.
15. **Command-Line Interface (CLI):**
    *   **Flask CLI:** Integrated via `flask_super` (`@command`, `@group`) to add custom commands for tasks like database management (`db2`, `fake`), bootstrapping, listing components/pages, running jobs, and managing the search index. (`app/flask/cli/`).
16. **Security Headers:**
    *   **Flask-Talisman:** Used to set security-related HTTP headers, including Content Security Policy (CSP), in non-debug environments.
17. **Frontend Integration:**
    *   **Flask-Vite:** Manages integration with the Vite frontend build tool.
    *   **Flask-HTMX:** Provides server-side support for HTMX interactions (detecting HTMX requests via `htmx.boosted`).
    *   **Custom Component System (PyWire):** A custom system inspired by Livewire/HTMX for building interactive UI components with server-side rendering and state management (`app/flask/lib/pywire/`). Handles component rendering (`markup_component`) and AJAX updates (`/livewire/message/` route).
18. **Admin Interface:**
    *   **SQLAdmin:** Used in the separate `adminapp` (Starlette-based) to provide a CRUD interface for database models.

### Architectural Patterns & Other Features

19. **Modular Application Structure (Blueprints):** Flask Blueprints are used to structure the application into logical modules (`app/modules/*`).
20. **Service Layer / Dependency Injection:** Uses `svcs` for registering and accessing services (`app/flask/services.py`, `app/services/`). Promotes decoupling.
21. **Repository Pattern:** Data access is often abstracted through Repository classes (`app/models/repositories.py`, `app/services/repositories/`).
22. **Model Mixins:** Reusable model functionalities (like ID generation, timestamps, ownership, address fields) are implemented using mixins (`app/models/mixins.py`).
23. **Custom View Abstraction (`Page`):** A custom `Page` class provides a structured way to define views/controllers, handling routing, context, templates, and lifecycle methods (`app/flask/lib/pages/`).
24. **ASGI/WSGI Compatibility:** The main server uses ASGI (Starlette/Granian) and mounts the WSGI Flask application using `asgiref.wsgi.WsgiToAsgi`.
25. **Application Server:** Uses Granian as the ASGI server (`adminapp/__main__.py`, `server/main.py`).
26. **Search Index Integration:** Explicit commands and backend code for interacting with Typesense (`app/modules/search/`).
