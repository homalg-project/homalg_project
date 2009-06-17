all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		doc/ExamplesForHomalg.xml doc/title.xml \
		doc/intro.xml doc/install.xml \
		doc/ExamplesForHomalg.bib gap/*.gd gap/*.gi \
		doc/examples.xml examples/*.g \
		PackageInfo.g VERSION
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/ExamplesForHomalg.tar.gz --exclude ".DS_Store" ExamplesForHomalg/doc/*.* ExamplesForHomalg/gap/*.{gi,gd} ExamplesForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} ExamplesForHomalg/examples/*.g)

WEBPOS=~/gap/pkg/ExamplesForHomalg/public_html
WEBPOS_FINAL=~/Sites/ExamplesForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.ExamplesForHomalg
	cp doc/manual.pdf ${WEBPOS}/ExamplesForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ../tar/ExamplesForHomalg.tar.gz ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}

