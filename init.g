#############################################################################
##
##  init.g                    RingsForHomalg package         Mohamed Barakat
##                                                           Simon Görtzen
##                                                           Max Neunhöffer
##                                                           Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the RingsForHomalg package.
##
#############################################################################

ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gd" );

ReadPackage( "RingsForHomalg", "gap/IO.gd" );

ReadPackage( "RingsForHomalg", "gap/HomalgExternalMatrix.gd" );

## GAP
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gd" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gd" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gd" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageTools.gd" );
ReadPackage( "RingsForHomalg", "gap/SageDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/SageIntegers.gd" );
ReadPackage( "RingsForHomalg", "gap/SageGF2.gd" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gd" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMADefault.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/MAGMA_Integers.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMA_GF2.gd" );
