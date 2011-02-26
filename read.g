#############################################################################
##
##  read.g                    RingsForHomalg package         Mohamed Barakat
##                                                            Simon Goertzen
##                                                          Markus Kirschmer
##                                                    Markus Lange-Hegermann
##                                                           Max Neunhoeffer
##                                                            Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the RingsForHomalg package.
##
#############################################################################

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then

## init
ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gi" );

## all the supported external computer algebra systems
ReadPackage( "RingsForHomalg", "gap/GAPHomalg.gi" );
ReadPackage( "RingsForHomalg", "gap/Singular.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2.gi" );
ReadPackage( "RingsForHomalg", "gap/Sage.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMA.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalg.gi" );

fi;

## GAP (using the GAP implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gi" );

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gi" );
fi;

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gi" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gi" );

## Singular
ReadPackage( "RingsForHomalg", "gap/SingularBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularBestBasis.gi" );

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then
ReadPackage( "RingsForHomalg", "gap/SingularTools.gi" );
fi;

ReadPackage( "RingsForHomalg", "gap/SingularGF2.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularQX.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularGroebner.gi" );

ReadPackage( "RingsForHomalg", "gap/LocalizePreRingMora.gi" );

## Macaulay2
ReadPackage( "RingsForHomalg", "gap/Macaulay2Basic.gi" );

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then
ReadPackage( "RingsForHomalg", "gap/Macaulay2Tools.gi" );
fi;

ReadPackage( "RingsForHomalg", "gap/Macaulay2_PIR.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2Groebner.gi" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gi" );

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then
ReadPackage( "RingsForHomalg", "gap/SageTools.gi" );
fi;

ReadPackage( "RingsForHomalg", "gap/SagePIR.gi" );
ReadPackage( "RingsForHomalg", "gap/SageFields.gi" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMABasic.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gi" );

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gi" );
fi;

ReadPackage( "RingsForHomalg", "gap/MAGMA_PIR.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMAGroebner.gi" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gi" );

if not ( IsBound( LOADED_RingsForHomalg_implementation ) and
         LOADED_RingsForHomalg_implementation = true ) then
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gi" );
fi;

ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gi" );
