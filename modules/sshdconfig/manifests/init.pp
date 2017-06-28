class sshdconfig ( $serviceName = hiera("sshservicename") ){
 
    file { "/tmp/test":
        ensure => present,
        owner => root,
        group => root,
        mode => 444,
        content => $serviceName
    }

    service { $serviceName:
        ensure => 'running',
        enable => 'true',
    }
}
