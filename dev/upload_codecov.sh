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

# read the token
if [ -z "$CODECOV_TOKEN" ]; then
  echo -e "\033[0;33mCODECOV_TOKEN is not set. Proceeding without token.\033[0m"
else
  echo -e "\033[0;32mUsing CODECOV_TOKEN from environment variable.\033[0m"
fi

# execute
chmod +x codecov
while ! ./codecov -Z -v -s ../ -F homalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F 4ti2Interface -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F ExamplesForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F Gauss -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F GaussForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F GradedModules -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F GradedRingForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F HomalgToCAS -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F IO_ForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F LocalizeRingForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F MatricesForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F Modules -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F RingsForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F SCO -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
while ! ./codecov -Z -v -s ../ -F ToolsForHomalg -t $CODECOV_TOKEN; do
    echo "Codecov upload failed, retrying in 60s"
    sleep 60
done
