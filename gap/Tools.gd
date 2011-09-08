#############################################################################
##
##  Tools.gd                                                 Modules package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of tool procedures.
##
#############################################################################

####################################
#
# attributes:
#
####################################

DeclareAttribute( "DimensionOfHilbertPoincareSeries",
        IsRationalFunction );

DeclareAttribute( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        IsRationalFunction );

DeclareAttribute( "HilbertPolynomialOfHilbertPoincareSeries",
        IsRationalFunction );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "VariableForHilbertPolynomial" );

DeclareGlobalFunction( "CoefficientsOfLaurentPolynomialsWithRange" );

DeclareGlobalFunction( "SumCoefficientsOfLaurentPolynomials" );

DeclareGlobalFunction( "_Binomial" );

# basic operations:

DeclareOperation( "LeadingModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        [ IsRationalFunction, IsInt ] );

DeclareOperation( "HilbertPolynomial",
        [ IsList, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsList, IsInt ] );

DeclareOperation( "PrimaryDecompositionOp",
        [ IsHomalgMatrix ] );
