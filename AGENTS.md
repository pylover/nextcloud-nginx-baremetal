# Project guidelines

- Keep every line at 79 characters or fewer, including code, documentation,
  and configuration files.
- Use the `ncver` variable from `.vars` for the Nextcloud version. Do not
  hardcode a release version in scripts.
- When adding a project-wide rule, document it in this file so future changes
  follow the same conventions.
- Run `bash -n install.sh` after changing the installer.
