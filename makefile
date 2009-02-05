all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		doc/Sheaves.xml doc/title.xml \
		doc/intro.xml doc/install.xml \
		doc/Sheaves.bib gap/*.gd gap/*.gi \
		doc/Modules.xml doc/Tate.xml \
		doc/examples.xml doc/appendix.xml \
		VERSION PackageInfo.g
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL maketest.g

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/Sheaves.tar.gz --exclude ".DS_Store" Sheaves/doc/*.* Sheaves/gap/*.{gi,gd} Sheaves/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g} Sheaves/examples/*.g)

WEBPOS=~/gap/pkg/Sheaves/public_html
WEBPOS_FINAL=~/Sites/Sheaves

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.Sheaves
	cp doc/manual.pdf ${WEBPOS}/Sheaves.pdf
	cp doc/*.{css,html} ${WEBPOS}
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
#	cp ../tar/Sheaves.tar.gz ${WEBPOS}

