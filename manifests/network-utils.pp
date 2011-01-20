class network::network-utils(
  $bridgeutils = 'installed',
  $tunctl = 'installed'
) 
{
  if $bridgeutils == 'installed' {
    package{'bridge-utils':
      ensure => present,
    }
  }
  if $tunctl == 'installed' {
    package{'tunctl':
      ensure => present,
    }
  }
}
