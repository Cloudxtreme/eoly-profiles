class profiles::ddclient {

 $packages = [ 'perl-JSON','perl-JSON-Any' ]

 $source      = "https://github.com/wimpunk/ddclient/archive/master.zip"
 $target_dir  = '/opt/staging'
 $target_file = 'ddclient.zip'
 $target      = "$::profiles::ddclient::download_dir/$::profiles::ddclient::file_name"
 $extracted   = 'ddclient-master'

 package { $::profiles::ddclient::packages:
   ensure => present
 }

 file { '/etc/ddclient':
   ensure => directory,
   owner  => 'root',
   group  => 'root',
   mode   => '0755',
 }

 staging::file { $::profiles::ddclient::target_file:
   source => $::profiles::ddclient::source_url,
   target => $::profiles::ddclient::target,
 }

 staging::extract { $::profiles::ddclient::target_file:
   source  => $::profiles::ddclient::target,
   target  => $::profiles::ddclient::target_dir,
   creates => "$::profiles::ddclient::target_dir/$::profiles::ddclient::extracted",
   require => Staging::File[$::profiles::ddclient::target_file],
 }

}
