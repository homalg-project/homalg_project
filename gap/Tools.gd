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

DeclareOperation( "CoefficientOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsInt ] );

DeclareOperation( "CoefficientsOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "CoefficientsOfUnivariatePolynomial",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement, IsHomalgRingElement ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement, IsString ] );

DeclareOperation( "LeadingCoefficient",
        [ IsHomalgRingElement ] );

DeclareOperation( "GetRidOfRowsAndColumnsWithUnits",
        [ IsHomalgMatrix ] );
