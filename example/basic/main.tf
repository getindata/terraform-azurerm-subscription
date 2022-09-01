module "this_subscription" {
  source  = "../../"
  context = module.this.context

  subscription_id = var.subscription_id
}
