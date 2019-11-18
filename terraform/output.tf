output "ci_access_key_id" {
  value = module.iam_system_user.access_key_id
}


output "ci_secret_access_key" {
  value = module.iam_system_user.secret_access_key
}
