# Basic example

```hcl
module "this_management_group" {
  source  = "../../"
  context = module.this.context

  parent_management_group_id = var.parent_management_group_id
}
```

## Usage

```shell
terraform init
terraform plan -var-file=example.tfvars -out tfplan
terraform apply tfplan
```
