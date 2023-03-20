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
while ! ./codecov -Z -v -s ../ -F homalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F 4ti2Interface; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F ExamplesForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F Gauss; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F GaussForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F GradedModules; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F GradedRingForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F HomalgToCAS; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F IO_ForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F LocalizeRingForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F MatricesForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F Modules; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F RingsForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F SCO; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F ToolsForHomalg; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
