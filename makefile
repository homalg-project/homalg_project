doc: doc/manual.six

doc/manual.six: doc/IO_ForHomalg.xml doc/install.xml \
		doc/examples.xml doc/intro.xml VERSION
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/IO_ForHomalg.tar.gz --exclude ".svn" --exclude test --exclude "public_html" IO_ForHomalg)

WEBPOS=~/gap/pkg/IO_ForHomalg/public_html

towww: archive
	echo '<?xml version="1.0" encoding="ISO-8859-1"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
#	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.IO_ForHomalg
	cp doc/manual.pdf ${WEBPOS}/IO_ForHomalg.pdf
	cp ../tar/IO_ForHomalg.tar.gz ${WEBPOS}

