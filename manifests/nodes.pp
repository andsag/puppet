node default {
    include base

}
node 'puppetslave01.local.com' {
    include stdlib
    include motd
    include init
    include sshdconfig
    include file
    include augeas	
    include www	
    include base
}
