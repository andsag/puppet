class postgres {

	$pack = ['postgresql-server', 'postgresql-contrib']

	package { $pack:
		ensure => present,
		allow_virtual => true,
		}


	exec    { 'initialize':
		command => 'sudo postgresql-setup initdb',
		path => "/bin/",
		onlyif => ['test ! -f /var/lib/pgsql/data/pg_hba.conf'],
		}
	
	service {"postgresql":
		ensure => running,
		enable => true,
		require =>Package[$pack],
		}
		
	exec    { 'rights':
                command => "sed -i 's/md5/ident/g' /var/lib/pgsql/data/pg_hba.conf",
                path => "/bin/",
                notify => Service["postgresql"],
		}
	

}
