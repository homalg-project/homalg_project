#!/bin/bash

set -e

# homalg
echo "Release homalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/homalg" --webdir "$PWD/gh-pages/homalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# 4ti2Interface
echo "Release 4ti2Interface"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/4ti2Interface" --webdir "$PWD/gh-pages/4ti2Interface" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ExamplesForHomalg
echo "Release ExamplesForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ExamplesForHomalg" --webdir "$PWD/gh-pages/ExamplesForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# Gauss
echo "Release Gauss"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/Gauss" --webdir "$PWD/gh-pages/Gauss" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GaussForHomalg
echo "Release GaussForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GaussForHomalg" --webdir "$PWD/gh-pages/GaussForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GradedModules
echo "Release GradedModules"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GradedModules" --webdir "$PWD/gh-pages/GradedModules" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GradedRingForHomalg
echo "Release GradedRingForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GradedRingForHomalg" --webdir "$PWD/gh-pages/GradedRingForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# HomalgToCAS
echo "Release HomalgToCAS"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/HomalgToCAS" --webdir "$PWD/gh-pages/HomalgToCAS" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# IO_ForHomalg
echo "Release IO_ForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/IO_ForHomalg" --webdir "$PWD/gh-pages/IO_ForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# LocalizeRingForHomalg
echo "Release LocalizeRingForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/LocalizeRingForHomalg" --webdir "$PWD/gh-pages/LocalizeRingForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# MatricesForHomalg
echo "Release MatricesForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/MatricesForHomalg" --webdir "$PWD/gh-pages/MatricesForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# Modules
echo "Release Modules"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/Modules" --webdir "$PWD/gh-pages/Modules" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# RingsForHomalg
echo "Release RingsForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/RingsForHomalg" --webdir "$PWD/gh-pages/RingsForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# SCO
echo "Release SCO"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/SCO" --webdir "$PWD/gh-pages/SCO" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ToolsForHomalg
echo "Release ToolsForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ToolsForHomalg" --webdir "$PWD/gh-pages/ToolsForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""
