module "this_subscription" {
  source  = "../../"
  context = module.this.context

  name            = var.subscription_name
  subscription_id = var.subscription_id
}
