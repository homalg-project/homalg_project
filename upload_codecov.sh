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
./codecov -Z || ./codecov -Z || ./codecov -Z
./codecov -Z -F homalg || ./codecov -Z -F homalg || ./codecov -Z -F homalg
./codecov -Z -F 4ti2Interface || ./codecov -Z -F 4ti2Interface || ./codecov -Z -F 4ti2Interface
./codecov -Z -F ExamplesForHomalg || ./codecov -Z -F ExamplesForHomalg || ./codecov -Z -F ExamplesForHomalg
./codecov -Z -F Gauss || ./codecov -Z -F Gauss || ./codecov -Z -F Gauss
./codecov -Z -F GaussForHomalg || ./codecov -Z -F GaussForHomalg || ./codecov -Z -F GaussForHomalg
./codecov -Z -F GradedModules || ./codecov -Z -F GradedModules || ./codecov -Z -F GradedModules
./codecov -Z -F GradedRingForHomalg || ./codecov -Z -F GradedRingForHomalg || ./codecov -Z -F GradedRingForHomalg
./codecov -Z -F HomalgToCAS || ./codecov -Z -F HomalgToCAS || ./codecov -Z -F HomalgToCAS
./codecov -Z -F IO_ForHomalg || ./codecov -Z -F IO_ForHomalg || ./codecov -Z -F IO_ForHomalg
./codecov -Z -F LocalizeRingForHomalg || ./codecov -Z -F LocalizeRingForHomalg || ./codecov -Z -F LocalizeRingForHomalg
./codecov -Z -F MatricesForHomalg || ./codecov -Z -F MatricesForHomalg || ./codecov -Z -F MatricesForHomalg
./codecov -Z -F Modules || ./codecov -Z -F Modules || ./codecov -Z -F Modules
./codecov -Z -F RingsForHomalg || ./codecov -Z -F RingsForHomalg || ./codecov -Z -F RingsForHomalg
./codecov -Z -F SCO || ./codecov -Z -F SCO || ./codecov -Z -F SCO
./codecov -Z -F ToolsForHomalg || ./codecov -Z -F ToolsForHomalg || ./codecov -Z -F ToolsForHomalg
