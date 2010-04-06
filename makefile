all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/GaussForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" GaussForHomalg/doc/*.* GaussForHomalg/doc/clean GaussForHomalg/gap/*.{gi,gd} GaussForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} GaussForHomalg/examples/*.g)

WEBPOS=~/gap/pkg/GaussForHomalg/public_html
WEBPOS_FINAL=~/Sites/homalg-project/GaussForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.GaussForHomalg
	cp doc/manual.pdf ${WEBPOS}/GaussForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/GaussForHomalg.tar.gz ${WEBPOS}/GaussForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s GaussForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/GaussForHomalg.tar.gz
