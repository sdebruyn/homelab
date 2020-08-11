data "local_file" "package" {
  filename = "${path.module}/../python/dist/sensors-0.1.tar.gz"
}