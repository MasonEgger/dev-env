packer {
  required_plugins {
    docker = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
  }
}

source "digitalocean" "ubuntu" {
  image     = "ubuntu-20-04-x64"
  region    = "sfo3"
  size      = "s-1vcpu-1gb"
  ssh_username = "root"
  snapshot_name = "devenv-${formatdate("YYYY-MM-DD, hh:mm", timestamp())}"
}

build {
  name = "developer-environment"
  sources = [
    "source.digitalocean.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    //extra_arguments = [ "-vvvv" ]
  }
/*  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
*/
}




