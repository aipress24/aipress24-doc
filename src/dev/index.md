# Aipress24 Developers Documentation

!!!Note
    Navigate using the navbar on the left-hand side of this page or using the "hanburger" icon on the top left corner of the page.

**Welcome to the Aipress24 Developer Documentation**

This documentation provides a comprehensive guide to the Aipress24 platform's internal architecture, development practices, and technical details. It is intended for developers who are contributing to the Aipress24 codebase or integrating with its services.

## Aipress24: An Overview

Aipress24 is a B2B digital platform designed to connect journalists, communication professionals, experts, and organizations. It fosters collaboration and information sharing within the media ecosystem. The platform offers a suite of tools and services, including:

*   **News:** A news portal featuring curated content from verified sources and press releases.
*   **Social:** A professional social network for the media industry.
*   **Work:** A workspace for editorial production, requests and sales.
*   **Marketplace:** Assignments, projects, jobs, subscriptions and rights transfers.
*   **Events:** A calendar of industry events.
*   **Search:** Cross-platform search.

## Key Technologies

Aipress24 is built using a modern technology stack, primarily leveraging:

*   **Backend:** Python 3.11+, Flask, SQLAlchemy 2.0 with Advanced-Alchemy, PostgreSQL (SQLite for tests).
*   **Frontend:** Tailwind CSS, DaisyUI, HTMX, AlpineJS, a custom PyWire component system, and Vite for asset bundling.
*   **Background tasks:** Dramatiq with a Redis broker.
*   **Auth:** Flask-Security-Too.
*   **Search:** an embedded BM25 full-text index (`wesh`).
*   **Payments:** Stripe (subscriptions and one-off purchases).
*   **Packaging & tooling:** `uv` for dependencies; `ruff`, `ty` and `pyrefly` for linting and type checking.
*   **Other services:** activity streams, email, image/media management, invoicing, moderation, PDF generation, reputation, notifications, and more.

## Documentation Structure

This documentation is organized into several key sections, accessible through the navigation bar on the left. Here's a brief overview:

*   **[Architecture](./architecture/):** Dive into the platform's architecture with C4 diagrams (context, container, component), module breakdowns, and service descriptions. Explore the database schema with simple and detailed diagrams.
*   **[API](./api/):** Discover how to interact with the Aipress24 API (documentation auto-generated from source code).
*   **[Modules](./modules/):** Understand the application's modular structure, with each module encompassing its own data model, views, templates, and UI components.
*   **[Services](./services/):** Learn about the various services that underpin the application, such as activity streams, configuration, email, image management, and more.
*   **[Front-End Architecture](./front-end/):** Get insights into the front-end development approach, utilizing Tailwind CSS, DaisyUI, HTMX, AlpineJS, and Vite for asset bundling.
*   **[Financial integration](./financial/):** How payments, subscriptions and invoicing work, via Stripe.
*   **[Testing](./tests/):** Familiarize yourself with the testing strategy, including unit, integration, and end-to-end tests.
*   **[Open Source Libraries](./libraries/):** See a comprehensive list of the open-source libraries used in the project.
*   **[Glossary](./glossary/):** Understand the terminology used within the application and documentation.
*   **[Misc Notes / How-tos](./notes/):** This includes how to drop the database cleanly and how to regenerate fake data.

## Getting Started

We recommend starting with the **Architecture** section to gain a high-level understanding of the platform's structure. Then, move on to the **API** and **Modules** sections for more detailed information. The **Front-End Architecture** section is crucial for developers working on the user interface.

## Contribution

This documentation is a living document. We encourage contributions and feedback from all developers. If you find any errors or have suggestions for improvement, please don't hesitate to submit a pull request or open an issue.

**Thank you for your interest in Aipress24! We hope this documentation helps you navigate the platform and contribute to its development.**
