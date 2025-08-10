# ==================================
# Terraform & Provider Configuration
# ==================================

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"


  backend "http" {
    address = "<repo-address>"
    lock_address="<repo-address>"
    unlock_address="<repo-address>"
    lock_method="POST"
    unlock_method="DELETE"
    retry_wait_min=5
    username = "terraform"
  }

}

provider "yandex" {
  service_account_key_file = "authorized_key.json"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

