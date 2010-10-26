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

