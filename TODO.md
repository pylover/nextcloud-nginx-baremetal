# nextcloud baremetal installer

This project is for manual installation of the nextcloud on Ubuntu server 
with nginx and php-fpm.

the instruction is:
- user must copy the `vars.example` to `.vars` and edit the variables.
- then executes the `install.sh`

## nci1 - download and verify the nextcloud archive
- edit the install.sh
- download the archive if the archive is not downloaded yet. otherwise
  use the existing archive in the tmp directory.
- use the checksumfile to verify the archive. the checksumfile structure is:
```
26aad8a3afdc1aa56349581bf75053e0  nextcloud-34.0.3.tar.bz2
cbc566425d969370e2df4d9be6e279cd  nextcloud-34.0.3.metadata
```
  So, you need to use the first column of the first line to verify the md5 
  checksum.

## nci2 - re-download if verification fails
- re-download the archive if md5sum verfication failes.
