class profiles::ssl {

  $ca_cert      = hiera('ca_cert')
  $host_key     = hiera('host_key')
  $host_cert    = hiera('host_cert')

  validate_string(
    $::profiles::ssl::ca_cert,
    $::profiles::ssl::host_key,
    $::profiles::ssl::host_cert
  )

  File {
    owner => 'root',
    group => 'root',
    mode  => '0440',
  }

  package { 'ca-certificates':
    ensure => present
  } ->

  file { '/etc/pki/ca-trust/source/anchors/sourcecurrent-ca.cert.pem':
    ensure  => file,
    content => $::profiles::ssl::ca_cert
  } ->

  exec { 'update-ca-trust':
    command => '/bin/update-ca-trust',
  } ->

  file { "/etc/pki/tls/private/${::fqdn}.key":
    ensure => file,
    content => $::profiles::ssl::host_key
  } ->

  file { "/etc/pki/tls/certs/${::fqdn}}.crt":
    ensure  => file,
    mode    => '0444',
    content => $::profiles::ssl::host_cert
  }

}
