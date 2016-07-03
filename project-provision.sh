vagrant login
vagrant init centos/7; vagrant up --provider virtualbox
#vagrant provision VM 
vagrant ssh -c "if [ ! -f /usr/bin/puppet ] ; then sudo yum -q -y update; sudo yum install -q -y epel-release ; sudo  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm ; sudo yum -y -q install puppet; sudo puppet resource package git ensure=latest ; puppet module install jproyo-git ; puppet module install jfryman-nginx; puppet module install jfryman-selinux; sudo setenforce permissive; sudo puppet resource file /etc/puppet/manifests ensure=directory ; cd /etc/puppet/manifests ; if [ ! -d /etc/puppet/manifests/puppet-t ] ; then sudo git clone https://github.com/sergekov/puppet-t.git ; fi ; fi"
# Puppet NGINX configuration
vagrant ssh -c "sudo puppet apply /etc/puppet/manifests/puppet-t/project-configure.pp"
#if [ -f /usr/bin/puppet ] ; then echo AAA ; fi
