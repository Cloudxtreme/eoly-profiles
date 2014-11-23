class profiles::apache {

  class { '::apache': 
    default_vhost          => false,
    server_tokens          => 'ProductOnly',
    server_signature       => 'Off',
    serveradmin            => 'webmaster@ericolsen.net',
    server_root            => '/etc/httpd',
    keepalive              => 'Off',
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
    serverlimit         => '4096',
    maxclients          => '4096',
    maxrequestsperchild => '20000',
  }

  class { '::apache::mod::status':
    allow_from      => [ '127.0.0.1' ],
    extended_status => 'On',
  }

  apache::vhost { 'ericolsen.net':
    port              => '443',
    ip_based          => false,
    serveraliases     => [ 'www.ericolsen.net' ],
    access_log_format => 'combined',
    ssl               => true,
    ssl_protocol      => '-All +SSLv3 +TLSv1',
    ssl_cipher        => 'ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM',
    docroot           => '/var/www/www.ericolsen.net',
    directories       => [
      {
        path           => '/var/www/www.ericolsen.net',
        options        => [ '-Indexes','FollowSymLinks','MultiViews' ],
        order          => 'Allow,Deny',
        allow_override => 'None',
      }
    ],
  }

}
