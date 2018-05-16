class bacula-storage::config {
	file { "/etc/bacula/bacula-sd.conf":
		ensure => present,
		source => "puppet:///modules/bacula-storage/bacula-sd.conf",
		mode => 0440,
		owner => 'bacula',
		group => 'bacula',
		require => Class["bacula-storage::install"],
		notify => Class["bacula-storage::service"],
	}
}
