all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi examples/*.g examples/orbifolds/*.g
	        gap makedoc.g

docclean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

test-with-coverage:	doc
	gap --cover stats maketest.g | perl -pe 'END { exit $$status } $$status=1 if /Expected output/;'
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
