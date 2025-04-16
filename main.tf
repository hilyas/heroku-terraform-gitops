# # Variables
# variable "app_name" {
#   description = "Name of the Heroku application"
#   type        = string
# }

# variable "region" {
#   description = "Heroku region"
#   type        = string
#   default     = "us"
# }

# variable "heroku_team" {
#   description = "Heroku team name (optional)"
#   type        = string
#   default     = null
# }

# # Heroku application
# resource "heroku_app" "app" {
#   name   = var.app_name
#   region = var.region

#   # If a team is specified, create the app in that team
#   dynamic "organization" {
#     for_each = var.heroku_team != null ? [1] : []
#     content {
#       name = var.heroku_team
#     }
#   }
# }

# # Postgres database add-on
# resource "heroku_addon" "database" {
#   app_id = heroku_app.app.id
#   plan   = "heroku-postgresql:essential-0"
# }

# # Variables for deployment
# variable "github_repo" {
#   description = "GitHub repository URL containing the application code"
#   type        = string
#   default     = null
# }

# variable "github_branch" {
#   description = "GitHub branch to deploy"
#   type        = string
#   default     = "main"
# }

# # Deploy application from GitHub if repo is specified
# resource "heroku_build" "app" {
#   count = var.github_repo != null ? 1 : 0

#   app_id = heroku_app.app.id

#   source {
#     url     = "${var.github_repo}/archive/refs/heads/${var.github_branch}.tar.gz"
#     version = var.github_branch
#   }
# }

# # Configure dyno formation for the app
# resource "heroku_formation" "web" {
#   count = var.github_repo != null && length(heroku_build.app) > 0 ? 1 : 0

#   app_id   = heroku_app.app.id
#   type     = "web"
#   quantity = 1
#   size     = "basic"

#   # Ensure the build is complete before scaling
#   depends_on = [heroku_build.app]
# }

# # Variables for add-ons
# variable "enable_logging" {
#   description = "Enable Papertrail logging add-on"
#   type        = bool
#   default     = false
# }

# variable "enable_metrics" {
#   description = "Enable Metrics add-on"
#   type        = bool
#   default     = false
# }

# # Papertrail logging add-on
# resource "heroku_addon" "logging" {
#   count  = var.enable_logging ? 1 : 0
#   app_id = heroku_app.app.id
#   plan   = "papertrail:choklad"
# }

# # Metrics add-on
# resource "heroku_addon" "metrics" {
#   count  = var.enable_metrics ? 1 : 0
#   app_id = heroku_app.app.id
#   plan   = "heroku-metrics:hobby-dev"
# }
