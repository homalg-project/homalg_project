all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Doc.autodoc \
		gap/*.gd gap/*.gi examples/*.g examples/examplesmanual/*.g
	        gap makedoc.g

docclean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

.PHONY: all doc docclean test
