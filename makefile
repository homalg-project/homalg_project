doc: doc/manual.six

doc/manual.six: doc/GaussForHomalg.xml doc/install.xml \
		doc/intro.xml VERSION
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/GaussForHomalg.tar.gz --exclude ".git" --exclude test --exclude "public_html" GaussForHomalg)

WEBPOS=~/gap/pkg/GaussForHomalg/public_html

towww: archive
	echo '<?xml version="1.0" encoding="ISO-8859-1"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.GaussForHomalg
	cp doc/manual.pdf ${WEBPOS}/GaussForHomalg.pdf
	cp ../tar/GaussForHomalg.tar.gz ${WEBPOS}
	cp doc/*.html ${WEBPOS}/

