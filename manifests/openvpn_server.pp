class profiles::openvpn_server {

  include '::openvpn'

  openvpn::conf { 'openvpn.conf':
    source => "puppet:///modules/${module_name}/openvpn_pugeye.conf"
  }

}
