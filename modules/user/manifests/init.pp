class user ($username = hiera("username")) {

	user { $username:
		ensure => 'present',
		home => "/home/$username",
		shell => '/bin/bash',
	}

notify {"Checkin $username .............. ":}

}
