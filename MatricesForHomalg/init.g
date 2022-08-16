# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Reading the declaration part of the package.
#
##
##  Reading the declaration part of the MatricesForHomalg package.
##
#############################################################################

## init
ReadPackage( "MatricesForHomalg", "gap/MatricesForHomalg.gd" );

## rings
ReadPackage( "MatricesForHomalg", "gap/homalgTable.gd" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRing.gd" );

## matrices
ReadPackage( "MatricesForHomalg", "gap/HomalgMatrix.gd" );

## ring maps
ReadPackage( "MatricesForHomalg", "gap/HomalgRingMap.gd" );

## ring relations
ReadPackage( "MatricesForHomalg", "gap/HomalgRingRelations.gd" );

## tools/service/basic
ReadPackage( "MatricesForHomalg", "gap/Tools.gd" );
ReadPackage( "MatricesForHomalg", "gap/Service.gd" );
ReadPackage( "MatricesForHomalg", "gap/Basic.gd" );

## LogicForHomalg subpackages
ReadPackage( "MatricesForHomalg", "gap/LIRNG.gd" );
ReadPackage( "MatricesForHomalg", "gap/LIMAP.gd" );
ReadPackage( "MatricesForHomalg", "gap/COLEM.gd" );
ReadPackage( "MatricesForHomalg", "gap/LIMAT.gd" );

## specific GAP4 internal rings
ReadPackage( "MatricesForHomalg", "gap/Euclidean.gd" );

## the subpackage ResidueClassRingForHomalg
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingForHomalg.gd" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRing.gd" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingBasic.gd" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingTools.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "MatricesForHomalg", "gap/Julia.gd" );
fi;
