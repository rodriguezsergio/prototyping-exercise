# Citrusbyte Exercise

This is a simple Golang application that is deployed on AWS with ECS. A Makefile is provided and it takes care of creating a new environment from scratch with `make bootstrap`. The Terraform layout is condensed for the sake of this exercise, but normally I would divide up individual services into their own directories and reference each other with `data` sources or use `terraform_remote_state`.

# Requirements
The Makefile assumes you have the AWS CLI installed as well as `git` and `make`. It is also assumed that you have `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` set in your environment.

- `make bootstrap`: provisions a new environment and readies it for deployment
- `make build`: builds the docker image locally
- `make publish`: builds and pushes the image to ECR
- `make everything`: provisions a new environment, builds the docker images, and publishes it to ECR

# Improvements
- Supporting other regions instead of just us-east-1
- Using `remote_state` to store changes in S3 or another supported Terraform back-end
- Using a community module, or creating my own, to provision the infrastructure
- Using something else besides ECS to deploy. The black-box feel of ECS isn't particularly appealing to me and it doesn't seem to be the fastest tool to get changes pushed out. However, it was fairly fast to get up and running.