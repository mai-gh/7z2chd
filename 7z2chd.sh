#!/bin/bash
set -uex

function 7z2chd {
  if [ ${#} -lt 1 ]; then
    echo "ERROR: must provide a 7z archive as only arguement"
    echo "USAGE: ${0} INPUT_ARCHIVE.7z"
    exit 1
  fi
  
  if ! type -P 7z > /dev/null; then
    echo "7z not found"
    echo "install with: # pacman -S p7zip"
    exit 1
  fi
  
  if ! type -P chdman > /dev/null; then
    echo "chdman not found"
    echo "install with: # pacman -S mame-tools"
    exit 1
  fi
  
  if ! test -f "${1}"; then
    echo "file not found: ${1}"
    exit 1
  fi
  
  OUTDIR='.'
  TMPDIR='/tmp/7z2chd_tmp'
  BASENAME=`basename "${1}" .7z`
  CUENAME="${BASENAME}.cue"
  CHDNAME="${BASENAME}.chd"
  
  if test -f "${OUTDIR}/${CHDNAME}"; then
    echo "FOUND: ${OUTDIR}/${CHDNAME}"
    echo "Skipping..."
    exit 0
  fi
  
  if test -d "${TMPDIR}"; then
    rm -rf "${TMPDIR}"
  fi
  
  7z x "${1}" -o"${TMPDIR}"
  chdman createcd -i "${TMPDIR}/${CUENAME}" -o "${TMPDIR}/${CHDNAME}"
  cp "${TMPDIR}/${CHDNAME}" "${OUTDIR}/${CHDNAME}"
  rm -rf "${TMPDIR}"
}


export -f 7z2chd
find ../ -name "*.7z" -exec bash -c '7z2chd "$0"' {} \;
