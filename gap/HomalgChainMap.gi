#############################################################################
##
##  HomalgChainMap.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for homalg chain maps.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsChainMapOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsChainMapOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of chain maps of finitley generated &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgChainMap"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsChainMapOfFinitelyPresentedObjectsRep",
        IsHomalgChainMap and IsMorphismOfFinitelyGeneratedObjectsRep,
        [  ] );

##  <#GAPDoc Label="IsCochainMapOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsCochainMapOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of cochain maps of finitley generated &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgChainMap"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCochainMapOfFinitelyPresentedObjectsRep",
        IsHomalgChainMap and IsMorphismOfFinitelyGeneratedObjectsRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgChainMaps",
        NewFamily( "TheFamilyOfHomalgChainMaps" ) );

# eight new types:
BindGlobal( "TheTypeHomalgChainMapOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgChainMapOfRightObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgCochainMapOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgCochainMapOfRightObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgChainSelfMapOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedObjectsRep and IsHomalgChainSelfMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgChainSelfMapOfRightObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedObjectsRep and IsHomalgChainSelfMap and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgCochainSelfMapOfLeftObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedObjectsRep and IsHomalgChainSelfMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgCochainSelfMapOfRightObjects",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedObjectsRep and IsHomalgChainSelfMap and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgResetFilters,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfChainMaps ) then
        HOMALG.PropertiesOfChainMaps :=
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
    fi;
    
    for property in HOMALG.PropertiesOfChainMaps do
        ResetFilterObj( cm, property );
    od;
    
end );

##
InstallMethod( SourceOfSpecialChainMap,
        "for homalg image square chain maps",
        [ IsHomalgChainMap and IsImageSquare ],
        
  function( sq )
    
    return LowestDegreeMorphism( Source( sq ) );
    
end );

##
InstallMethod( SourceOfSpecialChainMap,
        "for homalg kernel square chain maps",
        [ IsHomalgChainMap and IsKernelSquare ],
        
  function( sq )
    
    return HighestDegreeMorphism( Source( sq ) );
    
end );

##
InstallMethod( SourceOfSpecialChainMap,
        "for homalg Lambek pair of squares",
        [ IsHomalgChainMap and IsLambekPairOfSquares ],
        
  function( sq )
    
    return AsATwoSequence( Source( sq ) );
    
end );

##
InstallMethod( RangeOfSpecialChainMap,
        "for homalg image square chain maps",
        [ IsHomalgChainMap and IsImageSquare ],
        
  function( sq )
    
    return LowestDegreeMorphism( Range( sq ) );
    
end );

##
InstallMethod( RangeOfSpecialChainMap,
        "for homalg kernel square chain maps",
        [ IsHomalgChainMap and IsKernelSquare ],
        
  function( sq )
    
    return HighestDegreeMorphism( Range( sq ) );
    
end );

##
InstallMethod( RangeOfSpecialChainMap,
        "for homalg Lambek pair of squares",
        [ IsHomalgChainMap and IsLambekPairOfSquares ],
        
  function( sq )
    
    return AsATwoSequence( Range( sq ) );
    
end );

##
InstallMethod( CertainMorphismOfSpecialChainMap,
        "for homalg image square chain maps",
        [ IsHomalgChainMap and IsImageSquare ],
        
  function( sq )
    local d;
    
    d := DegreesOfChainMap( sq )[1];
    
    return CertainMorphism( sq, d );
    
end );

##
InstallMethod( CertainMorphismOfSpecialChainMap,
        "for homalg kernel square chain maps",
        [ IsHomalgChainMap and IsKernelSquare ],
        
  function( sq )
    local d;
    
    d := DegreesOfChainMap( sq )[1];
    
    return CertainMorphism( sq, d );
    
end );

##
InstallMethod( CertainMorphismOfSpecialChainMap,
        "for homalg Lambek pair of squares",
        [ IsHomalgChainMap and IsLambekPairOfSquares ],
        
  function( sq )
    local d;
    
    d := DegreesOfChainMap( sq )[1];
    
    return CertainMorphism( sq, d );
    
end );

##
InstallMethod( DegreesOfChainMap,		## this might differ from ObjectDegreesOfComplex( Source( cm ) ) when the chain map is not full
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return cm!.degrees;
    
end );

##
InstallMethod( ObjectDegreesOfComplex,		## this is not a mistake
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return ObjectDegreesOfComplex( Source( cm ) );
    
end );

##
InstallMethod( MorphismDegreesOfComplex,	## this is not a mistake
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return MorphismDegreesOfComplex( Source( cm ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    
    if IsBound( cm!.(String( i )) ) and IsHomalgMorphism( cm!.(String( i )) ) then
        return cm!.(String( i ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( MorphismsOfChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local degrees;
    
    degrees := DegreesOfChainMap( cm );
    
    return List( degrees, i -> CertainMorphism( cm, i ) );
    
end );

##
InstallMethod( LowestDegree,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return DegreesOfChainMap( cm )[1];
    
end );

##
InstallMethod( HighestDegree,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local degrees;
    
    degrees := DegreesOfChainMap( cm );
    
    return degrees[Length( degrees )];
    
end );

##
InstallMethod( LowestDegreeMorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return CertainMorphism( cm, LowestDegree( cm ) );
    
end );

##
InstallMethod( HighestDegreeMorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return CertainMorphism( cm, HighestDegree( cm ) );
    
end );

##
InstallMethod( SupportOfChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local degrees, morphisms, l;
    
    degrees := DegreesOfChainMap( cm );
    morphisms := MorphismsOfChainMap( cm );
    
    l := Length( degrees );
    
    return degrees{ Filtered( [ 1 .. l ], i -> not IsZero( morphisms[i] ) ) };
    
end );

##
InstallMethod( Add,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( cm, phi )
    local d, degrees, l;
    
    if HasIsChainMapForPullback( cm ) and IsChainMapForPullback( cm ) then
        Error( "this chain map is write-protected since IsChainMapForPullback = true\n" );
    elif HasIsChainMapForPushout( cm ) and IsChainMapForPushout( cm ) then
        Error( "this chain map is write-protected since IsChainMapForPushout = true\n" );
    elif HasIsKernelSquare( cm ) and IsKernelSquare( cm ) then
        Error( "this chain map is write-protected since IsKernelSquare = true\n" );
    elif HasIsImageSquare( cm ) and IsImageSquare( cm ) then
        Error( "this chain map is write-protected since IsImageSquare = true\n" );
    elif HasIsLambekPairOfSquares( cm ) and IsLambekPairOfSquares( cm ) then
        Error( "this chain map is write-protected since IsLambekPairOfSquares = true\n" );
    fi;
    
    d := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMap( cm );
    
    l := Length( degrees );
    
    l := degrees[l] + 1;
    
    if not l in ObjectDegreesOfComplex( cm ) then
        Error( "there is no module in the source complex with index ", l, "\n" );
    fi;
    
    if IsHomalgStaticObject( Source( phi ) ) then
        if not IsIdenticalObj( CertainObject( Source( cm ), l ), Source( phi ) ) then
            Error( "the ", l, ". module of the source complex in the chain map and the source of the new map are not identical\n" );
        elif not IsIdenticalObj( CertainObject( Range( cm ), l + d ), Range( phi ) ) then
            Error( "the ", l, ". module of the target complex in the chain map and the target of the new map are not identical\n" );
        fi;
    else
        if CertainObject( Source( cm ), l ) <> Source( phi ) then
            Error( "the ", l, ". object of the source complex in the chain map and the source of the new morphism are not the same\n" );
        elif CertainObject( Range( cm ), l + d ) <> Range( phi ) then
            Error( "the ", l, ". object of the target complex in the chain map and the target of the new morphism are not the same\n" );
        fi;
    fi;
    
    Add( degrees, l );
    
    cm!.(String( l )) := phi;
    
    ConvertToRangeRep( cm!.degrees );
    
    homalgResetFilters( cm );
    
    return cm;
    
end );

##
InstallMethod( AreComparableMorphisms,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsHomalgChainMap ],
        
  function( phi1, phi2 )
    
    return Source( phi1 ) = Source( phi2 ) and
           Range( phi1 ) = Range( phi2 ) and
           DegreeOfMorphism( phi1 ) = DegreeOfMorphism( phi2 );;
    
end );

##
InstallMethod( \=,
        "for two comparable homalg chain maps",
        [ IsHomalgChainMap, IsHomalgChainMap ],
        
  function( phi1, phi2 )
    local morphisms1, morphisms2;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    morphisms1 := MorphismsOfChainMap( phi1 );
    morphisms2 := MorphismsOfChainMap( phi2 );
    
    return ForAll( [ 1 .. Length( morphisms1 ) ], i -> morphisms1[i] = morphisms2[i] );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    local degree, S, T, degrees, morphisms, zeta, i;
    
    degree := DegreeOfMorphism( phi );
    
    S := Source( phi );
    T := Range( phi );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms := MorphismsOfChainMap( phi );
    
    zeta := HomalgChainMap( 0 * morphisms[1], S, T, [ degrees[1], degree ] );
    
    for i in [ 2 .. Length( morphisms ) ] do
        Add( zeta, 0 * morphisms[i] );
    od;
    
    return zeta;
    
end );

##
InstallMethod( \*,
        "of two homalg chain maps",
        [ IsRingElement, IsHomalgChainMap ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    local degree, S, T, degrees, morphisms, psi, i;
    
    degree := DegreeOfMorphism( phi );
    
    S := Source( phi );
    T := Range( phi );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms := MorphismsOfChainMap( phi );
    
    psi := HomalgChainMap( a * morphisms[1], S, T, [ degrees[1], degree ] );
    
    for i in [ 2 .. Length( morphisms ) ] do
        Add( psi, a * morphisms[i] );
    od;
    
    if IsUnit( HomalgRing( phi ), a ) then
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
        "of two homalg chain maps",
        [ IsHomalgChainMap, IsHomalgChainMap ],
        
  function( phi1, phi2 )
    local degree, S, T, degrees, morphisms1, morphisms2, psi, i;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two chain maps are not comparable" );
    fi;
    
    degree := DegreeOfMorphism( phi1 );
    
    S := Source( phi1 );
    T := Range( phi1 );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms1 := MorphismsOfChainMap( phi1 );
    morphisms2 := MorphismsOfChainMap( phi2 );
    
    psi := HomalgChainMap( morphisms1[1] + morphisms2[1], S, T, [ degrees[1], degree ] );
    
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
        "of homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return (-1) * phi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg chain maps",
        [ IsHomalgChainMap and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
InstallMethod( \-,
        "of two homalg chain maps",
        [ IsHomalgChainMap, IsHomalgChainMap ],
        
  function( phi1, phi2 )
    local degree, S, T, degrees, morphisms1, morphisms2, psi, i;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two chain maps are not comparable" );
    fi;
    
    degree := DegreeOfMorphism( phi1 );
    
    S := Source( phi1 );
    T := Range( phi1 );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms1 := MorphismsOfChainMap( phi1 );
    morphisms2 := MorphismsOfChainMap( phi2 );
    
    psi := HomalgChainMap( morphisms1[1] - morphisms2[1], S, T, [ degrees[1], degree ] );
    
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
InstallMethod( \*,
        "of two homalg chain maps",
        [ IsHomalgChainMap and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgChainMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    local degree1, degree2, S, T, degrees, morphisms1, morphisms2, psi, i;
    
    
    if not AreComposableMorphisms( phi1, phi2 ) then
        Error( "the two chain maps are not composable, since the target of the left one and the source of right one are not equal\n" );
    fi;
    
    degree1 := DegreeOfMorphism( phi1 );
    degree2 := DegreeOfMorphism( phi2 );
    
    S := Source( phi1 );
    T := Range( phi2 );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms1 := MorphismsOfChainMap( phi1 );
    morphisms2 := MorphismsOfChainMap( phi2 );
    
    psi := HomalgChainMap( morphisms1[1] * morphisms2[1], S, T, [ degrees[1], degree1 + degree2 ] );
    
    for i in [ 2 .. Length( morphisms1 ) ] do
        Add( psi, morphisms1[i] * morphisms2[i] );
    od;
    
    if HasIsMonomorphism( phi1 ) and IsMonomorphism( phi1 ) and
       HasIsMonomorphism( phi2 ) and IsMonomorphism( phi2 ) then
        SetIsMonomorphism( psi, true );
    fi;
    
    ## cannot use elif here:
    if HasIsEpimorphism( phi1 ) and IsEpimorphism( phi1 ) and
       HasIsEpimorphism( phi2 ) and IsEpimorphism( phi2 ) then
        SetIsEpimorphism( psi, true );
    elif HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
      HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( \*,
        "of two homalg chain maps",
        [ IsHomalgChainMap and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgChainMap and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi2, phi1 )
    local degree1, degree2, S, T, degrees, morphisms1, morphisms2, psi, i;
    
    
    if not AreComposableMorphisms( phi2, phi1 ) then
        Error( "the two chain maps are not composable, since the target of the left one and the source of right one are not equal\n" );
    fi;
    
    degree1 := DegreeOfMorphism( phi1 );
    degree2 := DegreeOfMorphism( phi2 );
    
    S := Source( phi1 );
    T := Range( phi2 );
    
    degrees := ObjectDegreesOfComplex( S );
    
    morphisms1 := MorphismsOfChainMap( phi1 );
    morphisms2 := MorphismsOfChainMap( phi2 );
    
    psi := HomalgChainMap( morphisms2[1] * morphisms1[1], S, T, [ degrees[1], degree1 + degree2 ] );
    
    for i in [ 2 .. Length( morphisms1 ) ] do
        Add( psi, morphisms2[i] * morphisms1[i] );
    od;
    
    if HasIsMonomorphism( phi1 ) and IsMonomorphism( phi1 ) and
       HasIsMonomorphism( phi2 ) and IsMonomorphism( phi2 ) then
        SetIsMonomorphism( psi, true );
    fi;
    
    ## cannot use elif here:
    if HasIsEpimorphism( phi1 ) and IsEpimorphism( phi1 ) and
       HasIsEpimorphism( phi2 ) and IsEpimorphism( phi2 ) then
        SetIsEpimorphism( psi, true );
    elif HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
      HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( DecideZero,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    DecideZero( Source( phi ) );
    DecideZero( Range( phi ) );
    
    List( MorphismsOfChainMap( phi ), DecideZero );
    
    return phi;
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:chainmap">
##  <ManSection>
##    <Meth Arg="cm" Name="ByASmallerPresentation" Label="for chain maps"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##    See <Ref Meth="ByASmallerPresentation" Label="for complexes"/> on complexes.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    ByASmallerPresentation( Source( cm ) );
    ByASmallerPresentation( Range( cm ) );
    
    List( MorphismsOfChainMap( cm ), DecideZero );
    
    return cm;
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>cm</A> and returns it.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( CertainMorphismAsKernelSquare,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainMorphismAsSubcomplex( Source( cm ), i );
    T := CertainMorphismAsSubcomplex( Range( cm ), i );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMap( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsKernelSquare( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CertainMorphismAsImageSquare,
        "for homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainMorphismAsSubcomplex( Source( cm ), i + 1 );
    T := CertainMorphismAsSubcomplex( Range( cm ), i + 1 );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMap( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsImageSquare( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CertainMorphismAsImageSquare,
        "for homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainMorphismAsSubcomplex( Source( cm ), i - 1 );
    T := CertainMorphismAsSubcomplex( Range( cm ), i - 1 );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMap( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsImageSquare( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CertainMorphismAsLambekPairOfSquares,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    local degree, phi, S, T, sub;
    
    degree := DegreeOfMorphism( cm );
    
    phi := CertainMorphism( cm, i );
    
    S := CertainTwoMorphismsAsSubcomplex( Source( cm ), i );
    T := CertainTwoMorphismsAsSubcomplex( Range( cm ), i );
    
    if phi = fail or S = fail or T = fail then
        return fail;
    fi;
    
    sub := HomalgChainMap( phi, S, T, [ i, degree ] );
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        SetIsMorphism( sub, true );
    fi;
    
    SetIsLambekPairOfSquares( sub, true );
    
    return sub;
    
end );

##
InstallMethod( CompleteImageSquare,
        "for homalg chain maps",
        [ IsHomalgChainMap and IsImageSquare ],
        
  function( cm )
    local alpha, phi, beta;
    
    alpha := LowestDegreeMorphism( Source( cm ) );
    phi := LowestDegreeMorphism( cm );
    beta := LowestDegreeMorphism( Range( cm ) );
    
    return CompleteImageSquare( alpha, phi, beta );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgChainMap">
##  <ManSection>
##    <Func Arg="phi[, C][, D][, d]" Name="HomalgChainMap" Label="constructor for chain maps given a map"/>
##    <Returns>a &homalg; chain map</Returns>
##    <Description>
##      The constructor creates a (co)chain map given a source &homalg; (co)chain complex <A>C</A>,
##      a target &homalg; (co)chain complex <A>D</A> (&see; <Ref Sect="Modules:Constructors"/>), and a
##      &homalg; map <A>phi</A> (&see; <Ref Sect="Maps:Constructors"/>)at (co)homological degree <A>d</A>.
##      The returned (co)chain map will cautiously be indicated using parenthesis: <Q>chain map</Q>.
##      To verify if the result is indeed a (co)chain map use <Ref Prop="IsMorphism" Label="for chain maps"/>.
##      If source and target are identical objects, and only then, the (co)chain map is created as a (co)chain selfmap.
##      <P/>
##      The following examples shows a chain map that induces the zero map on homology, but is itself <E>not</E> zero
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
##  gap> cm := HomalgChainMap( d, C1, C2 );
##  <A "chain map" containing a single left morphism at degree 0>
##  gap> Add( cm, b );
##  gap> IsMorphism( cm );
##  true
##  gap> cm;
##  <A chain map containing 2 morphisms of left modules at degrees [ 0 .. 1 ]>
##  gap> hcm := DefectOfExactness( cm );
##  <A chain map of graded objects containing
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
InstallGlobalFunction( HomalgChainMap,
  function( arg )
    local nargs, morphism, left, source, target, degrees, degree,
          chainmap, type, cm;
    
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
            morphism := HomalgMap( arg[1], CertainObject( source, degrees[1] ), CertainObject( target, degrees[1] + degree ) );
        else
            Error( "the first argument must be a homalg matrix or a morphism\n" );
        fi;
    fi;
    
    if IsHomalgChainMap( morphism ) then
        if Source( morphism ) <> CertainObject( source, degrees[1] ) then
            Error( "the chain map and the source complex do not match\n" );
        elif Range( morphism ) <> CertainObject( target, degrees[1] ) then
            Error( "the chain map and the target complex do not match\n" );
        fi;
    else
        if not IsIdenticalObj( Source( morphism ), CertainObject( source, degrees[1] ) ) then
            Error( "the map and the source complex do not match\n" );
        elif not IsIdenticalObj( Range( morphism ), CertainObject( target, degrees[1] + degree ) ) then
            Error( "the map and the target complex do not match\n" );
        fi;
    fi;
    
    ConvertToRangeRep( degrees );
    
    cm := rec( degrees := degrees );
    
    cm.(String( degrees[1] )) := morphism;
    
    if IsComplexOfFinitelyPresentedObjectsRep( source ) and
       IsComplexOfFinitelyPresentedObjectsRep( target ) then
        chainmap := true;
    elif IsCocomplexOfFinitelyPresentedObjectsRep( source ) and
      IsCocomplexOfFinitelyPresentedObjectsRep( target ) then
        chainmap := false;
    else
        Error( "source and target must either be both complexes or both cocomplexes\n" );
    fi;
    
    if source = target then
        if chainmap then
            if left then
                type := TheTypeHomalgChainSelfMapOfLeftObjects;
            else
                type := TheTypeHomalgChainSelfMapOfRightObjects;
            fi;
        else
            if left then
                type := TheTypeHomalgCochainSelfMapOfLeftObjects;
            else
                type := TheTypeHomalgCochainSelfMapOfRightObjects;
            fi;
        fi;
    else
        if chainmap then
            if left then
                type := TheTypeHomalgChainMapOfLeftObjects;
            else
                type := TheTypeHomalgChainMapOfRightObjects;
            fi;
        else
            if left then
                type := TheTypeHomalgCochainMapOfLeftObjects;
            else
                type := TheTypeHomalgCochainMapOfRightObjects;
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
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( o )
    local degrees, l;
    
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
            if IsChainMapOfFinitelyPresentedObjectsRep( o ) then
                Print( " chain map" );
            else
                Print( " cochain map" );
            fi;
        else
            if IsChainMapOfFinitelyPresentedObjectsRep( o ) then
                Print( " non-chain map" );
            else
                Print( " non-cochain map" );
            fi;
        fi;
    elif HasIsGeneralizedMorphism( o ) then
        if IsGeneralizedMorphism( o ) then
            if IsChainMapOfFinitelyPresentedObjectsRep( o ) then
                Print( " generalized chain map" );
            else
                Print( " generalized cochain map" );
            fi;
        else
            if IsChainMapOfFinitelyPresentedObjectsRep( o ) then
                Print( " non-chain map" );
            else
                Print( " non-cochain map" );
            fi;
        fi;
    else
        if IsChainMapOfFinitelyPresentedObjectsRep( o ) then
            Print( " \"chain map\"" );
        else
            Print( " \"cochain map\"" );
        fi;
    fi;
    
    if HasIsGradedMorphism( o ) and IsGradedMorphism( o ) then
        Print( " of graded objects" );
    fi;
    
    Print( " containing " );
    
    degrees := DegreesOfChainMap( o );
    
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
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        Print( " modules at degrees ", degrees, ">" );
        
    fi;
    
end );

##
InstallMethod( Display,
        "for homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local i;
    
    for i in Reversed( DegreesOfChainMap( o ) ) do
        Print( "-------------------------\n" );
        Print( "at homology degree: ", i, "\n" );
        Display( CertainMorphism( o, i ) );
    od;
    
    Print( "-------------------------\n" );
    
end );

##
InstallMethod( Display,
        "for homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local i;
    
    for i in Reversed( DegreesOfChainMap( o ) ) do
        Print( "---------------------------\n" );
        Print( "at cohomology degree: ", i, "\n" );
        Display( CertainMorphism( o, i ) );
    od;
    
    Print( "-------------------------\n" );
    
end );

