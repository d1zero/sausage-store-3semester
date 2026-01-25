resource "yandex_compute_disk" "sausage-store-vm-prod" {
  name     = "sausage-store-vm-prod"
  type     = "network-ssd"
  size     = 10
  image_id = "fd82odtq5h79jo7ffss3"
}

resource "yandex_compute_instance" "sausage-store-vm-prod" {
  name        = "vm-prod"
  platform_id = "standard-v1"
  network_interface {
    subnet_id = yandex_vpc_subnet.sausage_store_prod_subnet.id
    nat = true
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.sausage-store-vm-prod.id
  }

  network_interface {
    index  = 1
    subnet_id = yandex_vpc_subnet.sausage_store_prod_subnet.id
  }

  metadata = {
    ssh-keys = "sasuagestore:${file("./id_rsa.pub")}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./id_rsa")
    host        = self.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [ 
      "ping -c 5 google.com",
      "curl https://google.com"
     ]
  }
}