terraform {
  required_version = ">= 0.13"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.default_zone
}

# Используем существующую VPC
data "yandex_vpc_network" "my_vpc" {
  name = "my-vpc"
}

# Используем существующую публичную подсеть
data "yandex_vpc_subnet" "public" {
  name = "public"
  depends_on = [data.yandex_vpc_network.my_vpc]
}
