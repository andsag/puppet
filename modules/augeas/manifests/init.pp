class augeas {

 augeas{"hostfile" :
    context    => "/files/etc/hosts/5/",
    changes  => "set ipaddr 8.8.8.8",
  }

host { "asagan.local.com":
      ensure   => present,
      ip       => "10.1.2.3",
      provider => "augeas",
         }

host { "example.com":
  ensure   => absent,
  provider => augeas,
}

}
