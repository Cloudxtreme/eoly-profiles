class profiles::ddclient {

 $packages = [ 'perl-JSON','perl-JSON-Any' ]

 $source_url  = "https://github.com/wimpunk/ddclient/archive/master.zip"
 $target_dir  = '/opt/staging'
 $target_file = 'ddclient.zip'
 $target      = "$::profiles::ddclient::download_dir/$::profiles::ddclient::file_name"
 $extracted     = "$::profiles::ddclient::target_dir/ddclient-master"
 $config_source = "$::profiles::ddclient::extracted/sample-etc_ddclient.conf"
 $init_source   = "$::profiles::ddclient::extracted/sample-etc_rc.d_init.d_ddclient.redhat"

 $cloudflare_zone   = hiera('cloudflare_zone')
 $cloudflare_login  = hiera('cloudflare_login')
 $cloudflare_apikey = hiera('cloudflare_apikey')
 $cloudflare_record = hiera('cloudflare_record')

 package { $::profiles::ddclient::packages:
   ensure => present
 }

 file { '/etc/ddclient':
   ensure => directory,
   owner  => 'root',
   group  => 'root',
   mode   => '0755',
 } ->

 file { '/etc/ddclient/ddclient.conf':
   ensure  => present,
   owner   => 'root',
   group   => 'root',
   content => template("${module_name}/ddclient.conf.erb")
 }

 staging::file { $::profiles::ddclient::target_file:
   source => $::profiles::ddclient::source_url,
   target => $::profiles::ddclient::target,
 }

 staging::extract { $::profiles::ddclient::target_file:
   source  => $::profiles::ddclient::target,
   target  => $::profiles::ddclient::target_dir,
   creates => $::profiles::ddclient::extracted,
   require => Staging::File[$::profiles::ddclient::target_file],
 }

 exec { 'install_ddclient':
   command => "/bin/cp $::profiles::ddclient::extracted/ddclient /usr/local/bin/ddclient",
   require => Staging::Extract[$::profiles::ddclient::target_file],
 }

 exec { 'install_init':
   command => "/bin/cp $::profiles::ddclient::init_source /etc/init.d/ddclient",
   require => Staging::Extract[$::profiles::ddclient::target_file],
 }

}
