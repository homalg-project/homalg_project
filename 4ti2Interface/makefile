all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi examples/doc/*.g
			gap makedoc.g

clean:
	(cd doc ; ./clean)

test: doc
	gap tst/testall.g
