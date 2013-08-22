all: doc

doc: doc/manual.six

doc/manual.six: makedoc.g ListOfDocFiles.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/4ti2Interface.tar.gz --exclude ".DS_Store" --exclude "*~" 4ti2Interface/doc/*.* 4ti2Interface/doc/clean 4ti2Interface/gap/*.{gi,gd} 4ti2Interface/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,ListOfDocFiles.g} )

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/4ti2Interface

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.4ti2Interface
	cp doc/manual.pdf ${WEBPOS}/4ti2Interface.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/4ti2Interface.tar.gz ${WEBPOS}/4ti2Interface-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s 4ti2Interface-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/4ti2Interface.tar.gz
