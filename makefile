all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/MatricesForHomalg.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/MatricesForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" MatricesForHomalg/doc/*.* MatricesForHomalg/doc/clean MatricesForHomalg/gap/*.{gi,gd} MatricesForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} MatricesForHomalg/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/MatricesForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.MatricesForHomalg
	cp doc/manual.pdf ${WEBPOS}/MatricesForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/MatricesForHomalg.tar.gz ${WEBPOS}/MatricesForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s MatricesForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/MatricesForHomalg.tar.gz
