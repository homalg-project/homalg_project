#!/bin/bash

set -e

# get GPG key
curl -O https://keybase.io/codecovsecurity/pgp_keys.asc
# verify fingerprint
if ! gpg --import --import-options show-only --with-fingerprint pgp_keys.asc | grep "2703 4E7F DB85 0E0B BC2C  62FF 806B B28A ED77 9869"; then
    echo "Downloaded GPG key has wrong fingerprint"
    exit 1
fi
# import key into special keyring used by gpgv below
gpg --no-default-keyring --keyring ~/.gnupg/trustedkeys.kbx --import pgp_keys.asc

# get uploader with signatures
curl -O https://uploader.codecov.io/latest/linux/codecov
curl -O https://uploader.codecov.io/latest/linux/codecov.SHA256SUM
curl -O https://uploader.codecov.io/latest/linux/codecov.SHA256SUM.sig

# verify
gpgv codecov.SHA256SUM.sig codecov.SHA256SUM
shasum -a 256 -c codecov.SHA256SUM

# execute
chmod +x codecov
./codecov -Z -f "coverage*.json" -F homalg
./codecov -Z -f "coverage*.json" -F 4ti2Interface
./codecov -Z -f "coverage*.json" -F ExamplesForHomalg
./codecov -Z -f "coverage*.json" -F Gauss
./codecov -Z -f "coverage*.json" -F GaussForHomalg
./codecov -Z -f "coverage*.json" -F GradedModules
./codecov -Z -f "coverage*.json" -F GradedRingForHomalg
./codecov -Z -f "coverage*.json" -F HomalgToCAS
./codecov -Z -f "coverage*.json" -F IO_ForHomalg
./codecov -Z -f "coverage*.json" -F LocalizeRingForHomalg
./codecov -Z -f "coverage*.json" -F MatricesForHomalg
./codecov -Z -f "coverage*.json" -F Modules
./codecov -Z -f "coverage*.json" -F RingsForHomalg
./codecov -Z -f "coverage*.json" -F SCO
./codecov -Z -f "coverage*.json" -F ToolsForHomalg
