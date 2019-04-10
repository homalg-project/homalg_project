#############################################################################
##
##  Tools.gd                                                 Modules package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of tool procedures.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "MaximalIndependentSet",
        [ IsHomalgModule ] );

DeclareOperation( "EliminateOverBaseRing",
        [ IsHomalgMatrix, IsList, IsInt ] );

DeclareOperation( "EliminateOverBaseRing",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "SimplifiedInequalities",
        [ IsList ] );

DeclareOperation( "SimplifiedInequalities",
        [ IsHomalgMatrix ] );

DeclareOperation( "DefiningIdealFromNameOfResidueClassRing",
        [ IsHomalgRing, IsString ] );
