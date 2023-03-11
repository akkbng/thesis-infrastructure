# Setup

### Requirements

    brew install --cask google-cloud-sdk
    brew install terraform
    brew install kubectl
    brew install helm


### To run

First, authenticate with Google Cloud.

    gcloud auth application-default login

Running this command obtains credentials that are applied to all GCP API calls using the Application Default Credentials library, which terraform does too.

    terraform init    # downloads provider
    terraform plan    # creates execution plan
    terraform apply   # executing API calls, etc.
    terraform destroy # destroys infrastructure
