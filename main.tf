data "azurerm_billing_enrollment_account_scope" "this" {
  count = module.this.enabled && var.billing_enrollment_account_scope != null ? 1 : 0

  billing_account_name    = var.billing_enrollment_account_scope.billing_account_name
  enrollment_account_name = var.billing_enrollment_account_scope.enrollment_account_name
}

resource "azurerm_subscription" "this" {
  count = module.this.enabled ? 1 : 0

  subscription_id   = var.subscription_id
  subscription_name = local.name_from_descriptor
  alias             = local.name_from_descriptor

  billing_scope_id = one(data.azurerm_billing_enrollment_account_scope.this[*].id)

  tags = module.this.tags
}

resource "azurerm_management_group_subscription_association" "this" {
  count = module.this.enabled && var.management_group_id != null ? 1 : 0

  management_group_id = var.management_group_id
  subscription_id     = local.subscription_resource_id
}

resource "time_static" "consumption_budget_start_date" {
  count = module.this.enabled && length(var.consumption_budgets) > 0 ? 1 : 0
}

resource "azurerm_consumption_budget_subscription" "this" {
  for_each = module.this.enabled ? var.consumption_budgets : {}

  name            = each.key
  subscription_id = local.subscription_resource_id

  amount     = each.value["amount"]
  time_grain = lookup(each.value, "time_grain", local.consumption_budget_defaults.time_grain)

  time_period {
    start_date = coalesce(
      lookup(lookup(each.value, "time_period", {}), "start_date", null),
      local.consumption_budget_defaults.consumption_budget_start_date
    )
    end_date = try(each.value.time_period.end_date, null)
  }

  dynamic "notification" {
    for_each = each.value["notifications"]
    content {
      contact_emails = lookup(notification.value, "contact_emails", local.consumption_budget_defaults.notifications.contact_emails)
      operator       = lookup(notification.value, "operator", local.consumption_budget_defaults.notifications.operator)
      threshold      = lookup(notification.value, "threshold", local.consumption_budget_defaults.notifications.threshold)
      threshold_type = lookup(notification.value, "threshold_type", local.consumption_budget_defaults.notifications.threshold_type)
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = module.this.enabled && var.diagnostics_log_analytics_workspace_id != null ? 1 : 0

  name = "amds-default"

  target_resource_id         = local.subscription_resource_id
  log_analytics_workspace_id = var.diagnostics_log_analytics_workspace_id

  dynamic "log" {
    for_each = local.diagnostics_categories_flag_map
    content {
      category = log.key
      enabled  = log.value
    }
  }
}

resource "null_resource" "refresh_access_token" {
  count = module.this.enabled && var.refresh_token ? 1 : 0

  triggers = {
    subscription_id = local.subscription_id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/refresh_access_token.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail
  }

  depends_on = [azurerm_subscription.this]
}
