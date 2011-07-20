#############################################################################
##
##  ExteriorAlgebra.gd          Modules package              Florian Diebold
##
##  Copyright 2011, Florian Diebold, University of Kaiserslautern
##
##  Declarations of operations for exterior powers.
##
#############################################################################

DeclareAttribute( "ExteriorPowers",
        IsHomalgModule, "mutable" );

DeclareOperation( "ExteriorPower",
        [ IsHomalgModule, IsInt ]);


DeclareProperty( "IsExteriorPower",
        IsHomalgModule );

DeclareAttribute( "ExteriorPowerExponent",
        IsHomalgModule );

DeclareAttribute( "ExteriorPowerBaseModule",
        IsHomalgModule );


DeclareProperty( "IsExteriorPowerElement",
        IsHomalgModuleElement );

DeclareGlobalFunction( "_Homalg_CombinationIndex" );
DeclareGlobalFunction( "_Homalg_IndexCombination" );

DeclareOperation( "WedgeExteriorPowerElements",
        [ IsHomalgModuleElement, IsHomalgModuleElement ] );
DeclareGlobalFunction( "ExteriorPowerElementDual" );
DeclareGlobalFunction( "SingleValueOfExteriorPowerElement" );


DeclareGlobalFunction( "KoszulComplex" );
DeclareGlobalFunction( "GradeSequence" );


DeclareAttribute( "CayleyDeterminant",
        IsHomalgComplex );

