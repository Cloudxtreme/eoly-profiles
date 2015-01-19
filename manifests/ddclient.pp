class profiles::ddclient {

 $source_url = "https://github.com/wimpunk/ddclient/archive/master.zip"

 staging::file { 'ddclient.zip':
  source => $::profiles::ddclient::source_url,
  target => '/opt/staging/ddclient.zip',
 }

 staging::extract { 'ddclient.zip':
  target  => '/opt/staging/ddclient',
  creates => '/opt/staging/ddclient-master',
  require => Staging::File['ddclient.zip'],
 }

}
