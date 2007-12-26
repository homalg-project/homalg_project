#############################################################################
##
##  HomalgTable.gd             homalg package                Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for rings.
##
#############################################################################


####################################
#
# declarations for homalg tables:
#
####################################

# A new category of objects:
DeclareCategory( "IsHomalgTable", IsAttributeStoringRep );

## Now the constructor method:
DeclareOperation( "CreateHomalgTable", [ IsSemiringWithOneAndZero ] );

####################################
#
# filters and operations:
#
####################################

## ring theoretic attributes and properties:
DeclareAttribute( "GlobalDim",
        IsSemiringWithOneAndZero );

## The homalg ring package conversion table:
DeclareAttribute( "HomalgTable",
        IsSemiringWithOneAndZero );

DeclareAttribute( "RingRelations",
        IsHomalgTable );

## Must only then be provided by the RingPackage in case the default
## "service" function does not match the Ring
DeclareAttribute( "AddMat",
        IsHomalgTable );
DeclareAttribute( "BasisOfModule",
        IsHomalgTable );
DeclareAttribute( "Compose",
        IsHomalgTable );
DeclareAttribute( "MatrixInvolution",
        IsHomalgTable );
DeclareAttribute( "MulMat",
        IsHomalgTable );
DeclareAttribute( "PresentationInfo",
        IsHomalgTable );
DeclareAttribute( "Reduce",
        IsHomalgTable );
DeclareAttribute( "SubMat",
        IsHomalgTable );
DeclareAttribute( "SyzygiesGenerators",
        IsHomalgTable );

## Must be defined if other functions are not defined
DeclareAttribute( "TriangularBasis",  ## needed by BasisOfModule
        IsHomalgTable );

## Can optionally be provided by the RingPackage
## (homalg functions check if these functions are defined or not)
## (HomalgTable gives no default value)
DeclareAttribute( "BestBasis",
        IsHomalgTable );
#DeclareAttribute( "IsRingElement", IsHomalgTable );
DeclareAttribute( "RingElementNormalForm",
        IsHomalgTable );
DeclareAttribute( "SimplifyBasis",
        IsHomalgTable );

## Must only then be provided by the RingPackage in case the default
## value provided by HomalgTable does not match the Ring
#DeclareAttribute( "IsUnit", IsHomalgTable );
DeclareAttribute( "DivideByUnit",
        IsHomalgTable );
DeclareAttribute( "matrix",
        IsHomalgTable );
DeclareAttribute( "Minus",
        IsHomalgTable );
DeclareAttribute( "One",
        IsHomalgTable );

## The defaults provided by the table:
DeclareAttribute( "CertainRows",
        IsHomalgTable );
DeclareAttribute( "CertainColumns",
        IsHomalgTable );

## All other homalg procedures:
DeclareAttribute( "RankOfGauss",
        IsHomalgTable );

#######################################################################
# The following loads the sub-package "XX":
# Note that this requires other GAP packages, which are automatically
# loaded by this command if available.
#######################################################################
#DeclareGlobalFunction( "LoadXX" );

