class profiles::base {

  $ntp_servers = hiera('profiles::base::ntp_servers')

  class { 'ntp':
    servers => $ntp_servers,
  }

}
