#############################################################################
##
##  Module.gd              homalg package                    Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for modules.
##
#############################################################################


####################################
#
# Declarations for modules:
#
####################################

# A new category of objects:
DeclareCategory( "IsModuleForHomalg", IsAttributeStoringRep );

# Now the constructor method:
DeclareOperation( "Presentation", [IsList, IsSemiringWithOneAndZero]);
DeclareOperation( "Presentation", [IsList, IsList, IsSemiringWithOneAndZero]);

# Basic operations:
DeclareOperation( "GeneratorsOfModule", [IsModuleForHomalg]);
DeclareOperation( "RelationsOfModule", [IsModuleForHomalg]);

DeclareOperation( "RankOfGauss", [IsObject]);
DeclareOperation( "BasisOfModule", [IsObject, IsSemiringWithOneAndZero]);

####################################
#
# filters and operations:
#
####################################

DeclareProperty("IsZeroModule",IsModuleForHomalg);

DeclareAttribute("GeneratorsOfLeftOperatorAdditiveGroup",IsModuleForHomalg);
DeclareAttribute("DimensionOfVectors",IsModuleForHomalg);

DeclareAttribute( "DefaultRelations",IsModuleForHomalg);
DeclareAttribute( "GeneratorsRelationsCounter",IsModuleForHomalg);

DeclareAttribute( "NrGenerators",IsModuleForHomalg);
DeclareAttribute( "NrRelations",IsModuleForHomalg);


#######################################################################
# The following loads the sub-package "XX":
# Note that this requires other GAP packages, which are automatically
# loaded by this command if available.
#######################################################################
#DeclareGlobalFunction( "LoadXX" );

