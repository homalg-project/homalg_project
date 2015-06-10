all: test

doc: doc/manual.six

doc/manual.six: makedoc.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/Convex.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap -b maketest.g

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/Convex.tar.gz --exclude ".DS_Store" --exclude "*~" Convex/doc/*.* Convex/doc/clean Convex/gap/*.{gi,gd} Convex/{PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,ListOfDocFiles.g,maketest.g})

WEBPOS=public_html
WEBPOS_FINAL=~/public_html/gap_packages/Convex

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.Convex
	cp doc/manual.pdf ${WEBPOS}/Convex.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/Convex.tar.gz ${WEBPOS}/Convex-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s Convex-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/Convex.tar.gz
