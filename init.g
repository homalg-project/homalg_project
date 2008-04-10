#############################################################################
##
##  init.g                    RingsForHomalg package  Mohamed Barakat
##                                                    Simon Görtzen
##                                                    Markus Lange-Hegermann
##                                                    Max Neunhöffer
##                                                    Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the RingsForHomalg package.
##
#############################################################################

ReadPackage( "RingsForHomalg", "gap/IO.gd" );

ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gd" );

ReadPackage( "RingsForHomalg", "gap/HomalgToCAS.gd" );

ReadPackage( "RingsForHomalg", "gap/ConvertHomalgMatrix.gd" );

## all the supported external computer algebra systems
ReadPackage( "RingsForHomalg", "gap/GAPHomalg.gd" );
ReadPackage( "RingsForHomalg", "gap/Singular.gd" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2.gd" );
ReadPackage( "RingsForHomalg", "gap/Sage.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMA.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalg.gd" );

## GAP
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gd" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gd" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gd" );

## Singular
ReadPackage( "RingsForHomalg", "gap/SingularTools.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/SingularGF2.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularQX.gd" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageTools.gd" );
ReadPackage( "RingsForHomalg", "gap/SageDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/SageIntegers.gd" );
ReadPackage( "RingsForHomalg", "gap/SageGF2.gd" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMADefault.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/MAGMA_PIR.gd" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgDefault.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gd" );

ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gd" );
