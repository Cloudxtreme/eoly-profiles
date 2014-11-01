class profiles::base {

  $ntp_servers = hiera('profiles::base::ntp_servers')

  validate_array($ntp_servers)

  class { 'ntp':
    servers => $ntp_servers,
  }

}
