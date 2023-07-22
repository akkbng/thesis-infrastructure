resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_project_iam_binding" "service_account_role1" {
  project = var.project_name
  role    = "roles/monitoring.metricWriter"

  members = [
    //the service account email I created in the previous step
    "serviceAccount:${google_service_account.default.email}"
  ]
}

resource "google_project_iam_binding" "service_account_role2" {
  project = var.project_name
  role    = "roles/logging.logWriter"

  members = [
    //the service account email I created in the previous step
    "serviceAccount:${google_service_account.default.email}"
  ]
}

resource "google_project_iam_binding" "service_account_role3" {
  project = var.project_name
  role    = "roles/stackdriver.resourceMetadata.writer"

  members = [
    //the service account email I created in the previous step
    "serviceAccount:${google_service_account.default.email}"
  ]
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}