# Create an entry in the pound config
define pound::entry (
    $listen_ip       = undef,
    $listen_port     = undef,
    $listen_protocol = undef,
    $head_require    = undef,
    $service         = false,
    $backend         = [],
  ) {

    include pound

    concat::fragment {
        "pound_entry-${name}" :
            target => "${pound::pound_config}",
            content => template('pound/entry.cfg.erb'),
            order => 30,
            notify  => Service['pound'],
    }
}
