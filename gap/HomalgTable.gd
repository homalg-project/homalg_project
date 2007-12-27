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
# categories:
#
####################################

# a new category of objects:
DeclareCategory( "IsHomalgTable",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

####################################
#
# attributes:
#
####################################

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

#DeclareAttribute( "IsRingElement",
#        IsHomalgTable );

DeclareAttribute( "RingElementNormalForm",
        IsHomalgTable );

DeclareAttribute( "SimplifyBasis",
        IsHomalgTable );

## Must only then be provided by the RingPackage in case the default
## value provided by HomalgTable does not match the Ring

#DeclareAttribute( "IsUnit",
#        IsHomalgTable );

DeclareAttribute( "DivideByUnit",
        IsHomalgTable );

DeclareAttribute( "matrix",
        IsHomalgTable );

DeclareAttribute( "Minus",
        IsHomalgTable );

DeclareAttribute( "One",
        IsHomalgTable );

## the defaults provided by the table:

DeclareAttribute( "CertainRows",
        IsHomalgTable );

DeclareAttribute( "CertainColumns",
        IsHomalgTable );

## all other homalg procedures:

DeclareAttribute( "RankOfGauss",
        IsHomalgTable );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "CreateHomalgTable",
        [ IsSemiringWithOneAndZero ] );

