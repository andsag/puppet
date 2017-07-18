class tomcat {

	exec { 'wget_tomcat':
		command => "wget -P /tmp/ http://ftp.ps.pl/pub/apache/tomcat/tomcat-8/v8.0.45/bin/apache-tomcat-8.0.45.tar.gz",
		path => "/usr/bin/",
		onlyif => ['test ! -f /tmp/apache-tomcat-8.0.45.tar.gz'],
	     }


  	group { 'tomcat':
    		ensure => 'present',
  	      }

	user { 'tomcat':
   		 ensure => 'present',
    	         shell => '/sbin/nologin',
                 groups => 'tomcat',
		 home => '/opt/tomcat',
		 require => Group['tomcat'],
             }

	file { '/opt/tomcat':
   		 ensure => 'directory',
    		 owner  => 'tomcat',
    		 group  => 'tomcat',
 	         require => [ User['tomcat'], Group['tomcat'] ],
	      }

	exec { 'extract':
                command => "tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1",
                path => "/bin/",
		require => Exec['wget_tomcat'],
		onlyif => ['test ! -d /opt/tomcat'],
             }

	exec { 'rights_conf':
                command => "chmod -R g+r /opt/tomcat/conf",
                path => "/bin/",
                require => Exec['extract'],
	     }

	exec { 'rights_conf_2':
                command => "chmod g+x /opt/tomcat/conf",
                path => "/bin/",
		require => Exec['extract'],
             }

	exec { 'owner':
                command => "chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/",
                path => "/bin/",
		require => Exec['extract'],
             }

	file { '/etc/systemd/system/tomcat.service':
   		ensure => 'present',
 	     	content => template("tomcat/tomcat.service"), 
	     }

	exec { 'reload':
                command => "systemctl daemon-reload",
                path => "/bin/",
                require => File['/etc/systemd/system/tomcat.service'],
             }
	
	service { 'tomcat' :
		provider => systemd,
		ensure => running,
		enable => true,
		require => File['/etc/systemd/system/tomcat.service'],
        	}

}
