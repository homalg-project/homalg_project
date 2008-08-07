#############################################################################
##
##  HomalgBigradedObject.gi     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg bigraded objects.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representations for the GAP-category IsHomalgBigradedObject
# which are subrepresentations of the representation IsFinitelyPresentedObjectRep:
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
# methods for operations:
#
####################################

##
InstallMethod( homalgResetFilters,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfBigradedObjectes ) then
        HOMALG.PropertiesOfBigradedObjectes :=
          [ IsZero ];
    fi;
    
    for property in HOMALG.PropertiesOfBigradedObjectes do
        ResetFilterObj( E, property );
    od;
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
    return fail;
    
end );

##
InstallMethod( ObjectDegreesOfBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
    return E!.bidegrees;
    
end );

##
InstallMethod( LowestBidegreeInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBigradedObject( E );
    
    return [ bidegrees[1][1], bidegrees[2][1] ];
    
end );

##
InstallMethod( HighestBidegreeInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBigradedObject( E );
    
    return [ bidegrees[1][Length( bidegrees[1] )], bidegrees[2][Length( bidegrees[2] )] ];
    
end );

##
InstallMethod( CertainObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject, IsList ],
        
  function( E, pq )
    local Epq;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    if not IsBound(E!.(String( pq ))) then
        return fail;
    fi;
    
    Epq := E!.(String( pq ));
    
    if IsHomalgMorphism( Epq ) then
        return Source( Epq );
    fi;
    
    return Epq;
    
end );

##
InstallMethod( ObjectsOfBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBigradedObject( E );
    
    return List( Reversed( bidegrees[2] ), q -> List( bidegrees[1], p -> CertainObject( E, [ p, q ] ) ) );
    
end );

##
InstallMethod( LowestBidegreeObjectInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    local pq;
    
    pq := LowestBidegreeInBigradedObject( E );
    
    return CertainObject( E, pq );
    
end );

##
InstallMethod( HighestBidegreeObjectInBigradedObject,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    local pq;
    
    pq := HighestBidegreeInBigradedObject( E );
    
    return CertainObject( E, pq );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
    return HomalgRing( LowestBidegreeObjectInBigradedObject( E ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject, IsList ],
        
  function( E, pq )
    local Epq;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    if not IsBound(E!.(String( pq ))) then
        return fail;
    fi;
    
    Epq := E!.(String( pq ));
    
    if not IsHomalgMorphism( Epq ) then
        return fail;
    fi;
    
    return Epq;
    
end );

##
InstallMethod( LevelOfBigradedObject,
        "for homalg bigraded objects stemming from an exact couple",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsHomalgBigradedObjectAssociatedToAFilteredComplex ],
        
  function( E )
    
    return E!.level;
    
end );

##
InstallMethod( BidegreeOfDifferential,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsEndowedWithDifferential ],
        
  function( E )
    
    return E!.BidegreeOfDifferential;
    
end );

##
InstallMethod( UnderlyingBicomplex,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsHomalgBigradedObjectAssociatedToABicomplex and IsBigradedObjectOfFinitelyPresentedObjectsRep ],
        
  function( E )
    
    if IsBound(E!.bicomplex) then
        return E!.bicomplex;
    fi;
    
    Error( "it seems that the bigraded object does not stem from a bicomplex\n" );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
    
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
        
end );

##
InstallMethod( DecideZero,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
    
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( E )
    
    
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( HomalgBigradedObject,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees, E, p, q, left, type;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    E := rec( bidegrees := bidegrees,
              level := 0,
              bicomplex := B );
    
    for p in bidegrees[1] do
        for q in bidegrees[2] do
            E.(String( [ p, q ] )) := CertainObject( B, [ p, q ] );
        od;
    od;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( E.(String( [ p, q ] )) );
    
    if left then
        type := TheTypeZerothHomalgBigradedObjectAssociatedToABicomplexOfLeftObjects;
    else
        type := TheTypeZerothHomalgBigradedObjectAssociatedToABicomplexOfRightObjects;
    fi;
    
    ## Objectify
    Objectify( type, E );
    
    return E;
    
end );

##
InstallMethod( AsDifferentialObject,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsHomalgBigradedObjectAssociatedToABicomplex and IsBigradedObjectOfFinitelyPresentedObjectsRep ],
        
  function( E )
    local bidegrees, B, r, cpx, bidegree, lp, lq, q_degrees, p_degrees, p, q,
          source, target, emb_source, emb_target, mor_h, mor_v, mor, l;
    
    bidegrees := ObjectDegreesOfBigradedObject( E );
    
    B := UnderlyingBicomplex( E );
    
    r := LevelOfBigradedObject( E );
    
    cpx := IsBicomplexOfFinitelyPresentedObjectsRep( B );
    
    if cpx then
        bidegree := [ -r, r - 1 ];
    else
        bidegree := [ r, 1 - r ];
    fi;
    
    E!.BidegreeOfDifferential := bidegree;
    
    if r = 0 then
        lq := Length( bidegrees[2] );
        if cpx then
            q_degrees := bidegrees[2]{[ 2 .. lq ]};
        else
            q_degrees := bidegrees[2]{[ 1 .. lq - 1 ]};
        fi;
        for p in bidegrees[1] do
            for q in q_degrees do
                E!.(String( [ p, q ] )) := CertainVerticalMorphism( B, [ p, q ] );
            od;
        od;
    else
        lp := Length( bidegrees[1] );
        lq := Length( bidegrees[2] );
        if cpx then
            p_degrees := bidegrees[1]{[ r + 1 .. lp ]};
            q_degrees := bidegrees[2]{[ 1 .. lq - ( r - 1 ) ]};
            for p in p_degrees do
                for q in q_degrees do
                    source := CertainObject( E, [ p, q ] );
                    target := CertainObject( E, [ p, q ] + bidegree );
                    if ForAny( [ source, target ], IsZero ) then
                        mor := TheZeroMap( source, target );
                    else
                        emb_source := E!.absolute_embeddings.(String( [ p, q ] ));
                        emb_target := E!.absolute_embeddings.(String( [ p, q ] + bidegree ));
                        mor_h := List( [ 0 .. r - 1 ], i -> CertainHorizontalMorphism( B, [ p - i, q + i ] ) );
                        mor_v := List( [ 1 .. r - 1 ], i -> CertainVerticalMorphism( B, [ p - i, q + i ] ) );
                        if ForAny( mor_h, IsZero ) or ForAny( mor_v, IsZero ) then
                            mor := TheZeroMap( source, target );
                        else
                            mor := PreCompose( emb_source, mor_h[1] );
                            for l in [ 1 .. r - 1 ] do
                                mor := mor / mor_v[l];
                                mor := PreCompose( mor, mor_h[l + 1] );
                            od;
                            mor := mor / emb_target;
                        fi;
                    fi;
                    E!.(String( [ p, q ] )) := mor;
                od;
            od;
        else
            p_degrees := bidegrees[1]{[ 1 .. lp - r ]};
            q_degrees := bidegrees[2]{[ r .. lq ]};
            for p in p_degrees do
                for q in q_degrees do
                    source := CertainObject( E, [ p, q ] );
                    target := CertainObject( E, [ p, q ] + bidegree );
                    emb_source := E!.absolute_embeddings.(String( [ p, q ] ));
                    emb_target := E!.absolute_embeddings.(String( [ p, q ] + bidegree ));
                    mor_h := List( [ 0 .. r - 1 ], i -> CertainHorizontalMorphism( B, [ p + i, q - i ] ) );
                    mor_v := List( [ 1 .. r - 1 ], i -> CertainVerticalMorphism( B, [ p + i, q - i ] ) );
                    if ForAny( [ source, target ], IsZero ) or
                       ForAny( mor_h, IsZero ) or
                       ForAny( mor_v, IsZero ) then
                        mor := TheZeroMap( source, target );
                    else
                        mor := PreCompose( emb_source, mor_h[1] );
                        for l in [ 1 .. r - 1 ] do
                            mor := mor / mor_v[l];
                            mor := PreCompose( mor, mor_h[l + 1] );
                        od;
                        mor := mor / emb_target;
                    fi;
                    E!.(String( [ p, q ] )) := mor;
                od;
            od;
        fi;
    fi;
    
    SetIsEndowedWithDifferential( E, true );
    
    return E;
    
end );

##
InstallMethod( DefectOfExactness,
        "for homalg bigraded objects stemming from a bicomplex",
        [ IsBigradedObjectOfFinitelyPresentedObjectsRep and IsEndowedWithDifferential ],
        
  function( E )
    local left, bidegree, r, degree, cpx, bidegrees, B, p, q, pp, qq, H, i, j,
          Epq, post, pre, def, emb, emb_old, absolute_embeddings, type;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( E );
    
    bidegree := BidegreeOfDifferential( E );
    
    r := LevelOfBigradedObject( E );
    
    degree := Sum( bidegree );
    
    ## FIXME:
    if degree = -1 then
        cpx := true;
    elif degree = 1 then
        cpx := false;
    else
        cpx := fail;
    fi;
    
    bidegrees := ObjectDegreesOfBigradedObject( E );
    
    B := UnderlyingBicomplex( E );
    
    p := bidegrees[1];
    q := bidegrees[2];
    
    pp := Length( p );
    qq := Length( q );
    
    H := rec( bidegrees := bidegrees,
              level := r + 1,
              bicomplex := B,
              embeddings := rec( ),
              stable := List( [ 1 .. qq ], a -> ListWithIdenticalEntries( pp, '.' ) ) );
    
    for i in [ 1 .. pp ] do
        for j in [ 1 .. qq ] do
            Epq := CertainObject( E, [ p[i], q[j] ] );
            post := CertainMorphism( E, [ p[i], q[j] ] );
            pre := CertainMorphism( E, [ p[i], q[j] ] - bidegree );
            if IsHomalgMorphism( post ) and not IsZero( Epq ) then
                if IsHomalgMorphism( pre ) then
                    if left then
                        def := DefectOfExactness( pre, post );
                    else
                        def := DefectOfExactness( post, pre );
                    fi;
                    emb := NaturalEmbedding( def );
                else
                    def := Kernel( post );
                    emb := KernelEmb( post );
                fi;
                H.embeddings.(String( [ p[i], q[j] ] )) := emb;
                if IsZero( def ) then
                    H.stable[qq-j+1][i] := '.';
                else
                    H.stable[qq-j+1][i] := '*';
                fi;
            elif IsHomalgMorphism( pre ) and not ( HasIsZero( Epq ) and IsZero( Epq ) ) then
                def := Cokernel( pre );
                emb := CokernelGeneralizedEmb( pre );
                H.embeddings.(String( [ p[i], q[j] ] )) := emb;
                if IsZero( def ) then
                    H.stable[qq-j+1][i] := '.';
                else
                    H.stable[qq-j+1][i] := '*';
                fi;
            else
                def := CertainObject( E, [ p[i], q[j] ] );
                emb := TheIdentityMorphism( def );
                H.embeddings.(String( [ p[i], q[j] ] )) := emb;
                if IsZero( def ) then
                    H.stable[qq-j+1][i] := '.';
                else
                    ## although nonzero Epq became stable
                    H.stable[qq-j+1][i] := 's';
                fi;
            fi;
            H.(String( [ p[i], q[j] ] )) := def;
        od;
    od;
    
    if IsHomalgBigradedObjectAssociatedToAFilteredComplex( E ) then
        
        absolute_embeddings := rec( );
        
        ## the embeddings until the 0-th sheet
        if r = 0 then
            absolute_embeddings := H.embeddings;
        else
            ## build an absolute embedding table using the previous one
            for i in [ 1 .. pp ] do
                for j in [ 1 .. qq ] do
                    emb_old := E!.absolute_embeddings.(String( [ p[i], q[j] ] ));
                    if H.stable[qq-j+1][i] = '*' then;	## not yet stable
                        emb := H.embeddings.(String( [ p[i], q[j] ] ));
                        absolute_embeddings.(String( [ p[i], q[j] ] )) := PreCompose( emb, emb_old );
                    else				## already stable
                        absolute_embeddings.(String( [ p[i], q[j] ] )) := emb_old;
                    fi;
                od;
            od;
        fi;
        
        H.absolute_embeddings := absolute_embeddings;
        
        ## find more stable spots:
        cpx := IsBicomplexOfFinitelyPresentedObjectsRep( B );
        
        if cpx then
            bidegree := [ -(r + 1), (r + 1) - 1 ];
        else
            bidegree := [ (r + 1), 1 - (r + 1) ];
        fi;
    
        for i in [ 1 .. pp ] do
            for j in [ 1 .. qq ] do
                if not ( i + bidegree[1] in [ 1 .. pp ] and j + bidegree[2] in [ 1 .. qq ] and H.stable[qq-(j + bidegree[2])+1][i + bidegree[1]] <> '.' ) and
                   not ( i - bidegree[1] in [ 1 .. pp ] and j - bidegree[2] in [ 1 .. qq ] and H.stable[qq-(j - bidegree[2])+1][i - bidegree[1]] <> '.' ) and
                   H.stable[qq-j+1][i] = '*' then
                    H.stable[qq-j+1][i] := 's';
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
InstallMethod( ViewObj,
        "for homalg bigraded objects",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " bicocomplex>" );
    
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
    
    if IsBound( o!.stable ) then
        for s in o!.stable do
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

