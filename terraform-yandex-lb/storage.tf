# Создание бакета Object Storage
resource "yandex_storage_bucket" "images_bucket" {
  bucket     = "lebedev-vv-fops33-${formatdate("DD-MM-YYYY", timestamp())}"
  acl        = "public-read"
  folder_id  = var.yc_folder_id

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Загрузка картинки в бакет
resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.images_bucket.id
  key    = "image.jpg"
  source = "files/image.jpg"
  acl    = "public-read"
  
  depends_on = [
    yandex_storage_bucket.images_bucket
  ]
}

# Формирование URL картинки
locals {
  image_url = "https://${yandex_storage_bucket.images_bucket.bucket_domain_name}/${yandex_storage_object.image.key}"
}

# Вывод URL картинки
output "image_url" {
  value = local.image_url
}
