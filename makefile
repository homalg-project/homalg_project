all: test

doc: doc/manual.six

doc/manual.six: makedoc.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/ToricVarieties.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi
	        gap makedoc.g

test:	doc
	gap maketest.g

clean:
	(cd doc ; ./clean)

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/ToricVarieties.tar.gz --exclude ".DS_Store" --exclude "*~" ToricVarieties/doc/*.* ToricVarieties/doc/clean ToricVarieties/gap/*.{gi,gd} ToricVarieties/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,ListOfDocFiles.g})

WEBPOS=public_html
WEBPOS_FINAL=~/public_html/gap_packages/ToricVarieties

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.ToricVarieties
	cp doc/manual.pdf ${WEBPOS}/ToricVarieties.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/ToricVarieties.tar.gz ${WEBPOS}/ToricVarieties-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s ToricVarieties-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/ToricVarieties.tar.gz
