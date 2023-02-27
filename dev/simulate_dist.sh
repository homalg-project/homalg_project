#!/bin/bash

set -e

# homalg
echo "Simulate release of homalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/homalg" --webdir "$PWD/gh-pages/homalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# 4ti2Interface
echo "Simulate release of 4ti2Interface"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/4ti2Interface" --webdir "$PWD/gh-pages/4ti2Interface" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ExamplesForHomalg
echo "Simulate release of ExamplesForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/ExamplesForHomalg" --webdir "$PWD/gh-pages/ExamplesForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# Gauss
echo "Simulate release of Gauss"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/Gauss" --webdir "$PWD/gh-pages/Gauss" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# GaussForHomalg
echo "Simulate release of GaussForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/GaussForHomalg" --webdir "$PWD/gh-pages/GaussForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# GradedModules
echo "Simulate release of GradedModules"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/GradedModules" --webdir "$PWD/gh-pages/GradedModules" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# GradedRingForHomalg
echo "Simulate release of GradedRingForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/GradedRingForHomalg" --webdir "$PWD/gh-pages/GradedRingForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# HomalgToCAS
echo "Simulate release of HomalgToCAS"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/HomalgToCAS" --webdir "$PWD/gh-pages/HomalgToCAS" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# IO_ForHomalg
echo "Simulate release of IO_ForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/IO_ForHomalg" --webdir "$PWD/gh-pages/IO_ForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# LocalizeRingForHomalg
echo "Simulate release of LocalizeRingForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/LocalizeRingForHomalg" --webdir "$PWD/gh-pages/LocalizeRingForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# MatricesForHomalg
echo "Simulate release of MatricesForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/MatricesForHomalg" --webdir "$PWD/gh-pages/MatricesForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# Modules
echo "Simulate release of Modules"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/Modules" --webdir "$PWD/gh-pages/Modules" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# RingsForHomalg
echo "Simulate release of RingsForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/RingsForHomalg" --webdir "$PWD/gh-pages/RingsForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# SCO
echo "Simulate release of SCO"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/SCO" --webdir "$PWD/gh-pages/SCO" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ToolsForHomalg
echo "Simulate release of ToolsForHomalg"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/ToolsForHomalg" --webdir "$PWD/gh-pages/ToolsForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""
