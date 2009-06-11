all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g VERSION \
		doc/IO_ForHomalg.bib doc/*.xml \
		gap/*.gd gap/*.gi
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL -x 80 maketest.g

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/IO_ForHomalg.tar.gz --exclude ".DS_Store" IO_ForHomalg/doc/*.* IO_ForHomalg/gap/*.{gi,gd} IO_ForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g})

WEBPOS=~/gap/pkg/IO_ForHomalg/public_html
WEBPOS_FINAL=~/Sites/IO_ForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.IO_ForHomalg
	cp doc/manual.pdf ${WEBPOS}/IO_ForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	cp ../tar/IO_ForHomalg.tar.gz ${WEBPOS}

