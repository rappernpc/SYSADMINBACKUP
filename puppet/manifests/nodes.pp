node default {
}

node 'db' {
	package {'vim': ensure => present}
        include sudo
	include mysql
	include bacula-file
}

node 'storage' {
	package {'vim': ensure => present}
        include sudo
	include bacula-director
	include bacula-file
	include bacula-storage
}

node 'app' {
	package {'vim': ensure => present}
        include sudo
	include bacula-file
}

node 'mgmt' {
        include sudo
	include nagios
	include bacula-file
}

node 'AD' { 
	
}
