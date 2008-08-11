#############################################################################
##
##  Matrices.gd                 SCO package                   Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for matrix creation.
##
#############################################################################

##
DeclareGlobalFunction( "BoundaryOperator" );

##
DeclareOperation( "CreateCoboundaryMatrices",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateBoundaryMatrices",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );
