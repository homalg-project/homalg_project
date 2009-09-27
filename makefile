all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/RingsForHomalg.bib doc/*.xml \
		gap/*.gd gap/*.gi
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/RingsForHomalg.tar.gz --exclude ".DS_Store" RingsForHomalg/doc/*.* RingsForHomalg/gap/*.{gi,gd} RingsForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} RingsForHomalg/maple/{homalg.*,PIR.*,Involutive.*,Janet.*,JanetOre.*})

WEBPOS=~/gap/pkg/RingsForHomalg/public_html
WEBPOS_FINAL=~/Sites/RingsForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.RingsForHomalg
	cp doc/manual.pdf ${WEBPOS}/RingsForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ../tar/RingsForHomalg.tar.gz ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}

