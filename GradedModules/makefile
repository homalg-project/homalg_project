all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi examples/*.g examples/doc/*.g
	        gap makedoc.g

docclean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

test-with-coverage:	doc
	! gap --banner --quitonbreak --cover stats maketest.g 2>&1 | grep -v "Running list" | grep ""
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

ci-test:	test-with-coverage

.PHONY: all doc docclean test
