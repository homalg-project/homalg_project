LoadPackage( "AutoDoc" );

list_of_doc_entries := [
    [ "Introduction", "What_is_the_idea_of_4ti2Interface",
    Concatenation( "4ti2Interface is an GAP-Package that provides a link to the",
                   "CAS 4ti2. It is not supposed to do any work by itself, but to provide ",
                   "the methods in 4ti2 to GAP.\n ",
                   "At the moment, it only capsules the groebner method in 4ti2",
                   "but there are more to come." ) ],
   [ "Installation", "How_to_install_this_package",
   Concatenation( "This package can only be used on a system that has 4ti2 installed.\n ",
                  "For more information about this please visit <URL Text=\"www.4ti2.de\">http://www.4ti2.de</URL>.\n",
                  "For installing this package, first make sure you have 4ti2 installed. ",
                  "Copy it in your GAP pkg-directory.",
                  "After this, the package can be loaded via LoadPackage( \"4ti2Interface\" );." ) ] ];

CreateAutomaticDocumentation( "4ti2Interface", "gap/AutoDocEntries.g", "doc/", true, list_of_doc_entries );

QUIT;
