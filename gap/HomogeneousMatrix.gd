#############################################################################
##
##  HomogeneousMatrix.gd    GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for homogeneous matrices.
##
#############################################################################

####################################
#
# properties:
#
####################################

##
DeclareProperty( "Twitter",
        IsHomalgMatrix );

####################################
#
# attributes:
#
####################################

##
## the attributes below are intrinsic:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIHMAT.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="DegreesOfEntries">
##  <ManSection>
##    <Attr Arg="A" Name="DegreesOfEntries"/>
##    <Returns>a listlist of degrees/multi-degrees</Returns>
##    <Description>
##      The matrix of degrees of the matrix <A>A</A>.<P/>
##      (for the installed standard method see <Ref Meth="DegreesOfEntries" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreesOfEntries",
        IsHomalgMatrix );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "UnderlyingNonHomogeneousMatrix",
        [ IsHomalgMatrix ] );

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

DeclareOperation( "BlindlyCopyMatrixPropertiesToHomogeneousMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "HomogeneousMatrix",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "HomogeneousMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "HomogeneousMatrix",
        [ IsList, IsInt, IsInt, IsHomalgGradedRing ] );

