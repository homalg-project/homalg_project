#############################################################################
##
##  read.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the homalg package.
##
#############################################################################

ReadPackage( "homalg", "gap/homalg.gi" );

## rings
ReadPackage( "homalg", "gap/homalgTable.gi" );
ReadPackage( "homalg", "gap/HomalgRing.gi" );
ReadPackage( "homalg", "gap/HomalgRingMap.gi" );

## matrices
ReadPackage( "homalg", "gap/HomalgMatrix.gi" );

## relations/generators
ReadPackage( "homalg", "gap/HomalgRelations.gi" );
ReadPackage( "homalg", "gap/SetsOfRelations.gi" );
ReadPackage( "homalg", "gap/HomalgGenerators.gi" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gi" );

## modules/submodules
ReadPackage( "homalg", "gap/HomalgModule.gi" );
ReadPackage( "homalg", "gap/HomalgSubmodule.gi" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMap.gi" );

## filtrations
ReadPackage( "homalg", "gap/HomalgFiltration.gi" );

## complexes
ReadPackage( "homalg", "gap/HomalgComplex.gi" );

## chain maps
ReadPackage( "homalg", "gap/HomalgChainMap.gi" );

## bicomplexes
ReadPackage( "homalg", "gap/HomalgBicomplex.gi" );

## bigraded objects
ReadPackage( "homalg", "gap/HomalgBigradedObject.gi" );

## spectral sequences
ReadPackage( "homalg", "gap/HomalgSpectralSequence.gi" );

## functors
ReadPackage( "homalg", "gap/HomalgFunctor.gi" );

## diagrams
ReadPackage( "homalg", "gap/HomalgDiagram.gi" );

## tools/service/basic
ReadPackage( "homalg", "gap/Tools.gi" );
ReadPackage( "homalg", "gap/Service.gi" );
ReadPackage( "homalg", "gap/Basic.gi" );

## main
ReadPackage( "homalg", "gap/Modules.gi" );

ReadPackage( "homalg", "gap/Maps.gi" );

ReadPackage( "homalg", "gap/Complexes.gi" );

ReadPackage( "homalg", "gap/ChainMaps.gi" );

ReadPackage( "homalg", "gap/SpectralSequences.gi" );

ReadPackage( "homalg", "gap/Filtrations.gi" );

ReadPackage( "homalg", "gap/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/OtherFunctors.gi" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIRNG.gi" );
ReadPackage( "homalg", "gap/LIMAP.gi" );
ReadPackage( "homalg", "gap/LIMAT.gi" );
ReadPackage( "homalg", "gap/COLEM.gi" );
ReadPackage( "homalg", "gap/LIMOD.gi" );
ReadPackage( "homalg", "gap/LIMOR.gi" );
ReadPackage( "homalg", "gap/LICPX.gi" );

## specific GAP4 internal rings
ReadPackage( "homalg", "gap/Integers.gi" );
#ReadPackage( "homalg", "gap/EDIM.gi" );

## the subpackage ResidueClassRingForHomalg
ReadPackage( "homalg", "gap/ResidueClassRingForHomalg.gi" );
ReadPackage( "homalg", "gap/ResidueClassRing.gi" );
ReadPackage( "homalg", "gap/ResidueClassRingBasic.gi" );
ReadPackage( "homalg", "gap/ResidueClassRingTools.gi" );

