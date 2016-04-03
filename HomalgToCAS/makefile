all: doc test

doc: doc/manual.six
	gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap -b maketest.g

.PHONY: all doc clean test
