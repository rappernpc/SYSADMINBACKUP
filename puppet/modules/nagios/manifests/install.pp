class nagios::install{
	package { "nagios3" :
			ensure => present,
			require => User["nagios"],
	}
	package { "nagios-nrpe-plugin" :
			ensure => present,
			require => User["nagios"],
	}
	user	{ "nagios":
			ensure => present,
			comment => "nagios user",
			gid => "nagios",
			shell => "/bin/false",
			require => Group["nagios"],
	}
	group	{ "nagios" :
			ensure => present,
	}
}
