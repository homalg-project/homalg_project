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
./codecov -Z -v -s ../ -F homalg || (sleep 60; ./codecov -Z -v -s ../ -F homalg || (sleep 60; ./codecov -Z -v -s ../ -F homalg))
./codecov -Z -v -s ../ -F 4ti2Interface || (sleep 60; ./codecov -Z -v -s ../ -F 4ti2Interface || (sleep 60; ./codecov -Z -v -s ../ -F 4ti2Interface))
./codecov -Z -v -s ../ -F ExamplesForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F ExamplesForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F ExamplesForHomalg))
./codecov -Z -v -s ../ -F Gauss || (sleep 60; ./codecov -Z -v -s ../ -F Gauss || (sleep 60; ./codecov -Z -v -s ../ -F Gauss))
./codecov -Z -v -s ../ -F GaussForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F GaussForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F GaussForHomalg))
./codecov -Z -v -s ../ -F GradedModules || (sleep 60; ./codecov -Z -v -s ../ -F GradedModules || (sleep 60; ./codecov -Z -v -s ../ -F GradedModules))
./codecov -Z -v -s ../ -F GradedRingForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F GradedRingForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F GradedRingForHomalg))
./codecov -Z -v -s ../ -F HomalgToCAS || (sleep 60; ./codecov -Z -v -s ../ -F HomalgToCAS || (sleep 60; ./codecov -Z -v -s ../ -F HomalgToCAS))
./codecov -Z -v -s ../ -F IO_ForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F IO_ForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F IO_ForHomalg))
./codecov -Z -v -s ../ -F LocalizeRingForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F LocalizeRingForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F LocalizeRingForHomalg))
./codecov -Z -v -s ../ -F MatricesForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F MatricesForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F MatricesForHomalg))
./codecov -Z -v -s ../ -F Modules || (sleep 60; ./codecov -Z -v -s ../ -F Modules || (sleep 60; ./codecov -Z -v -s ../ -F Modules))
./codecov -Z -v -s ../ -F RingsForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F RingsForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F RingsForHomalg))
./codecov -Z -v -s ../ -F SCO || (sleep 60; ./codecov -Z -v -s ../ -F SCO || (sleep 60; ./codecov -Z -v -s ../ -F SCO))
./codecov -Z -v -s ../ -F ToolsForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F ToolsForHomalg || (sleep 60; ./codecov -Z -v -s ../ -F ToolsForHomalg))
