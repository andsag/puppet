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

	exec { 'wget_tomcat':
		command => "wget -P /tmp/ http://ftp.ps.pl/pub/apache/tomcat/tomcat-8/v8.0.45/bin/apache-tomcat-8.0.45.tar.gz",
		path => "/usr/bin/",
		onlyif => ['test ! -f /tmp/apache-tomcat-8.0.45.tar.gz'],
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
