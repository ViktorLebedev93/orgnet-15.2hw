# Сервисный аккаунт для управления инстансами
resource "yandex_iam_service_account" "sa" {
  name        = "instance-group-sa"
  description = "Service account for instance group"
}

# Назначение роли editor сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Шаблон для user_data
data "template_file" "user_data" {
  template = file("user_data.tpl")
  vars = {
    image_url = local.image_url
  }
}

# Создание группы инстансов
resource "yandex_compute_instance_group" "lamp_group" {
  name               = "lamp-instance-group"
  folder_id          = var.yc_folder_id
  service_account_id = yandex_iam_service_account.sa.id
  depends_on         = [yandex_resourcemanager_folder_iam_member.sa-editor]

  instance_template {
    platform_id = "standard-v3"
    
    resources {
      cores  = var.instance_cores
      memory = var.instance_memory
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_image_id
        size     = var.instance_disk_size
      }
    }

    network_interface {
      network_id = data.yandex_vpc_network.my_vpc.id  # Используем data source
      subnet_ids = [data.yandex_vpc_subnet.public.id] # Используем data source
      nat        = true
    }

    metadata = {
      ssh-keys   = "ubuntu:${var.ssh_public_key}"
      user-data  = data.template_file.user_data.rendered
    }
  }

  scale_policy {
    fixed_scale {
      size = var.instance_group_size
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 1
    max_expansion   = 1
    max_deleting    = 1
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name = "lamp-target-group"
  }
}
