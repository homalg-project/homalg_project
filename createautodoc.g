LoadPackage( "AutoDoc" );

list_of_doc_entries := [
    [ "Introduction", "What_is_the_idea_of_PolymakeInterface",
    Concatenation( "PolymakeInterface is an GAP-Package that provides a link to the callable library ",
                   "of the CAS polymake. It is not supposed to do any work by itself, but to provide ",
                   "the methods in polymake to GAP.\n ",
                   "All the functions in this package are supposed to be capsuled by functions ",
                   "in the Convex package, which provides needed structures and datatypes.\n",
                   "Also the functions the have nicer names.\n ",
                   "This fact also causes that there are no doumentations for functions in this package.\n ",
                   "To get an overview about the supported functions, one might look at the polymake_main.cpp file ",
                   "or simply message the author.\n ",
                   "Working with this package alone without Convex is not recommended." ) ],
   [ "Installation", "Install_polymake",
                [ "To make GAP and polymake work together porperly, one has to make sure that the two systems",
                  "are using the same GMP library.\n",
                  "You can choose the GMP which polymake uses by the flag --with-gmp=",
                  "in the polymake configure skript.\n",
                  "However, having BOTH systems using your systems GMP is HIGHLY recommended." ] ],
   [ "Installation", "How_to_install_this_package",
   Concatenation( "This package can only be compiled on a system that has polymake correctly installed, ",
                  "like it is said in the polymake wiki itself.\n ",
                  "For more information about this please visit <URL Text=\"www.polymake.org\">www.polymake.org</URL>.\n",
                  "For installing this package, first make sure you have polymake installed. ",
                  "Copy it in your GAP pkg-directory and run the configure script (./configure) ",
                  "with your GAP root-directory as argument.\n ",
                  "The default is ../../... ",
                  "Then run make. ",
                  "After this, the package can be loaded via LoadPackage( \"PolymakeInterface\" );." ) ] ];

CreateAutomaticDocumentation( "PolymakeInterface", "gap/AutoDocEntries.g", "doc/", true, list_of_doc_entries );

QUIT;
