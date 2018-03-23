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
# properties:
#
####################################

DeclareProperty( "IsPrimeModule",
        IsHomalgMatrix );

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

DeclareAttribute( "DataOfHilbertFunction",
        IsRationalFunction );

DeclareAttribute( "HilbertFunction",
        IsRationalFunction );

DeclareAttribute( "IndexOfRegularity",
        IsRationalFunction );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "VariableForHilbertPoincareSeries" );

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

DeclareOperation( "RadicalDecompositionOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "MaximalIndependentSet",
        [ IsHomalgModule ] );

DeclareOperation( "EliminateOverBaseRing",
        [ IsHomalgMatrix, IsList, IsInt ] );

DeclareOperation( "EliminateOverBaseRing",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "SimplifiedInequalities",
        [ IsList ] );

DeclareOperation( "SimplifiedInequalities",
        [ IsHomalgMatrix ] );

DeclareOperation( "DefiningIdealFromNameOfResidueClassRing",
        [ IsHomalgRing, IsString ] );
