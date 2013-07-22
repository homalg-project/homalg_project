#############################################################################
##
##  Tools.gd                    MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg tools.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Eliminate",
        [ IsList, IsList ] );

DeclareOperation( "Eliminate",
        [ IsList, IsHomalgRingElement ] );

DeclareOperation( "Coefficients",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "Coefficients",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "Coefficients",
        [ IsHomalgRingElement ] );

DeclareOperation( "CoefficientsOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "CoefficientsOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "CoefficientOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsInt ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement ] );

DeclareOperation( "GetRidOfRowsAndColumnsWithUnits",
        [ IsHomalgMatrix ] );

DeclareOperation( "Value",
        [ IsHomalgRingElement, IsList, IsList ] );

DeclareOperation( "Value",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "Value",
        [ IsObject, IsHomalgRingElement, IsRingElement ] );

DeclareOperation( "Value",
        [ IsObject, IsHomalgRingElement ] );

DeclareOperation( "ListOfDegreesOfMultiGradedRing",
        [ IsInt, IsHomalgRing, IsList ] );

DeclareOperation( "MonomialMatrixWeighted",
        [ IsInt, IsHomalgRing, IsList ] );

DeclareOperation( "MonomialMatrixWeighted",
        [ IsList, IsHomalgRing, IsList ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeLeftModulesWeighted",
        [ IsList, IsList, IsHomalgRing, IsList ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeRightModulesWeighted",
        [ IsList, IsList, IsHomalgRing, IsList ] );

DeclareOperation( "RandomMatrix",
        [ IsInt, IsInt, IsInt, IsHomalgRing, IsList ] );

DeclareOperation( "RandomMatrix",
        [ IsInt, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "GeneralLinearCombination",
    [ IsHomalgRing, IsInt, IsList, IsInt ] );

DeclareOperation( "GetMonicUptoUnit",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetMonicUptoUnit",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "GetMonic",
        [ IsHomalgMatrix ] );

DeclareOperationWithDocumentation( "GetMonic",
        [ IsHomalgMatrix, IsInt ],
	[ "Returns a list of 4 objects:",
          "[ <C>f</C>, <C>p</C>, <C>q</C>, <C>i</C> ].<Br/>",
          "<C>f</C> is [<C>p</C>, <C>q</C>]-th element of <A>M</A>, which is",
          "monic in <C>i</C>-th variable." ],
#          "<#Include Label=\"Patch\">" ],
	"a &homalg; matrix",
	"M, i",
        [ "Matrices", "Tools" ] );
