class opengrok {

	package { 'ctags':
                ensure => present,
                require =>Package["ctags"],
                allow_virtual => true,
		}



}
