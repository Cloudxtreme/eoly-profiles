class profiles::base {

  include ::epel

  $ntp_servers = hiera('ntp_servers')
  $user_groups = hiera('user_groups')

  validate_array($::profiles::base::ntp_servers)
  validate_hash($::profiles::base::user_groups)

  class { 'ntp':
    servers => $::profiles::base::ntp_servers,
  }

  create_resources(group,$::profiles::base::user_groups)

}
