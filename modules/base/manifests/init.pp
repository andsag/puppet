class base {

	package { "epel-release": 
		ensure => present,
		allow_virtual => true,
		}

	package { "mc":
		ensure => present,
		require =>Package["epel-release"],
		allow_virtual => true,	
		}

	package { "htop":
                ensure => present,
                require =>Package["epel-release"],
                allow_virtual => true,
		}

	package { "vim":
		ensure => present,
		require =>Package["epel-release"],
		allow_virtual => true,
		}

	file   { "/etc/motd":
               ensure => present,
               owner => root,
               group => root,
               mode => 444,
               content => template("base/motd.erb"),
               }

	package { wget:
                ensure => present,
                require =>Package["epel-release"],
		allow_virtual => true,
        	}

        file       { '/etc/selinux/config':
                   ensure => present,
                   }->
        file_line  { 'selinux':
                   path  => '/etc/selinux/config',
                   line  => 'SELINUX=disabled',
                   match => 'SELINUX=enforcing',
                   }

	service { 'chronyd':
		ensure => running,
		enable => true,
		}

	exec    { "ipv6":
		command =>"sysctl -w net.ipv6.conf.all.disable_ipv6=1; sysctl -w net.ipv6.conf.default.disable_ipv6=1",
		path => "/sbin/"
		}
 
	exec    { "timezone":
                command =>"timedatectl set-timezone Europe/Warsaw",
                path => "/usr/bin/"
		}
}
