Pound reverse proxy module
==========================

Status
------
This module is a fork of mrintegrity/puppet-pound that seeks to allow installation and configuration of pound on both debian and redhat based architecture.

Puppet-pound is heavilly inspired by the [CampToCamp bind] [1] module.

Features
--------
Manage a single /etc/pound/pound.cfg configuration, add entries for HTTP listeners and their backends.

Todo
----
* Rework the module a bit to follow best practice
* Some kind of support for managing the service with the poundctl command might be good to have (maybe even essential)

Usage
-----
``` puppet
#node.pp
    class { 'pound' :
      log_level  => 2,
      alive_time => 300,
    }
    pound::entry { 'ssl' :
      service         => false,
      listen_ip       => '0.0.0.0',
      listen_port     => '443',
      listen_protocol => 'ListenHTTPS',
      header_remove   => 'X-Forwarded-Proto',
      header_add      => 'X-Forwarded-Proto: https',
      cert            => [ '/etc/ssl/certs/webserver.pem', '/etc/ssl/certs/pound.pem' ],
    }
    pound::entry { 'test' :
      listen_ip       => '30.40.50.60',
      listen_port     => '8888',
      listen_protocol => 'ListenHTTP',
    }
    pound::entry { 'test1' :
      listen_ip => '0.0.0.0',
      listen_port => '8000',
      listen_protocol => 'ListenHTTP',
      head_require    => 'Host:.*files.myserver.com.*',
      service         => true,
      backend         => [ {
        ip   => '127.0.0.1',
        port => '9999'
      },
      {
        ip   => '127.0.0.2',
        port => '9998'
      }, ],
    }
    pound::entry { 'test2' :
      service      => true,
      head_require => 'Host:.*share.myserver.com.*',
      backend      => [ {
        ip   => '14.14.14.14',
        port => '9399'
      }, ],
    }
```
Copyright
---------
GPLv3 or later

[1]: https://github.com/camptocamp/puppet-bind        "CampToCamp Bind"
