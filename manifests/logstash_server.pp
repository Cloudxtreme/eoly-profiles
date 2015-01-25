class profiles::logstash_server {

  $logstash_redis_server  = "localhost"
  $logstash_redis_key     = "logstash"
 
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

  logstash::configfile { 'input_redis':
    content => template("${module_name}/logstash/input_redis.conf.erb"),
    order => 10
  }

}
