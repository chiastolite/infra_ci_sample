# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if ENV['WERCKER'] == "true"
    config.vm.hostname = 'infra-ci'
  else
    config.vm.hostname = 'infra-develop'
  end
  config.vm.box = 'chef/ubuntu-14.04'

  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = :latest
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box     = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    provider.image = 'Ubuntu 14.04 x64'
    provider.region = 'Singapore 1'
    provider.client_id = ENV['DO_CLIENT_ID']
    provider.api_key   = ENV['DO_API_KEY']

    if ENV['WERCKER'] == "true"
      provider.ssh_key_name = "wercker vagrant"
    else
      provider.ssh_key_name = "Vagrant"
    end
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = './cookbooks/'
    chef.run_list = %w(nginx)
  end
end
