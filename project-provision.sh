vagrant login
vagrant init centos/7; vagrant up --provider virtualbox
#vagrant provision VM 
vagrant ssh -c "sudo yum -q -y update; sudo yum install -q -y epel-release ; sudo  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm ; sudo yum -y -q install puppet; sudo puppet resource package git ensure=latest ; puppet module install jproyo-git ; puppet module install jfryman-nginx; puppet module install jfryman-selinux; sudo setenforce permissive; mkdir /etc/puppet/manifests ; cd /etc/puppet/manifests ; sudo git clone https://github.com/sergekov/puppet-t.git"
vagrant ssh -c "sudo puppet apply /etc/puppet/manifests/project-configure.pp
