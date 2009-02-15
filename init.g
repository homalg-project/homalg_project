#############################################################################
##
##  init.g                    IO_ForHomalg package           Mohamed Barakat
##                                                            Simon Goertzen
##                                                           Max Neunhoeffer
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the IO_ForHomalg package.
##
#############################################################################

## general stuff
ReadPackage( "IO_ForHomalg", "gap/IO_ForHomalg.gd" );

## pointers on external objects
ReadPackage( "IO_ForHomalg", "gap/homalgExternalObject.gd" );

## wrappers to some functionality of the IO package of Max
ReadPackage( "IO_ForHomalg", "gap/IO.gd" );

## external rings
ReadPackage( "IO_ForHomalg", "gap/HomalgExternalRing.gd" );

## external matrices
ReadPackage( "IO_ForHomalg", "gap/HomalgExternalMatrix.gd" );

## homalgSendBlocking
ReadPackage( "IO_ForHomalg", "gap/HomalgToCAS.gd" );

