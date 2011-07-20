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
        [ IsInt, IsHomalgModule ]);


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

DeclareGlobalFunction( "_Homalg_FreeModuleElementFromList" );

DeclareOperation( "WedgeExteriorPowerElements",
        [ IsHomalgModuleElement, IsHomalgModuleElement ] );
DeclareOperation( "ExteriorPowerElementDual",
        [ IsHomalgModuleElement ] );
DeclareOperation( "SingleValueOfExteriorPowerElement",
        [ IsHomalgModuleElement ] );


DeclareOperation( "KoszulComplex",
        [ IsList, IsHomalgModule ] );
DeclareOperation( "GradeSequence",
        [ IsList, IsHomalgModule ] );


DeclareAttribute( "CayleyDeterminant",
        IsHomalgComplex );

DeclareGlobalFunction( "Gcd_UsingCayleyDeterminant" );

