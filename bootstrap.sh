#!/usr/bin/env sh
# Bootstrap LWPT.
#
# One-time per fresh clone (or after `lwpt build --clean`). Produces
# build/lwpt, after which `./build/lwpt build` is the canonical build
# entry point.
#
# Prefers scripts/bootstrap.pas via InstantFPC; falls back to a direct
# fpc invocation when InstantFPC is unavailable. Both code paths invoke
# fpc with the same -Fu / -Fi paths for source/ and every workspace
# package under packages/<name>/source/ (currently: httpclient, cli,
# semver, toml, testing).

set -eu

cd "$(dirname "$0")"

if command -v instantfpc >/dev/null 2>&1; then
  exec instantfpc scripts/bootstrap.pas "$@"
fi

echo "bootstrap.sh: instantfpc not found; falling back to direct fpc" >&2
mkdir -p build
fpc \
  -Mdelphi -Sh \
  -O- -gw -godwarfsets -gl \
  -Ct -Cr -Sa \
  -FEbuild \
  -Fusource \
  -Fisource \
  -Fupackages/httpclient/source \
  -Fipackages/httpclient/source \
  -Fupackages/cli/source \
  -Fipackages/cli/source \
  -Fupackages/semver/source \
  -Fipackages/semver/source \
  -Fupackages/toml/source \
  -Fipackages/toml/source \
  -Fupackages/testing/source \
  -Fipackages/testing/source \
  -obuild/lwpt \
  source/lwpt.pas
echo "bootstrap complete: build/lwpt"
