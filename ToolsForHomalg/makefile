all: doc

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

docclean:
	(cd doc ; ./clean)

.PHONY: all doc docclean
