doc: doc/manual.six

doc/manual.six: doc/HomalgToCAS.xml doc/install.xml \
		doc/examples.xml doc/intro.xml VERSION
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/HomalgToCAS.tar.gz --exclude ".svn" --exclude test --exclude "public_html" HomalgToCAS)

WEBPOS=~/gap/pkg/HomalgToCAS/public_html

towww: archive
	echo '<?xml version="1.0" encoding="ISO-8859-1"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
#	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.HomalgToCAS
	cp doc/manual.pdf ${WEBPOS}/HomalgToCAS.pdf
	cp ../tar/HomalgToCAS.tar.gz ${WEBPOS}

