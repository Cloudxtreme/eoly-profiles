class profiles::logstash {

  $logstash_es_server     = "redis.hq.sourcecurrent.net"
  $logstash_es_cluster    = "logstash"
 
  include '::profiles::java'

  class { '::logstash':
    ensure            => present,
    status            => 'enabled',
    manage_repo       => true,
    repo_version      => '1.4',
    java_install      => false,
    autoupgrade       => false,
    restart_on_change => false,
  }

  logstash::configfile { 'output_redis':
    content => template("${module_name}/logstash/output_redis.conf.erb"),
    order => 30
  }

}
