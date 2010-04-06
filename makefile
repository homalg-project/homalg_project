all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/ExamplesForHomalg.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/ExamplesForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" ExamplesForHomalg/doc/*.* ExamplesForHomalg/doc/clean ExamplesForHomalg/gap/*.{gi,gd} ExamplesForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} ExamplesForHomalg/examples/*.g)

WEBPOS=~/gap/pkg/ExamplesForHomalg/public_html
WEBPOS_FINAL=~/Sites/homalg-project/ExamplesForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.ExamplesForHomalg
	cp doc/manual.pdf ${WEBPOS}/ExamplesForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/ExamplesForHomalg.tar.gz ${WEBPOS}/ExamplesForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s ExamplesForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/ExamplesForHomalg.tar.gz
