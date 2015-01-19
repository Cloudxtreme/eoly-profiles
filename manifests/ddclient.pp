class profiles::ddclient {

 $source_url = "https://github.com/wimpunk/ddclient/archive/master.zip"
 $packages = [ 'perl-JSON' ]

 package { $::profiles::ddclient::packages:
   ensure => present
 }

 staging::file { 'ddclient.zip':
   source => $::profiles::ddclient::source_url,
   target => '/opt/staging/ddclient.zip',
 }

 staging::extract { 'ddclient.zip':
   source  => '/opt/staging/ddclient.zip',
   target  => '/opt/staging',
   creates => '/opt/staging/ddclient-master',
   require => Staging::File['ddclient.zip'],
 }

}
