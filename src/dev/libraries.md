# Libraries and Dependencies in Aipress24

## Back-end

### High-Level Overview

Aipress24 is heavily reliant on the **Flask** ecosystem for its web framework, extensions, and utilities.

It uses **SQLAlchemy** (with `advanced-alchemy`) for database interactions and **PostgreSQL** (`psycopg2-binary`) as the database engine. The application features background task processing with **Dramatiq** and **Redis**, and user authentication is managed with **Flask-Security-Too**. Templating is done with **Jinja2**, and static assets may be managed with **Flask-Vite**.

Configuration is handled by a combination of **python-dotenv** and **dynaconf**.

The application includes functionality for handling payments using **Stripe**, generating PDFs (for invoices) with **WeasyPrint**, and various utilities for data manipulation, internationalization, and more.

Security is considered through libraries like **bcrypt** and **zxcvbn** for password management and **Talisman** for HTTP security headers.

The application also includes features for generating fake data, for testing or development purposes, using **Faker** and **Mimesis**.

### Detailed Enumeration

1. **Web Framework:**

    *   **Flask** (`^3.0.0`): The core web framework.

2. **Flask Extensions:**

    *   **Flask-Babel** (`^4.0.0`): Internationalization and localization.
    *   **Flask-Classful** (`^0.16.0`): Class-based views.
    *   **Flask-HTMX** (`^0.4`): For working with HTMX.
    *   **Flask-Login** (`^0.6.2`): User session management.
    *   **Flask-Mailman** (`^1.0.0`): Email sending.
    *   **Flask-Migrate** (`^4.0.5`): Database migrations.
    *   **Flask-Security-Too** (`^5.3.3`): Security features (authentication, authorization).
    *   **Flask-SQLAlchemy** (`^3.1.1`): SQLAlchemy integration.
    *   **Flask-Super** (`^0.2.3`): Extension that aims to improve developer experience with a collection of utilities.
    *   **Flask-Talisman** (`^1.1.0`): HTTP security headers.
    *   **Flask-Vite** (`^0.5`): Vite integration for frontend assets.
    *   **Flask-WTF** (`^1.2.1`): WTForms integration for form handling.

3. **HTML Templating:**

    *   **Jinja2-fragments**: (`^1.2.1`) - For rendering blocks of Jinja2 templates.

4. **Configuration:**

    *   **python-dotenv** (`^1.0.0`): Loads environment variables from a `.env` file.
    *   **dynaconf** (`^3.2.4`):  Configuration management from various sources (TOML, YAML, etc.).

5. **Web Utilities:**

    *   **webargs** (`^8.4.0`):  Parsing and validating HTTP request arguments.
    *   **webbits** (`^0.1.2`):  A collection of HTML-related utilities, used here for `webbits.html.h` function.

6. **Database and ORM:**

    *   **SQLAlchemy** (`^2.0.25`):  Database toolkit and ORM.
    *   **SQLAlchemy-Utils** (`^0.41.1`):  Various utility functions for SQLAlchemy.
    *   **advanced-alchemy** (`>=0.23`): Async ORM extension for SQLAlchemy.
    *   **psycopg2-binary** (`^2.9.9`):  PostgreSQL database adapter.

7. **Data Handling and Internationalization:**

    *   **python-iso639** (`^2024.1.2`):  ISO 639 language codes.

8. **Production:**

    *   **gunicorn** (`^23`):  WSGI HTTP server.
    *   **hyperdx-opentelemetry** (`^0.2`): OpenTelemetry integration for monitoring.
    *   **sentry-sdk** (`^2`): Sentry integration for error tracking.

9. **CLI and Development:**

    *   **honcho** (`^2`):  Process manager (for managing multiple processes in development).
    *   **rich** (`^13.7.0`):  Rich text and beautiful formatting in the terminal.
    *   **cleez** (`^0.1.11`):  Framework for creating CLIs.
    *   **devtools** (`^0.12.2`):  Development utilities, including debugging tools.
    *   **snoop** (`^0.6`):  Advanced debugging tools (currently used in prod too).
    *   **pytest** (`^8`): Testing framework.
    *   **hypothesis** (`^6.92.8`): Property-based testing library.

10. **Images:**

    *   **Pillow** (`^11`):  Image processing library.

11. **Full-Text Search:**

    *   **typesense** (`^0.21`): Typesense search engine client.
    *   **beautifulsoup4** (`^4.12`):  HTML parsing library, used here to remove HTML tags from content before indexing.

12. **Payments:**

    *   **stripe** (`^11`): Stripe API client.

13. **Logging:**

    *   **loguru** (`^0.7.2`):  Logging library.

14. **Markdown:**

    *   **markdown** (`^3.5.2`): Markdown parsing library.

15. **Background Tasks and Queues:**

    *   **Dramatiq** (`^1.15.0`):  Background task processing library.
    *   **dramatiq-pg** (`^0.11.0`):  PostgreSQL broker for Dramatiq.
    *   **APScheduler** (`^3.10.4`): Task scheduling library.
    *   **redis** (`^5.0.1`):  Redis client (used as a message broker for Dramatiq).

16. **Fake Data Generation:**

    *   **Faker** (`>=30`):  Generates fake data (names, addresses, etc.).
    *   **mimesis** (`>=18`): Another fake data generator.

17. **PDF Generation:**

    *   **WeasyPrint** (`^63`):  HTML and CSS to PDF converter.

18. **Security and Authentication:**

    *   **zxcvbn** (`^4.4.28`):  Password strength estimator.
    *   **bcrypt** (`4.0.1`):  Password hashing library.
    *   **phonenumbers** (`^8.13.27`):  Phone number validation.
    *   **authlib** (`^1.3.0`):  OAuth and OpenID Connect client and server implementation.
    *   **python-jose** (`^3.3.0`, with `cryptography` extras):  JOSE (Javascript Object Signing and Encryption) implementation.
    *   **argon2-cffi** (`^23.1.0`): Argon2 password hashing algorithm.

19. **KYC (Know Your Customer):**

    *   **email-validator** (`^2.1.1`): Email validation library.
    *   **dnspython** (`^2.6.1`): DNS toolkit.

20. **Other Utilities:**

    *   **arrow** (`^1.3.0`):  Better dates and times.
    *   **attrs** (`^24`):  Class utilities without boilerplate.
    *   **boltons** (`^24`):  Various utility functions.
    *   **pipe** (`^2.1`):  Functional-style data processing.
    *   **python-dateutil** (`^2.9.0.post0`):  Date/time utilities.
    *   **python-slugify** (`^8.0.1`):  Slugifies strings.
    *   **toml** (`^0.10.2`):  TOML parser.
    *   **tomli** (`^2.0.1`): Another TOML parser.
    *   **boto3** (`^1.34.16`): AWS SDK for Python.
    *   **svcs** (`^24.1.0`): Service registry and dependency injection.
    *   **aenum** (`^3.1.15`):  Advanced enumerations.
    *   **buildstr** (`^0.1.1`): String builder.
    *   **case-convert** (`^1.1.0`):  Case conversion utility.
    *   **nodeenv** (`^1.8.0`): Node.js virtual environment manager.
    *   **requests** (`^2.31.0`): HTTP library.
    *   **yarl** (`^1.9.4`): URL parsing library.

21. **XML and ODF Parsing:**

    *   **openpyxl** (`^3.1.2`):  Library for reading and writing Excel files.
    *   **defusedxml** (`^0.7.1`):  Secure XML parser.
    *   **lxml** (`==5.0.1`):  XML and HTML processing library (pinned to specific version).
    *   **odfdo** (`>=3.7.10`):  ODF (OpenDocument Format) toolkit.
    *   **odsparsator** (`>=1.10.0`):  ODS (OpenDocument Spreadsheet) parser.
    *   **odsgenerator** (`>=1.11.0`): ODS generator.

22. **Admin App:**

    *   **sqladmin** (`^0.20`): Admin interface for SQLAlchemy models.
    *   **starlette** (`^0.45`): ASGI framework used by `sqladmin`.
    *   **granian** (`^1.6`, with `reload` extras): ASGI server.
    *   **asyncpg** (`^0.30`): Async PostgreSQL driver.
    *   **asgiref** (`^3.8`): ASGI specification library.

## Front-end

See [Font-end](./front-end/).
