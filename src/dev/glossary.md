# Glossary

## Main Tabs vs. Code Modules

*   **`wip` (Work):**  "Work in Progress" module, likely for internal tools, content creation, and workflows related to content production and management. Code module: `wip`.
*   **`wire` (News):** Module for viewing and managing news feeds, articles, and other timely information. Code module: `wire`.
*   **Events:** Module for managing and displaying events (conferences, webinars, etc.). Code module: `events`.
*   **Market:** Module for the marketplace, where users can buy, sell, and find services and content. Code module: `biz`.
*   **Social:** Module for social networking features, user profiles, groups, and interactions. Code module: `swork`.
*   **Admin:** Module for administrative tasks, user management, system configuration, etc. Code module: `admin`.
*   **Preferences:** Module for user preferences management. Code module: `preferences`.
*   **Public:** Module for publicly accessible pages (homepage, pricing, static pages). Code module: `public`.
*   **Search:** Module for search functionality. Code module: `search`.
*   **Dashboard:** Module providing a dashboard overview (likely includes metrics and queue information). Potentially includes user-specific dashboards as well. Code module: `dashboard`.
*   **Auth:** Modules for user authentication and authorization, potentially including OAuth integration. Code modules: `iam`, `oauth`.
*   **KYC:** "Know Your Customer" module, handling user verification, profile information, and compliance. Code module: `kyc`.
*   **API:** Module defining REST API endpoints. Code module: `api`.

## Article Metadata

*   **`genre` (Genre):** The literary or journalistic style of the article (e.g., reportage, interview, editorial, opinion).
*   **`section` (Section):** The section or category within a publication where the article would appear (e.g., politics, sports, culture).
*   **`topic` (Topic):** The main subject or theme of the article (e.g., climate change, artificial intelligence, elections).
*   **`sector` (Sector):** The industry or field the article pertains to (e.g., healthcare, finance, technology).
*   **`author` (Author):** The author of the article.
*   **`title` (Title):** The title of the article.
*   **`summary` (Summary):** A brief summary of the article.
*   **`published_at` (Publish Date):** The date and time the article was published.
*   **`subheader` (Subheader):** The subheader of the article.
*   **`image_url` (Image URL):** The URL of the main image associated with the article.
*   **`image_caption` (Image Caption):** The caption for the image.
*   **`image_copyright` (Image Copyright):** The copyright information for the image.
*   **`subject` (Subject):** Subject of the article. Might be synonymous with topic.
*   **`copyright` (Copyright):** Copyright information for the article.
*   **`status` (Status):** Publication status of the article (e.g., draft, published, archived).

## Organization Types

*   **`Agence de presse` (Press Agency):** An organization that gathers and distributes news reports.
*   **`Média` (Media):** A news organization or publication.
*   **`PR agency` (PR Agency):** Public Relations Agency.
*   **`Autre` (Other):** Other organization type.

## Business Wall Types

*   **Press Agency:** `BWTypeEnum.AGENCY`
*   **Media:** `BWTypeEnum.MEDIA`
*   **Corporate:** `BWTypeEnum.CORPORATE`
*   **Press Union:** `BWTypeEnum.PRESSUNION`
*   **Communication:** `BWTypeEnum.COM`
*   **Organisation:** `BWTypeEnum.ORGANISATION`
*   **Transformer:** `BWTypeEnum.TRANSFORMER`
*   **Academic:** `BWTypeEnum.ACADEMICS`

## User Roles

*   **`admin` (Admin):** Administrator with full access. `RoleEnum.ADMIN`
*   **`guest` (Guest):** User with limited access. `RoleEnum.GUEST`
*   **`leader` (Leader):**  A leadership role within an organization. `RoleEnum.LEADER`
*   **`manager` (Manager):** A management role within an organization. `RoleEnum.MANAGER`
*   **`journalist` (Journalist):**  A journalist. `RoleEnum.PRESS_MEDIA`
*   **`press_relations` (Press Relations):** A role for communication professionals. `RoleEnum.PRESS_RELATIONS`
*   **`expert` (Expert):** An expert in a specific field. `RoleEnum.EXPERT`
*   **`academic` (Academic):** A role for academics and researchers. `RoleEnum.ACADEMIC`
*   **`transformer` (Transformer):** A role for professionals involved in organizational or digital transformation. `RoleEnum.TRANSFORMER`

## User Communities

*   **`Press & Media` (Press & Media):** Community for journalists and media professionals. `CommunityEnum.PRESS_MEDIA`
*   **`Communicants` (Communication):** Community for communication professionals. `CommunityEnum.COMMUNICANTS`
*   **`Leaders & Experts` (Leaders & Experts):** Community for leaders and experts. `CommunityEnum.LEADERS_EXPERTS`
*   **`Transformers` (Transformers):** Community for transformers. `CommunityEnum.TRANSFORMERS`
*   **`Academics` (Academics):** Community for academics. `CommunityEnum.ACADEMICS`

## Other Terms

*   **`avis d'enquête` (Investigation Notice):** A request from a journalist for information or interviews related to a specific topic.
*   **`commande` (Order or Commission):** A request for a specific piece of content or work.
*   **`sujet` (Subject or Topic):** A proposed topic for an article or investigation.
*   **`justificatif de publication` (Proof of Publication):** Evidence that an article has been published.
*   **`métadonnées` (Metadata):** Data about data, in this context usually referring to information describing an article or other piece of content.
*   **`parrainage` (Sponsorship or Referral):** A system for sponsoring or referring new users, possibly with incentives.
*   **`Business Wall` (Business Wall):** A dedicated space for organizations to manage their profile, communications, and interactions with journalists and other users.
*   **`CalRed` (Editorial Calendar):** A calendar showing planned publication dates and topics for media outlets.
*   **`CPPAP` (CPPAP - Commission paritaire des publications et agences de presse):** Joint Commission for Publications and Press Agencies (French regulatory body).
*   **`DGMIC` (DGMIC - Direction générale des médias et des industries culturelles):** Directorate General for Media and Cultural Industries (part of the French Ministry of Culture).
*   **`FSDP` (FSDP - Fonds stratégique pour le développement de la presse):** Strategic Fund for the Development of the Press (French fund supporting the press).
*   **`JRI` (JRI - Journaliste reporter d'images):** Video journalist, a journalist who also films and edits their own video reports.
*   **`SPEL` (SPEL - Services de presse en ligne):** Online press services.
*   **`pige` (Freelance work or Assignment):** A single piece of work done by a freelancer, usually paid per article/project.
*   **`marcom` (Marketing & Communication):** Marketing and communication, usually referring to a department or role within an organization.
*   **`contacts ciblés` (Targeted contacts):** A list of contacts, likely journalists or other relevant individuals, who are specifically targeted for a particular communication.
*   **`profil` (Profile):** User profile.
*   **`rôle` (Role):** User role, determining their permissions and access within the platform.
*   **`communauté` (Community):** A group of users with shared interests or characteristics.
*   **`ontologie` (Ontology):** A formal naming and definition of the types, properties, and interrelationships of the entities that exist within a specific domain (in this case, the platform's data model).
*   **`workflow` (Workflow):** A sequence of connected steps or processes, often used for content creation and approval.
*   **`visibilité` (Visibility):** How visible a user, organization, or piece of content is on the platform.
*   **`engagement` (Engagement):** User interaction with content (likes, shares, comments, etc.).
*   **`performance` (Performance):** Metrics related to user activity and content reach.
*   **`délégations` (Delegations):** Permissions granted to other users to perform actions on one's behalf.
*   **`facturation` (Billing):** The process of generating and managing invoices.
*   **`Source Agence de presse` (Press Agency Source):** Likely a label or identifier indicating that a piece of content originated from a press agency.
*   **`hypertrucages` (Deepfakes):** Manipulated or fabricated media, often using AI, to create realistic but false content.
*   **`Creative Commons` (Creative Commons):** A type of copyright license that allows for free distribution of copyrighted work.
*   **`PSP` (Payment Service Provider):** A third-party company that handles payment processing.
*   **`Data Viz` (Data Visualization):** Graphical representation of data.
*   **`ERP` (Enterprise Resource Planning):** Business process management software.
*   **`Dolibarr` (Dolibarr):** An open-source ERP and CRM system.
*   **`B2B` (Business-to-Business):** Transactions or interactions between businesses.
*   **`Routage` (Routing):** The process of directing requests or messages to the appropriate recipient or system.
*   **`Porte-monnaie électronique` (Electronic Wallet):** A system for storing and managing electronic funds.
*   **`Rescrit Fiscal` (Tax Ruling):** A formal interpretation of tax law by a tax authority, often requested by a taxpayer to clarify the tax treatment of a specific transaction or situation.
*   **`RGPD` (GDPR - General Data Protection Regulation):** General Data Protection Regulation (European Union regulation on data protection and privacy).
*   **`Chiffre d'Affaires (CA)` (Revenue or Turnover):** The total amount of money generated by a business during a specific period.
