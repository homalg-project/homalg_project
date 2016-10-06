all: doc test

doc: 
	gap makedoc.g

docclean:
	(cd doc ; ./clean)

test:	doc
	gap -b maketest.g

.PHONY: all doc docclean test
