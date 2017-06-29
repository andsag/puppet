class profile::basic {
	include base
}

class profile::web {
	include www
}

class profile::database {
	include postgres
}	
