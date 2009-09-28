all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		doc/LocalizeRingForHomalg.xml doc/title.xml \
		doc/intro.xml doc/install.xml \
		doc/LocalizeRingForHomalg.bib gap/*.gd gap/*.gi \
		doc/LocalizeRing.xml \
		doc/examples.xml doc/appendix.xml \
		examples/* \
		VERSION PackageInfo.g
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/LocalizeRingForHomalg.tar.gz --exclude ".DS_Store" LocalizeRingForHomalg/doc/*.* LocalizeRingForHomalg/gap/*.{gi,gd} LocalizeRingForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} LocalizeRingForHomalg/examples/*.g)

WEBPOS=~/gap/pkg/LocalizeRingForHomalg/public_html
WEBPOS_FINAL=~/Sites/LocalizeRingForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.LocalizeRingForHomalg
	cp doc/manual.pdf ${WEBPOS}/LocalizeRingForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
#	cp ../tar/LocalizeRingForHomalg.tar.gz ${WEBPOS}

