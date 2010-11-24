#############################################################################
##
##  HomalgFunctor.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations for functors.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new GAP-category:

##  <#GAPDoc Label="IsHomalgFunctor">
##  <ManSection>
##    <Filt Type="Category" Arg="F" Name="IsHomalgFunctor"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; (multi-)functors.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgFunctor",
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

##  <#GAPDoc Label="NameOfFunctor">
##  <ManSection>
##    <Attr Arg="F" Name="NameOfFunctor"/>
##    <Returns>a string</Returns>
##    <Description>
##      The name of the &homalg; functor <A>F</A>.
##      <Example><![CDATA[
##  gap> NameOfFunctor( Functor_Ext_for_fp_modules );
##  "Ext"
##  gap> Display( Functor_Ext_for_fp_modules );
##  Ext
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NameOfFunctor",
        IsHomalgFunctor );

##  <#GAPDoc Label="OperationOfFunctor">
##  <ManSection>
##    <Attr Arg="F" Name="OperationOfFunctor"/>
##    <Returns>an operation</Returns>
##    <Description>
##      The operation of the functor <A>F</A>.
##      <Example><![CDATA[
##  gap> Functor_Ext_for_fp_modules;
##  <The functor Ext for f.p. modules and their maps over computable rings>
##  gap> OperationOfFunctor( Functor_Ext_for_fp_modules );
##  <Operation "Ext">
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "OperationOfFunctor",
        IsHomalgFunctor );

##  <#GAPDoc Label="Genesis:functor">
##  <ManSection>
##    <Attr Arg="F" Name="Genesis"/>
##    <Returns>a list</Returns>
##    <Description>
##      The first entry of the returned list is the name of the constructor used to create the functor <A>F</A>.
##      The reset of the list contains arguments that were passed to this constructor for creating <A>F</A>.
##      <P/>
##      These are examples of different functors created using the different constructors:
##      <List>
##        <Item> <C>CreateHomalgFunctor</C>:
##      <Example><![CDATA[
##  gap> Functor_Hom_for_fp_modules;
##  <The functor Hom for f.p. modules and their maps over computable rings>
##  gap> Genesis( Functor_Hom_for_fp_modules );
##  [ "CreateHomalgFunctor", [ "name", "Hom" ],
##    [ "category", rec( description := "f.p. modules and their maps over computab\
##  le rings", short_description := "_for_fp_modules",
##            MorphismConstructor := function( arg ) ... end ) ],
##    [ "operation", "Hom" ], [ "number_of_arguments", 2 ],
##    [ "1", [ [ "contravariant", "right adjoint", "distinguished" ] ] ],
##    [ "2", [ [ "covariant", "left exact" ] ] ],
##    [ "OnObjects", function( M, N ) ... end ],
##    [ "OnMorphisms", function( M_or_mor, N_or_mor ) ... end ],
##    [ "MorphismConstructor", function( arg ) ... end ] ]
##  ]]></Example></Item>
##        <Item> <C>InsertObjectInMultiFunctor</C>:
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> LeftDualizingFunctor( ZZ, "ZZ_Hom" );
##  <The functor ZZ_Hom for f.p. modules and their maps over computable rings>
##  gap> Functor_ZZ_Hom_for_fp_modules;	## got automatically defined
##  <The functor ZZ_Hom for f.p. modules and their maps over computable rings>
##  gap> ZZ_Hom;		## got automatically defined
##  <Operation "ZZ_Hom">
##  gap> Genesis( Functor_ZZ_Hom_for_fp_modules );
##  [ "InsertObjectInMultiFunctor",
##    <The functor Hom for f.p. modules and their maps over computable rings>, 2,
##    <The free left module of rank 1 on a free generator> ]
##  gap> 1 * ZZ;
##  <The free left module of rank 1 on a free generator>
##  ]]></Example></Item>
##        <Item> <C>LeftDerivedFunctor</C>:
##      <Example><![CDATA[
##  gap> Functor_TensorProduct_for_fp_modules;
##  <The functor TensorProduct for f.p. modules and their maps over computable rin\
##  gs>
##  gap> Genesis( Functor_LTensorProduct_for_fp_modules );
##  [ "LeftDerivedFunctor",
##    <The functor TensorProduct for f.p. modules and their maps over computable r\
##  ings>, 1 ]
##  ]]></Example></Item>
##        <Item> <C>RightDerivedCofunctor</C>:
##      <Example><![CDATA[
##  gap> Genesis( Functor_RHom_for_fp_modules );
##  [ "RightDerivedCofunctor",
##    <The functor Hom for f.p. modules and their maps over computable rings>, 1 ]
##  ]]></Example></Item>
##        <Item> <C>LeftSatelliteOfFunctor</C>:
##      <Example><![CDATA[
##  gap> Genesis( Functor_Tor_for_fp_modules );
##  [ "LeftSatelliteOfFunctor",
##    <The functor TensorProduct for f.p. modules and their maps over computable r\
##  ings>, 1 ]
##  ]]></Example></Item>
##        <Item> <C>RightSatelliteOfCofunctor</C>:
##      <Example><![CDATA[
##  gap> Genesis( Functor_Ext_for_fp_modules );
##  [ "RightSatelliteOfCofunctor",
##    <The functor Hom for f.p. modules and their maps over computable rings>, 1 ]
##  ]]></Example></Item>
##        <Item> <C>ComposeFunctors</C>:
##      <Example><![CDATA[
##  gap> Genesis( Functor_HomHom_for_fp_modules );
##  [ "ComposeFunctors",
##    [ <The functor Hom for f.p. modules and their maps over computable rings>,
##        <The functor Hom for f.p. modules and their maps over computable rings>
##       ], 1 ]
##  gap> ValueGlobal( "ComposeFunctors" );
##  <Operation "ComposeFunctors">
##  ]]></Example></Item>
##      </List>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Genesis",
        IsHomalgFunctor );

DeclareAttribute( "IsIdentityOnObjects",
        IsHomalgFunctor );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "CreateHomalgFunctor" );

DeclareOperation( "CategoryOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "DescriptionOfCategory",
        [ IsHomalgFunctor ] );

DeclareOperation( "ShortDescriptionOfCategory",
        [ IsHomalgFunctor ] );

DeclareOperation( "InsertObjectInMultiFunctor",
        [ IsHomalgFunctor, IsInt, IsStructureObjectOrObjectOrMorphism, IsString, IsString ] );

DeclareOperation( "InsertObjectInMultiFunctor",
        [ IsHomalgFunctor, IsInt, IsStructureObjectOrObjectOrMorphism, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsInt, IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsInt, IsHomalgFunctor, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsInt, IsHomalgFunctor ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsHomalgFunctor, IsString ] );

DeclareOperation( "ComposeFunctors",
        [ IsHomalgFunctor, IsHomalgFunctor ] );

DeclareOperation( "*",
        [ IsHomalgFunctor, IsHomalgFunctor ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsInt, IsString, IsString ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor, IsString ] );

DeclareOperation( "RightSatelliteOfCofunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsInt, IsString, IsString ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor, IsString ] );

DeclareOperation( "LeftSatelliteOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsInt, IsString, IsString ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor, IsString ] );

DeclareOperation( "RightDerivedCofunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsInt, IsString, IsString ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsInt, IsString ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor, IsString ] );

DeclareOperation( "LeftDerivedFunctor",
        [ IsHomalgFunctor ] );

# basic operations:

DeclareOperation( "NaturalGeneralizedEmbedding",
        [ IsHomalgStaticObject ] );

DeclareOperation( "IsSpecialFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "MultiplicityOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsCovariantFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsCovariantFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsDistinguishedArgumentOfFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsDistinguishedFirstArgumentOfFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsAdditiveFunctor",
        [ IsHomalgFunctor, IsInt ] );

DeclareOperation( "IsAdditiveFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "IsIdenticalObjForFunctors",
        [ IsObject, IsObject ] );

DeclareOperation( "FunctorObj",
        [ IsHomalgFunctor, IsList ] );

DeclareOperation( "FunctorMap",
        [ IsHomalgFunctor, IsHomalgStaticMorphism, IsList ] );

DeclareOperation( "FunctorMap",
        [ IsHomalgFunctor, IsHomalgStaticMorphism ] );

DeclareOperation( "InstallFunctorOnObjects",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnMorphisms",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallSpecialFunctorOnMorphisms",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnComplexes",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnChainMaps",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctor",
        [ IsHomalgFunctor ] );

DeclareOperation( "InstallDeltaFunctor",
        [ IsHomalgFunctor ] );

DeclareGlobalFunction( "HelperToInstallUnivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnMorphismsAndSecondArgumentOnComplexes" );

DeclareGlobalFunction( "HelperToInstallFirstAndSecondArgumentOfBivariateFunctorOnComplexes" );

DeclareGlobalFunction( "HelperToInstallUnivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateFunctorOnChainMaps" );

DeclareGlobalFunction( "HelperToInstallUnivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfBivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfBivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallFirstArgumentOfTrivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallSecondArgumentOfTrivariateDeltaFunctor" );

DeclareGlobalFunction( "HelperToInstallThirdArgumentOfTrivariateDeltaFunctor" );

