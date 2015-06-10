all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/GradedModulesForHomalg.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g examples/doc/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap -b maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/GradedModules.tar.gz --exclude ".DS_Store" --exclude "*~" GradedModules/doc/*.* GradedModules/doc/clean GradedModules/gap/*.{gi,gd} GradedModules/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g} GradedModules/examples/*.g GradedModules/examples/doc/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/GradedModules

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.GradedModules
	cp doc/manual.pdf ${WEBPOS}/GradedModules.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/GradedModules.tar.gz ${WEBPOS}/GradedModules-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s GradedModules-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/GradedModules.tar.gz

