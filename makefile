all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/GradedRingForHomalg.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/GradedRingForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" GradedRingForHomalg/doc/*.* GradedRingForHomalg/doc/clean GradedRingForHomalg/gap/*.{gi,gd} GradedRingForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} GradedRingForHomalg/examples/*.g)

WEBPOS=~/gap/pkg/GradedRingForHomalg/public_html
WEBPOS_FINAL=~/public_html/GradedRingForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.GradedRingForHomalg
	cp doc/manual.pdf ${WEBPOS}/GradedRingForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/GradedRingForHomalg.tar.gz ${WEBPOS}/GradedRingForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s GradedRingForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/GradedRingForHomalg.tar.gz

