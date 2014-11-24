class profiles::base {

  include ::epel

  $ntp_servers = hiera('ntp_servers')

  validate_array($ntp_servers)

  class { '::ntp':
    servers => $ntp_servers,
  }

}
