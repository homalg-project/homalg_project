#############################################################################
##
##  init.g                    HomalgToCAS package            Mohamed Barakat
##                                                             Thomas Breuer
##                                                            Simon Goertzen
##                                                              Frank Lübeck
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the HomalgToCAS package.
##
#############################################################################

## general stuff
ReadPackage( "HomalgToCAS", "gap/HomalgToCAS.gd" );

## pointers on external objects
ReadPackage( "HomalgToCAS", "gap/homalgExternalObject.gd" );

## external rings
ReadPackage( "HomalgToCAS", "gap/HomalgExternalRing.gd" );

## external matrices
ReadPackage( "HomalgToCAS", "gap/HomalgExternalMatrix.gd" );

## homalgSendBlocking
ReadPackage( "HomalgToCAS", "gap/homalgSendBlocking.gd" );

## IO
ReadPackage( "HomalgToCAS", "gap/IO.gd" );

## This is a workaround since GAP (<=4.4.12) does not load
## the implementation parts of the different packages
## in the same order as the declaration parts;
## I hope this becomes obsolete in the future
LOADED_HomalgToCAS_implementation := true;

## general stuff
ReadPackage( "HomalgToCAS", "gap/HomalgToCAS.gi" );

## pointers on external objects
ReadPackage( "HomalgToCAS", "gap/homalgExternalObject.gi" );

## external rings
ReadPackage( "HomalgToCAS", "gap/HomalgExternalRing.gi" );
