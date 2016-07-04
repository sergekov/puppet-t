#vagrant login
#vagrant init centos/7; 
vagrant up --provider virtualbox
#Baseline reprovision VM layer if required
vagrant ssh -c "sudo /etc/puppet/manifests/puppet-t/baseline.sh"
# Puppet NGINX configuration
vagrant ssh -c "sudo puppet apply /etc/puppet/manifests/puppet-t/project-configure.pp"
