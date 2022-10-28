workspace "Yoco" "This is an example workspace to illustrate the key features of Structurizr, via the DSL, based around a minimal Yoco system." {

    model {
        customer = person "Yoco Customer" "Yoco merchant who has an active card machine" "Customer"

        enterprise "Yoco" {
            supportStaff = person "Customer Support" "Customer support within Yoco." "Support Staff"

            salesForce = softwaresystem "SalesForce" "The system used by operations and commercial to handle customer interactions." "Existing System"
            capital = softwaresystem "Capital" "Service that handles some merhcant capital offers" "Existing System" {
                !docs docs
                !adrs adrs
            }

            core = softwaresystem "Core System" "Handles customers information about their bank accounts, and make payments." {
                !docs docs
                !adrs adrs
                mobileApp = container "Mobile App / POS / Register" "Provides a limited subset of the Internet banking functionality to customers via their mobile device." "React Native" "Mobile App"
                webApplication = container "Single Page Application / Portal" "Delivers the static content and the merchants dashboard single page application." "React" "Web Browser"
                adminWebApplication = container "Admin Web Application" "Dashboard for administration of merchant" "Python/React" "Web Browser"
                apiApplication = container "API Application" "Handles API calls" "Scala" "Backend"
                database = container "Database" "Stores user registration information, hashed authentication credentials, access logs, etc." "Postgres Database Schema" "Database"
            }
        }

        # relationships between people and software systems
        customer -> core "Views account balances, and makes payments using"
        supportStaff -> core "Uses"
        salesForce -> customer "Sends e-mails to"
        customer -> supportStaff "Asks questions to" "Telephone"

        # relationships to/from containers
        core -> salesForce "Gets account information from, and makes payments using"
        capital -> core "Sends Lulalend offers to"
        customer -> webApplication "Views dashboard"
        supportStaff -> adminWebApplication "Visits bigbank.com/ib using" "HTTPS"
        customer -> mobileApp "Views account balances, and makes payments using"
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout lr
        }

        container core "Containers" {
            include *
            animation {
                customer salesForce
                webApplication
                adminWebApplication
                mobileApp
                apiApplication
                database
            }
            autoLayout lr
        }

        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Customer" {
                background #08427b
            }
            element "Bank Staff" {
                background #999999
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Failover" {
                opacity 25
            }
        }
    }
}
