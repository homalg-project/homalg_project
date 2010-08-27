#############################################################################
##
##  Gradedmatrix.gd         GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for graded matrices.
##
#############################################################################

####################################
#
# attributes:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "UnderlyingNonGradedMatrix",
        [ IsHomalgMatrix ] );

##  <#GAPDoc Label="NonTrivialDegreePerRow">
##  <ManSection>
##    <Oper Arg="A[, col_degrees]" Name="NonTrivialDegreePerRow"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      The list of non-trivial degrees per row of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "NonTrivialDegreePerRow",
        [ IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerRow",
        [ IsHomalgMatrix, IsList ] );

##  <#GAPDoc Label="NonTrivialDegreePerColumn">
##  <ManSection>
##    <Oper Arg="A[, row_degrees]" Name="NonTrivialDegreePerColumn"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      The list of non-trivial degrees per column of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgRing, IsList ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "MonomialMatrix",
        [ IsList, IsHomalgRing, IsList ] );

DeclareOperation( "MonomialMatrix",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeLeftModules",
        [ IsList, IsList, IsHomalgRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeRightModules",
        [ IsList, IsList, IsHomalgRing ] );

# constructor methods:

DeclareOperation( "BlindlyCopyMatrixPropertiesToGradedMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BlindlyCopyRingPropertiesToGradedRing",
        [ IsHomalgRing, IsHomalgGradedRing ] );

DeclareOperation( "GradedMatrix",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

