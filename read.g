#############################################################################
##
##  read.g                    RingsForHomalg package         Mohamed Barakat
##                                                            Simon Goertzen
##                                                    Markus Lange-Hegermann
##                                                           Max Neunhoeffer
##                                                            Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the RingsForHomalg package.
##
#############################################################################

ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gi" );

## all the supported external computer algebra systems
ReadPackage( "RingsForHomalg", "gap/GAPHomalg.gi" );
ReadPackage( "RingsForHomalg", "gap/Singular.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2.gi" );
ReadPackage( "RingsForHomalg", "gap/Sage.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMA.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalg.gi" );

## GAP
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gi" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gi" );

## Singular
ReadPackage( "RingsForHomalg", "gap/SingularTools.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/SingularGF2.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularQX.gi" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageTools.gi" );
ReadPackage( "RingsForHomalg", "gap/SageDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/SageIntegers.gi" );
ReadPackage( "RingsForHomalg", "gap/SageGF2.gi" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMADefault.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/MAGMA_PIR.gi" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gi" );
