class opengrok {


	exec { 'wget_opengrok':
		command => "wget -P /tmp/ https://github.com/OpenGrok/OpenGrok/releases/download/1.1-rc5/opengrok-1.1-rc5.tar.gz",
		path => "/usr/bin/",
		onlyif => ['test ! -f /tmp/opengrok-1.1-rc5.tar.gz'],
	     }->
	exec { 'structure':
                command => "cd /opt ; mkdir opengrok ;  cd opengrok/ ; mkdir data src etc ; cd src/",
                path => "/usr/bin/",
                onlyif => ['test ! -d /opt/opengrok'],
             }->
	exec { 'extract_grok':
                command => "tar xvf /tmp/opengrok-1.1-rc5.tar.gz -C /opt/opengrok/etc --strip-components=1",
                path => "/bin/",
		onlyif => ['test -d /opt/opengrok'],
             }->
	package { 'ctags':
		ensure => present,
		allow_virtual => true,
		}->
	exec {  "run opengrok":  
		command => "/opt/opengrok/etc/bin/OpenGrok deploy",
		environment => ["CATALINA_HOME=/opt/tomcat" , "OPENGROK_TOMCAT_BASE=/opt/tomcat" , "OPENGROK_INSTANCE_BASE=/opt/opengrok/src" , "JAVA_HOME=/usr/java/jdk1.8.0_131/jre"],
	     }


}
