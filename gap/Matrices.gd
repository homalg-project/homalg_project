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
DeclareOperation( "CreateCohomologyMatrix",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomologyMatrix",
        [ IsSimplicialSet, IsInt, IsHomalgRing ] );

##
DeclareOperation( "AddEntry",
        [ IsMatrix, IsInt, IsInt, IsObject ] );
