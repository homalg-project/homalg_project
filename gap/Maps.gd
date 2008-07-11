#############################################################################
##
##  Maps.gd                     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for maps ( = module homomorphisms ).
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgMap ] );

DeclareOperation( "Resolution",
        [ IsHomalgMap ] );

DeclareOperation( "CokernelSequence",
        [ IsHomalgMap ] );

DeclareOperation( "CokernelCosequence",
        [ IsHomalgMap ] );

DeclareOperation( "KernelSequence",
        [ IsHomalgMap ] );

DeclareOperation( "KernelCosequence",
        [ IsHomalgMap ] );

