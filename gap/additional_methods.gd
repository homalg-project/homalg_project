#############################################################################
##
##  additional_methods.gd  PolymakeInterface package       Sebastian Gutsche
##                                                            Thomas Bächler
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Additional GAP methods.
##
#############################################################################

DeclareOperationWithDocumentation( "POLYMAKE_SKETCH_WITH_OPTIONS",
                                   [ IsExternalPolymakeObject, IsList ],
                                   [ "This method produces the sketch output from polymake.",
                                     "Sketch have to be installed to use this method.",
                                     "The first argument must be a polymake external object,",
                                     "the second can be a filename, as a string, or a list of pairs",
                                     "specifying polymakes VISUAL options.",
                                     "In each pair the first entry needs to be the name of the option,",
                                     "the second should be the value it has to be given.",
                                     "As value strings and lists of integers are allowed.",
                                     "Please see the polymake documentation for more informations." ],
                                   "nothing",
                                   [ "Sketch", "Sketch_methods" ] );

DeclareOperationWithDocumentation( "POLYMAKE_SKETCH_WITH_OPTIONS",
                                   [ IsExternalPolymakeObject, IsString, IsList ],
                                   [ "This works like the other POLYMAKE_SKETCH_WITH_DOCUMENTATION method",
                                     "but one can give a filename and options at the same time.",
                                     "Second argument here needs to be the filename,",
                                     "third the list of VISUAL option pairs." ],
                                   "nothing",
                                   [ "Sketch", "Sketch_methods" ] );

DeclareOperationWithDocumentation( "POLYMAKE_CREATE_TIKZ_FILE",
                                   [ IsExternalPolymakeObject, IsString ],
                                   [ "Given a polymake object and a filename,",
                                     "this method produces the tikz output",
                                     "given by sketch and stores it in the file." ],
                                   "nothing",
                                   [ "Sketch", "Sketch_methods" ] );

DeclareOperationWithDocumentation( "POLYMAKE_CREATE_TIKZ_FILE",
                                   [ IsExternalPolymakeObject, IsString, IsList ],
                                   [ "This does the same as POLYMAKE_CREATE_TIKZ_FILE",
                                     "but the third argument is passed to the VISUAL command",
                                     "of polymake.",
                                     "It need to be a (possibly empty) list of options.",
                                     "The list must be consist of pairs,",
                                     "where the first entry is the name of the option",
                                     "the second the value.",
                                     "As values strings and lists of integers are allowed." ],
                                   "nothing",
                                   [ "Sketch", "Sketch_methods" ] );

DeclareOperationWithDocumentation( "POLYMAKE_CREATE_TIKZ_FILE_WITH_SKETCH_OPTIONS",
                                   [ IsExternalPolymakeObject, IsString, IsList, IsString ],
                                   [ "Works like POLYMAKE_CREATE_TIKZ_FILE with 3 arguments,",
                                     "but the last argument has to be a string of options passed directly to sketch.",
                                     "For example, if you want to have a compilable tex file build, add \"-T\"." ],
                                   "nothing",
                                   [ "Sketch", "Sketch_methods" ] );
