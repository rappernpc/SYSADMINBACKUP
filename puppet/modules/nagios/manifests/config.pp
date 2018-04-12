class nagios::config {
	file { "/etc/nagios3/htpasswd.users":
		ensure => present,
		source => "puppet:///modules/nagios/htpasswd.users",
		mode => 0444,
		owner => "nagios",
		group => "nagios",
		require => Class["nagios::install"],
		notify => Class["nagios::service"],
	}

	file { "/etc/nagios3/nagios.cfg":
		ensure => present,
		source => "puppet:///modules/nagios/nagios.cfg",
		mode => 0444,
		owner => "nagios",
		group => "nagios",
		require => Class["nagios::install"],
		notify => Class["nagios::service"],
	}

	nagios_contact { 'garribh1':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Brett',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email',
		host_notification_commands => 'notify-host-by-email',
		email => 'root@localhost',
	}
	

	nagios_contactgroup { 'sysadmins':
		target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
		alias => 'Systems Administrators',
		members => 'garribh1',
	}

	nagios_host { 'db.foo.org.nz':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'db',
		address => '10.25.137.140',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}

	nagios_service { 'MySQL':
		service_description => 'MySQL DB',
		hostgroup_name => 'db-servers',
		target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
		check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
		max_check_attempts => 3,
		retry_check_interval => 1,
		normal_check_interval => 5,
		check_period => '24x7',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'w,u,c',
		contact_groups => 'sysadmins',
	}

	nagios_hostgroup { 'db-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Database Servers',
		members => 'db.foo.org.nz',
	}
}

