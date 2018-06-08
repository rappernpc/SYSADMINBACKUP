class nagios::config {
	file { '/etc/nagios3/htpasswd.users':
		ensure => present,
		source => 'puppet:///modules/nagios/htpasswd.users',
		mode => 0444,
		owner => 'nagios',
		group => 'nagios',
		require => Class['nagios::install'],
		notify => Class['nagios::service'],
	}

	file { '/etc/nagios3/nagios.cfg':
		ensure => present,
		source => 'puppet:///modules/nagios/nagios.cfg',
		mode => 0444,
		owner => 'nagios',
		group => 'nagios',
		require => Class['nagios::install'],
		notify => Class['nagios::service'],
	}
}
