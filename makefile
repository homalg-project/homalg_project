all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/HomalgToCAS.bib doc/*.xml \
		gap/*.gd gap/*.gi
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/HomalgToCAS.tar.gz --exclude ".DS_Store" HomalgToCAS/doc/*.* HomalgToCAS/gap/*.{gi,gd} HomalgToCAS/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g})

WEBPOS=~/gap/pkg/HomalgToCAS/public_html
WEBPOS_FINAL=~/Sites/HomalgToCAS

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.HomalgToCAS
	cp doc/manual.pdf ${WEBPOS}/HomalgToCAS.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	cp ../tar/HomalgToCAS.tar.gz ${WEBPOS}

