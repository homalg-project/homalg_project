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
