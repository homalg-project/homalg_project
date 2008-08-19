doc: doc/manual.six

doc/manual.six: doc/SCO.xml doc/install.xml \
		doc/examples.xml doc/intro.xml VERSION
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/SCO.tar.gz --exclude ".git" --exclude test --exclude "public_html" --exclude "examples/data" SCO)

WEBPOS=~/gap/pkg/SCO/public_html

towww: archive
	echo '<?xml version="1.0" encoding="ISO-8859-1"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.SCO
	cp doc/manual.pdf ${WEBPOS}/SCO.pdf
	cp ../tar/SCO.tar.gz ${WEBPOS}
	cp doc/*.html ${WEBPOS}/

