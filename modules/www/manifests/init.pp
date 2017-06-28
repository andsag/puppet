class www ( $servicename = hiera("servicewww")) {

	package { $servicename:
		ensure => present,
		}

	service { $servicename :
		ensure => running,
		enable => true,
		require => Package[$servicename],
        	}

        file { "/var/www/html/index.html":
                ensure => present,
                owner => apache,
                group => apache,
                mode => 444,
                content => "dupa",
                require => Package[$servicename],
        }

}

