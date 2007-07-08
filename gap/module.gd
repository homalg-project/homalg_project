#############################################################################
##
##  module.gd              homalg package                    Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for modules.
##
#############################################################################


# Our info class:
DeclareInfoClass( "InfoHomalg" );
SetInfoLevel( InfoHomalg, 1 );

# A central place for configurations:
DeclareGlobalVariable( "HOMALG" );


####################################
#
# Declarations for modules:
#
####################################

# A new category of objects:
DeclareCategory( "IsModule", IsAttributeStoringRep );

# We have different representations:
DeclareRepresentation( "IsGivenAsCokernel", IsModule, [] );
DeclareRepresentation( "IsGivenAsKernel", IsModule, [] );
DeclareRepresentation( "IsGivenAsCoimage", IsModule, [] );
DeclareRepresentation( "IsGivenAsImage", IsModule, [] );

# Now the constructor method:
DeclareGlobalFunction( "Module" );

####################################
#
# Filters:
#
####################################

# Indicates, whether a basis of relations has already been computed or not:
DeclareFilter( "IsGivenByBasisOfRelations", IsModule );

# Computing the combinatorial data is triggered "PresentationInfo":
DeclareAttribute( "PresentationInfo", [ IsModule ] );

#######################################################################
# The following loads the sub-package "XX":
# Note that this requires other GAP packages, which are automatically
# loaded by this command if available.
#######################################################################
#DeclareGlobalFunction( "LoadXX" );

