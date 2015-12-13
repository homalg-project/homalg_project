all: test

doc: doc/manual.six

doc/manual.six: makedoc.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/ToricVarieties.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g examples/examplesmanual/*.g
	        gap makedoc.g

test:	doc
	gap maketest.g

clean:
	(cd doc ; ./clean)


