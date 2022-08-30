output "alias_id" {
  value       = local.alias_id
  description = "Alias ID of the subscription"
}

output "subscription_resource_id" {
  value       = local.subscription_resource_id
  description = "Resource ID of the subscription"
}

output "subscription_id" {
  value       = local.subscription_id
  description = "ID of the subscription"
}

output "subscription_name" {
  value       = local.subscription_resource_id
  description = "Name of the subscription"
}

output "subscription_id_after_refreshed_access_token" {
  value       = one(null_resource.refresh_access_token[*].triggers.subscription_id)
  description = "Subscription ID, which can be used after the running service principal refreshed its access token"
}
