class profiles::ddclient {

 $source_url = "https://github.com/wimpunk/ddclient/archive/master.zip"

 staging::file { 'ddclient':
  source => $::profiles::ddclient::source_url
 }
  
}
