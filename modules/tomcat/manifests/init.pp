class tomcat {

  	group { 'tomcat':
    		ensure => 'present',
  	      } ->
	user  { 'tomcat':
   		 ensure => 'present',
    	         shell => '/sbin/nologin',
                 groups => 'tomcat',
		 home => '/opt/tomcat',
		 require => Group['tomcat'],
              }

	file { "/tmp/apache-tomcat-8.0.45.tar.gz":
        	ensure => file,
		source => 'puppet:///modules/tomcat/apache-tomcat-8.0.45.tar.gz',
    	     }->
	file { '/opt/tomcat':
   		 ensure => 'directory',
    		 owner  => 'tomcat',
    		 group  => 'tomcat',
	      }->
	exec { 'extract':
                command => "tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1",
                path => "/bin/",
		onlyif => ['test -d /opt/tomcat'],
             }->
	file { '/opt/tomcat/conf/tomcat-users.xml':
                ensure => 'present',
                content => template("tomcat/tomcat-users.xml"),
             }->
	exec { 'ownership':
                command => "chown -hR tomcat:tomcat /opt/tomcat",
                path => "/bin/",
                onlyif => ['test -d /opt/tomcat'],
	        before => Service['tomcat'], 
		}

	file { '/etc/systemd/system/tomcat.service':
   		ensure => 'present',
 	     	content => template("tomcat/tomcat.service"), 
	     }

	exec { 'reload':
                command => "systemctl daemon-reload",
                path => "/bin/",
                onlyif => ['test -f /etc/systemd/system/tomcat.service'],
             }

	service { 'tomcat' :
		provider => systemd,
		ensure => running,
		enable => true,
		before => Exec['reload'],
	}
}
