node 'puppetslave01.local.com' {
	include role::webserver
}

node 'puppetslave02.local.com' {
	include role::dbserver
}

node 'puppetslave03.local.com' {
	include role
	include jdk
	include tomcat
}
