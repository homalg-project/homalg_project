#############################################################################
##
##  IO.gd                     IO_ForHomalg package            Thomas Bächler
##                                                           Mohamed Barakat
##                                                           Max Neunhoeffer
##                                                            Daniel Robertz
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff to use the GAP4 I/O package of Max Neunhoeffer.
##
#############################################################################

# our info class:
DeclareInfoClass( "InfoIO_ForHomalg" );
SetInfoLevel( InfoIO_ForHomalg, 1 );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "SendForkingToCAS" );

DeclareGlobalFunction( "SendToCAS" );

DeclareGlobalFunction( "CheckOutputOfCAS" );

DeclareGlobalFunction( "SendBlockingToCAS" );

#! @ChapterInfo Tools, Functions
#! @Arguments function, args
#! @Returns list
#! @Description
#!   Returns real time seconds of the call function( args ) as first entry of list, result of call as second.
DeclareGlobalFunction( "TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL" );
