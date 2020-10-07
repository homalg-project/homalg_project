#!/bin/bash

set -e

packages="homalg 4ti2Interface ExamplesForHomalg Gauss GaussForHomalg GradedModules GradedRingForHomalg HomalgToCAS IO_ForHomalg LocalizeRingForHomalg MatricesForHomalg Modules RingsForHomalg SCO ToolsForHomalg "

base_dir="$PWD"

for pkg in ${packages}; do
  ./release-gap-package --skip-existing-release --srcdir ${base_dir}/${pkg} --webdir ${base_dir}/gh-pages/${pkg} --update-file ${base_dir}/gh-pages/update.g $@
done
