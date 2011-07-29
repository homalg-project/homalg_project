#############################################################################
##
##  HomalgChainMorphism.gi                                    homalg package
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for homalg chain morphisms.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsChainMorphismOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsChainMorphismOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of chain morphisms of finitely presented &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgChainMorphism"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsChainMorphismOfFinitelyPresentedObjectsRep",
        IsHomalgChainMorphism and IsMorphismOfFinitelyGeneratedObjectsRep,
        [  ] );

##  <#GAPDoc Label="IsCochainMorphismOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsCochainMorphismOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of cochain morphisms of finitely presented &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgChainMorphism"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCochainMorphismOfFinitelyPresentedObjectsRep",
        IsHomalgChainMorphism and IsMorphismOfFinitelyGeneratedObjectsRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgChainMorphisms",
        NewFamily( "TheFamilyOfHomalgChainMorphisms" ) );

# eight new types:
BindGlobal( "TheTypeHomalgChainMorphismOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsChainMorphismOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgChainMorphismOfRightObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsChainMorphismOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgCochainMorphismOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsCochainMorphismOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgCochainMorphismOfRightObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsCochainMorphismOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgChainEndomorphismOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsChainMorphismOfFinitelyPresentedObjectsRep and IsHomalgChainEndomorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgChainEndomorphismOfRightObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsChainMorphismOfFinitelyPresentedObjectsRep and IsHomalgChainEndomorphism and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgCochainEndomorphismOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsCochainMorphismOfFinitelyPresentedObjectsRep and IsHomalgChainEndomorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgCochainEndomorphismOfRightObjects",
        NewType( TheFamilyOfHomalgChainMorphisms,
                IsCochainMorphismOfFinitelyPresentedObjectsRep and IsHomalgChainEndomorphism and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# global variables:
#
####################################

HOMALG.PropertiesOfChainMorphisms :=
  [ IsZero,
    IsMorphism,
    IsGeneralizedMorphism,
    IsGradedMorphism,
    IsSplitMonomorphism,
    IsMonomorphism,
    IsGeneralizedMonomorphism,
    IsSplitEpimorphism,
    IsEpimorphism,
    IsGeneralizedEpimorphism,
    IsIsomorphism,
    IsGeneralizedIsomorphism,
    IsQuasiIsomorphism,
    IsImageSquare,
    IsKernelSquare,
    IsLambekPairOfSquares ];

## do not delete the component to retain the caching!
HOMALG.AttributesOfChainMorphismsDoNotDelete :=
  [ CokernelEpi,
    ImageObjectEmb,
    ImageObjectEpi,
    KernelEmb,
    ];

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( StructureObject,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return StructureObject( Source( cm ) );
    
end );

##
InstallMethod( homalgResetFilters,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local property, attribute;
    
    for property in HOMALG.PropertiesOfChainMorphisms do
        ResetFilterObj( cm, property );
    od;
    
    for attribute in HOMALG.AttributesOfChainMorphismsDoNotDelete do
        if Tester( attribute )( cm ) then
            ## do not delete the component to retain the caching!
            ResetFilterObj( cm, attribute );
        fi;
    od;
    
end );

## provided to avoid branching in the code and always returns fail
InstallMethod( PositionOfTheDefaultPresentation,
        "for homalg morphisms",
        [ IsHomalgChainMorphism ],
        
  function( M )
    
    return fail;
    
end );

##
InstallMethod( SourceOfSpecialChainMorphism,
        "for homalg image square chain morphisms",
        [ IsHomalgChainMorphism and IsImageSquare ],
        
  function( sq )
    
    return LowestDegreeMorphism( Source( sq ) );
    
end );

##
InstallMethod( SourceOfSpecialChainMorphism,
        "for homalg kernel square chain morphisms",
        [ IsHomalgChainMorphism and IsKernelSquare ],
        
  function( sq )
    
    return HighestDegreeMorphism( Source( sq ) );
    
end );

##
InstallMethod( SourceOfSpecialChainMorphism,
        "for homalg Lambek pair of squares",
        [ IsHomalgChainMorphism and IsLambekPairOfSquares ],
        
  function( sq )
    
    return AsATwoSequence( Source( sq ) );
    
end );

##
InstallMethod( RangeOfSpecialChainMorphism,
        "for homalg image square chain morphisms",
        [ IsHomalgChainMorphism and IsImageSquare ],
        
  function( sq )
    
    return LowestDegreeMorphism( Range( sq ) );
    
end );

##
InstallMethod( RangeOfSpecialChainMorphism,
        "for homalg kernel square chain morphisms",
        [ IsHomalgChainMorphism and IsKernelSquare ],
        
  function( sq )
    
    return HighestDegreeMorphism( Range( sq ) );
    
end );

##
InstallMethod( RangeOfSpecialChainMorphism,
        "for homalg Lambek pair of squares",
        [ IsHomalgChainMorphism and IsLambekPairOfSquares ],
        
  function( sq )
    
    return AsATwoSequence( Range( sq ) );
    
end );

##
InstallMethod( CertainMorphismOfSpecialChainMorphism,
        "for homalg image square chain morphisms",
        [ IsHomalgChainMorphism and IsImageSquare ],
        
  function( sq )
    local d;
    
    d := DegreesOfChainMorphism( sq )[1];
    
    return CertainMorphism( sq, d );
    
end );

##
InstallMethod( CertainMorphismOfSpecialChainMorphism,
        "for homalg kernel square chain morphisms",
        [ IsHomalgChainMorphism and IsKernelSquare ],
        
  function( sq )
    local d;
    
    d := DegreesOfChainMorphism( sq )[1];
    
    return CertainMorphism( sq, d );
    
end );

##
InstallMethod( CertainMorphismOfSpecialChainMorphism,
        "for homalg Lambek pair of squares",
        [ IsHomalgChainMorphism and IsLambekPairOfSquares ],
        
  function( sq )
    local d;
    
    d := DegreesOfChainMorphism( sq )[1];
    
    return CertainMorphism( sq, d );
    
end );

##
InstallMethod( DegreesOfChainMorphism,		## this might differ from ObjectDegreesOfComplex( Source( cm ) ) when the chain morphism is not full
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return cm!.degrees;
    
end );

##
InstallMethod( ObjectDegreesOfComplex,		## this is not a mistake
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return ObjectDegreesOfComplex( Source( cm ) );
    
end );

##
InstallMethod( MorphismDegreesOfComplex,	## this is not a mistake
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return MorphismDegreesOfComplex( Source( cm ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsInt ],
        
  function( cm, i )
    
    if IsBound( cm!.(String( i )) ) and IsHomalgMorphism( cm!.(String( i )) ) then
        return cm!.(String( i ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( MorphismsOfChainMorphism,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local degrees;
    
    degrees := DegreesOfChainMorphism( cm );
    
    return List( degrees, i -> CertainMorphism( cm, i ) );
    
end );

##
InstallMethod( LowestDegree,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return DegreesOfChainMorphism( cm )[1];
    
end );

##
InstallMethod( HighestDegree,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local degrees;
    
    degrees := DegreesOfChainMorphism( cm );
    
    return degrees[Length( degrees )];
    
end );

##
InstallMethod( LowestDegreeMorphism,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return CertainMorphism( cm, LowestDegree( cm ) );
    
end );

##
InstallMethod( HighestDegreeMorphism,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return CertainMorphism( cm, HighestDegree( cm ) );
    
end );

##
InstallMethod( SupportOfChainMorphism,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local degrees, morphisms, l;
    
    degrees := DegreesOfChainMorphism( cm );
    morphisms := MorphismsOfChainMorphism( cm );
    
    l := Length( degrees );
    
    return degrees{ Filtered( [ 1 .. l ], i -> not IsZero( morphisms[i] ) ) };
    
end );

##
InstallMethod( Add,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( cm, phi )
    local d, degrees, l;
    
    if HasIsChainMorphismForPullback( cm ) and IsChainMorphismForPullback( cm ) then
        Error( "this chain morphism is write-protected since IsChainMorphismForPullback = true\n" );
    elif HasIsChainMorphismForPushout( cm ) and IsChainMorphismForPushout( cm ) then
        Error( "this chain morphism is write-protected since IsChainMorphismForPushout = true\n" );
    elif HasIsKernelSquare( cm ) and IsKernelSquare( cm ) then
        Error( "this chain morphism is write-protected since IsKernelSquare = true\n" );
    elif HasIsImageSquare( cm ) and IsImageSquare( cm ) then
        Error( "this chain morphism is write-protected since IsImageSquare = true\n" );
    elif HasIsLambekPairOfSquares( cm ) and IsLambekPairOfSquares( cm ) then
        Error( "this chain morphism is write-protected since IsLambekPairOfSquares = true\n" );
    fi;
    
    d := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMorphism( cm );
    
    l := Length( degrees );
    
    l := degrees[l] + 1;
    
    if not l in ObjectDegreesOfComplex( cm ) then
        Error( "there is no object in the source complex with index ", l, "\n" );
    fi;
    
    if IsHomalgStaticObject( Source( phi ) ) then
        if not IsIdenticalObj( CertainObject( Source( cm ), l ), Source( phi ) ) then
            Error( "the ", l, ". object of the source complex in the chain morphism and the source of the new morphism are not identical\n" );
        elif not IsIdenticalObj( CertainObject( Range( cm ), l + d ), Range( phi ) ) then
            Error( "the ", l, ". object of the target complex in the chain morphism and the target of the new morphism are not identical\n" );
        fi;
    else
        if CertainObject( Source( cm ), l ) <> Source( phi ) then
            Error( "the ", l, ". object of the source complex in the chain morphism and the source of the new morphism are not equal\n" );
        elif CertainObject( Range( cm ), l + d ) <> Range( phi ) then
            Error( "the ", l, ". object of the target complex in the chain morphism and the target of the new morphism are not equal\n" );
        fi;
    fi;
    
    Add( degrees, l );
    
    cm!.(String( l )) := phi;
    
    ConvertToRangeRep( cm!.degrees );
    
    homalgResetFilters( cm );
    
    return cm;
    
end );

##
InstallMethod( Add,
        "for homalg chain morphisms",
        [ IsMorphismOfFinitelyGeneratedObjectsRep, IsHomalgChainMorphism ],
        
  function( phi, cm )
    local d, degrees, l;
    
    if HasIsChainMorphismForPullback( cm ) and IsChainMorphismForPullback( cm ) then
        Error( "this chain morphism is write-protected since IsChainMorphismForPullback = true\n" );
    elif HasIsChainMorphismForPushout( cm ) and IsChainMorphismForPushout( cm ) then
        Error( "this chain morphism is write-protected since IsChainMorphismForPushout = true\n" );
    elif HasIsKernelSquare( cm ) and IsKernelSquare( cm ) then
        Error( "this chain morphism is write-protected since IsKernelSquare = true\n" );
    elif HasIsImageSquare( cm ) and IsImageSquare( cm ) then
        Error( "this chain morphism is write-protected since IsImageSquare = true\n" );
    elif HasIsLambekPairOfSquares( cm ) and IsLambekPairOfSquares( cm ) then
        Error( "this chain morphism is write-protected since IsLambekPairOfSquares = true\n" );
    fi;
    
    d := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMorphism( cm );
    
    l := degrees[1] - 1;
    
    if not l in ObjectDegreesOfComplex( cm ) then
        Error( "there is no object in the source complex with index ", l, "\n" );
    fi;
    
    if IsHomalgStaticObject( Source( phi ) ) then
        if not IsIdenticalObj( CertainObject( Source( cm ), l ), Source( phi ) ) then
            Error( "the ", l, ". object of the source complex in the chain morphism and the source of the new morphism are not identical\n" );
        elif not IsIdenticalObj( CertainObject( Range( cm ), l + d ), Range( phi ) ) then
            Error( "the ", l, ". object of the target complex in the chain morphism and the target of the new morphism are not identical\n" );
        fi;
    else
        if CertainObject( Source( cm ), l ) <> Source( phi ) then
            Error( "the ", l, ". object of the source complex in the chain morphism and the source of the new morphism are not equal\n" );
        elif CertainObject( Range( cm ), l + d ) <> Range( phi ) then
            Error( "the ", l, ". object of the target complex in the chain morphism and the target of the new morphism are not equal\n" );
        fi;
    fi;
    
    cm!.degrees := Concatenation( [ l ], degrees );
    
    cm!.(String( l )) := phi;
    
    ConvertToRangeRep( cm!.degrees );
    
    homalgResetFilters( cm );
    
    return cm;
    
end );

##
InstallMethod( AreComparableMorphisms,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( phi1, phi2 )
    
    return Source( phi1 ) = Source( phi2 ) and
           Range( phi1 ) = Range( phi2 ) and
           DegreeOfMorphism( phi1 ) = DegreeOfMorphism( phi2 );;
    
end );

##
InstallMethod( \=,
        "for two comparable homalg chain morphisms",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( phi1, phi2 )
    local morphisms1, morphisms2;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    morphisms1 := MorphismsOfChainMorphism( phi1 );
    morphisms2 := MorphismsOfChainMorphism( phi2 );
    
    return ForAll( [ 1 .. Length( morphisms1 ) ], i -> morphisms1[i] = morphisms2[i] );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( phi )
    local degree, S, T, degrees, morphisms, zeta, i;
    
    degree := DegreeOfMorphism( phi );
    
    S := Source( phi );
    T := Range( phi );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms := MorphismsOfChainMorphism( phi );
    
    zeta := HomalgChainMorphism( 0 * morphisms[1], S, T, [ degrees[1], degree ] );
    
    for i in [ 2 .. Length( morphisms ) ] do
        Add( zeta, 0 * morphisms[i] );
    od;
    
    return zeta;
    
end );

##
InstallMethod( \*,
        "of two homalg chain morphisms",
        [ IsRingElement, IsHomalgChainMorphism ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    local degree, S, T, degrees, morphisms, psi, i;
    
    degree := DegreeOfMorphism( phi );
    
    S := Source( phi );
    T := Range( phi );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms := MorphismsOfChainMorphism( phi );
    
    psi := HomalgChainMorphism( a * morphisms[1], S, T, [ degrees[1], degree ] );
    
    for i in [ 2 .. Length( morphisms ) ] do
        Add( psi, a * morphisms[i] );
    od;
    
    if IsUnit( StructureObject( phi ), a ) then
        if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
            SetIsIsomorphism( psi, true );
        else
            if HasIsSplitMonomorphism( phi ) and IsSplitMonomorphism( phi ) then
                SetIsSplitMonomorphism( psi, true );
            elif HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
                SetIsMonomorphism( psi, true );
            fi;
            
            if HasIsSplitEpimorphism( phi ) and IsSplitEpimorphism( phi ) then
                SetIsSplitEpimorphism( psi, true );
            elif HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
                SetIsEpimorphism( psi, true );
            elif HasIsMorphism( phi ) and IsMorphism( phi ) then
                SetIsMorphism( psi, true );
            fi;
        fi;
    elif HasIsMorphism( phi ) and IsMorphism( phi ) then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( \+,
        "of two homalg chain morphisms",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( phi1, phi2 )
    local degree, S, T, degrees, morphisms1, morphisms2, psi, i;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two chain morphisms are not comparable" );
    fi;
    
    degree := DegreeOfMorphism( phi1 );
    
    S := Source( phi1 );
    T := Range( phi1 );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms1 := MorphismsOfChainMorphism( phi1 );
    morphisms2 := MorphismsOfChainMorphism( phi2 );
    
    psi := HomalgChainMorphism( morphisms1[1] + morphisms2[1], S, T, [ degrees[1], degree ] );
    
    for i in [ 2 .. Length( morphisms1 ) ] do
        Add( psi, morphisms1[i] + morphisms2[i] );
    od;
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( phi )
    
    return (-1) * phi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg chain morphisms",
        [ IsHomalgChainMorphism and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
InstallMethod( \-,
        "of two homalg chain morphisms",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( phi1, phi2 )
    local degree, S, T, degrees, morphisms1, morphisms2, psi, i;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two chain morphisms are not comparable" );
    fi;
    
    degree := DegreeOfMorphism( phi1 );
    
    S := Source( phi1 );
    T := Range( phi1 );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms1 := MorphismsOfChainMorphism( phi1 );
    morphisms2 := MorphismsOfChainMorphism( phi2 );
    
    psi := HomalgChainMorphism( morphisms1[1] - morphisms2[1], S, T, [ degrees[1], degree ] );
    
    for i in [ 2 .. Length( morphisms1 ) ] do
        Add( psi, morphisms1[i] - morphisms2[i] );
    od;
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( PreCompose,
        "for two composable homalg chain morphisms",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( pre, post )
    local degree_pre, degree_post, S, T, degrees, morphisms_pre, morphisms_post, psi, i;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( pre ) then
        if not AreComposableMorphisms( pre, post ) then
            Error( "the two chain morphisms are not composable, since the target of the left one and the source of right one are not equal\n" );
        fi;
    else
        if not AreComposableMorphisms( post, pre ) then
            Error( "the two chain morphisms are not composable, since the target of the left one and the source of right one are not equal\n" );
        fi;
    fi;
    
    degree_pre := DegreeOfMorphism( pre );
    degree_post := DegreeOfMorphism( post );
    
    S := Source( pre );
    T := Range( post );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms_pre := MorphismsOfChainMorphism( pre );
    morphisms_post := MorphismsOfChainMorphism( post );
    
    psi := HomalgChainMorphism( PreCompose( morphisms_pre[1], morphisms_post[1] ), S, T, [ degrees[1], degree_pre + degree_post ] );
    
    for i in [ 2 .. Length( morphisms_pre ) ] do
        Add( psi, PreCompose( morphisms_pre[i], morphisms_post[i] ) );
    od;
    
    SetPropertiesOfComposedMorphism( pre, post, psi );
    
    return psi;
    
end );

##
InstallMethod( DecideZero,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( phi )
    
    DecideZero( Source( phi ) );
    DecideZero( Range( phi ) );
    
    List( MorphismsOfChainMorphism( phi ), DecideZero );
    
    return phi;
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:chainmorphism">
##  <ManSection>
##    <Meth Arg="cm" Name="ByASmallerPresentation" Label="for chain morphisms"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##    See <Ref Meth="ByASmallerPresentation" Label="for complexes"/> on complexes.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    ByASmallerPresentation( Source( cm ) );
    ByASmallerPresentation( Range( cm ) );
    
    List( MorphismsOfChainMorphism( cm ), DecideZero );
    
    return cm;
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>cm</A> and returns it.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( CertainMorphismAsKernelSquare,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainMorphismAsSubcomplex( Source( cm ), i );
    T := CertainMorphismAsSubcomplex( Range( cm ), i + degree );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMorphism( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsKernelSquare( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CertainMorphismAsImageSquare,
        "for homalg chain morphisms",
        [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainMorphismAsSubcomplex( Source( cm ), i + 1 );
    T := CertainMorphismAsSubcomplex( Range( cm ), i + 1 + degree );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMorphism( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsImageSquare( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CertainMorphismAsImageSquare,
        "for homalg chain morphisms",
        [ IsCochainMorphismOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainMorphismAsSubcomplex( Source( cm ), i - 1 );
    T := CertainMorphismAsSubcomplex( Range( cm ), i - 1 );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMorphism( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsImageSquare( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CertainMorphismAsLambekPairOfSquares,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainTwoMorphismsAsSubcomplex( Source( cm ), i );
    T := CertainTwoMorphismsAsSubcomplex( Range( cm ), i + degree );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMorphism( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsLambekPairOfSquares( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CompleteImageSquare,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism and IsImageSquare ],
        
  function( cm )
    local alpha, phi, beta;
    
    alpha := LowestDegreeMorphism( Source( cm ) );
    phi := LowestDegreeMorphism( cm );
    beta := LowestDegreeMorphism( Range( cm ) );
    
    return CompleteImageSquare( alpha, phi, beta );
    
end );

##
InstallMethod( PostDivide,
        "for two chain morphisms with the same target",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( gamma, beta )
    local degree_gamma, degree_beta, S, T, degrees, morphisms_gamma, morphisms_beta,
          psi_i, b, psi, i;
    
    if not Range( gamma ) = Range( beta ) then
        Error( "the target objects of the two morphisms are not equal\n" );
    fi;
    
    degree_gamma := DegreeOfMorphism( gamma );
    degree_beta := DegreeOfMorphism( beta );
    
    S := Source( gamma );
    T := Source( beta );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms_gamma := MorphismsOfChainMorphism( gamma );
    morphisms_beta := MorphismsOfChainMorphism( beta );
    
    psi_i := PostDivide( morphisms_gamma[1], morphisms_beta[1] );
    
    b := HasIsMorphism( psi_i ) and IsMorphism( psi_i );
    
    psi := HomalgChainMorphism( psi_i, S, T, [ degrees[1], degree_gamma - degree_beta ] );
    
    for i in [ 2 .. Length( morphisms_gamma ) ] do
        psi_i := PostDivide( morphisms_gamma[i], morphisms_beta[i] );
        b := b and HasIsMorphism( psi_i ) and IsMorphism( psi_i );
        Add( psi, psi_i );
    od;
    
    Assert( 2, IsMorphism( psi ) );
    
    if b then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( PreDivide,
        "for two chain morphisms with the same source",
        [ IsHomalgChainMorphism, IsHomalgChainMorphism ],
        
  function( epsilon, eta )
    local degree_epsilon, degree_eta, S, T, degrees, morphisms_epsilon, morphisms_eta,
          psi_i, b, psi, i;
    
    if not Source( epsilon ) = Source( eta ) then
        Error( "the source objects of the two chain morphisms are not equal\n" );
    fi;
    
    degree_epsilon := DegreeOfMorphism( epsilon );
    degree_eta := DegreeOfMorphism( eta );
    
    S := Range( epsilon );
    T := Range( eta );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms_epsilon := MorphismsOfChainMorphism( epsilon );
    morphisms_eta := MorphismsOfChainMorphism( eta );
    
    psi_i := PreDivide( morphisms_epsilon[1], morphisms_eta[1] );
    
    b := HasIsMorphism( psi_i ) and IsMorphism( psi_i );
    
    psi := HomalgChainMorphism( psi_i, S, T, [ degrees[1], degree_epsilon - degree_eta ] );
    
    for i in [ 2 .. Length( morphisms_epsilon ) ] do
        psi_i := PreDivide( morphisms_epsilon[i], morphisms_eta[i] );
        b := b and HasIsMorphism( psi_i ) and IsMorphism( psi_i );
        Add( psi, psi_i );
    od;
    
    Assert( 2, IsMorphism( psi ) );
    
    if b then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( SubChainMorphism,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsInt, IsInt ],
        
  function( d_phi, i, j )
    local dS, dT, phi, d_psi, k;
    
    dS := Subcomplex( Source( d_phi ), i, j );
    
    if IsHomalgEndomorphism( d_phi ) then
        dT := dS;
    else
        dT := Subcomplex( Range( d_phi ), i, j );
    fi;
    
    phi := CertainMorphism( d_phi, i );
    
    if phi = fail then
        Error( "The chain map does not have the demanded degree" );
    fi;
    
    d_psi := HomalgChainMorphism( phi, dS, dT, i );
    
    for k in [ i+1 .. j ] do
        
        phi := CertainMorphism( d_phi, k );
        
        if phi = fail then
            Error( "The chain map does not have the demanded degree" );
        fi;
        
        Add( d_psi, phi );
        
    od;
    
    if HasIsZero( d_phi ) and IsZero( d_phi ) then
        SetIsZero( d_psi, true );
    elif HasIsGradedMorphism( d_phi ) and IsGradedMorphism( d_phi ) then
        SetIsGradedMorphism( d_psi, true );
    fi;
    
    if HasIsOne( d_phi ) and IsOne( d_phi ) then
        SetIsOne( d_psi, true );
    fi;
    
    if HasIsMorphism( d_phi ) and IsMorphism( d_phi ) then
        SetIsMorphism( d_psi, true );
    fi;
    
    if HasIsGeneralizedMorphism( d_phi ) and IsGeneralizedMorphism( d_phi ) then
        SetIsGeneralizedMorphism( d_psi, true );
    fi;
    
    if HasIsGeneralizedEpimorphism( d_phi ) and IsGeneralizedEpimorphism( d_phi ) then
        SetIsGeneralizedEpimorphism( d_psi, true );
    fi;
    
    if HasIsGeneralizedMonomorphism( d_phi ) and IsGeneralizedMonomorphism( d_phi ) then
        SetIsGeneralizedMonomorphism( d_psi, true );
    fi;
    
    if HasIsMonomorphism( d_phi ) and IsMonomorphism( d_phi ) then
        SetIsMonomorphism( d_psi, true );
    fi;
    
    if HasIsEpimorphism( d_phi ) and IsEpimorphism( d_phi ) then
        SetIsEpimorphism( d_psi, true );
    fi;
    
    if HasIsSplitMonomorphism( d_phi ) and IsSplitMonomorphism( d_phi ) then
        SetIsSplitMonomorphism( d_psi, true );
    fi;
    
    if HasIsSplitEpimorphism( d_phi ) and IsSplitEpimorphism( d_phi ) then
        SetIsSplitEpimorphism( d_psi, true );
    fi;
    
    return d_psi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgChainMorphism">
##  <ManSection>
##    <Func Arg="phi[, C][, D][, d]" Name="HomalgChainMorphism" Label="constructor for chain morphisms given a morphism"/>
##    <Returns>a &homalg; chain morphism</Returns>
##    <Description>
##      The constructor creates a (co)chain morphism given a source &homalg; (co)chain complex <A>C</A>,
##      a target &homalg; (co)chain complex <A>D</A>, and a &homalg; morphism <A>phi</A> at (co)homological degree <A>d</A>.
##      The returned (co)chain morphism will cautiously be indicated using parenthesis: <Q>chain morphism</Q>.
##      To verify if the result is indeed a (co)chain morphism use <Ref Prop="IsMorphism" Label="for chain morphisms"/>.
##      If source and target are identical objects, and only then, the (co)chain morphism is created as a (co)chain endomorphism.
##      <P/>
##      The following examples shows a chain morphism that induces the zero morphism on homology, but is itself <E>not</E> zero
##      in the derived category:
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := 1 * ZZ;
##  <The free left module of rank 1 on a free generator>
##  gap> Display( M );
##  Z^(1 x 1)
##  gap> N := HomalgMatrix( "[3]", 1, 1, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> Display( N );
##  Z/< 3 >
##  gap> a := HomalgMap( HomalgMatrix( "[2]", 1, 1, ZZ ), M, M );
##  <An endomorphism of a left module>
##  gap> c := HomalgMap( HomalgMatrix( "[2]", 1, 1, ZZ ), M, N );
##  <A homomorphism of left modules>
##  gap> b := HomalgMap( HomalgMatrix( "[1]", 1, 1, ZZ ), M, M );
##  <An endomorphism of a left module>
##  gap> d := HomalgMap( HomalgMatrix( "[1]", 1, 1, ZZ ), M, N );
##  <A homomorphism of left modules>
##  gap> C1 := HomalgComplex( a );
##  <A non-zero acyclic complex containing a single morphism of left modules at de\
##  grees [ 0 .. 1 ]>
##  gap> C2 := HomalgComplex( c );
##  <A non-zero acyclic complex containing a single morphism of left modules at de\
##  grees [ 0 .. 1 ]>
##  gap> cm := HomalgChainMorphism( d, C1, C2 );
##  <A "chain morphism" containing a single left morphism at degree 0>
##  gap> Add( cm, b );
##  gap> IsMorphism( cm );
##  true
##  gap> cm;
##  <A chain morphism containing 2 morphisms of left modules at degrees
##  [ 0 .. 1 ]>
##  gap> hcm := DefectOfExactness( cm );
##  <A chain morphism of graded objects containing
##  2 morphisms of left modules at degrees [ 0 .. 1 ]>
##  gap> IsZero( hcm );
##  true
##  gap> IsZero( Source( hcm ) );
##  false
##  gap> IsZero( Range( hcm ) );
##  false
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgChainMorphism,
  function( arg )
    local nargs, morphism, left, source, target, degrees, degree,
          S, category, chainmorphism, type, cm;
    
    nargs := Length( arg );
    
    if nargs < 2 then
        Error( "too few arguments\n" );
    fi;
    
    if IsMorphismOfFinitelyGeneratedObjectsRep( arg[1] ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( arg[1] );
        morphism := arg[1];
    elif nargs = 1 then
        Error( "if a single argument is given it must be a homalg morphism\n" );
    fi;
    
    if nargs > 1 and IsHomalgComplex( arg[2] ) then
        if not IsBound( left ) then
            left := IsHomalgLeftObjectOrMorphismOfLeftObjects( arg[2] );
        fi;
        source := arg[2];
    fi;
    
    if nargs > 2 and IsHomalgComplex( arg[3] ) then
        if ( IsHomalgRightObjectOrMorphismOfRightObjects( arg[3] ) and left ) or
           ( IsHomalgLeftObjectOrMorphismOfLeftObjects( arg[3] ) and not left ) then
            Error( "the two complexes must either be both left or both right complexes\n" );
        fi;
        target := arg[3];
    else
        target := source;
    fi;
    
    if IsInt( arg[nargs] ) then
        degrees := [ arg[nargs] ];
        degree := 0;
    elif IsList( arg[nargs] ) and Length( arg[nargs] ) = 2 and ForAll( arg[nargs], IsInt ) then
        degrees := [ arg[nargs][1] ];
        degree := arg[nargs][2];
    else
        degrees := [ ObjectDegreesOfComplex( source )[1] ];
        degree := 0;
    fi;
    
    if not IsBound( morphism ) then
        if IsHomalgMatrix( arg[1] ) then
            S := CertainObject( source, degrees[1] );
            category := CategoryOfObject( S );
            if IsBound( category.MorphismConstructor ) then
                morphism := category.MorphismConstructor( arg[1], S, CertainObject( target, degrees[1] + degree ) );
            else
                Error( "didn't find the morphism constructor in the category of the source object\n" );
            fi;
        else
            Error( "the first argument must be a homalg matrix or a morphism\n" );
        fi;
    fi;
    
    if IsHomalgChainMorphism( morphism ) then
        if Source( morphism ) <> CertainObject( source, degrees[1] ) then
            Error( "the chain morphism and the source complex do not match\n" );
        elif Range( morphism ) <> CertainObject( target, degrees[1] ) then
            Error( "the chain morphism and the target complex do not match\n" );
        fi;
    else
        if not IsIdenticalObj( Source( morphism ), CertainObject( source, degrees[1] ) ) then
            Error( "the morphism and the source complex do not match\n" );
        elif not IsIdenticalObj( Range( morphism ), CertainObject( target, degrees[1] + degree ) ) then
            Error( "the morphism and the target complex do not match\n" );
        fi;
    fi;
    
    ConvertToRangeRep( degrees );
    
    cm := rec( degrees := degrees );
    
    cm.(String( degrees[1] )) := morphism;
    
    if IsComplexOfFinitelyPresentedObjectsRep( source ) and
       IsComplexOfFinitelyPresentedObjectsRep( target ) then
        chainmorphism := true;
    elif IsCocomplexOfFinitelyPresentedObjectsRep( source ) and
      IsCocomplexOfFinitelyPresentedObjectsRep( target ) then
        chainmorphism := false;
    else
        Error( "source and target must either be both complexes or both cocomplexes\n" );
    fi;
    
    if source = target then
        if chainmorphism then
            if left then
                type := TheTypeHomalgChainEndomorphismOfLeftObjects;
            else
                type := TheTypeHomalgChainEndomorphismOfRightObjects;
            fi;
        else
            if left then
                type := TheTypeHomalgCochainEndomorphismOfLeftObjects;
            else
                type := TheTypeHomalgCochainEndomorphismOfRightObjects;
            fi;
        fi;
    else
        if chainmorphism then
            if left then
                type := TheTypeHomalgChainMorphismOfLeftObjects;
            else
                type := TheTypeHomalgChainMorphismOfRightObjects;
            fi;
        else
            if left then
                type := TheTypeHomalgCochainMorphismOfLeftObjects;
            else
                type := TheTypeHomalgCochainMorphismOfRightObjects;
            fi;
        fi;
    fi;
    
    ## Objectify
    ObjectifyWithAttributes(
            cm, type,
            Source, source,
            Range, target,
            DegreeOfMorphism, degree
            );
    
    return cm;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( o )
    local degrees, l, oi;
    
    Print( "<A" );
    
    if HasDegreeOfMorphism( o ) and DegreeOfMorphism( o ) <> 0 then
        Print( " degree ", DegreeOfMorphism( o ) );
    fi;
    
    if HasIsZero( o ) then
        if IsZero ( o ) then
            Print( " zero" );
        else
            Print( " non-zero" );
        fi;
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            if IsChainMorphismOfFinitelyPresentedObjectsRep( o ) then
                Print( " chain " );
            else
                Print( " cochain " );
            fi;
            if HasIsIsomorphism( o ) and IsIsomorphism( o ) then
                Print( "iso" );
            elif HasIsQuasiIsomorphism( o ) and IsQuasiIsomorphism( o ) then
                Print( "quasi-iso" );
            elif HasIsMonomorphism( o ) and IsMonomorphism( o ) then
                Print( "mono" );
            elif HasIsEpimorphism( o ) and IsEpimorphism( o ) then
                Print( "epi" );
            fi;
        else
            if IsChainMorphismOfFinitelyPresentedObjectsRep( o ) then
                Print( " non-chain " );
            else
                Print( " non-cochain " );
            fi;
        fi;
        Print( "morphism" );
    elif HasIsGeneralizedMorphism( o ) then
        if IsGeneralizedMorphism( o ) then
            if IsChainMorphismOfFinitelyPresentedObjectsRep( o ) then
                Print( " generalized chain " );
            else
                Print( " generalized cochain " );
            fi;
        else
            if IsChainMorphismOfFinitelyPresentedObjectsRep( o ) then
                Print( " non-chain " );
            else
                Print( " non-cochain " );
            fi;
        fi;
        Print( "morphism" );
    else
        if IsChainMorphismOfFinitelyPresentedObjectsRep( o ) then
            Print( " \"chain morphism\"" );
        else
            Print( " \"cochain morphism\"" );
                   fi;
    fi;
    
    if HasIsGradedMorphism( o ) and IsGradedMorphism( o ) then
        Print( " of graded objects" );
    fi;
    
    Print( " containing " );
    
    degrees := DegreesOfChainMorphism( o );
    
    l := Length( degrees );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        Print( " morphism at degree ", degrees[1], ">" );
        
    else
        
        Print( l, " morphisms" );
        
        Print( " of " );
        
        if IsBound( o!.adjective ) then
            Print( o!.adjective, " " );
        fi;
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left " );
        else
            Print( "right " );
        fi;
        
        oi := Source( CertainMorphism( o, degrees[1] ) );
        
        if IsBound( oi!.string ) then
            if IsBound( oi!.string_plural ) then
                Print( oi!.string_plural );
            else
                Print( oi!.string, "s" );
            fi;
        else
            Print( "objects" );
        fi;
        
        Print( " at degrees ", degrees, ">" );
        
    fi;
    
end );

##
InstallMethod( Display,
        "for homalg chain morphisms",
        [ IsChainMorphismOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local i;
    
    for i in Reversed( DegreesOfChainMorphism( o ) ) do
        Print( "-------------------------\n" );
        Print( "at homology degree: ", i, "\n" );
        Display( CertainMorphism( o, i ) );
    od;
    
    Print( "-------------------------\n" );
    
end );

##
InstallMethod( Display,
        "for homalg chain morphisms",
        [ IsCochainMorphismOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local i;
    
    for i in Reversed( DegreesOfChainMorphism( o ) ) do
        Print( "---------------------------\n" );
        Print( "at cohomology degree: ", i, "\n" );
        Display( CertainMorphism( o, i ) );
    od;
    
    Print( "-------------------------\n" );
    
end );

