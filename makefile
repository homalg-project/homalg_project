all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/LocalizeRingForHomalg.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/LocalizeRingForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" LocalizeRingForHomalg/doc/*.* LocalizeRingForHomalg/doc/clean LocalizeRingForHomalg/gap/*.{gi,gd} LocalizeRingForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g} LocalizeRingForHomalg/examples/*.g)

WEBPOS=~/gap/pkg/LocalizeRingForHomalg/public_html
WEBPOS_FINAL=~/public_html/LocalizeRingForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.LocalizeRingForHomalg
	cp doc/manual.pdf ${WEBPOS}/LocalizeRingForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/LocalizeRingForHomalg.tar.gz ${WEBPOS}/LocalizeRingForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s LocalizeRingForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/LocalizeRingForHomalg.tar.gz

