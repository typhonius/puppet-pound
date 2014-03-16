class pound {

  case $::operatingsystem {
    'Debian','Ubuntu': { 
      $pound_user   = 'www-data'
      $pound_config = '/etc/pound/pound.cfg'
      include pound::debian
    }
    'CentOS'         : { 
      $pound_user = 'apache'
      $pound_config = '/etc/pound.cfg'
      include pound::redhat
    }
    default          : { fail "Unknown ${::operatingsystem}" }
  }

}
