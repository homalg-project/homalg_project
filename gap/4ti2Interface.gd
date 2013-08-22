#############################################################################
##
##  4ti2Interface.gd                                    4ti2Interface package
##
##  Copyright 2013,               Sebastian Gutsche, RWTH-Aachen University
##
##  Reading the declaration part of the 4ti2Interface package.
##
#############################################################################

#! @Chapter 4ti2 functions

#! @Section Groebner

#! @Description
#!  This launches the 4ti2 groebner command with the
#!  argument as matrix input.
#!  It returns the output of the groebner command
#!  as a list of lists.
#! @Returns A list of vectors
DeclareGlobalFunction( "4ti2Interface_groebner_matrix" );

#! @Description
#!  This launches the 4ti2 groebner command with the
#!  argument as matrix input.
#!  It returns the output of the groebner command
#!  as a list of lists.
#! @Returns A list of vectors
DeclareGlobalFunction( "4ti2Interface_groebner_basis" );


#! @Section Hilbert basis

#! @Description
#!  This function produces the hilbert basis of the cone C given
#!  by <A>A</A>x >= 0 for all x in C. For the second function also
#!  x >= 0 is assumed.
#! @Returns a list of vectors
#! @Arguments A
#! @Group for inequalities
DeclareGlobalFunction( "4ti2Interface_hilbert_inequalities" );

#! @Arguments A
#! @Group for inequalities
DeclareGlobalFunction( "4ti2Interface_hilbert_inequalities_in_positive_ortant" );

#! @Description
#!  This function produces the hilbert basis of the cone C given by
#!  the equations <A>A</A>x = 0 in the positive ortant of the coordinate system.
#! @Returns a list of vectors
#! @Arguments A
DeclareGlobalFunction( "4ti2Interface_hilbert_equalities_in_positive_ortant" );

#! @Description
#!  This function produces the hilbert basis of the cone C given by
#!  the equations <A>A</A>x = 0 and the inequations <A>B</A>x >= 0.
#!  For the second function x>=0 is assumend.
#! @Returns a list of vectors
#! @Arguments A, B
#! @Group for equalities and inequalities
DeclareGlobalFunction( "4ti2Interface_hilbert_equalities_and_inequalities" );

#! @Arguments A, B
#! @Group for equalities and inequalities
DeclareGlobalFunction( "4ti2Interface_hilbert_equalities_and_inequalities_in_positive_ortant" );


#! @Chapter Tool functions

#! @Section AutoDoc

#! @Description
#!  The argument must be a string, representing a filename of
#!  a matrix to read. Numbers must be seperated by whitespace,
#!  and the first two numbers must be the number of rows and columns.
#!  The function then returns the matrix as list of lists.
#! @Returns a list of vectors
DeclareGlobalFunction( "4ti2Interface_Read_Matrix_From_File" );

#! @Description
#!  First argument must be a matrix, i.e. a list of list
#!  of integers.
#!  Second argument has to be a filename.
#!  The method stores the matrix in this file,
#!  seperated by whitespace, line by line.
#!  The content of the file, if there is any,
#!  will be deleted.
#! @Returns nothing
DeclareGlobalFunction( "4ti2Interface_Write_Matrix_To_File" );
