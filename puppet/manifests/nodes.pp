node default {
}

node 'db' {
	package {'vim': ensure => present}
        include sudo
	include mysql
}

node 'storage' {
	package {'vim': ensure => present}
        include sudo
}

node 'app' {
	package {'vim': ensure => present}
        include sudo
}

node 'mgmt' {
        include sudo
	include nagios
}

node 'AD' { 
	
}
