#############################################################################
##
##  read.g                    IO_ForHomalg package           Mohamed Barakat
##                                                            Simon Goertzen
##                                                           Max Neunhoeffer
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the IO_ForHomalg package.
##
#############################################################################

## general stuff
ReadPackage( "IO_ForHomalg", "gap/IO_ForHomalg.gi" );

## pointers on external objects
ReadPackage( "IO_ForHomalg", "gap/homalgExternalObject.gi" );

## wrappers to some functionality of the IO package of Max
ReadPackage( "IO_ForHomalg", "gap/IO.gi" );

## external rings
ReadPackage( "IO_ForHomalg", "gap/HomalgExternalRing.gi" );

## external matrices
ReadPackage( "IO_ForHomalg", "gap/HomalgExternalMatrix.gi" );

## homalgSendBlocking
ReadPackage( "IO_ForHomalg", "gap/HomalgToCAS.gi" );

