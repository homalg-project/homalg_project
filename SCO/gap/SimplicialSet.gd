#############################################################################
##
##  SimplicialSet.gd             SCO package                  Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for SCO.
##
#############################################################################

##
DeclareCategory( "IsSimplicialSet",
        IsAttributeStoringRep );

DeclareOperation( "SimplicialSet",
        [ IsOrbifoldTriangulation ] );

DeclareOperation( "SimplicialSet",
        [ IsSimplicialSet, IsInt ] );

DeclareOperation( "ComputeNextDimension",
        [ IsSimplicialSet ] );

DeclareOperation( "Extend",
        [ IsSimplicialSet, IsInt ] );
