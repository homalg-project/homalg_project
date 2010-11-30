all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g \
		doc/IO_ForHomalg.bib doc/*.xml \
		gap/*.gd gap/*.gi
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/IO_ForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" IO_ForHomalg/doc/*.* IO_ForHomalg/doc/clean IO_ForHomalg/gap/*.{gi,gd} IO_ForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g})

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/IO_ForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.IO_ForHomalg
	cp doc/manual.pdf ${WEBPOS}/IO_ForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/IO_ForHomalg.tar.gz ${WEBPOS}/IO_ForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s IO_ForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/IO_ForHomalg.tar.gz
