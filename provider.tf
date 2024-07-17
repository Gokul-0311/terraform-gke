provider "google" {
    project = "var.project"
    region = "var.region"
    credentials = file("service-account.json")
}