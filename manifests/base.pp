class profiles::base {

  $ntp_servers = hiera('ntp_servers')
  $local_users = hiera('local_users')

  validate_array($ntp_servers)
  validate_hash($local_users)

  class { 'ntp':
    servers => $ntp_servers,
  }

  create_resources(user, $local_users)

}
