#!/bin/sh
# SPDX-FileCopyrightText: 2024 Simen Strange <https://github.com/dxlr8r/wrax>
# SPDX-License-Identifier: MIT
# Version: 0.1.0

set -eo pipefail

# set cwd to dirname of this script
CDPATH= cd -- "$(dirname -- "$0")"

b64() { 
  if base64 --version 2>&1 | head -n1 | grep -q 'GNU'; then
    base64 -w0 "$1"
  else
    base64 -i "$1"
  fi
}

append_install() {
  printf "printf '%%s\\\n' '"%s"' | base64 --decode > \"%s/%s\"\n" $(b64 bin/"$1") '$BINDIR' "$1"  >> 'install.sh'
  printf 'chmod +x "%s/%s"\n' '$BINDIR' "$1"  >> 'install.sh'
}

printf '%s\n' '#!/bin/sh' > 'install.sh'
printf '%s\n' 'BINDIR=${BINDIR:-"$HOME/bin"}' >> 'install.sh'
printf 'mkdir -p "%s"\n' '$BINDIR' >> 'install.sh'

append_install wrcmd
append_install wrcp
append_install wrsudo
