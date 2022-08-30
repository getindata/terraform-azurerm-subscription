variable "subscription_id" {
  type        = string
  description = "If Provided, subscription will not be created but managed via Alias"
  default     = null
}

variable "management_group_id" {
  type        = string
  description = "ID of the Management Group where subscription will be created"
  default     = null
}

variable "billing_enrollment_account_scope" {
  type = object({
    billing_account_name : string
    enrollment_account_name : string
  })
  description = "Enterprise Account details. The Billing Account Name and the Enrollment Account Name."
  default     = null
}

variable "diagnostics_log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "Resource ID of the log analytics workspace. Used for diagnostics logs and metrics"
}

variable "consumption_budgets" {
  type        = map(any)
  default     = {}
  description = <<-EOT
    Consumption budget resources associated with this resource group, it should be a map of values:
    `{
      amount = number
      time_period = object
      notifications = map

      #optional
      time_grain = string
    }`
    `time_period` is an object of `start_date` (which is required) and `end_date` (which is optional).
    `time_grain` must be one of Monthly, Quarterly, Annually, BillingMonth, BillingQuarter, or BillingYear. Defaults to Monthly
    `notifications` is a map of values:
    `{
      #optional
      contact_emails = list(string)
      operator = string
      threshold = string
      threshold_type = string
    }`
    `contact_emails` is a list of email addresses to send the budget notification to when the threshold is exceeded
    `operator` - the comparison operator for the notification. Must be one of EqualTo, GreaterThan, or GreaterThanOrEqualTo. Defaults to `EqualTo`
    `threshold` - threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000. Defaults to 90.
    `threshold_type` - the type of threshold for the notification. This determines whether the notification is triggered by forecasted costs or actual costs. The allowed values are Actual and Forecasted. Default is Actual.

    For more information, please visit: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group
    EOT
}

variable "default_consumption_budget_notification_emails" {
  type        = list(string)
  default     = []
  description = "List of e-mail addresses that will be used for notifications if they were not provided explicitly"
}
