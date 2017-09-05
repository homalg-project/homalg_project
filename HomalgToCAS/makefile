all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi
	        gap makedoc.g

docclean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

.PHONY: all doc docclean test
