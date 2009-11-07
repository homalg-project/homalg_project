all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/SCOBib.xml.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/SCO.tar.gz --exclude ".DS_Store" --exclude "*~" SCO/doc/*.* SCO/doc/clean SCO/gap/*.{gi,gd} SCO/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} SCO/examples/*.g SCO/examples/orbifolds/*.g)

WEBPOS=~/gap/pkg/SCO/public_html
WEBPOS_FINAL=~/Sites/homalg-project/SCO

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.SCO
	cp doc/manual.pdf ${WEBPOS}/SCO.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ../tar/SCO.tar.gz ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}

