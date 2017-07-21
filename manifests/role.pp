class role {
	include profile::basic
}

class role::webserver inherits role {
	include profile::web
}

class role::dbserver inherits role {
	include profile::database
}

class role::javaserver inherits role {
	include profile::java
}
