# Azure Subscription Terraform Module

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

![License](https://badgen.net/github/license/getindata/terraform-azurerm-subscription/)
![Release](https://badgen.net/github/release/getindata/terraform-azurerm-subscription/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

This module manages Azure Subscription.

## USAGE
```hcl
module "test_subscription" {
  source  = "github.com/getindata/terraform-azurerm-subscription"

  name              = "Test Subscription"
  subscription_id   = "00000000-0000-0000-0000-000000000000"
}
```

## Consumption Budget
You can create a consumption budget for the subscription and setup notifications based on various thresholds.

```hcl
consumption_budgets = {
  default = {
    amount = 100
    time_period = {
      start_date = "2022-07-01T00:00:00Z"
    }
    notifications = {
      forecastedGreaterThan100 = {
        contact_emails = ["notify@example.com"]
        operator       = "GreaterThan"
        threshold      = 100
        threshold_type = "Forecasted"
      }
    }
  }
}
```

> This module supports only e-mail addresses for notification.

## Examples

- [Basic Subscription management](examples/basic)

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_billing_enrollment_account_scope"></a> [billing\_enrollment\_account\_scope](#input\_billing\_enrollment\_account\_scope) | Enterprise Account details. The Billing Account Name and the Enrollment Account Name. | <pre>object({<br>    billing_account_name : string<br>    enrollment_account_name : string<br>  })</pre> | `null` | no |
| <a name="input_consumption_budgets"></a> [consumption\_budgets](#input\_consumption\_budgets) | Consumption budget resources associated with this resource group, it should be a map of values:<br>`{<br>  amount = number<br>  time_period = object<br>  notifications = map<br><br>  #optional<br>  time_grain = string<br>}`<br>`time_period` is an object of `start_date` (which is required) and `end_date` (which is optional).<br>`time_grain` must be one of Monthly, Quarterly, Annually, BillingMonth, BillingQuarter, or BillingYear. Defaults to Monthly<br>`notifications` is a map of values:<br>`{<br>  #optional<br>  contact_emails = list(string)<br>  operator = string<br>  threshold = string<br>  threshold_type = string<br>}`<br>`contact_emails` is a list of email addresses to send the budget notification to when the threshold is exceeded<br>`operator` - the comparison operator for the notification. Must be one of EqualTo, GreaterThan, or GreaterThanOrEqualTo. Defaults to `EqualTo`<br>`threshold` - threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000. Defaults to 90.<br>`threshold_type` - the type of threshold for the notification. This determines whether the notification is triggered by forecasted costs or actual costs. The allowed values are Actual and Forecasted. Default is Actual.<br><br>For more information, please visit: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group | `map(any)` | `{}` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_default_consumption_budget_notification_emails"></a> [default\_consumption\_budget\_notification\_emails](#input\_default\_consumption\_budget\_notification\_emails) | List of e-mail addresses that will be used for notifications if they were not provided explicitly | `list(string)` | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_diagnostics_categories_flag_map"></a> [diagnostics\_categories\_flag\_map](#input\_diagnostics\_categories\_flag\_map) | Map of Diagnostic categories. By default all of them are enabled. Ti disable particular category, add an entry with a `false` value | `map(bool)` | `{}` | no |
| <a name="input_diagnostics_log_analytics_workspace_id"></a> [diagnostics\_log\_analytics\_workspace\_id](#input\_diagnostics\_log\_analytics\_workspace\_id) | Resource ID of the log analytics workspace. Used for diagnostics logs and metrics | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | ID of the Management Group where subscription will be created | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_refresh_token"></a> [refresh\_token](#input\_refresh\_token) | Indicates wherever the refresh token of service principal should be refreshed after the subscription is created. | `bool` | `true` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | If Provided, subscription will not be created but managed via Alias | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_id"></a> [alias\_id](#output\_alias\_id) | Alias ID of the subscription |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | ID of the subscription |
| <a name="output_subscription_id_after_refreshed_access_token"></a> [subscription\_id\_after\_refreshed\_access\_token](#output\_subscription\_id\_after\_refreshed\_access\_token) | Subscription ID, which can be used after the running service principal refreshed its access token |
| <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name) | Name of the subscription |
| <a name="output_subscription_resource_id"></a> [subscription\_resource\_id](#output\_subscription\_resource\_id) | Resource ID of the subscription |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.8.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.8.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_consumption_budget_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |
| [azurerm_management_group_subscription_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription) | resource |
| [null_resource.refresh_access_token](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_static.consumption_budget_start_date](https://registry.terraform.io/providers/hashicorp/time/0.8.0/docs/resources/static) | resource |
| [azurerm_billing_enrollment_account_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/billing_enrollment_account_scope) | data source |
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/terraform-azurerm-subscription/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-azurerm-subscription" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
