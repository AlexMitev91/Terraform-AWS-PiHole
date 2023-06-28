# Pi-Hole Docker Container on AWS EC2 with Terraform

This repository contains the necessary code and configuration to provision a Pi-Hole Docker container on an AWS EC2 instance running Ubuntu 20. The provisioning is automated using Terraform, allowing you to quickly set up a Pi-Hole instance with minimal effort.

## Prerequisites
Before you begin, ensure that you have the following prerequisites installed and configured:

1. AWS account with appropriate permissions to create EC2 instances and related resources.
2. Terraform installed on your local machine.

## Getting Started

To get started with the Pi-Hole Docker container on AWS EC2, follow these steps:

Clone this repository to your local machine:

```git clone https://github.com/your-username/pi-hole-aws-terraform.git```

Navigate to the cloned repository:

```cd pi-hole-aws-terraform```

Update the following files with your own configurations:

### variables.tf:

**Line 2**: Assign the variable the value of the IP address and subnet mask, which will be allowed to access the server. Leave the default value, if you would like the service to be public. 

### main.tf:

**Line 3**: Replace with your own AWS profile.

**Line 89**: Replace with your own AWS key file (.pem).

### docker-compose.yml:

**Line 15**: Specify your timezone.

**Line 16**: Specify your own password for the Pi-Hole Admin user.

Initialize the Terraform working directory:

```terraform init```

```terraform plan```

Apply the changes to provision the EC2 instance and deploy the Pi-Hole Docker container:

```terraform apply```

Once the provisioning is complete, you will see the URL address of the Pi-Hole admin panel in the Terraform output. Access Pi-Hole by entering the EC2 instance's public IP address in your web browser.

## Additional Configuration

If you wish to customize further aspects of the Pi-Hole setup, such as DNS settings or blocklists, please refer to the official Pi-Hole documentation for instructions on how to modify the Pi-Hole Docker container's configuration.

## Cleaning Up

To tear down the infrastructure and terminate the EC2 instance, run the following command:

```terraform destroy```

Please note that this will permanently remove all associated resources, including the EC2 instance and any data stored on it. Exercise caution when using this command.
