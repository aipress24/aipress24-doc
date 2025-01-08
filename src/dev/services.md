# Aipress24 services

Application Services in Aipress24

Application services in Aipress24 encapsulate specific business logic and operations, providing a layer of abstraction over models and other lower-level components. They are designed to be reusable and composable, promoting modularity and maintainability. Services are located in the `src/app/services` directory.

## Service Structure

Many services are implemented as classes, often using the `@service` decorator from `flask_super.decorators`. This decorator helps with dependency injection and service discovery. Services may depend on other services or resources, which are typically injected through the constructor or using the `svcs` container.

## Key Services

Here's a description of some of the most important application services in Aipress24:

*   **`ActivityStream`:** Manages the activity stream, recording user actions and generating timelines.
    *   `post_activity()`: Posts an activity to the stream.
    *   `get_timeline()`: Retrieves a timeline of activities.
    *   Defines `ActivityType` enum for different activity types.
    *   Stores activities in the `str_activity` table.
*   **`AuthService`:** Handles authentication-related operations.
    *   `get_user()`: Retrieves the currently authenticated user (typically from `flask.g`).
*   **`BlobService`:** Manages the storage and retrieval of binary large objects (blobs), such as images and other files.
    *   `save()`: Saves a blob.
    *   `get_path()`: Returns the local file path for a blob.
    *   `get()`: Retrieves a blob by ID.
    *   `delete()`: Deletes a blob.
    *   Uses a configurable storage backend (e.g., local file system or S3).
*   **`Cache`:** Provides a simple key-value caching mechanism. (Note: This is currently basic and might be replaced by a more robust solution in the future.)
*   **`Config`:** Provides access to the application's configuration settings.
*   **`EmailService`:** Handles sending emails.
    *   `send_system_email()`: Sends system emails using a template.
    *   Defines `ALERTS_RECIPIENTS` for system alerts.
    *   Includes templates for various email types (e.g., notifications, invitations).
*   **`ImageService`:** Provides image manipulation functionalities.
    *   `make_square()`: Resizes an image to a square, adding padding if necessary.
*   **`NotificationService`:** Manages user notifications.
    *   `post()`: Posts a notification to a user.
    *   `get_notifications()`: Retrieves notifications for a user.
    *   `mark_read()`: Marks notifications as read.
    *   Uses the `not_notifications` table to store notifications.
*   **`Promotions`:** Handles promotions and special offers.
    *   `get_promotion()`: Retrieves a promotion by its slug.
    *   Uses the `adm_promotion` table to store promotions.
*   **`Reputation`:** Calculates and manages user reputation scores.
    *   `compute_reputation()`: Calculates the reputation score for a user based on various factors and predefined specifications.
    *   `update_reputations()`: Updates reputation scores for all users.
    *   `get_reputation_history()`: Retrieves the reputation history for a user.
    *   Defines different reputation calculation formulas for different user roles (e.g., journalists, members, organizations).
    *   Stores reputation records in the `rep_record` table.
*   **`Security`:** Provides security-related utilities.
    *   `generate_password_hash()`: Generates a password hash with salt.
    *   `check_password_hash()`: Checks a password against a hash.
*   **`SessionService`:** Manages user sessions.
    *   Stores session data in the `ses_session` table.
    *   Provides functions to get, create, and update sessions.
*   **`SocialGraph`:** Manages social connections and interactions between users, organizations, and content.
    *   Provides adapters (`SocialUser`, `SocialOrganisation`, `SocialContent`) for interacting with different entities in a uniform way.
    *   Handles following/unfollowing users and organizations.
    *   Manages likes on content.
    *   Uses tables like `soc_following_users`, `soc_following_orgs`, and `soc_likes` to store social graph data.
*   **`Stats`:** Collects and manages application statistics.
    *   `update_stats()`: Updates daily statistics.
    *   Defines metrics like `amount_transactions`, `new_users`, and `user_connections`.
    *   Stores statistics in the `sta_record` table.
*   **`Stripe`:** Integrates with Stripe for payment processing.
*   **`Tracking`:** Tracks user views of content.
    *   `record_view()`: Records a view event.
    *   `get_view_count()`: Retrieves the total view count for a piece of content.
    *   `get_unique_view_count()`: Retrieves the unique view count for a piece of content.
    *   Stores view events in the `sta_view_event` table.
*   **`Web`:** Provides utilities for web-related operations.
    *   `check_url()`: Checks the validity of a URL.
*   **`ZipCode`:** Manages zip code information.
    *   Provides functions to create, update, and retrieve zip code entries.
    *   Uses the `zip_code` table to store zip code data.
*   **`GeoNames`:** Handles geographical data and operations.
    *   Provides functions related to departments and regions, such as checking if a department is in a region and getting a department's name.
*   **`Taxonomies`:**  Manages custom taxonomies.
    *   Provides functions to create, update, and retrieve taxonomy entries.
    *   `get_taxonomy()`: retrieve entries of a taxonomy.
    *   `get_full_taxonomy()`: retrieve all taxonomies.
    *   Uses the `tax_taxonomy` table to store taxonomy data.
*   **`json_ld`:** Generates JSON-LD data for objects.
*   **`healthcheck`:** Provides a health check endpoint to verify the application's status.
*   **`opengraph`:** Generates OpenGraph metadata for objects.
*   **`pdf`:** Generates PDF documents.
    *   Provides a generic `to_pdf()` function and a `generate_pdf()` function.
    *   Includes a specific implementation for generating invoices in PDF format.
*   **`roles`:** Manages user roles and permissions.
    * `has_role()`: checks if a user has a specific role.
    * `add_role()`: adds a role to a user.
    * `remove_role()`: removes a role from a user.
    * `get_users_with_role()`: retrieves users with a specific role.
*   **`screenshots`:** Creates screenshots of web pages.
    *   Uses a headless browser (via a command-line tool) to capture screenshots.
    *   Can store screenshots in a cloud storage service (e.g., S3).
*   **`tagging`:** Handles tagging of content.
    *   `add_tag()`: Adds a tag to an object.
    *   `get_tags()`: Retrieves tags for an object.
    *   `get_tag_applications()`: Retrieves tag applications.
    *   Uses the `tag_application` table to store tag associations.
*   **`moderation`:** Likely intended for content moderation features (not fully implemented in the provided code).

## Service Dependencies

Services often depend on other services or resources. For example:

*   `NotificationService` depends on `NotificationRepository`.
*   `ReputationService` might depend on services related to user activity and social interactions.
*   Services that interact with the database typically depend on the `db` object (SQLAlchemy session).

## Using Services

Services can be accessed in several ways:

1. **Dependency Injection:** Some services can be injected into other services or components through the constructor.
2. **`svcs` Container:** The `svcs` container (accessible via `svcs.flask.container`) can be used to retrieve some service instances. For example:

```python
from svcs.flask import container
from app.services.auth import AuthService

auth_service = container.get(AuthService)
user = auth_service.get_user()
```

## Further Exploration

To understand a specific service in more detail, examine its implementation in the `src/app/services` directory. Pay attention to the class methods, dependencies, and interactions with other components of the application. Also, looking at the `tests/` directory can be useful to see how the service is used.
