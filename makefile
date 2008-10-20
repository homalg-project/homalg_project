all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketst.g \
		doc/homalg.xml doc/title.xml \
		doc/intro.xml doc/install.xml \
		doc/homalg.bib gap/*.gd gap/*.gi \
		doc/Rings.xml doc/Matrices.xml \
		doc/Relations.xml doc/Generators.xml \
		doc/Modules.xml doc/Maps.xml \
		doc/Complexes.xml doc/ChainMaps.xml \
		doc/Bicomplexes.xml doc/BigradedObjects.xml \
		doc/SpectralSequences.xml doc/Functors.xml \
		doc/examples.xml doc/Project.xml \
		doc/appendix.xml VERSION
	        gapL makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gapL maketst.g

archive: doc
	(mkdir -p ../tar; cd ..; tar czvf tar/homalg.tar.gz --exclude ".git" --exclude "public_html" homalg)

WEBPOS=~/gap/pkg/homalg/public_html

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
#	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.homalg
	cp doc/manual.pdf ${WEBPOS}/homalg.pdf
	cp ../tar/homalg.tar.gz ${WEBPOS}

