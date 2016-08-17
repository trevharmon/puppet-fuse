class ::fuse::params {

  case $::osfamily {
    'Debian': {
      $configuration_file = '/etc/fuse'
      $package_name       = 'fuse'
    },
    'RedHat': {
      $configuration_file = '/etc/fuse'
      $package_name       = 'fuse'
    },
    default: {
      fail("Unsupported OS Family: $::osfamily")
    }
  }

}
