variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Yandex Cloud default zone"
  type        = string
  default     = "ru-central1-b"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "192.168.10.0/24"
}

variable "lamp_image_id" {
  description = "LAMP image ID for instance group"
  type        = string
  default     = "fd827b91d99psvq5fjit"
}

variable "instance_group_size" {
  description = "Number of instances in the group"
  type        = number
  default     = 3
}

variable "instance_cores" {
  description = "Number of CPU cores per instance"
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "Memory in GB per instance"
  type        = number
  default     = 2
}

variable "instance_disk_size" {
  description = "Disk size in GB per instance"
  type        = number
  default     = 20
}

variable "ssh_public_key" {
  description = "SSH public key for instances"
  type        = string
}
