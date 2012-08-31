LoadPackage( "AutoDoc" );

list_of_doc_entries := [
    [ "Introduction", "What_is_the_idea_of_PolymakeInterface",
    Concatenation( "PolymakeInterface is an GAP-Package that provides a link to the callable library ",
                   "of the CAS polymake. It is not supposed to do any work by itself, but to provide ",
                   "the methods in polymake to GAP. ",
                   "All the functions in this package are supposed to be capsuled by functions ",
                   "in the Convex package, which provides needed structures and datatypes.\n",
                   "Also the functions the have nicer names. ",
                   "This fact also causes that there are no doumentations for functions in this package. ",
                   "To get an overview about the supported functions, one might look at the polymake_main.cpp file ",
                   "or simply message the author. ",
                   "Working with this package alone without Convex is not recommended." ) ],
   [ "Installation", "How_to_install_this_package",
   Concatenation( "This package can only be compiled on a system that has polymake correctly installed, ",
                  "like it is said in the polymake wiki itself. ",
                  "For more information about this please visit www.polymake.org.\n",
                  "For installing this package, first make sure you have polymake installed. ",
                  "Copy it in your GAP pkg-directory and run the configure script (./configure) ",
                  "with your GAP root-directory as argument. ",
                  "The default is ../../... ",
                  "Then run make. ",
                  "After this, the package can be loaded via LoadPackage( \"PolymakeInterface\" );." ) ] ];

CreateAutomaticDocumentation( "PolymakeInterface", "gap/AutoDocEntries.g", "doc/", true, list_of_doc_entries );

QUIT;
