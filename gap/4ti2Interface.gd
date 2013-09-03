#############################################################################
##
##                                                      4ti2Interface package
##
##  Copyright 2013,           Sebastian Gutsche, University of Kaiserslautern
##
##  Reading the declaration part of the 4ti2Interface package.
##
#############################################################################


#! @Chapter Introduction
#! @Section What is the idea of 4ti2Interface
#!  4ti2Interface is an GAP-Package that provides a link to the
#!  CAS 4ti2. It is not supposed to do any work by itself, but to provide 
#!  the methods in 4ti2 to GAP.\n 
#!  At the moment, it only capsules the groebner and hilbert method in 4ti2
#!  but there are more to come.
#!  If you have any questions or suggestions, please feel free to contact me,
#!  or leave an issue on https://github.com/homalg-project/4ti2Interface.git.

#! @Chapter Installation
#! @Section How to install this package
#!  This package can only be used on a system that has 4ti2 installed.
#!  For more information about this please visit <URL Text="www.4ti2.de">http://www.4ti2.de</URL>.
#!  For installing this package, first make sure you have 4ti2 installed. 
#!  Copy it in your GAP pkg-directory.
#!  After this, the package can be loaded via LoadPackage( "4ti2Interface" );


#! @Chapter 4ti2 functions

#! @Section Groebner

#! These are wrappers of some use cases of 4ti2s groebner command.

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


#! @Section Hilbert

#! These are wrappers of some use cases of 4ti2s hilbert command.

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
DeclareGlobalFunction( "4ti2Interface_hilbert_inequalities_in_positive_orthant" );

#! @Description
#!  This function produces the hilbert basis of the cone C given by
#!  the equations <A>A</A>x = 0 in the positive orthant of the coordinate system.
#! @Returns a list of vectors
#! @Arguments A
DeclareGlobalFunction( "4ti2Interface_hilbert_equalities_in_positive_orthant" );

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
DeclareGlobalFunction( "4ti2Interface_hilbert_equalities_and_inequalities_in_positive_orthant" );


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
