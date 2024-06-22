# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

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

DeclareOperation( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        [ IsRationalFunction, IsInt ] );

DeclareOperation( "HilbertPolynomial",
        [ IsList, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsList, IsInt ] );

DeclareOperation( "MaxDimensionalRadicalSubobjectOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "RadicalSubobjectOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "RadicalDecompositionOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "MaxDimensionalSubobjectOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "EquiDimensionalDecompositionOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "PrimaryDecompositionOp",
        [ IsHomalgMatrix ] );

DeclareOperation( "Eliminate",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "Eliminate",
        [ IsList, IsList, IsHomalgRing ] );

DeclareOperation( "Eliminate",
        [ IsList, IsList ] );

DeclareOperation( "Eliminate",
        [ IsHomalgMatrix, IsHomalgRingElement ] );

DeclareOperation( "Eliminate",
        [ IsHomalgMatrix ] );

DeclareOperation( "Eliminate",
        [ IsList, IsHomalgRingElement ] );

DeclareOperation( "Coefficients",
        [ IsHomalgRingElement, IsList ] );

DeclareOperation( "Coefficients",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "Coefficients",
        [ IsHomalgRingElement ] );

DeclareOperation( "Coefficients",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "Coefficients",
        [ IsHomalgMatrix ] );

DeclareOperation( "CoefficientsOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "CoefficientsOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "CoefficientOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsInt ] );

DeclareOperation( "DecomposeInMonomials",
        [ IsHomalgRingElement ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement ] );

DeclareOperation( "LeadingMonomial",
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

#! @Description
#!  Returns a list of 4 objects:
#!  [ <C>f</C>, <C>p</C>, <C>q</C>, <C>i</C> ].<Br/>
#!  <C>f</C> is [<C>p</C>, <C>q</C>]-th element of <A>M</A>, which is
#!  monic in <C>i</C>-th variable.
## <#Include Label="Patch">
#! @Returns a &homalg; matrix
#! @Arguments M, i
#! @ChapterInfo Matrices, Tools
DeclareOperation( "GetMonic",
                  [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "Diff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "Diff",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "Diff",
        [ IsHomalgRingElement ] );

DeclareOperation( "TangentSpaceByEquationsAtPoint",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "TangentSpaceByEquationsAtPoint",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "LeadingModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "IntersectWithSubalgebra",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "MaximalIndependentSet",
        [ IsHomalgMatrix ] );

DeclareOperation( "AMaximalIdealContaining",
        [ IsHomalgMatrix ] );

DeclareOperation( "IsolateIndeterminate",
        [ IsHomalgRingElement ] );

DeclareOperation( "Saturate",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "Saturate",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "RingMapOntoRewrittenResidueClassRing",
        [ IsHomalgRing ] );

DeclareOperation( "RingMapOntoSimplifiedOnceResidueClassRing",
        [ IsHomalgRing ] );

DeclareOperation( "RingMapOntoSimplifiedResidueClassRing",
        [ IsHomalgRing ] );

DeclareOperation( "RingMapOntoSimplifiedOnceResidueClassRingUsingLinearEquations",
        [ IsHomalgRing ] );

DeclareOperation( "RingMapOntoSimplifiedResidueClassRingUsingLinearEquations",
        [ IsHomalgRing ] );

## This is a dummy declaration for a function actually installed
## in GaussForHomalg
DeclareGlobalFunction( "HOMALG_RING_OF_INTEGERS_PRIME_POWER_HELPER" );
