resource "google_service_account" "kubernetes" {
    account_id = "kubernetes"
}

resource "google_container_cluster" "my cluster" {
    name = "gke-cluster"
    location = "var.region"
    project = "var.project"
    network = "google_compute_network.vpc.id"
    subnetwork = "google_compute_subnetwork.private_subnet.name"
    remove_default_node_pool = "true"
    initial_node_count = 1
    networking_mode = "VPC_NATIVE"
    logging_service = "logging.googleapis.com/kubernetes"
    monitoring_service = "monitoring.googleapis.com/kubernetes"


    release_channel {
      channel = "REGULAR"
    }
}

resource "google_container_node_pool" "my node pool" {
    name = "gke-node-pool"
    cluster = "google_container_cluster.my cluster.name"
    location = "var.region"
    node_count = 2

    
    autoscaling {
      max_node_count = 6
      min_node_count = 1
    }
    node_config {
      preemptible = true
      machine_type = "e2-micro"
      
      service_account = google_service_account.kubernetes.email
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]
    } 
      
} 
      


