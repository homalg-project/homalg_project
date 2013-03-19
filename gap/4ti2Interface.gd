#############################################################################
##
##  4ti2Interface.gd                                    4ti2Interface package
##
##  Copyright 2013,               Sebastian Gutsche, RWTH-Aachen University
##
##  Reading the declaration part of the 4ti2Interface package.
##
#############################################################################

DeclareGlobalFunctionWithDocumentation( "4ti2Interface_Read_Matrix_From_File",
                                        [ "The argument must be a string, representing a filename of",
                                          "a matrix to read. Numbers must be seperated by whitespace,",
                                          "and the first two numbers must be the number of rows and columns.",
                                          "The function then returns the matrix as list of lists." ],
                                        "a list of lists of integers",
                                        [ "Tool_functions", "Tool_functions" ] );

DeclareGlobalFunctionWithDocumentation( "4ti2Interface_Write_Matrix_To_File",
                                        [ "First argument must be a matrix, i.e. a list of list",
                                          "of integers.",
                                          "Second argument has to be a filename.",
                                          "The method stores the matrix in this file,",
                                          "seperated by whitespace, line by line.",
                                          "The content of the file, if there is any,",
                                          "will be deleted." ],
                                        "nothing",
                                        [ "Tool_functions", "Tool_functions" ] );

DeclareGlobalFunctionWithDocumentation( "4ti2Interface_groebner_matrix",
                                        [ "This launches the 4ti2 groebner command with the",
                                          "argument as matrix input.",
                                          "It returns the output of the groebner command",
                                          "as a list of lists." ],
                                        "a list of lists of integers",
                                        [ "4ti2_functions", "groebner_function" ] );

DeclareGlobalFunctionWithDocumentation( "4ti2Interface_groebner_basis",
                                        [ "This launches the 4ti2 groebner command with the",
                                          "argument as matrix input.",
                                          "It returns the output of the groebner command",
                                          "as a list of lists." ],
                                        "a list of lists of integers",
                                        [ "4ti2_functions", "groebner_function" ] );
