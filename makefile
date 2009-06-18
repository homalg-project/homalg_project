all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/SCOBib.xml.bib doc/*.xml \
		gap/*.gd gap/*.gi
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/SCO.tar.gz --exclude ".DS_Store" SCO/doc/*.* SCO/gap/*.{gi,gd} SCO/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g})

WEBPOS=~/gap/pkg/SCO/public_html
WEBPOS_FINAL=~/Sites/SCO

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

