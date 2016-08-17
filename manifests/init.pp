class ::fuse (
  Integer $mount_max        = 1000,
  Boolean $user_allow_other = false,
){

  require ::fuse::params

  package { 'FUSE (Filesystem in Userspace) Package':
    ensure => present,
    name   => $::fuse::params::package_name,
  }

  file { 'FUSE (Filesystem in Userspace) Configuration File':
    ensure  => file,
    path    => $::fuse::params::configuration_file,
    content => template('fuse/fuse.conf'),
    require => Package['FUSE (Filesystem in Userspace) Package'],
  }

}
