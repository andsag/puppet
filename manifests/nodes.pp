node default {
  case $machine_role {
    websrv:             { include role::webserver }
    dbsrv:               { include role::dbserver }
    javasrv:             { include role::javaserver }
    default:             { include role}
  }
}
