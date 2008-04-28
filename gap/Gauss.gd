#############################################################################
##
##  Gauss.gd                Gauss package                     Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for Gauss.
##
#############################################################################

##
DeclareCategory( "IsOrbifoldTriangulation",
        IsAttributeStoringRep );

DeclareOperation( "OrbifoldTriangulation",
        [ IsList, IsRecord, IsList ] );

##
DeclareCategory( "IsSimplicialSet",
        IsAttributeStoringRep );

DeclareOperation( "SimplicialSet",
        [ IsOrbifoldTriangulation, IsInt ] );

DeclareAttribute( "Dimension",
        IsSimplicialSet );

##
DeclareOperation( "BoundaryOperator",
        [ IsInt, IsList, IsFunction ] );

##
DeclareOperation( "CreateCohomologyMatrix",
        [ IsOrbifoldTriangulation, IsSimplicialSet, IsHomalgRing ] );

DeclareOperation( "CreateHomologyMatrix",
        [ IsOrbifoldTriangulation, IsSimplicialSet, IsHomalgRing ] );

##
DeclareOperation( "Gauss_Examples",
        [ ] );
