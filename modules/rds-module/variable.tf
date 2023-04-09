variable "engine_name" {
  description = "Enter the DB engine"
  type        = string
}
variable "name" {
  description = "Tag Name to be assigned with resources"

}
variable "user_name" {
  description = "Enter the username for DB"
  type        = string
}
variable "pass" {
  description = "Enter the username for DB"
  type        = string
}
variable "multi_az_deployment" {
  description = "Enable or disable multi-az deployment"
  type        = bool
}
variable "public_access" {
  description = "Whether public access needed"
  type        = bool
}
variable "skip_finalSnapshot" {
  type    = bool
}
variable "delete_automated_backup" {
  type    = bool
}
variable "instance_class" {
  type    = string
}