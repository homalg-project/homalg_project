#############################################################################
##
##  read.g                                             GradedModules package
##
##  Copyright 2008-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen
##
##  Reading the implementation part of the GradedModules package.
##
#############################################################################

##
ReadPackage( "GradedModules", "gap/GradedModule.gi" );

##
ReadPackage( "GradedModules", "gap/GradedSubmodule.gi" );

##
ReadPackage( "GradedModules", "gap/GradedModuleMap.gi" );

##
ReadPackage( "GradedModules", "gap/DegreesOfGenerators.gi" );

##
ReadPackage( "GradedModules", "gap/UnderlyingModule.gi" );

##
ReadPackage( "GradedModules", "gap/UnderlyingMap.gi" );

##
ReadPackage( "GradedModules", "gap/BettiTable.gi" );

##
ReadPackage( "GradedModules", "gap/GradedStructureFunctors.gi" );

##
ReadPackage( "GradedModules", "gap/BasicFunctors.gi" );

##
ReadPackage( "GradedModules", "gap/ToolFunctors.gi" );

##
ReadPackage( "GradedModules", "gap/OtherFunctors.gi" );

##
ReadPackage( "GradedModules", "gap/RingMaps.gi" );

##
ReadPackage( "GradedModules", "gap/Relative.gi" );

##
ReadPackage( "GradedModules", "gap/Koszul.gi" );

##
ReadPackage( "GradedModules", "gap/Tate.gi" );

## LogicForHomalg subpackages
ReadPackage( "GradedModules", "gap/LIGrRNG.gi" );
ReadPackage( "GradedModules", "gap/LIGrMOD.gi" );
ReadPackage( "GradedModules", "gap/LIGrHOM.gi" );
ReadPackage( "GradedModules", "gap/LICPX.gi" );

if IsBound( MakeThreadLocal ) then
    Perform(
            [
             "HOMALG_GRADED_MODULES",
             "LIGrMOD",
             "LIGrHOM",
             ],
            MakeThreadLocal );
fi;
