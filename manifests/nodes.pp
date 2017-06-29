node default {
    include base
    include postgres
}
node 'puppetslave01.local.com' {
    include www	
    include base
    include postgres	
}
