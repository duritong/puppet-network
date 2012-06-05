define network::tap(
  $ensure = present,
  $bridge,
  $onboot = yes
){
  require network::tunctl

  file { "/etc/sysconfig/network-scripts/ifcfg-${name}":
    owner => root,
    group => root,
    mode => 600,
    content =>
      template("network/sysconfig/network-scripts/ifcfg.tap.erb"),
    ensure => $ensure,
    alias => "ifcfg-$name",
  }
  if $::operatingsystem == 'CentOS' and $::lsbmajdistrelease == 5 {
    require network::centos::fixifupdown
  }
  
  case $ensure {
    present: {
      exec { "/sbin/ifdown ${name}; /sbin/ifup ${name}":
        subscribe => File["ifcfg-${name}"],
        refreshonly => true,
        require => Network::Bridge[$bridge],
      }
    }
    absent: {
      exec { "/sbin/ifdown ${name}":
        before => [ File["ifcfg-${name}"], Network::Bridge[$bridge] ],
        onlyif => "/sbin/ifconfig ${name}",
      }
    }
  }
}
