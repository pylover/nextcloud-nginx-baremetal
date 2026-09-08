#! /usr/bin/env bash
set -euo pipefail

HERE="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
source "${HERE}/.vars"


log() {
  printf '[nextcloud-installer] %s\n' "$1"
}


download_archive() {
  log "downloading the archive"
  wget -O "${archive}" "${ncdurl}/${archivefilename}"
}


verify_archive() {
  local actual_checksum

  actual_checksum="$(md5sum "${archive}" | awk '{ print $1 }')"
  [[ "${actual_checksum}" == "${expected_checksum}" ]]
}


archivefilename="nextcloud-${ncver}.tar.bz2"
archive="${tmpdir}/${archivefilename}"
checksumurl="${ncdurl}/${archivefilename}.md5"
checksumfile="${tmpdir}/${archivefilename}.md5"

mkdir -p "${tmpdir}"

log "check existing archive"
if [[ -f "${archive}" ]]; then
  log "using existing archive: ${archive}"
else
  download_archive
fi

log "downloading the checksum file"
wget -q -O "${checksumfile}" "${checksumurl}"

expected_checksum="$(
  awk 'NR == 1 { print $1; exit }' "${checksumfile}" |
    tr '[:upper:]' '[:lower:]'
)"
if [[ ! "${expected_checksum}" =~ ^[[:xdigit:]]{32}$ ]]; then
  log "invalid MD5 checksum in ${checksumfile}"
  exit 1
fi

if ! verify_archive; then
  log "MD5 checksum failed; re-downloading the archive"
  download_archive

  if ! verify_archive; then
    log "MD5 checksum verification failed for ${archive}"
    exit 1
  fi
fi

log "MD5 checksum verified: ${archive}"
