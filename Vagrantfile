# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "liam"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "AKIAIYSLIYWFJR2QQ6UA"
    aws.secret_access_key = "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"
    aws.keypair_name = "lbuell"
    aws.security_groups = ['vagrant']

    aws.ami = "ami-7747d01e"


    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "/home/liam/.aws/lbuell.pem"
  end
end
