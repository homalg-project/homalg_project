#!/bin/bash

set -e

# homalg
echo "Release homalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/homalg" --webdir "$PWD/gh-pages/homalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# 4ti2Interface
echo "Release 4ti2Interface"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/4ti2Interface" --webdir "$PWD/gh-pages/4ti2Interface" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ExamplesForHomalg
echo "Release ExamplesForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ExamplesForHomalg" --webdir "$PWD/gh-pages/ExamplesForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# Gauss
echo "Release Gauss"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/Gauss" --webdir "$PWD/gh-pages/Gauss" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GaussForHomalg
echo "Release GaussForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GaussForHomalg" --webdir "$PWD/gh-pages/GaussForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GradedModules
echo "Release GradedModules"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GradedModules" --webdir "$PWD/gh-pages/GradedModules" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GradedRingForHomalg
echo "Release GradedRingForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GradedRingForHomalg" --webdir "$PWD/gh-pages/GradedRingForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# HomalgToCAS
echo "Release HomalgToCAS"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/HomalgToCAS" --webdir "$PWD/gh-pages/HomalgToCAS" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# IO_ForHomalg
echo "Release IO_ForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/IO_ForHomalg" --webdir "$PWD/gh-pages/IO_ForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# LocalizeRingForHomalg
echo "Release LocalizeRingForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/LocalizeRingForHomalg" --webdir "$PWD/gh-pages/LocalizeRingForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# MatricesForHomalg
echo "Release MatricesForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/MatricesForHomalg" --webdir "$PWD/gh-pages/MatricesForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# Modules
echo "Release Modules"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/Modules" --webdir "$PWD/gh-pages/Modules" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# RingsForHomalg
echo "Release RingsForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/RingsForHomalg" --webdir "$PWD/gh-pages/RingsForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# SCO
echo "Release SCO"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/SCO" --webdir "$PWD/gh-pages/SCO" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ToolsForHomalg
echo "Release ToolsForHomalg"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ToolsForHomalg" --webdir "$PWD/gh-pages/ToolsForHomalg" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""
