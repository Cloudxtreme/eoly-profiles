class profiles::ddclient {

 $source_url = "https://github.com/wimpunk/ddclient/archive/master.zip"

 class { '::staging':
  path => '/opt/staging/ddclient'
 }

 staging::file { 'ddclient.zip':
  source => $::profiles::ddclient::source_url
 }

 staging::extract { 'ddclient.zip':
  require => Staging::File['ddclient.zip'],
 }
  
}
