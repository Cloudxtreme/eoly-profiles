class profiles::redis {

  class { '::redis::install':
    redis_package => true,
  }
  contain '::redis::install'

  redis::server {
    'logstash':
      redis_name   => 'logstash',
      redis_memory => '1g',
      redis_ip     => '0.0.0.0',
      redis_port   => 6379,
      running      => true,
  }
  
}
