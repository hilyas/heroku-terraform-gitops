terraform {
  backend "gcs" {
    bucket = "terraform-heroku-gitops-state-playground-20231012"
    prefix = "terraform/state"
  }
}
