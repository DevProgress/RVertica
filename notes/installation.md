
### Installing Vertica on Ubuntu 16.04

- Create a MyVertica account at https://my.vertica.com/

- Download the Debian / Ubuntu .deb from https://my.vertica.com/download/vertica/community-edition/
  (as of today: version 7.2.3-0, size of 150mb)

- Install it via `sudo dpkg -i vertica_7.2.3-0_amd64.deb`

- Follow up with sudo /opt/vertica/sbin/install_vertica
    + fails with 'stretch/sid' in `/etc/debian_version`, temporary this by
      manual edit/copy to an override of 'jessie/sid'
    + initial `sudo /opt/vertica/sbin/install_vertica --dba-user myuser` fails
    + create user: `sudo usermod -a -G verticadba myuser`
    + also do: `ulimit -n 65536` or it will fail later
    + with some short-cut overrides: `sudo /opt/vertica/sbin/install_vertica --dba-user myuser --data-dir /spare/vertica --failure-threshold HALT`

- Run admintools: `/opt/vertica/bin/adminTools`
    + Click OK for the Community Edition
    + Read and accept the EULA
    + Go to Configuration Menu then Create Database to create a test database which I named 'testdb'
    + Important (see above): `ulimit -n 65536`

- Also see https://my.vertica.com/docs/7.2.x/HTML/Content/Authoring/InstallationGuide/InstallingVertica/RunTheInstallScript.htm

- R Language Pack (also 7.2.3-0, 51.3mb)

- The install https://github.com/uber/vertica-python

- A missing detail: I had a bit of bear getting data into the db.  It is a
  combination of running the `vmart_gen` binary followed by a collection of
  the scripts to get the schemas created and loaded.  I didn;t take detailed
  notes here.
