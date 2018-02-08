define network::alias(
    $ipaddress,
    $netmask   = undef,
    $network   = undef,
    $broadcast = undef,
    $ensure    = 'up'
){
  $interface = $name

  $onboot = $ensure ? {
    up => "yes",
    down => "no"
  }

  file {"/etc/sysconfig/network-scripts/ifcfg-${interface}":
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("network/sysconfig/network-scripts/ifcfg.interface.alias.erb"),
    alias   => "ifcfg-${interface}"
  }

  case $ensure {
    up: {
      exec { "/sbin/ifdown ${interface}; /sbin/ifup ${interface}":
        subscribe => File["ifcfg-${interface}"],
        refreshonly => true
      }
    }

    down: {
      exec { "/sbin/ifdown ${interface}":
        subscribe => File["ifcfg-${interface}"],
        refreshonly => true
      }
    }
  }
}
