class bacula-file::config {
	file { "/etc/bacula/bacula-fd.conf":
		ensure => present,
		source => "puppet:///modules/bacula-file/bacula-fd.conf",
		mode => 0440,
		owner => 'bacula',
		group => 'bacula',
		require => Class["bacula-file::install"],
		notify => Class["bacula-file::service"],
	}
}
