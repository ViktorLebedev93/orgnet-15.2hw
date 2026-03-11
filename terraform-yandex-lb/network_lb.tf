# Создание сетевого балансировщика
resource "yandex_lb_network_load_balancer" "lb" {
  name = "lamp-network-load-balancer"

  listener {
    name        = "http-listener"
    port        = 80
    target_port = 80
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_group.load_balancer[0].target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

# Вывод IP балансировщика
output "load_balancer_ip" {
  description = "Public IP address of the network load balancer"
  value = one(yandex_lb_network_load_balancer.lb.listener[*].external_address_spec[*].address)
}
