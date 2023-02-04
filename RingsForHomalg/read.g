# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Reading the implementation part of the package.
#

## init
ReadPackage( "RingsForHomalg", "gap/RingsForHomalg.gi" );

## GAP (using the GAP implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgBestBasis.gi" );
ReadPackage( "RingsForHomalg", "gap/GAPHomalgTools.gi" );

ReadPackage( "RingsForHomalg", "gap/GAPHomalgPIR.gi" );
#ReadPackage( "RingsForHomalg", "gap/GAPHomalgInvolutive.gi" );

## Singular
ReadPackage( "RingsForHomalg", "gap/SingularBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularBestBasis.gi" );
ReadPackage( "RingsForHomalg", "gap/SingularTools.gi" );

ReadPackage( "RingsForHomalg", "gap/SingularGroebner.gi" );

## Macaulay2
ReadPackage( "RingsForHomalg", "gap/Macaulay2Basic.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2Tools.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2_PIR.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2Groebner.gi" );

## Sage
ReadPackage( "RingsForHomalg", "gap/SageBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/SageBestBasis.gi" );
ReadPackage( "RingsForHomalg", "gap/SageTools.gi" );
ReadPackage( "RingsForHomalg", "gap/SagePIR.gi" );
ReadPackage( "RingsForHomalg", "gap/SageFields.gi" );

## MAGMA
ReadPackage( "RingsForHomalg", "gap/MAGMABasic.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMABestBasis.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMATools.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMA_PIR.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMAGroebner.gi" );

## Maple (using the Maple implementation of homalg)
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgBestBasis.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgTools.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgPIR.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgInvolutive.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanet.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgJanetOre.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalgOreModules.gi" );

## Oscar
ReadPackage( "RingsForHomalg", "gap/OscarBasic.gi" );
ReadPackage( "RingsForHomalg", "gap/OscarTools.gi" );
ReadPackage( "RingsForHomalg", "gap/OscarGroebner.gi" );

## all the supported external computer algebra systems
ReadPackage( "RingsForHomalg", "gap/GAPHomalg.gi" );
ReadPackage( "RingsForHomalg", "gap/Singular.gi" );
ReadPackage( "RingsForHomalg", "gap/Macaulay2.gi" );
ReadPackage( "RingsForHomalg", "gap/Sage.gi" );
ReadPackage( "RingsForHomalg", "gap/MAGMA.gi" );
ReadPackage( "RingsForHomalg", "gap/MapleHomalg.gi" );
ReadPackage( "RingsForHomalg", "gap/Oscar.gi" );
ReadPackage( "RingsForHomalg", "gap/LiE.gi" );

if IsBound( MakeThreadLocal ) then
    Perform(
            [
             "HOMALG_RINGS",
             "CommonHomalgTableForRings",
             "HOMALG_IO_GAP",
             "GAPHomalgMacros",
             "CommonHomalgTableForGAPHomalgBasic",
             "CommonHomalgTableForGAPHomalgBestBasis",
             "CommonHomalgTableForGAPHomalgTools",
             "HOMALG_IO_MAGMA",
             "MAGMAMacros",
             "CommonHomalgTableForMAGMABasic",
             "CommonHomalgTableForMAGMABestBasis",
             "CommonHomalgTableForMAGMATools",
             "HOMALG_IO_Macaulay2",
             "Macaulay2Macros",
             "CommonHomalgTableForMacaulay2Basic",
             "CommonHomalgTableForMacaulay2Tools",
             "HOMALG_IO_Maple",
             "MapleMacros",
             "CommonHomalgTableForMapleHomalgBasic",
             "CommonHomalgTableForMapleHomalgBestBasis",
             "CommonHomalgTableForMapleHomalgTools",
             "HOMALG_IO_Sage",
             "CommonHomalgTableForSageBasic",
             "CommonHomalgTableForSageBestBasis",
             "SageMacros",
             "CommonHomalgTableForSageTools",
             "HOMALG_IO_Singular",
             "SingularMacros",
             "CommonHomalgTableForSingularBasic",
             "CommonHomalgTableForSingularBestBasis",
             "CommonHomalgTableForSingularTools",
             "HOMALG_IO_Oscar",
             "OscarMacros",
             "CommonHomalgTableForOscarBasic",
             "CommonHomalgTableForOscarBestBasis",
             "CommonHomalgTableForOscarTools",
             "HOMALG_IO_LiE",
             "LiEMacros",
             ],
            MakeThreadLocal );
fi;
