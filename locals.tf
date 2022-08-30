locals {
  name_from_descriptor = replace(lookup(module.this.descriptors, "subscription", module.this.id), "/--+/", "-")

  consumption_budget_defaults = {
    time_grain = "Monthly"
    notifications = {
      contact_emails = var.default_consumption_budget_notification_emails
      operator       = "EqualTo"
      threshold      = "90.0"
      threshold_type = "Actual"
    }
  }

  alias_id                 = one(azurerm_subscription.this[*].id)
  subscription_resource_id = "/subscriptions/${one(azurerm_subscription.this[*].id)}"
  subscription_id          = one(azurerm_subscription.this[*].subscription_id)
  subscription_name        = one(azurerm_subscription.this[*].subscription_name)
}
