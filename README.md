# EC2 Initialization Project

This project is designed to initialize EC2 instances in AWS for testing or performing various tasks. It combines the use of Terraform and Ansible for infrastructure provisioning and configuration. Currently, Ansible is configured to install Node.js and Docker on the EC2 instances, with the flexibility to add more software as needed.

## Prerequisites

Ensure the following tools are installed on your local machine:

-   [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
-   [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
-   [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Steps to Use

### 1. Install Required Tools

Install Ansible, Terraform, and AWS CLI on your local machine. Follow the official documentation for installation instructions.

### 2. Configure AWS

-   Set up your AWS credentials using the AWS CLI:
    ```bash
    aws configure
    ```
-   Provide your AWS Access Key, Secret Key, default region, and output format.

### 3. Run Terraform

Terraform is used to provision the EC2 instances.

#### Initialize Terraform

Run the following command to initialize the Terraform working directory:

```bash
terraform init
```

#### Plan the Infrastructure

Generate and review an execution plan:

```bash
terraform plan
```

#### Apply the Configuration

Provision the infrastructure:

```bash
terraform apply
```

#### Destroy the Infrastructure

When you're done, clean up the resources:

```bash
terraform destroy
```

### 4. Configure EC2 Instances with Ansible

Ansible is used to configure the EC2 instances after they are provisioned. By default, it installs Node.js and Docker. You can modify the Ansible playbooks to install additional software as needed.

Run the Ansible playbook:

```bash
cd ansible
ansible-playbook -i inventory playbook.yml
```

## Notes

-   Ensure your AWS IAM user has the necessary permissions to create and manage EC2 instances.
-   Modify the Terraform and Ansible configurations as needed for your specific use case.
-   Update the Ansible playbook to include additional software installations or configurations as required.
-   Ensure the EC2 instances have the necessary SSH access for Ansible to connect and configure them.
