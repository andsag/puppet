class motd {
    file { "/etc/motd":
        ensure => present,
        owner => root,
        group => root,
        mode => 444,
        content => template("motd/motd.erb"),
    }
}
