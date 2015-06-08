#############################################################################
##
##  init.g                    RingsForHomalg package         Mohamed Barakat
##                                                            Simon Goertzen
##                                                          Markus Kirschmer
##                                                    Markus Lange-Hegermann
##                                                           Max Neunhoeffer
##                                                            Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the RingsForHomalg package.
##
#############################################################################

## init
ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gd" );

## all the supported external computer algebra systems
ReadPackage( "RingsForHomalg", "gap/GAPHomalg.gd" );
ReadPackage( "RingsForHomalg", "gap/Singular.gd" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2.gd" );
ReadPackage( "RingsForHomalg", "gap/Sage.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMA.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalg.gd" );

## GAP (using the GAP implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBasic.gd" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gd" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gd" );

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gd" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gd" );

## Singular
ReadPackage( "RingsForHomalg", "gap/SingularBasic.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularBestBasis.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularTools.gd" );

ReadPackage( "RingsForHomalg", "gap/SingularGF2.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularQX.gd" );
ReadPackage( "RingsForHomalg", "gap/SingularGroebner.gd" );

## Macaulay2
ReadPackage( "RingsForHomalg", "gap/Macaulay2Basic.gd" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2Tools.gd" );

ReadPackage( "RingsForHomalg", "gap/Macaulay2_PIR.gd" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2Groebner.gd" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageBasic.gd" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gd" );
ReadPackage( "RingsForHomalg", "gap/SageTools.gd" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMABasic.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gd" );

ReadPackage( "RingsForHomalg", "gap/MAGMA_PIR.gd" );
ReadPackage( "RingsForHomalg", "gap/MAGMAGroebner.gd" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBasic.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gd" );

ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gd" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gd" );
