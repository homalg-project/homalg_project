all: doc

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		gap/*.gd gap/*.gi
	        gap makedoc.g

clean:
	(cd doc ; rm manual.six)


