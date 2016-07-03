include git

class { selinux:
  mode => 'permissive',
}

git::repo{'nginx-website-content':
 path   => '/var/www/puppet-test',
 source => 'https://github.com/puppetlabs/exercise-webpage',
 update => true
}

class { 'nginx': }

nginx::resource::vhost { 'puppet-test.localhost':
  ensure  => present,
  listen_port => 8000,
  www_root => '/var/www/puppet-test',
  notify  => Class['::nginx::service']
}
