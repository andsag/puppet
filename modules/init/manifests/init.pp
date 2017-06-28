class init {
        package { vim:
                ensure => present,
		allow_virtual => true,
        }

       
        package { wget:
                ensure => present,
		allow_virtual => true,        
	}
  

	file { '/etc/selinux/config':
		  ensure => present,
	}

	file_line { 'selinux':
                path  => '/etc/selinux/config',
                line  => 'SELINUX=disabled',
                match => 'SELINUX=enforcing',
       }

}
