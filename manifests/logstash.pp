class profiles::logstash {
 
  include '::profiles::java'

  class { '::logstash':
    ensure            => present,
    status            => 'enabled'
    manage_repo       => true,
    repo_version      => '1.4',
    java_install      => false,
    autoupgrade       => false,
    restart_on_change => false,
  }

}
