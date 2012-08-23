#############################################################################
##
##  HomalgSubmodule.gd                                       Modules package
##
##  Copyright 2007-2010 Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for homalg submodules.
##
#############################################################################

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsPrimeIdeal">
##  <ManSection>
##    <Prop Arg="J" Name="IsPrimeIdeal"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; submodule <A>J</A> is a prime ideal. The ring has to be commutative. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPrimeIdeal",
        IsHomalgModule );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="ResidueClassRing">
##  <ManSection>
##    <Attr Arg="J" Name="ResidueClassRing"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      In case <A>J</A> was defined as a (left/right) ideal of the ring <M>R</M> the residue class ring <M>R/</M><A>J</A> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ResidueClassRing",
        IsHomalgModule );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "Subobject",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "Subobject",
        [ IsList, IsHomalgModule ] );

DeclareOperation( "Subobject",
        [ IsHomalgRelations, IsHomalgModule ] );

DeclareOperation( "LeftSubmodule",
        [ IsRingElement ] );

DeclareOperation( "LeftSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "LeftSubmodule",
        [ IsList ] );

DeclareOperation( "LeftSubmodule",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "ZeroLeftSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "RightSubmodule",
        [ IsRingElement ] );

DeclareOperation( "RightSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "RightSubmodule",
        [ IsList ] );

DeclareOperation( "RightSubmodule",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "ZeroRightSubmodule",
        [ IsHomalgRing ] );

DeclareOperation( "LeftIdealOfMinors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "LeftIdealOfMaximalMinors",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightIdealOfMinors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "RightIdealOfMaximalMinors",
        [ IsHomalgMatrix ] );

# basic operations:

DeclareOperation( "MatrixOfSubobjectGenerators",
        [ IsHomalgObject ] );

