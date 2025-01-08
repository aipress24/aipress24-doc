# Modules

The Aipress24 application is structured into modules, each responsible for a specific set of features or functionalities. This modular design promotes code organization, maintainability, and reusability. Modules are located in the `src/app/modules` directory.

## Naming Conventions

*   Modules are named using lowercase with underscores (e.g., `swork`, `kyc`).
*   Historically, some modules have been renamed in the UI but not in the code (e.g., "Biz" for "Market", "Swork" for "Social", "Wire" for "News"). This is noted in the code comments.

## Key Modules

Here's a description of some of the most important modules:

*   **`admin`:** Provides administrative functionalities, including user management, organization management, system information, and data export.
    *   Defines admin pages using the `Page` class, organized under `pages/`.
    *   Uses tables, implemented with `Table` and `DataSource`, to display data.
    *   Includes routes for user validation, showing user details, and exporting data.
    *   Handles invitations and organization email management.
*   **`api`:** Exposes a RESTful API for interacting with the platform's data and services.
    *   Provides endpoints for retrieving blobs, handling likes, and potentially other operations.
    *   Includes authentication checks for API requests.
*   **`biz`:** Implements the marketplace ("Market") functionality, where users can buy and sell editorial products, services, and subscriptions.
    *   Defines models for marketplace content and purchases.
    *   Includes components like `BizCard` and `BizTabs` for UI representation.
    *   Features pages for browsing the marketplace, viewing purchases, and managing items.
*   **`common`:** Contains components, utilities, and functionalities shared across multiple modules.
*   **`dashboard`:** (Possibly a placeholder or intended for future use) Aims to provide a dashboard for monitoring the application's queue system.
*   **`debug`:** Provides debugging tools and information, accessible only in non-production environments.
*   **`events`:** Manages events, including conferences, webinars, and training sessions.
    *   Allows users to view event details, register for events, and manage participation.
    *   Includes models for events and participation.
    *   Defines components like `EventCard` and `EventList` for UI display.
*   **`iam`:** (Currently not actively used) Intended for identity and access management, potentially using OAuth2.
*   **`kyc`:** Handles user registration, profile management, and "Know Your Customer" (KYC) processes.
    *   Implements a dynamic form system based on a survey model loaded from an Excel file.
    *   Includes custom form fields, validators, and renderers.
    *   Manages temporary blob storage for user uploads.
    *   Defines functions for community-to-role mapping and organization utilities.
*   **`oauth`:** (Currently not actively used) Intended for OAuth2-based authentication.
*   **`preferences`:** Allows users to manage their preferences, including profile visibility, contact options, and interests.
    *   Defines pages for editing user profiles and managing organization invitations.
*   **`public`:** Handles public-facing pages and functionalities, such as the home page, health checks, sitemap, and static asset serving.
    *   Includes views for user login/logout and debug features in non-production environments.
*   **`search`:** Provides search functionality across the platform.
    *   Utilizes a search backend (Typesense) for indexing and searching content.
    *   Defines search handlers and collections.
    *   Includes a `SearchPage` for user interaction.
*   **`security`:** (Potentially deprecated or under development) Intended for managing security-related aspects, potentially including roles and permissions.
*   **`swork`:** Implements the social network ("Social") features, enabling users to connect, follow each other, and share content.
    *   Defines models for posts, groups, and user relationships.
    *   Includes components for displaying member lists, organization lists, and group information.
    *   Features pages for user profiles, organization profiles, group management, and member directories.
*   **`wallet`:** (Likely intended for future use) Aims to manage user wallets and payments.
*   **`wip`:** Provides a back-office interface ("Work") for managing content, including articles, avis d'enquête, and other editorial products.
    *   Defines forms for creating and editing content, utilizing a form generation system.
    *   Includes models for newsroom entities like `Article`, `AvisEnquete`, `Commande`, `Sujet`, and `JustifPublication`.
    *   Features pages for managing content lists, details, creation, and updates.
    *   Implements a dropdown menu component and table components for UI display.
    *   Contains a section on data for clients (data4clients)
*   **`wire`:** Implements the news feed ("News") functionality, displaying articles and other content to users.
    *   Defines models for article posts and their status.
    *   Includes components like `PostCard` and `Carousel` for UI representation.
    *   Features pages for displaying the news feed and individual posts.
    *   Handles actions like toggling likes and adding comments.

## Module Structure

Each module typically contains the following components, with some variations:

*   **`__init__.py`:**  Initializes the module and defines the Flask Blueprint.
*   **`models.py`:** Defines the SQLAlchemy database models specific to the module.
*   **`views.py` or `pages/`:** Contains the Flask views or page definitions that handle user interface logic and interactions.
*   **`forms.py`:** (If applicable) Defines WTForms used for data input and validation.
*   **`components/`:** (If applicable) Contains PyWire components for reusable UI elements.
*   **`services.py`:** (If applicable) Contains business logic and services related to the module.
*   **`templates/`:** (If applicable) Contains Jinja2 templates for rendering HTML.
*   **`settings.py`:** (If applicable) Holds module-specific configuration.
*   **`routing.py`:** (If applicable) Specifies URL routing rules and registers URL generators.
*   **`tests/`:** (If applicable) Contains unit and integration tests for the module.

## Further Exploration

To gain a deeper understanding of a specific module, explore its directory within `src/app/modules`. Examining the `models.py`, `views.py` (or `pages/`), and `components/` (if present) files will provide the most comprehensive insight into its functionality. Also, looking at the `tests/` directory can be useful to see how the module is used.
