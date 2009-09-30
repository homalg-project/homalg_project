all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/homalg.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/homalg.tar.gz --exclude ".DS_Store" homalg/doc/*.* homalg/gap/*.{gi,gd} homalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} homalg/examples/*.g)

WEBPOS=~/gap/pkg/homalg/public_html
WEBPOS_FINAL=~/Sites/homalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.homalg
	cp doc/manual.pdf ${WEBPOS}/homalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ../tar/homalg.tar.gz ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}

