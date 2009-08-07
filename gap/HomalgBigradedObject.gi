#############################################################################
##
##  HomalgBigradedObject.gi     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg bigraded objects.
##
#############################################################################

##  <#GAPDoc Label="BigradedObjects:intro">
##    Bigraded objects in &homalg; provide a data structure for the sheets (or pages) of spectral sequences.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgBigradedObject

##  <#GAPDoc Label="IsBigradedObjectOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="Er" Name="IsBigradedObjectOfFinitelyPresentedObjectsRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of bigraded objects of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgBigradedObject"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsBigradedObjectOfFinitelyPresentedObjectsRep",
        IsHomalgBigradedObject and IsFinitelyPresentedObjectRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgBigradedObjectes",
        NewFamily( "TheFamilyOfHomalgBigradedObjectes" ) );

# four new types:
BindGlobal( "TheTypeZerothHomalgBigradedObjectAssociatedToABicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgBigradedObjectes,
                IsBigradedObjectOfFinitelyPresentedObjectsRep and
                IsHomalgBigradedObjectAssociatedToABicomplex and
                IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeZerothHomalgBigradedObjectAssociatedToABicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgBigradedObjectes,
                IsBigradedObjectOfFinitelyPresentedObjectsRep and
                IsHomalgBigradedObjectAssociatedToABicomplex and
                IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHigherHomalgBigradedObjectAssociatedToABicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgBigradedObjectes,
                IsBigradedObjectOfFinitelyPresentedObjectsRep and
                IsHomalgBigradedObjectAssociatedToABicomplex and
                IsHomalgBigradedObjectAssociatedToAnExactCouple and
                IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHigherHomalgBigradedObjectAssociatedToABicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgBigradedObjectes,
                IsBigradedObjectOfFinitelyPresentedObjectsRep and
                IsHomalgBigradedObjectAssociatedToABicomplex and
                IsHomalgBigradedObjectAssociatedToAnExactCouple and
                IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsStableSheet,
        IsHomalgBigradedObject, 0,
        
  function( Er )
    
    if IsBound( Er!.stability_table ) then
        return Position( Flat( Er!.stability_table ), '*' ) = fail;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsStableSheet,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    if IsBound( Er!.stability_table ) then
        return Position( Flat( Er!.stability_table ), '*' ) = fail;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgResetFilters,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfBigradedObjectes ) then
        HOMALG.PropertiesOfBigradedObjectes :=
          [ IsZero,
            IsStableSheet ];
    fi;
    
    for property in HOMALG.PropertiesOfBigradedObjectes do
        ResetFilterObj( Er, property );
    od;
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    return fail;
    
end );

##
InstallMethod( ObjectDegreesOfBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    return Er!.bidegrees;
    
end );

##
InstallMethod( CertainObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject, IsList ],
        
  function( Er, pq )
    local Epq;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    if not IsBound(Er!.(String( pq ))) then
        return fail;
    fi;
    
    Epq := Er!.(String( pq ));
    
    if IsHomalgMorphism( Epq ) then
        return Source( Epq );
    fi;
    
    return Epq;
    
end );

##
InstallMethod( ObjectsOfBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBigradedObject( Er );
    
    return List( Reversed( bidegrees[2] ), q -> List( bidegrees[1], p -> CertainObject( Er, [ p, q ] ) ) );
    
end );

##
InstallMethod( LowestBidegreeInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBigradedObject( Er );
    
    return [ bidegrees[1][1], bidegrees[2][1] ];
    
end );

##
InstallMethod( HighestBidegreeInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBigradedObject( Er );
    
    return [ bidegrees[1][Length( bidegrees[1] )], bidegrees[2][Length( bidegrees[2] )] ];
    
end );

##
InstallMethod( LowestBidegreeObjectInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local pq;
    
    pq := LowestBidegreeInBigradedObject( Er );
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( HighestBidegreeObjectInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    local pq;
    
    pq := HighestBidegreeInBigradedObject( Er );
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    return HomalgRing( LowestBidegreeObjectInBigradedObject( Er ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject, IsList ],
        
  function( Er, pq )
    local Epq;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    if not IsBound(Er!.(String( pq ))) then
        return fail;
    fi;
    
    Epq := Er!.(String( pq ));
    
    if not IsHomalgMorphism( Epq ) then
        return fail;
    fi;
    
    return Epq;
    
end );

##
InstallMethod( LevelOfBigradedObject,
        "for homalg bigraded objects stemming from an exact couple",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsHomalgBigradedObjectAssociatedToAFilteredComplex ],
        
  function( Er )
    
    return Er!.level;
    
end );

##
InstallMethod( BidegreeOfDifferential,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsEndowedWithDifferential ],
        
  function( Er )
    
    return Er!.BidegreeOfDifferential;
    
end );

##
InstallMethod( UnderlyingBicomplex,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsHomalgBigradedObjectAssociatedToABicomplex and IsBigradedObjectOfFinitelyPresentedObjectsRep ],
        
  function( Er )
    
    if IsBound(Er!.bicomplex) then
        return Er!.bicomplex;
    fi;
    
    Error( "it seems that the bigraded object does not stem from a bicomplex\n" );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    List( Flat( ObjectsOfBigradedObject( Er ) ), BasisOfModule );
    
    return Er;
    
end );

##
InstallMethod( DecideZero,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    List( Flat( ObjectsOfBigradedObject( Er ) ), DecideZero );
    
    return Er;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    List( Flat( ObjectsOfBigradedObject( Er ) ), OnLessGenerators );
    
    return Er;
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:bigradedobject">
##  <ManSection>
##    <Meth Arg="Er" Name="ByASmallerPresentation" Label="for bigraded objects"/>
##    <Returns>a &homalg; bigraded object</Returns>
##    <Description>
##    See <Ref Meth="ByASmallerPresentation" Label="for modules"/> on modules.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    List( Flat( ObjectsOfBigradedObject( Er ) ), ByASmallerPresentation );
    
    return Er;
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>Er</A> and returns it.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgBigradedObject">
##  <ManSection>
##    <Oper Arg="B" Name="HomalgBigradedObject" Label="constructor for bigraded objects given a bicomplex"/>
##    <Returns>a &homalg; bigraded object</Returns>
##    <Description>
##    This constructor creates a homological (resp. cohomological) bigraded object given a homological
##    (resp. cohomological) &homalg; bicomplex <A>B</A>
##    (&see; <Ref Func="HomalgBicomplex" Label="constructor for bicomplexes given a complex of complexes"/>).
##    This is nothing but the level zero sheet (without differential) of the spectral sequence associated to
##    the bicomplex <A>B</A>. So it is the double array of &homalg; objects (i.e. modules or complexes) in <A>B</A>
##    forgetting the morphisms.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> d := Resolution( M );;
##  gap> dd := Hom( d );;
##  gap> C := Resolution( dd );;
##  gap> CC := Hom( C );
##  <A non-zero acyclic complex containing a single morphism of left cocomplexes a\
##  t degrees [ 0 .. 1 ]>
##  gap> B := HomalgBicomplex( CC );
##  <A non-zero bicomplex containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> E0 := HomalgBigradedObject( B );
##  <A bigraded object containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> Display( E0 );
##  Level 0:
##  
##   * *
##   * *
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgBigradedObject,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees, Er, p, q, type;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    Er := rec( bidegrees := bidegrees,
              level := 0,
              bicomplex := B );
    
    for p in bidegrees[1] do
        for q in bidegrees[2] do
            Er.(String( [ p, q ] )) := CertainObject( B, [ p, q ] );
        od;
    od;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( Er.(String( [ p, q ] )) ) then
        type := TheTypeZerothHomalgBigradedObjectAssociatedToABicomplexOfLeftObjects;
    else
        type := TheTypeZerothHomalgBigradedObjectAssociatedToABicomplexOfRightObjects;
    fi;
    
    ## Objectify
    Objectify( type, Er );
    
    return Er;
    
end );

##  <#GAPDoc Label="AsDifferentialObject:bicomplex">
##  <ManSection>
##    <Meth Arg="Er" Name="AsDifferentialObject" Label="for homalg bigraded objects stemming from a bicomplex"/>
##    <Returns>a &homalg; bigraded object</Returns>
##    <Description>
##    Add the induced bidegree <M>( -r, r - 1 )</M> (resp. <M>( r, -r + 1 )</M>) differential to the level <A>r</A>
##    homological (resp. cohomological) bigraded object stemming from a homological (resp. cohomological) bicomplex.
##    This method performs side effects on its argument <A>Er</A> and returns it. <P/>
##    For an example see <Ref Meth="DefectOfExactness" Label="for homalg differential bigraded objects"/> below.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AsDifferentialObject,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsHomalgBigradedObjectAssociatedToABicomplex and IsBigradedObjectOfFinitelyPresentedObjectsRep ],
        
  function( Er )
    local bidegrees, B, r, cpx, bidegree, lp, lq, q_degrees, p_degrees, d, max,
          p, q, i, j, source, target, mor_h, mor_v, emb_source, emb_target,
          bidegrees_target, mor, bidegrees_source, aid, k;
    
    bidegrees := ObjectDegreesOfBigradedObject( Er );
    
    ## the associated bicomplex
    B := UnderlyingBicomplex( Er );
    
    r := LevelOfBigradedObject( Er );
    
    cpx := IsBicomplexOfFinitelyPresentedObjectsRep( B );
    
    if cpx then
        bidegree := [ -r, r - 1 ];
    else
        bidegree := [ r, 1 - r ];
    fi;
    
    Er!.BidegreeOfDifferential := bidegree;
    
    lp := Length( bidegrees[1] );
    lq := Length( bidegrees[2] );
    
    if r = 0 then
        if cpx then
            q_degrees := bidegrees[2]{[ 2 .. lq ]};
            d := r -> [ -r, r - 1 ];
        else
            q_degrees := bidegrees[2]{[ 1 .. lq - 1 ]};
            d := r -> [ r, 1 - r ];
        fi;
        
        for p in bidegrees[1] do
            for q in q_degrees do
                Er!.(String( [ p, q ] )) := CertainVerticalMorphism( B, [ p, q ] );
            od;
        od;
        
        max := Minimum( lp, lq );
        
        p := bidegrees[1];
        q := bidegrees[2];
        
        ## create the stability table for the zeroth sheet
        Er!.stability_table := List( [ 1 .. lq ], a -> ListWithIdenticalEntries( lp, '.' ) );
        for i in [ 1 .. lp ] do
            for j in [ 1 .. lq ] do
                if not IsZero( CertainObject( Er, [ p[i], q[j] ] ) ) then
                    Er!.stability_table[lq-j+1][i] := '*';
                fi;
            od;
        od;
        for i in [ 1 .. lp ] do
            for j in [ 1 .. lq ] do
                if Er!.stability_table[lq-j+1][i] = '*' then
                    if ForAll( [ r .. max ],
                               a -> not ( i + d(a)[1] in [ 1 .. lp ] and j + d(a)[2] in [ 1 .. lq ] and Er!.stability_table[lq-(j + d(a)[2])+1][i + d(a)[1]] <> '.' ) and
                               not ( i - d(a)[1] in [ 1 .. lp ] and j - d(a)[2] in [ 1 .. lq ] and Er!.stability_table[lq-(j - d(a)[2])+1][i - d(a)[1]] <> '.' ) ) then
                        
                        Er!.stability_table[lq-j+1][i] := 's';
                    fi;
                fi;
            od;
        od;
    else
        if cpx then
            p_degrees := bidegrees[1]{[ r + 1 .. lp ]};
            q_degrees := bidegrees[2]{[ 1 .. lq - ( r - 1 ) ]};
            for p in p_degrees do
                for q in q_degrees do
                    source := CertainObject( Er, [ p, q ] );
                    target := CertainObject( Er, [ p, q ] + bidegree );
                    if not ForAny( [ source, target ], IsZero ) then
                        mor_h := List( [ 0 .. r - 1 ], i -> CertainHorizontalMorphism( B, [ p - i, q + i ] ) );
                        mor_v := List( [ 1 .. r - 1 ], i -> CertainVerticalMorphism( B, [ p - i, q + i ] ) );
                        if ForAny( mor_h, IsZero ) or ForAny( mor_v, IsZero ) then
                            mor := TheZeroMap( source, target );
                        else
                            emb_source := Er!.absolute_embeddings.(String( [ p, q ] ));
                            emb_target := Er!.absolute_embeddings.(String( [ p, q ] + bidegree ));
                            if r = 1 then
                                mor := PreCompose( emb_source, mor_h[1] );
                            elif r > 1 then
                                bidegrees_target := List( [ 1 .. r - 1 ], i -> [ p - i, q + i - 1 ] );
                                mor := PreCompose( emb_source, MorphismOfTotalComplex( B, [ [ p, q ] ], bidegrees_target ) );
                                mor_v := MorphismOfTotalComplex( B, [ [ p - r + 1, q + r - 1 ] ], bidegrees_target );
                                if r > 2 then
                                    bidegrees_source := List( [ 1 .. r - 2 ], i -> [ p - i, q + i ] );
                                    aid := MorphismOfTotalComplex( B, bidegrees_source, bidegrees_target );
                                    mor_v := GeneralizedMap( mor_v, aid );
                                fi;
                                mor := - mor / mor_v;
                                mor := PreCompose( mor, mor_h[r] );
                            fi;
                            mor := mor / emb_target;
                        fi;
                        Assert( 1, IsMorphism( mor ) );
                        SetIsMorphism( mor, true );
                        Er!.(String( [ p, q ] )) := mor;
                    fi;
                od;
            od;
        else
            p_degrees := bidegrees[1]{[ 1 .. lp - r ]};
            q_degrees := bidegrees[2]{[ r .. lq ]};
            for p in p_degrees do
                for q in q_degrees do
                    source := CertainObject( Er, [ p, q ] );
                    target := CertainObject( Er, [ p, q ] + bidegree );
                    if not ForAny( [ source, target ], IsZero ) then
                        mor_h := List( [ 0 .. r - 1 ], i -> CertainHorizontalMorphism( B, [ p + i, q - i ] ) );
                        mor_v := List( [ 1 .. r - 1 ], i -> CertainVerticalMorphism( B, [ p + i, q - i ] ) );
                        if ForAny( mor_h, IsZero ) or ForAny( mor_v, IsZero ) then
                            mor := TheZeroMap( source, target );
                        else
                            emb_source := Er!.absolute_embeddings.(String( [ p, q ] ));
                            emb_target := Er!.absolute_embeddings.(String( [ p, q ] + bidegree ));
                            if r = 1 then
                                mor := PreCompose( emb_source, mor_h[1] );
                            elif r > 1 then
                                bidegrees_target := List( [ 1 .. r - 1 ], i -> [ p + i, q - i + 1 ] );
                                mor := PreCompose( emb_source, MorphismOfTotalComplex( B, [ [ p, q ] ], bidegrees_target ) );
                                mor_v := MorphismOfTotalComplex( B, [ [ p + r - 1, q - r + 1 ] ], bidegrees_target );
                                if r > 2 then
                                    bidegrees_source := List( [ 1 .. r - 2 ], i -> [ p + i, q - i ] );
                                    aid := MorphismOfTotalComplex( B, bidegrees_source, bidegrees_target );
                                    mor_v := GeneralizedMap( mor_v, aid );
                                fi;
                                mor := - mor / mor_v;
                                mor := PreCompose( mor, mor_h[r] );
                            fi;
                            mor := mor / emb_target;
                        fi;
                        Assert( 1, IsMorphism( mor ) );
                        SetIsMorphism( mor, true );
                        Er!.(String( [ p, q ] )) := mor;
                    fi;
                od;
            od;
        fi;
    fi;
    
    SetIsEndowedWithDifferential( Er, true );
    
    return Er;
    
end );

##  <#GAPDoc Label="DefectOfExactness:bigradedobject">
##  <ManSection>
##    <Meth Arg="Er" Name="DefectOfExactness" Label="for homalg differential bigraded objects"/>
##    <Returns>a &homalg; bigraded object</Returns>
##    <Description>
##    Homological:
##    Compute the homology of a level <A>r</A> <E>differential</E> homological bigraded object, that is the <A>r</A>-th
##    sheet of a homological spectral sequence endowed with a bidegree <M>( -r, r - 1 )</M> differential.
##    The result is a level <A>r</A><M>+1</M> homological bigraded object <E>without</E> its differential.
##    <P/>
##    Cohomological:
##    Compute the cohomology of a level <A>r</A> <E>differential</E> cohomological bigraded object, that is the <A>r</A>-th
##    sheet of a cohomological spectral sequence endowed with a bidegree <M>( r, -r + 1 )</M> differential.
##    The result is a level <A>r</A><M>+1</M> cohomological bigraded object <E>without</E> its differential.
##    <P/>
##    The differential of the resulting level <A>r</A><M>+1</M> object can a posteriori be computed using
##    <Ref Meth="AsDifferentialObject" Label="for homalg bigraded objects stemming from a bicomplex"/>.
##    The objects in the result are subquotients of the objects in <A>Er</A>. An object in <A>Er</A> (at
##    a spot <M>(p,q)</M>) is called <E>stable</E> if no passage to a true subquotient occurs at any higher level.
##    Of course, a zero object (at a spot <M>(p,q)</M>) is always stable.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> d := Resolution( M );;
##  gap> dd := Hom( d );;
##  gap> C := Resolution( dd );;
##  gap> CC := Hom( C );
##  <A non-zero acyclic complex containing a single morphism of left cocomplexes a\
##  t degrees [ 0 .. 1 ]>
##  gap> B := HomalgBicomplex( CC );
##  <A non-zero bicomplex containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  ]]></Example>
##    Now we construct the spectral sequence associated to the bicomplex <M>B</M>, also called the <E>first</E>
##    spectral sequence:
##      <Example><![CDATA[
##  gap> I_E0 := HomalgBigradedObject( B );
##  <A bigraded object containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> Display( I_E0 );
##  Level 0:
##  
##   * *
##   * *
##  gap> AsDifferentialObject( I_E0 );
##  <A bigraded object with a differential of bidegree
##  [ 0, -1 ] containing left modules at bidegrees [ 0 .. 1 ]x[ -1 .. 0 ]>
##  gap> I_E0;
##  <A bigraded object with a differential of bidegree
##  [ 0, -1 ] containing left modules at bidegrees [ 0 .. 1 ]x[ -1 .. 0 ]>
##  gap> AsDifferentialObject( I_E0 );
##  <A bigraded object with a differential of bidegree
##  [ 0, -1 ] containing left modules at bidegrees [ 0 .. 1 ]x[ -1 .. 0 ]>
##  gap> I_E1 := DefectOfExactness( I_E0 );
##  <A bigraded object containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> Display( I_E1 );
##  Level 1:
##  
##   * *
##   . .
##  gap> AsDifferentialObject( I_E1 );
##  <A bigraded object with a differential of bidegree
##  [ -1, 0 ] containing left modules at bidegrees [ 0 .. 1 ]x[ -1 .. 0 ]>
##  gap> I_E2 := DefectOfExactness( I_E1 );
##  <A bigraded object containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> Display( I_E2 );
##  Level 2:
##  
##   s .
##   . .
##  ]]></Example>
##    Legend:
##    <List>
##      <Item>A star <A>*</A> stands for a nonzero module.</Item>
##      <Item>A dot <A>.</A> stands for a zero module.</Item>
##      <Item>The letter <A>s</A> stands for a nonzero module that became stable.</Item>
##    </List>
##    <P/>
##    The <E>second</E> spectral sequence of the bicomplex is, by definition, the spectral sequence associated to
##    the transposed bicomplex:
##      <Example><![CDATA[
##  gap> tB := TransposedBicomplex( B );
##  <A non-zero bicomplex containing left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> II_E0 := HomalgBigradedObject( tB );
##  <A bigraded object containing left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E0 );
##  Level 0:
##  
##   * *
##   * *
##  gap> AsDifferentialObject( II_E0 );
##  <A bigraded object with a differential of bidegree
##  [ 0, -1 ] containing left modules at bidegrees [ -1 .. 0 ]x[ 0 .. 1 ]>
##  gap> II_E1 := DefectOfExactness( II_E0 );
##  <A bigraded object containing left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E1 );
##  Level 1:
##  
##   * *
##   . s
##  gap> AsDifferentialObject( II_E1 );
##  <A bigraded object with a differential of bidegree
##  [ -1, 0 ] containing left modules at bidegrees [ -1 .. 0 ]x[ 0 .. 1 ]>
##  gap> II_E2 := DefectOfExactness( II_E1 );
##  <A bigraded object containing left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E2 );
##  Level 2:
##  
##   s .
##   . s
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DefectOfExactness,
        "for homalg differential bigraded objects stemming from a bicomplex",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsEndowedWithDifferential ],
        
  function( Er )
    local left, bidegree, r, degree, cpx, bidegrees, B, C, compute_nat_trafos,
          natural_transformations, outer_functor_on_natural_epis, p, q, lp, lq,
          H, i, j, Epq, post, pre, def, nat, emb, emb_new, relative_embeddings,
          absolute_embeddings, type, d, max;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( Er );
    
    bidegree := BidegreeOfDifferential( Er );
    
    r := LevelOfBigradedObject( Er );
    
    degree := Sum( bidegree );
    
    bidegrees := ObjectDegreesOfBigradedObject( Er );
    
    ## the associated bicomplex
    B := UnderlyingBicomplex( Er );
    
    cpx := IsBicomplexOfFinitelyPresentedObjectsRep( B );
    
    p := bidegrees[1];
    q := bidegrees[2];
    
    lp := Length( p );
    lq := Length( q );
    
    H := rec( bidegrees := bidegrees,
              level := r + 1,
              bicomplex := B,
              embeddings := rec( ),
              stability_table := List( [ 1 .. lq ], a -> ListWithIdenticalEntries( lp, '.' ) ) );
    
    if r = 0 and not IsTransposedWRTTheAssociatedComplex( B )
       and IsBound( B!.OuterFunctorOnNaturalEpis ) then
        compute_nat_trafos := true;
        natural_transformations := rec( );
        H.NaturalTransformations := natural_transformations;
        outer_functor_on_natural_epis := B!.OuterFunctorOnNaturalEpis;
    else
        compute_nat_trafos := false;
    fi;
    
    for i in [ 1 .. lp ] do
        for j in [ 1 .. lq ] do
            Epq := CertainObject( Er, [ p[i], q[j] ] );
            post := CertainMorphism( Er, [ p[i], q[j] ] );
            pre := CertainMorphism( Er, [ p[i], q[j] ] - bidegree );
            if IsHomalgMorphism( post ) and not IsZero( Epq ) then
                if IsHomalgMorphism( pre ) then
                    if left then
                        def := DefectOfExactness( pre, post );
                    else
                        def := DefectOfExactness( post, pre );
                    fi;
                    emb := NaturalGeneralizedEmbedding( def );
                else
                    def := Kernel( post );
                    emb := KernelEmb( post );
                    ## construct the natural monomorphism/equivalence
                    ## F(G(P_p)) -> R^0(F)(G(P_p))
                    if compute_nat_trafos and q[j] = 0 then
                        nat := outer_functor_on_natural_epis.(String( [ p[i], 0 ] )) / emb;
                        Assert( 1, IsMonomorphism( nat ) );
                        SetIsMonomorphism( nat, true );
                        natural_transformations.(String( [ p[i], 0 ] )) := nat;
                    fi;
                fi;
                if IsZero( def ) then
                    H.stability_table[lq-j+1][i] := '.';
                    SetIsZero( emb, true );
                else
                    H.stability_table[lq-j+1][i] := '*';
                fi;
                H.embeddings.(String( [ p[i], q[j] ] )) := emb;
            elif IsHomalgMorphism( pre ) and not ( HasIsZero( Epq ) and IsZero( Epq ) ) then
                def := Cokernel( pre );
                emb := CokernelNaturalGeneralizedIsomorphism( pre );
                    ## construct the natural epimorphism/equivalence
                    ## L_0(F)(G(P_p)) -> F(G(P_p))
                    if compute_nat_trafos and q[j] = 0 then
                        nat := PreCompose( RemoveMorphismAidMap( emb ), outer_functor_on_natural_epis.(String( [ p[i], 0 ] )) );
                        Assert( 1, IsEpimorphism( nat ) );
                        SetIsEpimorphism( nat, true );
                        natural_transformations.(String( [ p[i], 0 ] )) := nat;
                    fi;
                if IsZero( def ) then
                    H.stability_table[lq-j+1][i] := '.';
                    SetIsZero( emb, true );
                else
                    H.stability_table[lq-j+1][i] := '*';
                fi;
                H.embeddings.(String( [ p[i], q[j] ] )) := emb;
            else
                def := CertainObject( Er, [ p[i], q[j] ] );
                emb := TheIdentityMorphism( def );
                if IsZero( def ) then
                    H.stability_table[lq-j+1][i] := '.';
                    SetIsZero( emb, true );
                else
                    H.stability_table[lq-j+1][i] := '*';
                fi;
                H.embeddings.(String( [ p[i], q[j] ] )) := emb;
            fi;
            H.(String( [ p[i], q[j] ] )) := def;
        od;
    od;
    
    if IsHomalgBigradedObjectAssociatedToAFilteredComplex( Er ) then
        
        ## construct the generalized embeddings into the objects of the special sheet Ea
        ## and store them under the component "relative_embeddings"
        if IsBound( Er!.SpecialSheet ) and Er!.SpecialSheet = true  then
            H.relative_embeddings := H.embeddings;
            H.relative_embeddings.target_level := r;
        elif IsBound( Er!.relative_embeddings ) then
            ## build an absolute embedding table using the previous one
            relative_embeddings := rec( target_level := Er!.relative_embeddings.target_level );
            
            for i in [ 1 .. lp ] do
                for j in [ 1 .. lq ] do
                    emb := Er!.relative_embeddings.(String( [ p[i], q[j] ] ));
                    if Er!.stability_table[lq-j+1][i] = '*' then;	## not yet stable
                        emb_new := H.embeddings.(String( [ p[i], q[j] ] ));
                        emb := PreCompose( emb_new, emb );
                    fi;
                    
                    ## check assertion
                    Assert( 4, IsGeneralizedMonomorphism( emb ) );
                    
                    SetIsGeneralizedMonomorphism( emb, true );
                    
                    relative_embeddings.(String( [ p[i], q[j] ] )) := emb;
                od;
            od;
            
            H.relative_embeddings := relative_embeddings;
        fi;
        
        ## construct the generalized embeddings into the objects of the 0-th sheet E0
        ## and store them under the component "absolute_embeddings"
        if r = 0 then
            H.absolute_embeddings := H.embeddings;
        elif IsBound( Er!.absolute_embeddings ) then
            ## build an absolute embedding table using the previous one
            absolute_embeddings := rec( );
            
            for i in [ 1 .. lp ] do
                for j in [ 1 .. lq ] do
                    emb := Er!.absolute_embeddings.(String( [ p[i], q[j] ] ));
                    if Er!.stability_table[lq-j+1][i] = '*' then;	## not yet stable
                        emb_new := H.embeddings.(String( [ p[i], q[j] ] ));
                        emb := PreCompose( emb_new, emb );
                    fi;
                    
                    ## check assertion
                    Assert( 4, IsGeneralizedMonomorphism( emb ) );
                    
                    SetIsGeneralizedMonomorphism( emb, true );
                    
                    absolute_embeddings.(String( [ p[i], q[j] ] )) := emb;
                od;
            od;
            
            H.absolute_embeddings := absolute_embeddings;
        fi;
        
        ## find stable spots:
        if cpx then
            d := r -> [ -r, r - 1 ];
        else
            d := r -> [ r, 1 - r ];
        fi;
        
        max := Minimum( lp, lq );
        
        for i in [ 1 .. lp ] do
            for j in [ 1 .. lq ] do
                if H.stability_table[lq-j+1][i] = '*' then
                    if ForAll( [ r + 1 .. max ],
                               a -> not ( i + d(a)[1] in [ 1 .. lp ] and j + d(a)[2] in [ 1 .. lq ] and H.stability_table[lq-(j + d(a)[2])+1][i + d(a)[1]] <> '.' ) and
                               not ( i - d(a)[1] in [ 1 .. lp ] and j - d(a)[2] in [ 1 .. lq ] and H.stability_table[lq-(j - d(a)[2])+1][i - d(a)[1]] <> '.' ) ) then
                        
                        H.stability_table[lq-j+1][i] := 's';
                    fi;
                fi;
            od;
        od;
    fi;
    
    if left then
        type := TheTypeHigherHomalgBigradedObjectAssociatedToABicomplexOfLeftObjects;
    else
        type := TheTypeHigherHomalgBigradedObjectAssociatedToABicomplexOfRightObjects;
    fi;
    
    ## Objectify
    Objectify( type, H );
    
    return H;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( o )
    local degrees, l, opq;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg bigraded object
        Print( " non-zero" );
    fi;
    
    Print( " bigraded object" );
    
    if HasIsEndowedWithDifferential( o ) and IsEndowedWithDifferential( o ) then
        Print( " with a differential of bidegree ", BidegreeOfDifferential( o ) );
    fi;
    
    Print( " containing " );
    
    degrees := ObjectDegreesOfBigradedObject( o );
    
    l := Length( degrees[1] ) * Length( degrees[2] );
    
    opq := CertainObject( o, [ degrees[1][1], degrees[2][1] ] );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgModule( opq ) then
            Print( " module" );
        else
            if IsComplexOfFinitelyPresentedObjectsRep( opq ) then
                Print( " complex" );
            else
                Print( " cocomplex" );
            fi;
        fi;
        
        Print( " at bidegree ", [ degrees[1][1], degrees[2][1] ], ">" );
        
    else
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgModule( opq ) then
            Print( " modules" );
        else
            if IsComplexOfFinitelyPresentedObjectsRep( opq ) then
                Print( " complexes" );
            else
                Print( " cocomplexes" );
            fi;
        fi;
        
        Print( " at bidegrees ", degrees[1], "x", degrees[2], ">" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg bigraded objects",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " bigraded object>" );
    
end );

##
InstallMethod( Display,
        "for homalg bigraded objects",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep ],
        
  function( o )
    local s, c, bidegrees, q, p, Epq;
    
    if IsBound(o!.level) then
        Print( "Level ", o!.level,":\n\n" );
    fi;
    
    if IsBound( o!.stability_table ) then
        for s in o!.stability_table do
            for c in s do
                Print( " ", [ c ] );
            od;
            Print( "\n" );
        od;
    else
        bidegrees := ObjectDegreesOfBigradedObject( o );
        for q in Reversed( bidegrees[2] ) do
            for p in bidegrees[1] do
                Epq := CertainObject( o, [ p, q ] );
                if HasIsZero( Epq ) and IsZero( Epq ) then
                    Print( " ." );
                else
                    Print( " *" );
                fi;
            od;
            Print( "\n" );
        od;
    fi;
    
end );

