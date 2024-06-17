// (Not used anymore).

workspace "AIpress24" "This is a model of the AIpress24 software system." {

    model {
        // Users
        guest_user = person "Anyonymous / Guest User" "User with very limited access to the features of the platform"
        registered_user = person "Registered User" "Users the platform (according to its user profile and permissions)"

        // Systems
        waf = softwareSystem "WAF (Sqreen)" "Sqreen" "Existing System"
        auth_providers = softwareSystem "OAuth providers" "OAuth providers (Linkedin, Google, Tweeter...)" "Existing System"
        email = softwareSystem "Email system" "Sends emails (alerts, etc.)" "Existing system"
        payment = softwareSystem "Payment Gateway" "Manages credit card payments" "Existing system"

        enterprise "AIpress24" {
            // Users
            admin_user = person "Admin User" "Manages users (registration)" "Staff"

            // Systems
            aipress24 = softwareSystem "AIpress24" "Digital workspace for press and PR profesionnals" {
                web_app = container "AIpress24 Web App" "Provides all of the ... " {
                    registration_component = component "Registration"
                    auth_component = component "Auth"
                    rbac_component = component "RBAC (access control)"
                    bpm_component = component "BPM (Workflow)"
                    activities_component = component "Activity streams and notifications"
                    search_component = component "Search"
                }

                postgresql = Container "PostgreSQL database"
                redis = Container "Redis database"
                s3 = Container "Blob store" "S3"
                search_index = Container "Search index" "Elastic or ..."

                web_app -> postgresql
                web_app -> redis
                web_app -> s3
                web_app -> search_index
            }

            erp = softwareSystem "ERP" "Manages accouting" "Existing system"
        }

        // Arrows
        guest_user -> aipress24 "Uses [https]"
        registered_user -> aipress24 "Uses [https]"
        admin_user -> aipress24 "Uses [https]"

        aipress24 -> auth_providers "Uses" "OAuth"
        aipress24 -> waf "Uses"
        aipress24 -> erp "Uses" "XML-RPC"
        aipress24 -> email "Uses" "SMTP/IMAP"
        aipress24 -> payment "Uses" "REST"
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemContext aipress24 "SystemContext" "System Context for AIpress24." {
            include *
            autoLayout
        }

        container aipress24 "SoftwareSystem" {
            include *
            # autoLayout
        }

        component web_app "Components" {
            include *
            # autoLayout
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "Staff" {
                shape person
                background #999999
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
        }
    }

}
