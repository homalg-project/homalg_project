#############################################################################
##
##  SpectralSequences.gi        homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg spectral sequences.
##
#############################################################################

## we assume E collapsed to its p-axes
InstallMethod( AddTotalEmbeddingsToCollapsedToZeroSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    local E_infinity, BC, Tot, co, embeddings, n, Totn, bidegrees, tot_embs,
          pq, p, q, gen_emb;
    
    ## the limit sheet of the spectral sequence
    E_infinity := HighestLevelSheetInSpectralSequence( E );
    
    ## if the highest sheet is not stable issue an error
    if not ( HasIsStableSheet( E_infinity ) and IsStableSheet( E_infinity ) ) and
       not ( IsBound( E_infinity!.stability_table ) and IsStableSheet( E_infinity ) ) then
        Error( "the highest sheet doesn't seem to be stable\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## the associated bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    if IsComplexOfFinitelyPresentedObjectsRep( Tot ) then
        co := 1;
    else
        co := -1;
    fi;
    
    embeddings := rec( );
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        tot_embs := EmbeddingsInCoproductObject( Totn, bidegrees );
        
        ## get the absolute embeddings
        gen_emb := E_infinity!.absolute_embeddings.(String( [ n, 0 ] ));
        
        ## create the total embeddings
        if tot_embs <> fail then
            if IsTransposedWRTTheAssociatedComplex( BC ) then
                gen_emb := PreCompose( gen_emb, tot_embs.(String( [ 0, n ] )) );
            else
                gen_emb := PreCompose( gen_emb, tot_embs.(String( [ n, 0 ] )) );
            fi;
        fi;
        
        ## CertainMorphism( Tot, n + co ) is the minimum of what
        ## gen_emb needs to master the lifts it will be used for.
        ## We distinguish between complexes and cocomplexes
        ## (or between homological and cohomological spectral sequences)
        gen_emb := GeneralizedMap( gen_emb, CertainMorphism( Tot, n + co ) );
        
        ## check assertion
        Assert( 1, IsGeneralizedMonomorphism( gen_emb ) );
        
        SetIsGeneralizedMonomorphism( gen_emb, true );
        
        embeddings.(String( [ n, 0 ] )) := gen_emb;
        
    od;
    
    ## now its time to enrich E
    SetGeneralizedEmbeddingsInTotalObjects( E, embeddings );
    
    return E;
    
end );

##
InstallMethod( AddTotalEmbeddingsToSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    local E_infinity, BC, Tot, embeddings, n, Totn, bidegrees, tot_embs,
          monomorphism_aid_map, pq, pp, qq, p, q, gen_emb;
    
    ## the limit sheet of the spectral sequence
    E_infinity := HighestLevelSheetInSpectralSequence( E );
    
    ## if the highest sheet is not stable issue an error
    if not ( HasIsStableSheet( E_infinity ) and IsStableSheet( E_infinity ) ) and
       not ( IsBound( E_infinity!.stability_table ) and IsStableSheet( E_infinity ) ) then
        Error( "the highest sheet doesn't seem to be stable\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## the associated bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    embeddings := rec( );
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        tot_embs := EmbeddingsInCoproductObject( Totn, bidegrees );
        
        ## initialize the monomorphism aid map
        monomorphism_aid_map := 0;
        
        ## in case E is a cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## in case E is a second spectral sequence
        if IsTransposedWRTTheAssociatedComplex( BC ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## for the n-th bidegrees
        for pq in bidegrees do
            
            pp := pq[1];
            qq := pq[2];
            
            if IsTransposedWRTTheAssociatedComplex( BC ) then
                p := qq;
                q := pp;
            else
                p := pp;
                q := qq;
            fi;
            
            ## get the absolute embeddings
            gen_emb := E_infinity!.absolute_embeddings.(String( [ p, q ] ));
            
            ## create the total embeddings
            if tot_embs <> fail then
                gen_emb := PreCompose( gen_emb, tot_embs.(String( [ pp, qq ] )) );
            fi;
            
            ## elevate the generalized embedding to the correct height
            ## (i.e. to the correct subfactor of the total complex)
            gen_emb := AddToMorphismAidMap( gen_emb, monomorphism_aid_map );
            
            ## check assertion
            Assert( 1, IsGeneralizedMonomorphism( gen_emb ) );
            
            SetIsGeneralizedMonomorphism( gen_emb, true );
            
            embeddings.(String( [ p, q ] )) := gen_emb;
            
            ## prepare the next step
            if tot_embs <> fail then
                if IsHomalgMorphism( monomorphism_aid_map ) then
                    ## for this next line we need to run through
                    ## the bidegrees in the correct order
                    monomorphism_aid_map := StackMaps( tot_embs.(String( [ pp, qq ] )), monomorphism_aid_map );
                else
                    monomorphism_aid_map := tot_embs.(String( [ pp, qq ] ));
                fi;
            fi;
            
        od;
        
    od;
    
    ## now its time to enrich E
    SetGeneralizedEmbeddingsInTotalObjects( E, embeddings );
    
    return E;
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjects,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList, IsRecord ],
        
  function( E, p_range, embeddings1 )
    local embeddings, BC, filtration, n,
          bidegrees, gen_emb1, pq, p, q, gen_emb2;
    
    ## add the embeddings in the objects of the total complex
    AddTotalEmbeddingsToSpectralSequence( E, p_range );
    
    ## get them
    embeddings := GeneralizedEmbeddingsInTotalObjects( E );
    
    ## the underlying bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## initialize an empty record to save the resulting filtration
    filtration := rec( );
    
    for n in p_range do
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the generalized embedding we want to lift with,
        ## i.e. of the object we want to filter
        gen_emb1 := embeddings1.(String( n ));
        
        ## construct the generalized embeddings filtering
        ## tE^{n,0} = H^n( Tot( BC ) ) by E^{p,q}
        for pq in bidegrees do
            
            if IsTransposedWRTTheAssociatedComplex( BC ) then
                p := pq[2];
                q := pq[1];
            else
                p := pq[1];
                q := pq[2];
            fi;
            
            ## the generalized embedding we want to lift,
            ## i.e. of an object appearing in the filtration
            gen_emb2 := embeddings.(String( [ p, q ] ));
            
            ## [Ba, Cor. 3.3]: gen_emb1 lifts gen_emb2
            filtration.(String( [ p, q ] )) := gen_emb2 / gen_emb1;	## generalized lift
            
            ## this last line is one of the highlights in the code,
            ## where generalized embeddings play a decisive role
            ## (see the functors PostDivide and Compose)
            
        od;
        
    od;
    
    return filtration;
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt, IsList ],
        
  function( E, r, p_range )
    local BC, tBC, tE, tE_infinity, emb1, embeddings1, n, filtration;
    
    ## the underlying bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## the transposed of the underlying bicomplex
    tBC := TransposedBicomplex( BC );
    
    ## the transposed spectral sequence (w.r.t. BC),
    ## which we assume collapsed to its p-axes
    tE := HomalgSpectralSequence( r, tBC );	## enforce computation till the r-th sheet, even if things stabilize earlier
    
    ## the limit sheet of the transposed spectral sequence
    tE_infinity := HighestLevelSheetInSpectralSequence( tE );
    
    ## add the embeddings in the objects of the total complex
    AddTotalEmbeddingsToCollapsedToZeroSpectralSequence( tE, p_range );
    
    ## get them
    emb1 := GeneralizedEmbeddingsInTotalObjects( tE );
    
    ## prepare the input for AddSpectralFiltrationOfObjects
    embeddings1 := rec( );
    
    for n in p_range do
        embeddings1.(String( n )) := emb1.(String( [ n, 0 ] ));
    od;
    
    ## construct the generalized embeddings filtering
    ## tE^{n,0} = H^n( Tot( BC ) ) by E^{p,q} for all n in p_range
    filtration := AddSpectralFiltrationOfObjects( E, p_range, embeddings1 );
    
    ## enrich the spectral sequence E
    E!.GeneralizedEmbeddingsInStableSheetOfCollapsedTransposedSpectralSequence := filtration;
    
    ## finally enrich E with tE
    E!.TransposedSpectralSequence := tE;
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    
    AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence( E, -1, p_range );
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, r )
    local p_range;
    
    ## the p-range of the collapsed (to its p-axes) transposed spectral sequence
    p_range := ObjectDegreesOfSpectralSequence( E )[2];
    
    AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence( E, r, p_range );
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence( E, -1 );
    
end );

##
InstallMethod( AddSpectralFiltrationOfTotalDefects,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    local BC, Tot, embeddings1, n, Hn, filtration;
    
    ## the underlying bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    ## prepare the input for AddSpectralFiltrationOfObjects
    embeddings1 := rec( );
    
    for n in p_range do
        
        ## the n-th total (co)homology
        Hn := DefectOfExactness( Tot, n );
        
        ## the n-th generalized embedding
        embeddings1.(String( n )) := NaturalGeneralizedEmbedding( Hn );
        
    od;
    
    ## construct the generalized embeddings filtering
    ## H^n( Tot( BC ) ) by E^{p,q} for all n in p_range
    filtration := AddSpectralFiltrationOfObjects( E, p_range, embeddings1 );
    
    ## enrich the spectral sequence E
    SetGeneralizedEmbeddingsInTotalDefects( E, filtration );
    
end );

##
InstallMethod( AddSpectralFiltrationOfTotalDefects,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    local BC, p_range;
    
    BC := UnderlyingBicomplex( E );
    
    p_range := TotalObjectDegreesOfBicomplex( BC );
    
    AddSpectralFiltrationOfTotalDefects( E, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsInt, IsList ],
        
  function( BC, r, a, p_range )
    local E;
    
    E := HomalgSpectralSequence( BC, a );
    
    ## filter the stable objects of the collapsed transposed spectral sequence
    ## with the stable objects of this spectral sequence
    AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence( E, r, p_range );
    
    return E;
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( BC, p_range )
    
    return SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence( BC, -1, -1, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsInt ],
        
  function( BC, r, a )
    local p_range;
    
    ## the p-range of the collapsed (to its p-axes) transposed spectral sequence
    p_range := ObjectDegreesOfBicomplex( BC )[2];
    
    return SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence( BC, r, a, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    
    return SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence( BC, -1, -1 );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsList ],
        
  function( BC, a, p_range )
    local E;
    
    E := HomalgSpectralSequence( BC, a );
    
    ## filter the total defects
    ## with the stable objects of this spectral sequence
    AddSpectralFiltrationOfTotalDefects( E, p_range );
    
    return E;
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( BC, p_range )
    
    return SpectralSequenceWithFiltrationOfTotalDefects( BC, -1, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( BC, a )
    local p_range;
    
    p_range := TotalObjectDegreesOfBicomplex( BC );
    
    return SpectralSequenceWithFiltrationOfTotalDefects( BC, a, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    
    return SpectralSequenceWithFiltrationOfTotalDefects( BC, -1 );
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltration,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsInt, IsList ],
        
  function( BC, r, a, p_range )
    local tBC, q_degrees, II_E;
    
    tBC := TransposedBicomplex( BC );
    
    q_degrees := ObjectDegreesOfBicomplex( BC )[2];
    
    if ( IsBicomplexOfFinitelyPresentedObjectsRep( BC ) and q_degrees[Length( q_degrees )] = 0 ) or
       ( IsBicocomplexOfFinitelyPresentedObjectsRep( BC ) and q_degrees[1] = 0 ) then
        return SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence( tBC, r, a, p_range );
    else
        II_E := SpectralSequenceWithFiltrationOfTotalDefects( tBC, a, p_range );
        AssociatedFirstSpectralSequence( II_E );
        return II_E;
    fi;
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltration,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( BC, p_range )
    
    return SecondSpectralSequenceWithFiltration( BC, -1, -1, p_range );
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltration,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsInt ],
        
  function( BC, r, a )
    local q_degrees, p_range;
    
    q_degrees := ObjectDegreesOfBicomplex( BC )[2];
    
    if ( IsBicomplexOfFinitelyPresentedObjectsRep( BC ) and q_degrees[Length( q_degrees )] = 0 ) or
       ( IsBicocomplexOfFinitelyPresentedObjectsRep( BC ) and q_degrees[1] = 0 ) then
        p_range := ObjectDegreesOfBicomplex( BC )[1];
    else
        p_range := TotalObjectDegreesOfBicomplex( BC );
    fi;
    
    return SecondSpectralSequenceWithFiltration( BC, r, a, p_range );
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltration,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    
    return SecondSpectralSequenceWithFiltration( BC, -1, -1 );
    
end );

##
InstallMethod( GrothendieckBicomplex,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep ],
        
  function( Functor_F, Functor_G, M )
    local F, G, P, GP, CE, FCE, BC, p_degrees, FGP, HFGP, Hgen_embs, p,
          natural_epis, F_natural_epis;
    
    F := OperationOfFunctor( Functor_F );
    G := OperationOfFunctor( Functor_G );
    
    ## a projective resolution of M
    ## (which is an injective resolution in the opposite category)
    P := Resolution( M );
    
    ## apply the inner functor G to the resolution P of M
    GP := G( P );
    
    ## compute the Cartan-Eilenberg resolution of P
    CE := Resolution( GP );
    
    ## apply the outer functor F to the Cartan-Eilenberg resolution
    FCE := F( CE );
    
    ## the associated bicomplex
    BC := HomalgBicomplex( FCE );
    
    ## the p-degrees
    p_degrees := ObjectDegreesOfBicomplex( BC )[1];
    
    ## in case F is contravariant and left exact
    ## or F is covariant and right exact, then
    ## F( G( P ) ) is the zero-th row of first sheet
    ## of the collapsed (to its p-axes) first spectral sequence
    FGP := F( GP );
    
    ## HFGP = H( (FG)( P ) )
    ## = L_*(FG)(M) (FG covariant)
    ## = R^*(FG)(M) (FG contravariant)
    HFGP := DefectOfExactness( FGP );
    
    ## extract the natural embeddings out of H( (FG)( P ) )
    Hgen_embs := rec( );
    
    for p in p_degrees do
        Hgen_embs.(String( [ p, 0 ] ) ) := NaturalGeneralizedEmbedding( CertainObject( HFGP, p ) );
    od;
    
    ## enrich the bicomplex with the natural embeddings
    ## of H( (FG)( P ) ) into (FG)( P )
    BC!.GeneralizedEmbeddingsOfHigherDerivedFunctorsOfTheComposition := Hgen_embs;
    
    ## the natural epimorphisms CE -> GP -> 0
    natural_epis := CE!.NaturalEpis;
    
    F_natural_epis := rec( );
    
    for p in p_degrees do
        F_natural_epis.(String( [ p, 0 ] )) := F( natural_epis.(String( [ p, 0 ] )) );
    od;
    
    ## enrich the bicomplex with F(natural epis)
    ## (by this, SecondSpectralSequenceWithFiltration applied to BC
    ##  will compute certain natural transformations needed later)
    BC!.OuterFunctorOnNaturalEpis := F_natural_epis;
    
    return BC;
    
end );

##
InstallMethod( EnrichAssociatedFirstGrothendieckSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsHomalgFunctorRep ],
        
  function( II_E, Functor_F )
    local BC, Hgen_embs, I_E, I_E1, natural_transformations,
          I_E2, gen_embs, p_degrees, nat_trafos, p;
    
    ## the (enriched) Grothendieck bicomplex
    BC := TransposedBicomplex( UnderlyingBicomplex( II_E ) );
    
    if IsTransposedWRTTheAssociatedComplex( BC ) then
        Error( "this doesn't seem like a second spectral sequence; it is probably a first spectral sequence\n" );
    fi;
    
    ## the natural embeddings of H( (FG)( P ) ) into (FG)( P )
    Hgen_embs := BC!.GeneralizedEmbeddingsOfHigherDerivedFunctorsOfTheComposition;
    
    ## extract the associated first spectral sequence
    I_E := AssociatedFirstSpectralSequence( II_E );
    
    ## exit if I_E is already enriched
    if IsBound( I_E!.NaturalTransformations ) and
       IsBound( I_E!.NaturalGeneralizedEmbeddings ) then
        return;
    fi;
    
    ## the first sheet of the first spectral sequence
    I_E1 := CertainSheet( I_E, 1 );
    
    ## extract the natural transformations
    ## 0 -> F(G(P_p)) -> R^0(F)(G(P_p)) (F contravariant)
    ## L_0(F)(G(P_p)) -> F(G(P_p)) -> 0 (F covariant)
    ## out of the first sheet of the first spectral sequence
    natural_transformations := I_E1!.NaturalTransformations;
    
    ## the second sheet of the first spectral sequence
    I_E2 := CertainSheet( I_E, 2 );
    
    ## extract the natural embeddings out of the zero-th row
    ## of the second sheet of the first spectral sequence
    gen_embs := I_E2!.embeddings;
    
    ## the p-degrees
    p_degrees := ObjectDegreesOfBicomplex( BC )[1];
    
    p_degrees := List( p_degrees, p -> String( [ p, 0 ]) );
    
    ## the natural transformations between the zero-th row
    ## of the second sheet of the first spectral sequence
    ## and H( (FG)( P ) )
    
    nat_trafos := rec( );
    
    if IsCovariantFunctor( Functor_F ) then
        for p in p_degrees do
            if IsBound( natural_transformations.(p) ) then
                nat_trafos.(p) := PreCompose( gen_embs.(p), natural_transformations.(p) ) / Hgen_embs.(p);	## generalized lift
            else
                nat_trafos.(p) := TheZeroMap( Source( gen_embs.(p) ), Source( Hgen_embs.(p) ) );
            fi;
            Assert( 1, IsMonomorphism( nat_trafos.(p) ) );
            SetIsMonomorphism( nat_trafos.(p), true );
        od;
    else
        for p in p_degrees do
            if IsBound( natural_transformations.(p) ) then
                nat_trafos.(p) := ( gen_embs.(p) / natural_transformations.(p) ) / Hgen_embs.(p);	## generalized lift
            else
                nat_trafos.(p) := TheZeroMap( Source( gen_embs.(p) ), Source( Hgen_embs.(p) ) );
            fi;
            Assert( 1, IsMonomorphism( nat_trafos.(p) ) );
            SetIsMonomorphism( nat_trafos.(p), true );
        od;
    fi;
    
    ## enrich I_E
    I_E!.NaturalTransformations := nat_trafos;
    I_E!.NaturalGeneralizedEmbeddings := Hgen_embs;
    
end );

##
InstallMethod( GrothendieckSpectralSequence,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep, IsList ],
        
  function( Functor_F, Functor_G, M, _p_range )
    local BC, p_range, II_E;
    
    ## the (enriched) Grothendieck bicomplex
    BC := GrothendieckBicomplex( Functor_F, Functor_G, M );
    
    ## set the p_range
    if _p_range = [ ] then
        p_range := ObjectDegreesOfBicomplex( BC )[1];
    else
        p_range := _p_range;
    fi;
    
    ## the spectral sequence II_E associated to the transposed of BC,
    ## also called the second spectral sequence of the bicomplex BC;
    ## it becomes intrinsic at the second level (w.r.t. some original data)
    ## (e.g. R^{-p} F R^q G => L_{p+q} FG)
    ## 
    ## ... together with the filtration II_E induces
    ## on the objects of the collapsed (to its p-axes) first spectral sequence
    ## (or, equivalently, on the defects of the associated total complex)
    ##
    ## ... and since the Grothendieck bicomplex BC is enriched
    ## with F(natural epis) the next command will also compute
    ## certain natural transformations needed below
    ## 
    ## the first 2 means:
    ## compute the first spectral sequence till the second sheet,
    ## even if things stabilize earlier
    ## 
    ## the second 2 means:
    ## the second sheet of the second spectral sequence is,
    ## in general, the first intrinsic sheet
    II_E := SecondSpectralSequenceWithFiltration( BC, 2, 2, p_range );
    
    ## astonishingly, EnrichAssociatedFirstGrothendieckSpectralSequence
    ## hardly causes extra computations;
    ## this is probably due to the caching mechanisms
    ## (this was observed with Purity.g)
    EnrichAssociatedFirstGrothendieckSpectralSequence( II_E, Functor_F );	## only the parity of Functor_F is needed
    
    return II_E;
    
end );
    
##
InstallMethod( GrothendieckSpectralSequence,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep ],
        
  function( Functor_F, Functor_G, M )
    
    return GrothendieckSpectralSequence( Functor_F, Functor_G, M, [ ] );
    
end );
    
