#/bin/bash

packages="4ti2Interface ExamplesForHomalg GaussForHomalg GradedModules homalg IO_ForHomalg MatricesForHomalg PolymakeInterface SCO ToricVarieties Convex Gauss GradedRingForHomalg HomalgToCAS LocalizeRingForHomalg Modules RingsForHomalg ToolsForHomalg"

base_dir="$PWD"

for i in ${packages}; do
  ./release --srcdir ${base_dir}/${i} --webdir ${base_dir}/gh-pages/${i} --update-file ${base_dir}/gh-pages/update.g
done

for i in ${packages}; do
  cp gh-pages/${i}/_data/package.yml gh-pages/_data/package${i}.yml
done

echo "Please push website now"

exit 0
