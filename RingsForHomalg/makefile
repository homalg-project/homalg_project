all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/RingsForHomalg.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/RingsForHomalg.tar.gz --exclude ".DS_Store" --exclude "*~" RingsForHomalg/doc/*.* RingsForHomalg/doc/clean RingsForHomalg/gap/*.{gi,gd} RingsForHomalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g} RingsForHomalg/maple/{homalg.*,PIR.*,Involutive.*,Janet.*,JanetOre.*,OreModules.*,QuillenSuslin.*} RingsForHomalg/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/RingsForHomalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.RingsForHomalg
	cp doc/manual.pdf ${WEBPOS}/RingsForHomalg.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/RingsForHomalg.tar.gz ${WEBPOS}/RingsForHomalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s RingsForHomalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/RingsForHomalg.tar.gz
