class opengrok {


	exec { 'wget_opengrok':
		command => "wget -P /tmp/ https://github.com/OpenGrok/OpenGrok/releases/download/1.1-rc5/opengrok-1.1-rc5.tar.gz",
		path => "/usr/bin/",
		onlyif => ['test ! -f /tmp/opengrok-1.1-rc5.tar.gz'],
	     }


	exec { 'structure':
                command => "cd /opt ; mkdir opengrok ;  cd opengrok/ ; mkdir data src etc ; cd src/",
                path => "/usr/bin/",
                onlyif => ['test ! -d /opt/opengrok'],
             }->
	exec { 'extract_grok':
                command => "tar xvf /tmp/opengrok-1.1-rc5.tar.gz -C /opt/opengrok/etc --strip-components=1",
                path => "/bin/",
		onlyif => ['test -d /opt/opengrok'],
             }

	exec { 'CATALINA_HOME':
 		 environment => ["CATALINA_HOME=/opt/tomcat/"],
		 command => '/bin/echo $CATALINA_HOME > /tmp/bar',
	     }	
	
	exec { 'OPENGROK_TOMCAT_BASE':
                 environment => ["OPENGROK_TOMCAT_BASE=/opt/tomcat/"],
                 command => '/bin/echo $OPENGROK_TOMCAT_BASE > /tmp/bar',
             }

	exec { 'OPENGROK_INSTANCE_BASE':
                 environment => ["OPENGROK_INSTANCE_BASE=/opt/opengrok/src"],
                 command => '/bin/echo $OPENGROK_INSTANCE_BASE > /tmp/bar',
             }

	exec { 'OPENGROK_DEPLOY':
                command => 'OpenGrok deploy',
		path => "/opt/opengrok/etc/bin/",
             }

}
