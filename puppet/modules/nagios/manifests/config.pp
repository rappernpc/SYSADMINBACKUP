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

	nagios_contact { 'garribh1':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Brett',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email, notify-service-by-slack',
		host_notification_commands => 'notify-host-by-email, notify-host-by-slack',
		email => 'garribh1@student.op.ac.nz',
	}
	
	nagios_contact { 'garbca1':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Chris',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email, notify-service-by-slack',
		host_notification_commands => 'notify-host-by-email, notify-host-by-slack',
		email => 'garbca1@student.op.ac.nz',
	}	

	nagios_contactgroup { 'sysadmins':
		target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
		alias => 'Systems Administrators',
		members => 'garribh1, garbca1',
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

	nagios_host { 'storage.foo.org.nz':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'storage',
		address => '10.25.100.15',
		check_period => '24x7',
		max_check_attempts => 3, 
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}

	nagios_host { 'app.foo.org.nz':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'app',
		address => '10.25.137.141',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}
	
	nagios_service { 'Apache':
		service_description => 'Check Apache Web Server',
		hostgroup_name => 'app-server',
		target => '/etc/nagios3/conf.d/ppt_apache2_service.cfg',
		check_command => 'check_http',
		max_check_attempts => 3, 
		retry_check_interval => 1,
		normal_check_interval => 5,
		check_period => '24x7',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'w,u,c',
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

	nagios_hostgroup { 'servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Other Servers',
		members => 'storage.foo.org.nz, app.foo.org.nz',
	}
	nagios_hostgroup { 'app-server':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'App Server',
		members => 'app.foo.org.nz',
	}
}

