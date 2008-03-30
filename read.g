#############################################################################
##
##  read.g                    RingsForHomalg package         Mohamed Barakat
##                                                           Simon Görtzen
##                                                           Max Neunhöffer
##                                                           Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the homalg package.
##
#############################################################################

ReadPackage( "RingsForHomalg", "gap/gap.g" );
ReadPackage( "RingsForHomalg", "gap/singular.g" );
ReadPackage( "RingsForHomalg", "gap/macaulay2.g" );
ReadPackage( "RingsForHomalg", "gap/sage.g" );
ReadPackage( "RingsForHomalg", "gap/magma.g" );
ReadPackage( "RingsForHomalg", "gap/maple9.g" );
ReadPackage( "RingsForHomalg", "gap/maple95.g" );
ReadPackage( "RingsForHomalg", "gap/maple10.g" );
ReadPackage( "RingsForHomalg", "gap/maple11.g" );

ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gi" );

ReadPackage( "RingsForHomalg", "gap/IO.gi" );

ReadPackage( "RingsForHomalg", "gap/HomalgExternalMatrix.gi" );

## GAP
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gi" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gi" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageTools.gi" );
ReadPackage( "RingsForHomalg", "gap/SageDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/SageIntegers.gi" );
ReadPackage( "RingsForHomalg", "gap/SageGF2.gi" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgDefault.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gi" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMADefault.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gi" );

ReadPackage( "RingsForHomalg", "gap/MAGMA_Integers.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMA_GF2.gi" );

