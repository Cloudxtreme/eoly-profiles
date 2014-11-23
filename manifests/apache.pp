class profiles::apache {

  class { '::apache': 
    default_vhost          => false,
    server_tokens          => 'ProductOnly',
    server_signature       => 'Off',
    serveradmin            => 'webmaster@ericolsen.net',
    server_root            => '/etc/httpd',
    keepalive              => 'On',
    max_keepalive_requests => '500',
    keepalive_timeout      => '15',
    mpm_module             => false,
    trace_enable           => 'Off',
    vhost_dir              => '/etc/httpd/vhosts.d',
  }
  
  class { '::apache::mod::prefork':
    startservers        => '8',
    minspareservers     => '5',
    maxspareservers     => '20',
    maxclients          => '100',
    maxrequestsperchild => '1000',
  }

  class { '::apache::mod::status':
    allow_from      => [ '127.0.0.1' ],
    extended_status => 'On',
  }

  ::apache::vhost { 'ericolsen.net':
    port              => '80',
    ip_based          => false,
    serveraliases     => [ 'www.ericolsen.net' ],
    access_log_format => 'combined',
    docroot           => '/var/www/www.ericolsen.net',
    directories       => [
      {
        path           => '/var/www/www.ericolsen.net',
        options        => [ '-Indexes','+FollowSymLinks','+MultiViews' ],
        order          => 'Allow,Deny',
        allow_override => 'None',
      }
    ],
  }

}
