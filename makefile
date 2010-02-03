all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/Sheaves.bib doc/*.xml \
		gap/*.gd gap/*.gi
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/Sheaves.tar.gz --exclude ".DS_Store" --exclude "*~" Sheaves/doc/*.* Sheaves/doc/clean Sheaves/gap/*.{gi,gd} Sheaves/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} Sheaves/examples/*.g)

WEBPOS=~/gap/pkg/Sheaves/public_html
WEBPOS_FINAL=~/Sites/homalg-project/Sheaves

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.Sheaves
	cp doc/manual.pdf ${WEBPOS}/Sheaves.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ../tar/Sheaves.tar.gz ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}

