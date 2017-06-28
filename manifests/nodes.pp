node default {
    include file
    include user

}
node 'puppetslave01.local.com' {
    include stdlib
    include motd
    include init
    include sshdconfig
    include file
    include augeas	
    include www	
}

node 'puppetslave02.local.com' {
    include motd
    include sshdconfig
    include augeas	
    include www
}
