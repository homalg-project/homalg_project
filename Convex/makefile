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


