# to store the terraform state file in GCS bucket
terraform {
  backend "gcs" {
    bucket                   = "tf-test-bucket"
    prefix                   = "terraform/state"
    credentials              = "./environments/service-account.json"
  }
}

## Using this block if you wanna save the terraform state file in your local

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}