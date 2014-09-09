# Create an entry in the pound config
define pound::entry (
    $listen_ip       = undef,
    $listen_port     = undef,
    $listen_protocol = undef,
    $head_require    = undef,
    $service         = false,
    $backend         = [],
    $cert            = '/etc/ssl/certs/pound.pem',
    $header_add      = undef,
    $header_remove   = undef,
    $ciphers         = undef,
  ) {

    concat::fragment {
        "pound_entry-${name}" :
            target => "${pound::pound_config}",
            content => template('pound/entry.cfg.erb'),
            order => 30,
            notify  => Service['pound'],
    }
}
