
.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(libname, pkgname) {
    packageStartupMessage("RVertica starting up. Note that we're still alpha at this point.")

    psqlpath <- unname(Sys.which("psql"))
    if (psqlpath == "") {
        warning("No 'psql' binary found. The package is not functional.")
    }
    packageStartupMessage("Good. We found 'psql' at '", psqlpath, "'.")
    assign("psqlpath", psqlpath, envir=.pkgenv)

    vhost <- Sys.getenv("VERTICAHOST", "")
    if (vhost == "") {
        warning("No environment variable 'VERTICAHOST' found, and no current fallback.")
    }
    packageStartupMessage("Good. We found 'VERTICAHOST' as an environment variable.")
    assign("vhost", vhost, envir=.pkgenv)
    Sys.setenv(PGHOST = vhost)

    vport <- Sys.getenv("VERTICAPORT", "")
    if (vport == "") {
        warning("No environment variable 'VERTICAPORT' found, and no current fallback.")
    }
    packageStartupMessage("Good. We found 'VERTICAPORT' as an environment variable.")
    assign("vport", vport, envir=.pkgenv)
    Sys.setenv(PGPORT = vport)

    vdb <- Sys.getenv("VERTICADATABASE", "")
    if (vdb == "") {
        warning("No environment variable 'VERTICADATABASE' found, and no current fallback.")
    }
    packageStartupMessage("Good. We found 'VERTICADATABASE' as an environment variable.")
    assign("vdb", vdb, envir=.pkgenv)
    Sys.setenv(PGDATABASE = vdb)

    vuser <- Sys.getenv("VERTICAUSER", "")
    if (vuser == "") {
        warning("No environment variable 'VERTICAUSER' found, and no current fallback.")
    }
    packageStartupMessage("Good. We found 'VERTICAUSER' as an environment variable.")
    assign("vuser", vuser, envir=.pkgenv)
    Sys.setenv(PGUSER = vuser)

    vpasswd <- Sys.getenv("VERTICAPASSWORD", "")
    if (vpasswd == "") {
        warning("No environment variable 'VERTICAPASSWORD' found, and no current fallback.")
    }
    packageStartupMessage("Good. We found 'VERTICAPASSWORD' as an environment variable.")
    assign("vpasswd", vpasswd, envir=.pkgenv)
    Sys.setenv(PGPASSWORD = vpasswd)

    vjar <- Sys.getenv("VERTICAJARPATH", "")
    if (vjar == "") {
        warning("No environment variable 'VERTICAJARPATH' found, and no current fallback.")
    }
    packageStartupMessage("Good. We found 'VERTICAJARPATH' as an environment variable.")
    if (file.exists(vjar)) {
        packageStartupMessage("Good. 'VERTICAJARPATH' points a an existing file.")
    }
    assign("vjar", vjar, envir=.pkgenv)
}
