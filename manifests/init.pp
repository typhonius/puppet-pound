class pound (
  $alive_time = 30,
  $log_level  = 3 ) {

  case $::operatingsystem {
    'Debian','Ubuntu': { 
      $pound_user     = 'www-data'
      $pound_config   = '/etc/pound/pound.cfg'
      $control_socket = '/var/run/pound/poundctl.socket'
      include pound::debian
    }
    'CentOS'         : { 
      $pound_user = 'apache'
      $pound_config = '/etc/pound.cfg'
      $control_socket = '/var/run/poundctl.socket'
      include pound::redhat
    }
    default          : { fail "Unknown ${::operatingsystem}" }
  }

}
