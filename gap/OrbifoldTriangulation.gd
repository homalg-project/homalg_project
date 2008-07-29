#############################################################################
##
##  OrbifoldTriangulation.gd      SCO package                 Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for Orbifold Triangulations.
##
#############################################################################

##
DeclareCategory( "IsOrbifoldTriangulation",
        IsAttributeStoringRep );

##
DeclareGlobalFunction( "OrbifoldTriangulation" );

##
DeclareOperation( "Vertices",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "Simplices",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "Isotropy",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "Mu",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "MuData",
        [ IsOrbifoldTriangulation ] );

##
DeclareOperation( "InfoString",
        [ IsOrbifoldTriangulation ] );

