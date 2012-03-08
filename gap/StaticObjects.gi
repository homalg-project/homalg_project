#############################################################################
##
##  Objects.gi                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations of homalg procedures for homalg static objects.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

## fallback method
InstallMethod( ResolutionWithRespectToMorphism,
          "for a homalg object",
        [ IsInt, IsHomalgStaticObject, IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( q, M, psi )
    
    return Resolution( q, M );
    
end );


##
InstallMethod( \/,
        "for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( K, J )
    local M, mapK, mapJ, phi, im, iso, def, emb;
    
    M := SuperObject( J );
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    mapK := MorphismHavingSubobjectAsItsImage( K );
    mapJ := MorphismHavingSubobjectAsItsImage( J );
    
    phi := PreCompose( mapK, CokernelEpi( mapJ ) );
    
    im := ImageObject( phi );
    
    ## recall that im was created as a subobject of
    ## Cokernel( mapJ ) which in turn is a factor object of M,
    ## but since we need to view im as a subfactor of M
    ## we will construct an isomorphism iso onto im
    iso := AnIsomorphism( im );
    
    ## and call its source def (for defect)
    def := Source( iso );
    
    ## then: the following compositions give the
    ## desired generalized embedding of def into M
    emb := PreCompose( iso, NaturalGeneralizedEmbedding( im ) );
    
    emb := PreCompose( emb, CokernelNaturalGeneralizedIsomorphism( mapJ ) );
    
    ## check assertion
    Assert( 3, IsGeneralizedMonomorphism( emb ) );
    
    SetIsGeneralizedMonomorphism( emb, true );
    
    def!.NaturalGeneralizedEmbedding := emb;
    
    return def;
    
end );

##
InstallMethod( \/,
        "for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedObjectRep, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M, N )	## M must be either the super object of N or 1 * R or R * 1
    local R;
    
    CheckIfTheyLieInTheSameCategory( M, N );
    
    R := StructureObject( M );
    
    if not ( IsIdenticalObj( M, SuperObject( N ) ) or IsIdenticalObj( M, 1 * R ) or IsIdenticalObj( M, R * 1 ) ) then
        TryNextMethod( );
    fi;
    
    return FactorObject( N );
    
end );

##
InstallMethod( \/,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep, IsStaticFinitelyPresentedObjectRep and HasUnderlyingSubobject ],
        
  function( M, N )	## M must be either the super object of N or 1 * R or R * 1
    
    return M / UnderlyingSubobject( N );
    
end );

##
InstallMethod( HasCurrentResolution,
        "for a homalg static object",
        [ IsHomalgStaticObject ],
        
  function( M )
    local pos;
    
    pos := PositionOfTheDefaultPresentation( M );
    
    return IsBound( M!.Resolutions.(pos) );
    
end );

##
InstallMethod( CurrentResolution,
        "for a homalg static object",
        [ IsHomalgStaticObject ],
        
  function( M )
    local pos;
    
    pos := PositionOfTheDefaultPresentation( M );
    
    return M!.Resolutions.(pos);
    
end );

##
InstallMethod( Resolution,
        "for homalg subobjects of static objects",
        [ IsInt, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( q, N )
    
    return Resolution( q, UnderlyingObject( N ) );
    
end );

##
InstallMethod( Resolution,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectOrSubobjectRep ],
        
  function( M )
    
    return Resolution( -1, M );
    
end );

##
InstallMethod( FiniteFreeResolution,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    if HasAFiniteFreeResolution( M ) then
        return AFiniteFreeResolution( M );
    elif not HasFiniteFreeResolutionExists( M ) or FiniteFreeResolutionExists( M ) then	## in words: either a finite free resolution exists or its existence is not known yet
        Resolution( M );
    fi;
    
    ## now check again:
    if HasAFiniteFreeResolution( M ) then
        return AFiniteFreeResolution( M );
    fi;
    
    return fail;
    
end );

##
InstallMethod( LengthOfResolution,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectOrSubobjectRep ],
        
  function( M )
    local d;
    
    d := Resolution( M );
    
    if IsBound(d!.LengthOfResolution) then
        return d!.LengthOfResolution;
    else
        return fail;
    fi;
    
end );

##
InstallMethod( FirstMorphismOfResolution,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectOrSubobjectRep ],
        
  function( M )
    local d;
    
    d := Resolution( 1, M );
    
    return CertainMorphism( d, 1 );
    
end );

##
InstallMethod( SyzygiesObjectEmb,
        "for homalg static objects",
        [ IsInt, IsStaticFinitelyPresentedObjectRep ],
        
  function( q, M )
    local d;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        ## this is not really an embedding, but spares us case distinctions at several places (e.g. Left/RightSatelliteOfFunctor)
        return TheMorphismToZero( M );
    elif q = 1 then
        return KernelEmb( CoveringEpi( M ) );
    fi;
    
    d := Resolution( q - 1, M );
    
    return KernelEmb( CertainMorphism( d, q - 1 ) );
    
end );

##
InstallMethod( SyzygiesObjectEmb,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return SyzygiesObjectEmb( 1, M );
    
end );

##
InstallMethod( SyzygiesObject,
        "for homalg static objects",
        [ IsInt, IsStaticFinitelyPresentedObjectRep ],
        
  function( q, M )
    local d;
    
    if q < 0 then
        return 0 * M;
    elif q = 0 then
        return M;
    fi;
    
    return Source( SyzygiesObjectEmb( q, M ) );
    
end );

##
InstallMethod( SyzygiesObject,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return SyzygiesObject( 1, M );
    
end );

##
InstallMethod( CoveringEpi,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return SyzygiesObjectEpi( 0, M );
    
end );

InstallMethod( CoveringEpi,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    
    return CoveringEpi( UnderlyingObject( M ) );
    
end );

##
InstallMethod( CoveringObject,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return Source( CoveringEpi( M ) );
    
end );

##
InstallMethod( SubResolution,
        "for homalg static objects",
        [ IsInt, IsStaticFinitelyPresentedObjectRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( q, M )
    local d, dq1, res;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        dq1 := FirstMorphismOfResolution( M );
        res := AsATwoSequence( dq1, TheMorphismToZero( CoveringObject( M ) ) );
        if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
            SetIsRightAcyclic( res, true );
        else
            SetIsAcyclic( res, true );
        fi;
        return res;
    fi;
    
    d := Resolution( q + 1, M );
    
    dq1 := CertainMorphism( d, q + 1 );
    
    res := AsATwoSequence( dq1, CertainMorphism( d, q ) );
    
    res := Shift( res, -q );
    
    if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
        SetIsRightAcyclic( res, true );
    else
        SetIsAcyclic( res, true );
    fi;
    
    SetIsATwoSequence( res, true );
    
    return res;
    
end );

##
InstallMethod( SubResolution,
        "for homalg static objects",
        [ IsInt, IsStaticFinitelyPresentedObjectRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( q, M )
    local d, dq1, res;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        dq1 := FirstMorphismOfResolution( M );
        res := AsATwoSequence( TheMorphismToZero( CoveringObject( M ) ), dq1 );
        if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
            SetIsRightAcyclic( res, true );
        else
            SetIsAcyclic( res, true );
        fi;
        return res;
    fi;
    
    d := Resolution( q + 1, M );
    
    dq1 := CertainMorphism( d, q + 1 );
    
    res := AsATwoSequence( CertainMorphism( d, q ), dq1 );
    
    res := Shift( res, -q );
    
    if HasIsMonomorphism( dq1 ) and IsMonomorphism( dq1 ) then
        SetIsRightAcyclic( res, true );
    else
        SetIsAcyclic( res, true );
    fi;
    
    SetIsATwoSequence( res, true );
    
    return res;
    
end );

#=======================================================================
# Shorten a given resolution q times if possible
#
# I learned it from Alban's thesis
#
# see also Alban and Daniel:
# Constructive Computation of Bases of Free Modules over the Weyl Algebras
#
# (see also [Rotman, Lemma 9.40])
#
#_______________________________________________________________________
InstallMethod( ShortenResolution,
        "an integer and a right acyclic complex",
        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsRightAcyclic ],
        
  function( q, d )	## q is the number of shortening steps
    local max, min, m, n, mx, d_m, d_m_1, shortened, F_m, s_m_1, d_m_2,
          d_short, l, epi;
    
    max := HighestDegree( d );
    min := LowestDegree( d );
    
    m := max - min;
    
    ## q = 0 means do not shorten
    ## q < 0 means fully shorten
    
    if q = 0 or m < 2 then
        return d;
    fi;
    
    ## initialize
    n := q;	## number of shortening steps
    mx := max;
    
    d_m := CertainMorphism( d, mx );
    d_m_1 := CertainMorphism( d, mx - 1 );
    
    shortened := false;
    
    ## iterate: m is now at least 2, i.e. at least two morphisms
    while n <> 0 and m > 1 do
        
        F_m := Source( d_m );
        
        if IsZero( F_m ) then
            
            d_m := d_m_1;
            
            if m > 2 then
                d_m_1 := CertainMorphism( d, mx - 2 );
            fi;
            
        else
            
            s_m_1 := PostInverse( d_m );
            
            if IsBool( s_m_1 ) then
                if not shortened then
                    ## the resolution cannot be shortened
                    return d;
                fi;
                
                ## the resolution cannot be shortened further
                break;
            fi;
            
            shortened := true;
            
            d_m := ProductMorphism( d_m_1, s_m_1 );
            
            Assert( 2, IsMonomorphism( d_m ) );
            
            SetIsMonomorphism( d_m, true );
            
            if m > 2 then
                d_m_2 := CertainMorphism( d, mx - 2 ); ## only for the next line
                d_m_1 := CoproductMorphism( d_m_2, TheZeroMorphism( F_m, Range( d_m_2 ) ) );
                if m = 3 then
                    if not HasCokernelEpi( d_m_2 ) then
                        Error( "d_m_2 has no CokernelEpi set\n" );
                    fi;
                    epi := CokernelEpi( d_m_2 );
                    if HasCokernelEpi( d_m_1 ) and not CokernelEpi( d_m_1 ) = epi then
                        Error( "d_m_1 already has CokernelEpi set\n" );
                    fi;
                    SetCokernelEpi( d_m_1, epi );
                fi;
            fi;
            
        fi;
        
        mx := mx - 1;
        m := m - 1;
        n := n - 1;
    od;
    
    if m > 2 then
        d_short := HomalgComplex( CertainMorphism( d, min + 1 ), min + 1 );
        for l in [ 2 .. m - 2 ] do
            Add( d_short, CertainMorphism( d, min + l ) );
        od;
        Add( d_short, d_m_1 );
        Add( d_short, d_m );
    elif m = 2 then
        d_short := HomalgComplex( d_m_1, min + 1 );
        Add( d_short, d_m );
    else ## m = 1
        
        if not IsIdenticalObj( d_m, CertainMorphism( d, 1 ) ) then
            
            if not IsIdenticalObj( d_m_1, CertainMorphism( d, 1 ) ) then
                Error( "expected d_m_1 to be the first morphism of the given resolution\n" );
            elif HasCokernelEpi( d_m_1 ) then
                ## d_m_1 is the first morphism of the given resolution
                epi := PreCompose( EpiOnLeftFactor( Range( d_m ) ), CokernelEpi( d_m_1 ) );
                if HasCokernelEpi( d_m ) and not CokernelEpi( d_m ) = epi then
                    Error( "d_m already has CokernelEpi set\n" );
                fi;
                SetCokernelEpi( d_m, epi );
            fi;
        fi;
        
        d_short := HomalgComplex( d_m, min + 1 );
    fi;
    
    d_short!.LengthOfResolution := m;
    
    SetIsRightAcyclic( d_short, true );
    
    return d_short;
    
end );

##
InstallMethod( ShortenResolution,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsRightAcyclic ],
        
  function( d )
    
    return ShortenResolution( -1, d );
    
end );

##
InstallMethod( ShortenResolution,
        "for homalg static objects",
        [ IsInt, IsStaticFinitelyPresentedObjectRep ],
        
  function( q, M )
    local d, l;
    
    d := Resolution( M );
    
    d := ShortenResolution( q, d );
    
    l := Length( MorphismDegreesOfComplex( d ) );
    
    if ForAll( ObjectsOfComplex( d ), HasIsProjective and IsProjective ) then
        SetUpperBoundForProjectiveDimension( M, l );
    fi;
    
    SetCurrentResolution( M, d );
    
    ResetFilterObj( M, AFiniteFreeResolution );
    SetAFiniteFreeResolution( M, d );
    
    return d;
    
end );

##
InstallMethod( ShortenResolution,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return ShortenResolution( -1, M );
    
end );

##
InstallMethod( AsEpimorphicImage,
        "for morphisms of static homalg objects",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi )
    local pos, iso;
    
    if not ( HasIsEpimorphism( phi ) and IsEpimorphism( phi ) ) and
       not IsZero( Cokernel( phi ) ) then	## I do not require phi to be a morphism, that's why I don't use IsEpimorphism
        Error( "the first argument must be an epimorphism\n" );
    fi;
    
    if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
        
        iso := phi;
        
    else
        
        iso := ImageObjectEmb( phi );
        
        ## phi is not required to be a morphism, hence
        ## the properties of iso might not have been set
        IsIsomorphism( iso );
        
    fi;
    
    return PushPresentationByIsomorphism( iso );
    
end );

## the second argument is there for method selection
InstallMethod( Intersect2,
        "for homalg objects",
        [ IsList, IsObject ],
        
  function( L, M )
    
    return Iterated( L, Intersect2 );
    
end );

##
InstallGlobalFunction( Intersect,
  function( arg )
    local nargs;
    
    nargs := Length( arg );
    
    if nargs = 0  then
        Error( "<arg> must be nonempty" );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        arg := arg[1];
    fi;
    
    return Intersect2( arg, arg[1] );
    
end );

##  <#GAPDoc Label="IntersectWithMultiplicity">
##  <ManSection>
##    <Oper Arg="ideals, mults" Name="IntersectWithMultiplicity"/>
##    <Returns>a &homalg; left or right ideal</Returns>
##    <Description>
##      Intersect the ideals in the list <A>ideals</A> after raising them to the corresponding power specified in the list of
##      multiplicities <A>mults</A>.
##      <Example><![CDATA[
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( IntersectWithMultiplicity,
        "for homalg ideals",
        [ IsList, IsList ],
        
  function( ideals, mults )
    local s, left, intersection;
    
    if not ForAll( ideals, p -> IsStaticFinitelyPresentedSubobjectRep( p ) and HasConstructedAsAnIdeal( p ) and ConstructedAsAnIdeal( p ) ) then
        Error( "the first argument is not a list of ideals\n" );
    fi;
    
    ## the number of ideals
    s := Length( ideals );
    
    if s = 0 then
        Error( "the list of ideals is empty\n" );
    fi;
    
    if s <> Length( mults ) then
        Error( "the length of the list of ideals and the length of the list of their multiplicities must coincide\n" );
    fi;
    
    ## decide if we are dealing with left or right ideals
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( ideals[1] );
    
    if not ForAll( ideals, a -> IsHomalgLeftObjectOrMorphismOfLeftObjects( a ) = left ) then
        Error( "all ideals must be provided either by left or by right ideals\n" );
    fi;
    
    intersection := Iterated( List( [ 1 .. s ], i -> ideals[i]^mults[i] ), Intersect );
    
    intersection!.Genesis := [ IntersectWithMultiplicity, ideals, mults ];
    
    return intersection;
    
end );

##
InstallMethod( EmbeddingsInCoproductObject,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep, IsList ],
        
  function( coproduct, degrees )
    local l, embeddings, emb_summand, summand, i;
    
    if ( IsBound( coproduct!.EmbeddingsInCoproductObject ) and
         IsBound( coproduct!.EmbeddingsInCoproductObject.degrees ) and
         coproduct!.EmbeddingsInCoproductObject.degrees = degrees ) then
        
        return coproduct!.EmbeddingsInCoproductObject;
        
    fi;
    
    l := Length( degrees );
    
    if l < 2 then
        return fail;
    fi;
    
    embeddings := rec( );
    
    ## contruct the total embeddings of summands into their coproduct
    if l = 2 then
        embeddings.(String(degrees[1])) := MonoOfRightSummand( coproduct );
        embeddings.(String(degrees[2])) := MonoOfLeftSummand( coproduct );
    else
        emb_summand := TheIdentityMorphism( coproduct );
        summand := coproduct;
        embeddings.(String(degrees[1])) := MonoOfRightSummand( summand );
        
        for i in [ 2 .. l - 1 ] do
            emb_summand := PreCompose( MonoOfLeftSummand( summand ), emb_summand );
            summand := Range( EpiOnLeftFactor( summand ) );
            embeddings.(String(degrees[i])) := PreCompose( MonoOfRightSummand( summand ), emb_summand );
        od;
        
        embeddings.(String(degrees[l])) := PreCompose( MonoOfLeftSummand( summand ), emb_summand );
    fi;
    
    coproduct!.EmbeddingsInCoproductObject := embeddings;
    
    return embeddings;
    
end );

##
InstallMethod( ProjectionsFromProductObject,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep, IsList ],
        
  function( product, degrees )
    local l, projections, prj_factor, factor, i;
    
    if ( IsBound( product!.ProjectionsFromProductObject ) and
         IsBound( product!.ProjectionsFromProductObject.degrees ) and
         product!.ProjectionsFromProductObject.degrees = degrees ) then
        
        return product!.ProjectionsFromProductObject;
        
    fi;
    
    l := Length( degrees );
    
    if l < 2 then
        return fail;
    fi;
    
    projections := rec( );
    
    ## contruct the total projections from the product onto the factors
    if l = 2 then
        projections.(String(degrees[1])) := EpiOnRightFactor( product );
        projections.(String(degrees[2])) := EpiOnLeftFactor( product );
    else
        prj_factor := TheIdentityMorphism( product );
        factor := product;
        projections.(String(degrees[1])) := EpiOnRightFactor( factor );
        
        for i in [ 2 .. l - 1 ] do
            prj_factor := PreCompose( prj_factor, EpiOnLeftFactor( factor ) );
            factor := Source( MonoOfLeftSummand( factor ) );
            projections.(String(degrees[i])) := PreCompose( prj_factor, EpiOnRightFactor( factor ) );
        od;
        
        projections.(String(degrees[l])) := PreCompose( prj_factor, EpiOnLeftFactor( factor ) );
    fi;
    
    product!.ProjectionsFromProductObject := projections;
    
    return projections;
    
end );

##  <#GAPDoc Label="Saturate">
##  <ManSection>
##    <Oper Arg="K, J" Name="Saturate" Label="for ideals"/>
##    <Returns>a &homalg; ideal</Returns>
##    <Description>
##      Compute the saturation ideal <M><A>K</A>:<A>J</A>^\infty</M> of the ideals <A>K</A> and <A>J</A>.
##    <P/>
##    <#Include Label="Saturate:example">
##    <P/>
##    <Listing Type="Code"><![CDATA[
InstallMethod( Saturate,
        "for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( K, J )
    local quotient_last, quotient;
    
    quotient_last := SubobjectQuotient( K, J );
    
    quotient := SubobjectQuotient( quotient_last, J );
    
    while not IsSubset( quotient_last, quotient ) do
        quotient_last := quotient;
        quotient := SubobjectQuotient( quotient_last, J );
    od;
    
    return quotient_last;
    
end );

##
InstallMethod( \-,	## a geometrically motivated definition
        "for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( K, J )
    
    return Saturate( K, J );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( SetPropertiesIfKernelIsTorsionObject,
        "for homalg morphisms of static object",
        [ IsHomalgStaticMorphism ],
        
  function( par )
    local M;
    
    M := Source( par );
    
    if HasIsTorsionFree( M ) then
        ## never skip this HasIsTorsionFree since
        ## the current procedure maybe have been invoked from
        ## a procedure used to set IsTorsionFree,
        ## which would then lead to infinite loops
        
        Assert( 2, IsMonomorphism( par ) = IsTorsionFree( M ) );
        
        SetIsMonomorphism( par, IsTorsionFree( M ) );
        
    else
        
        Assert( 2, IsMorphism( par ) );
        
        SetIsMorphism( par, true );
        
    fi;
    
end );
