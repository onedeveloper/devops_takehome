# Stack
Stack are a group of modules that are needed to build a specific software.

## create a workspace
```hcl
terraform workspace new <environment>
terraform workspace select <environment> when switching- make sure for consistency that <environment> also matches a directory in env
terraform workspace list and terraform workspace show can help you determine what you are work on.
```

## operation on an environemnt
```hcl
# initializing
terraform workspace select dev
terraform init

# applying changes
terraform workspace select dev
terraform apply -var-file ../env/dev/dev.auto.tfvars