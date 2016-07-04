include git
include baseline


class baseline {
 $base_packages = [ 'epel-release', 'hiera', 'vim-common', 'vim-enhanced', 'bash', 'yum', 'rpm', 'deltarpm', 'tree', 'puppet'  ]
 package { 'puppetlabs-release':
     provider => 'rpm',
     ensure => installed,
     source => "http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm"
 } ->

 package { $base_packages: ensure => latest } ->

 file { "/etc/puppet/manifests": ensure => directory, owner => "root", group  => "root", mode  => "0755", } ->
 file { "/etc/puppet/hiera.yaml": ensure => link, target => '/etc/hiera.yaml' } ->

 git::repo{'manifests':
    path   => '/etc/puppet/manifests/puppet-t',
    source => 'https://github.com/sergekov/puppet-t',
    update => true
 } ->

 class { selinux:
    mode => 'permissive',
 }

} 

class { 'nginx':
  require => Class['::baseline']
}

git::repo{'nginx-website-content':
 path   => '/var/www/puppet-test',
 source => 'https://github.com/puppetlabs/exercise-webpage',
 update => true,
 require => [ Class['baseline'] ]
} ->

nginx::resource::vhost { 'puppet-test.localhost':
  ensure  => present,
  listen_port => 8000,
  www_root => '/var/www/puppet-test',
  notify  => Class['::nginx::service']
}
