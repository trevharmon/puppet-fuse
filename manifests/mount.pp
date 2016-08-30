# Generic class for handling Fuse mount configuration

define fuse::mount (
  Array[String]            $mount_options       = [ "nodev", "nosuid"],
  Boolean                  $default_permissions = false,
  Boolean                  $allow_other         = false, # Mutually exclusive with $allow_root
  Boolean                  $allow_root          = false, # Mutually exclusive with $allow_others
  Boolean                  $kernel_cache        = false,
  Boolean                  $auto_cache          = false,
  Boolean                  $large_read          = false,
  Boolean                  $direct_io           = false,
  Optional[Intenter[1,32]] $max_read            = undef,
  Optional[Integer]    	   $max_readahead       = undef,
  Optional[Integer]        $max_write           = undef,
  Boolean                  $sync_read           = false, # handles async_read and sync_read
  Boolean                  $hard_remove         = false,
  Boolean                  $debug               = false,
  Optional[String]         $fsname              = undef,
  Optional[String]         $subtype             = undef,
  Boolean                  $use_ino             = false,
  Boolean                  $readdir_ino         = false,
  Boolean                  $nonempty            = false,
  Optional[String]         $umask               = undef,
  Optional[Integer]        $uid                 = undef,
  Optional[Integer]        $gid                 = undef,
  Boolean                  $blkdev              = false,
  Float                    $entry_timeout       = 1.0,
  Float                    $negative_timeout    = 0.0,
  Float                    $attr_timeout        = 1.0,
  Float                    $ac_attr_timeout     = $attr_timeout,
  Boolean                  $intr                = false,
  Optional[String]         $intr_signal         = undef,
  Boolean                  $iconv               = false,
  Optional[String]         $from_code           = undef,
  Optional[String]         $to_code             = undef,
  Boolean                  $subdir              = false,
  Boolean                  $rellinks            = false, # handles rellinks and norellinks
){

  include ::fuse

  if ($allow_other and $allow_root) {
    fail('Cannot have both $allow_others and $allow_root set to true')
  }
  if ($blkdev and !$fsname) {
    fail('Must specify $fsname when $blkdev is set to true')
  }
  if ($iconv) {
    if (!$from_code or !$to_code) {
      fail('Must specify both $from_code and $to_code when $iconv is set to true')
    }
  }
  else {
    if ($from_code or $to_code) {
      fail('$iconv must be set to true if $from_code or $to_code is set')
    }
  }
  if ($rellinks and !$subdir) {
    fail('Must set $subdir to true when $rellinks is set to true')
  }

}
