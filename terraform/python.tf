resource "null_resource" "package" {
  provisioner "local-exec" {
    working_dir = "${path.module}/../python/"
    command     = "python3 setup.py sdist"
  }
}

data "local_file" "package" {
  depends_on = [
  null_resource.package]
  filename = "${path.module}/../python/dist/sensors-0.1.tar.gz"
}