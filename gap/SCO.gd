#############################################################################
##
##  SCO.gd                    SCO package                     Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for SCO.
##
#############################################################################

##
DeclareOperation( "ComplexOfSimplicialSet",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "CocomplexOfSimplicialSet",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "Homology",
        [ IsList, IsHomalgRing ] );

##
DeclareOperation( "Homology",
        [ IsList ] );

##
DeclareOperation( "Cohomology",
        [ IsList, IsHomalgRing ] );

##
DeclareOperation( "Cohomology",
        [ IsList ] );

##
DeclareGlobalFunction( "SCO_Examples" );
