node default {
    include file
    include user

}
node 'puppetslave01.local.com' {
    include user
    $username = "bart"
    include stdlib
    include motd
    include init
    include sshdconfig
    include file
    include augeas	

}

node 'puppetslave02.local.com' {
    include user
    include motd
    include sshdconfig
    include augeas	
}
