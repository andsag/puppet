class jdk {

	exec { 'wget_jdk':
		command => "wget --no-cookies --no-check-certificate -P /tmp/ --header \"Cookie: oraclelicense=accept-securebackup-cookie\" \"http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm\"",
		path => "/usr/bin/",
		onlyif => ['test ! -f /tmp/jdk-8u131-linux-x64.rpm'],
	     }

	package { 'jdk1.8.0_131-2000:1.8.0_131-fcs.x86_64':
		ensure => installed,
    		provider => 'rpm',
    		source => "/tmp/jdk-8u131-linux-x64.rpm",
  		require => Exec["wget_jdk"],
		}

	exec { 'enviroment':
		command => "echo \"export JAVA_HOME=/usr/java/jdk1.8.0_131/jre\" > /etc/environment",
		path => "/bin/",
		require => Package['jdk1.8.0_131-2000:1.8.0_131-fcs.x86_64'],
	     }

}
