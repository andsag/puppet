node 'puppetslave01.local.com' {
	include role::webserver
}

node 'puppetslave02.local.com' {
	include role::dbserver
}
