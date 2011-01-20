class network::centos::fixifupdown {
  file { "/etc/sysconfig/network-scripts/ifup-eth":
    owner => root,
    group => root,
    mode => 755,
    source => "puppet:///modules/network/centos/fixifupdown/ifup-eth",
  }
  file { "/etc/sysconfig/network-scripts/ifdown-eth":
    owner => root,
    group => root,
    mode => 755,
    source => "puppet:///modules/network/centos/fixifupdown/ifdown-eth",
  }
}
