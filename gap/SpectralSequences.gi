#############################################################################
##
##  SpectralSequences.gi        homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg spectral sequences.
##
#############################################################################

##
InstallMethod( AddTotalEmbeddingsToCollapsedFirstSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( I_E, p_range )
    local BC, I_E_infinity, Tot, embeddings, co, n, Totn, bidegrees, tot_embs,
          pq, p, q, gen_emb;
    
    BC := UnderlyingBicomplex( I_E );
    
    if IsTransposedWRTTheAssociatedComplex( BC ) then
        Error( "this doesn't seem like a first spectral sequence; it is probably a second spectral sequence\n" );
    fi;
    
    ## the limit sheet of the spectral sequence
    I_E_infinity := HighestLevelSheetInSpectralSequence( I_E );
    
    ## if the highest sheet is not stable issue an error
    if not ( HasIsStableSheet( I_E_infinity ) and IsStableSheet( I_E_infinity ) ) and
       not ( IsBound( I_E_infinity!.stability_table ) and IsStableSheet( I_E_infinity ) ) then
        Error( "the highest sheet doesn't seem to be stable\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    embeddings := rec( );
    
    if IsComplexOfFinitelyPresentedObjectsRep( Tot ) then
        co := 1;
    else
        co := -1;
    fi;
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        tot_embs := EmbeddingsInCoproductObject( Totn, bidegrees );
        
        ## get the absolute embeddings
        gen_emb := I_E_infinity!.absolute_embeddings.(String( [ n, 0 ] ));
        
        ## create the total embeddings
        if tot_embs <> fail then
            gen_emb := PreCompose( gen_emb, tot_embs.(String( [ n, 0 ] )) );
        fi;
        
        ## CertainMorphism( Tot, n + co ) is the minimum of what
        ## gen_emb1 needs to master the lifts below
        gen_emb := GeneralizedMap( gen_emb, CertainMorphism( Tot, n + co ) );
        
        ## check assertion
        Assert( 1, IsGeneralizedMonomorphism( gen_emb ) );
        
        SetIsGeneralizedMonomorphism( gen_emb, true );
        
        embeddings.(String( [ n, 0 ] )) := gen_emb;
        
    od;
    
    ## now its time to enrich I_E
    SetGeneralizedEmbeddingsInTotalObjects( I_E, embeddings );
    
    return I_E;
    
end );

##
InstallMethod( AddTotalEmbeddingsToSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    local E_infinity, BC, Tot, embeddings, n, Totn, bidegrees, tot_embs,
          pq, pp, qq, p, q, gen_emb;
    
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
            
            ## check assertion
            Assert( 1, IsGeneralizedMonomorphism( gen_emb ) );
            
            SetIsGeneralizedMonomorphism( gen_emb, true );
            
            embeddings.(String( [ p, q ] )) := gen_emb;
            
        od;
        
    od;
    
    ## now its time to enrich E
    SetGeneralizedEmbeddingsInTotalObjects( E, embeddings );
    
    return E;
    
end );

##
InstallMethod( AddSpectralFiltrationOfTotalDefects,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex and IsSpectralCosequenceOfFinitelyPresentedObjectsRep, IsList ],
        
  function( E, p_range )
    local E_infinity, embeddings, BC, Tot, filtration, n, Totn, Hn, Hgen_emb,
          bidegrees, tot_prjs, pq, pp, qq, p, q, gen_emb, gen_prj, gen_embH;
    
    ## the limit sheet of the spectral sequence
    E_infinity := HighestLevelSheetInSpectralSequence( E );
    
    ## get the absolute embeddings
    embeddings := E_infinity!.absolute_embeddings;
    
    ## the associated bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    filtration := rec( );
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the n-th total (co)homology
        Hn := DefectOfExactness( Tot, n );
        
        ## the n-th generalized embedding
        Hgen_emb := NaturalGeneralizedEmbedding( Hn );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the projections from Tot^n -> BC^{p,q}
        tot_prjs := ProjectionsFromProductObject( Totn, bidegrees );
        
        ## this is necessary for handling not only homological
        ## but also cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## this is necessary for handling the
        ## second spectral sequence of a bicomplex
        if IsTransposedWRTTheAssociatedComplex( BC ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
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
            
            gen_emb := embeddings.(String( [ p, q ] ));
            
            if tot_prjs <> fail then
                gen_prj := PreCompose( Hgen_emb, tot_prjs.(String( [ pp, qq ] )) );
            else
                gen_prj := Hgen_emb;
            fi;
            
            gen_embH := gen_emb / gen_prj;
            
            filtration.(String( [ p, q ] )) := gen_embH;
            
        od;
        
    od;
    
    ## enrich E
    SetGeneralizedEmbeddingsInTotalDefects( E, filtration );
    
    return E;
    
end );

##
InstallMethod( AddSpectralFiltrationOfTotalDefects,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    local BC, embeddings, Tot, filtration, n, Totn, Hn, Hgen_emb, bidegrees,
          tot_embs, pq, pp, qq, p, q, gen_emb, gen_emb0, monomorphism_aid_map,
          gen_embH;
    
    ## add the embeddings in the objects of the total complex
    AddTotalEmbeddingsToSpectralSequence( E, p_range );
    
    ## get them
    embeddings := GeneralizedEmbeddingsInTotalObjects( E );
    
    ## the associated bicomplex
    BC := UnderlyingBicomplex( E );
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    filtration := rec( );
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the n-th total (co)homology
        Hn := DefectOfExactness( Tot, n );
        
        ## the n-th generalized embedding
        Hgen_emb := NaturalGeneralizedEmbedding( Hn );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        tot_embs := EmbeddingsInCoproductObject( Totn, bidegrees );
        
        ## this is necessary for handling not only homological
        ## but also cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## this is necessary for handling the
        ## second spectral sequence of a bicomplex
        if IsTransposedWRTTheAssociatedComplex( BC ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## store the morphism aid map
        if HasMorphismAidMap( Hgen_emb ) then
            monomorphism_aid_map := MorphismAidMap( Hgen_emb );
        else
            monomorphism_aid_map := 0;
        fi;
        
        ## prepare a copy of Hgen_emb without the morphism aid map
        ## (will be added below)
        gen_emb0 := RemoveMorphismAidMap( Hgen_emb );
        
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
            
            gen_emb := embeddings.(String( [ p, q ] ));
            
            ## prepare gen_emb0 to master the coming lift
            gen_emb0 := AddToMorphismAidMap( gen_emb0, monomorphism_aid_map );
            
            gen_embH := gen_emb / gen_emb0;
            
            filtration.(String( [ p, q ] )) := gen_embH;
            
            ## prepare the next step
            if tot_embs <> fail then
                monomorphism_aid_map := tot_embs.(String( [ pp, qq ] ));
            fi;
            
        od;
        
    od;
    
    ## enrich E
    SetGeneralizedEmbeddingsInTotalDefects( E, filtration );
    
    return E;
    
end );

##
InstallMethod( AddSpectralFiltrationOfTotalDefects,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    local BC, p_range;
    
    BC := UnderlyingBicomplex( E );
    
    p_range := TotalObjectDegreesOfBicomplex( BC );
    
    return AddSpectralFiltrationOfTotalDefects( E, p_range );
    
end );

##
InstallMethod( SecondSpectralSequenceWithCollapsedFirstSpectralSequence,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep, IsList ],
        
  function( _BC, p_range )
    local BC, Tot, I_E, I_E_infinity, tBC, II_E, II_E2,
          embeddings1, embeddings2, embeddings, n, Totn, bidegrees,
          tot_embs, gen_emb1, Hn, monomorphism_aid_map1, pq, p, q,
          gen_emb2, gen_emb;
    
    if IsTransposedWRTTheAssociatedComplex( _BC ) then
        BC := TransposedBicomplex( _BC );
    else
        BC := _BC;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    ## the spectral sequence associated to BC,
    ## also called the first spectral sequence of the bicomplex BC;
    ## its limit sheet is the second sheet,
    ## where it also becomes intrinsic (in the abelian category)
    I_E := HomalgSpectralSequence( 2, BC );	## enforce computation till the second sheet, even if things stabilize earlier
    
    ## the limit sheet of the first spectral sequence
    I_E_infinity := HighestLevelSheetInSpectralSequence( I_E );
    
    ## the transposed bicomplex
    tBC := TransposedBicomplex( BC );
    
    ## the spectral sequence associated to tBC,
    ## also called the second spectral sequence of the bicomplex BC;
    ## it becomes intrinsic at the second level (w.r.t. some original data)
    ## (e.g. R^{-p} F R^q G => L_{p+q} FG)
    II_E := HomalgSpectralSequence( tBC, 2 );	## the second sheet is the intrinsic sheet of the second spectral sequence
    
    ## the intrinsic sheet of the second spectral sequence
    #II_E2 := CertainSheet( II_E, 2 );
    
    ## add the embeddings in the objects of the total complex
    AddTotalEmbeddingsToCollapsedFirstSpectralSequence( I_E, p_range );
    AddTotalEmbeddingsToSpectralSequence( II_E, p_range );
    
    embeddings1 := GeneralizedEmbeddingsInTotalObjects( I_E );
    embeddings2 := GeneralizedEmbeddingsInTotalObjects( II_E );
    
    embeddings := rec( );
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        tot_embs := EmbeddingsInCoproductObject( Totn, bidegrees );
        
        ## for the first spectral sequence I_E
        gen_emb1 := embeddings1.(String( [ n, 0 ] ));
        
        ## store the morphism aid map
        if HasMorphismAidMap( gen_emb1 ) then
            monomorphism_aid_map1 := MorphismAidMap( gen_emb1 );
        else
            monomorphism_aid_map1 := 0;
        fi;
        
        ## prepare a copy of gen_emb1 without the morphism aid map
        ## (will be added below)
        gen_emb1 := RemoveMorphismAidMap( gen_emb1 );
        
        ## construct the generalized embeddings filtering
        ## I_E^{n,0} = H^n( Tot( BC ) ) by II_E^{p,q}
        for pq in Reversed( bidegrees ) do		## note the "Reversed"
            
            q := pq[1];		## we flip p and q of the bicomplex since we take
            p := pq[2];		## the second spectral sequence as our reference
            
            gen_emb2 := embeddings2.(String( [ p, q ] ));
            
            ## prepare gen_emb1 to master the coming lift
            gen_emb1 := AddToMorphismAidMap( gen_emb1, monomorphism_aid_map1 );		## this works without side effects
            
            ## check assertion
            Assert( 1, IsGeneralizedMorphism( gen_emb1 ) );
            
            SetIsGeneralizedMorphism( gen_emb1, true );
            
            ## gen_emb1 now has enough aid to lift gen_emb2
            ## (literal and unliteral)
            gen_emb := gen_emb2 / gen_emb1;
            
            ## this last line is one of the highlights in the code,
            ## where generalized embeddings play a decisive role
            ## (see the functors PostDivide and Compose)
            
            embeddings.(String( [ p, q ] )) := gen_emb;
            
            ## prepare the next step
            if tot_embs <> fail then
                monomorphism_aid_map1 := tot_embs.(String( [ q, p ] ));	## note the flip [ q, p ]
            fi;
            
        od;
        
    od;
    
    ## enrich the second spectral sequence II_E
    II_E!.GeneralizedEmbeddingsInStableSheetOfFirstSpectralSequence := embeddings;
    
    ## finally enrich II_E with I_E
    II_E!.FirstSpectralSequence := I_E;
    
    return II_E;
    
end );

##
InstallMethod( SecondSpectralSequenceWithCollapsedFirstSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    local p_range;
    
    p_range := ObjectDegreesOfBicomplex( BC )[1];
    
    return SecondSpectralSequenceWithCollapsedFirstSpectralSequence( BC, p_range );
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( _BC, p_range )
    local BC, Tot, tBC, II_E;
    
    if IsTransposedWRTTheAssociatedComplex( _BC ) then
        BC := TransposedBicomplex( _BC );
    else
        BC := _BC;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    ## the transposed bicomplex
    tBC := TransposedBicomplex( BC );
    
    ## the spectral sequence associated to tBC,
    ## also called the second spectral sequence of the bicomplex BC;
    ## it becomes intrinsic at the second level (w.r.t. some original data)
    ## (e.g. R^{-p} F R^q G => L_{p+q} FG)
    II_E := HomalgSpectralSequence( tBC, 2 );	## the second sheet is the intrinsic sheet of the second spectral sequence
    
    ## filter the total defects with the stable objects
    ## of the second spectral sequence
    AddSpectralFiltrationOfTotalDefects( II_E, p_range );
    
    AssociatedFirstSpectralSequence( II_E );
    
    return II_E;
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    local p_range;
    
    p_range := TotalObjectDegreesOfBicomplex( BC );
    
    return SecondSpectralSequenceWithFiltrationOfTotalDefects( BC, p_range );
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltration,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( BC, p_range )
    
    if IsBicomplexOfFinitelyPresentedObjectsRep( BC ) then
        return SecondSpectralSequenceWithCollapsedFirstSpectralSequence( BC, p_range );
    else
        return SecondSpectralSequenceWithFiltrationOfTotalDefects( BC, p_range );
    fi;
    
end );

##
InstallMethod( SecondSpectralSequenceWithFiltration,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    local p_range;
    
    if IsBicomplexOfFinitelyPresentedObjectsRep( BC ) then
        p_range := ObjectDegreesOfBicomplex( BC )[1];
    else
        p_range := TotalObjectDegreesOfBicomplex( BC );
    fi;
    
    return SecondSpectralSequenceWithFiltration( BC, p_range );
    
end );

##
InstallMethod( GrothendieckSpectralSequence,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep, IsList ],
        
  function( Functor_F, Functor_G, M, _p_range )
    local F, G, P, GP, CE, FCE, BC, p_degrees, p_range,
          natural_epis, F_natural_epis, p, II_E,
          I_E, I_E1, natural_transformations, FGP, HFGP, I_E2,
          gen_embs, Hgen_embs, nat_trafos;
    
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
    
    ## set the p_range
    if _p_range = [ ] then
        p_range := p_degrees;
    else
        p_range := _p_range;
    fi;
    
    ## the natural epimorphisms CE -> GP -> 0
    natural_epis := CE!.NaturalEpis;
    
    F_natural_epis := rec( );
    
    for p in p_degrees do
        F_natural_epis.(String( [ p, 0 ] )) := F( natural_epis.(String( [ p, 0 ] )) );
    od;
    
    ## enrich the bicomplex with F(natural epis)
    ## (by this, the next command will compute
    ##  certain natural transformations needed below)
    BC!.OuterFunctorOnNaturalEpis := F_natural_epis;
    
    ## the second spectral sequence
    II_E := SecondSpectralSequenceWithFiltration( BC, p_range );
    
    ## astonishingly, the remaining code only causes
    ## very few extra computations (if any)
    
    ## in case F is contravariant and left exact
    ## or F is covariant and right exact, then
    ## F( G( P ) ) is the zero-th row of first sheet
    ## of the collapsed first spectral sequence
    FGP := F( GP );
    
    ## HFGP = H( (FG)( P ) )
    ## = L_*(FG)(M) (FG covariant)
    ## = R^*(FG)(M) (FG contravariant)
    HFGP := DefectOfExactness( FGP );
    
    ## extract the associated first spectral sequence
    I_E := AssociatedFirstSpectralSequence( II_E );
    
    ## the first sheet of the first spectral sequence
    I_E1 := CertainSheet( I_E, 1 );
    
    ## extract the natural transformations
    ## 0 -> F(G(P_p)) -> R^0(F)(G(P_p)) (F contravariant)
    ## L_0(F)(G(P_p)) -> F(G(P_p)) -> 0 (F covariant)
    ## out of the first sheet of the first spectral sequence
    natural_transformations := I_E1!.NaturalTransformations;
    
    ## the second sheet of the first spectral sequence
    I_E2 := CertainSheet( I_E, 2 );
    
    ## 1) extract the natural embeddings out of the zero-th row
    ## of the second sheet of the first spectral sequence
    ## 2) extract the natural embeddings out of H( (FG)( P ) )
    gen_embs := I_E2!.embeddings;
    Hgen_embs := rec( );
    
    for p in p_degrees do
        Hgen_embs.(String( [ p, 0 ] ) ) := NaturalGeneralizedEmbedding( CertainObject( HFGP, p ) );
    od;
    
    ## the natural transformations between the zero-th row
    ## of the second sheet of the first spectral sequence
    ## and H( (FG)( P ) )
    
    nat_trafos := rec( );
    
    p_degrees := List( p_degrees, p -> String( [ p, 0 ]) );
    
    if IsCovariantFunctor( Functor_F ) then
        for p in p_degrees do
            if IsBound( natural_transformations.(p) ) then
                nat_trafos.(p) := PreCompose( gen_embs.(p), natural_transformations.(p) ) / Hgen_embs.(p);
            else
                nat_trafos.(p) := TheZeroMap( Source( gen_embs.(p) ), Source( Hgen_embs.(p) ) );
            fi;
            Assert( 1, IsMonomorphism( nat_trafos.(p) ) );
            SetIsMonomorphism( nat_trafos.(p), true );
        od;
    else
        for p in p_degrees do
            if IsBound( natural_transformations.(p) ) then
                nat_trafos.(p) := ( gen_embs.(p) / natural_transformations.(p) ) / Hgen_embs.(p);
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
    
    return II_E;
    
end );
    
##
InstallMethod( GrothendieckSpectralSequence,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep ],
        
  function( Functor_F, Functor_G, M )
    
    return GrothendieckSpectralSequence( Functor_F, Functor_G, M, [ ] );
    
end );
    
##
InstallMethod( FiltrationOfTotalDefectOfSpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, n )
    local gen_embs, bidegrees, degrees, gen_embs_n, gen_emb, pq;
    
    if HasGeneralizedEmbeddingsInTotalDefects( E ) then
        
        gen_embs := GeneralizedEmbeddingsInTotalDefects( E );
        
        bidegrees := BidegreesOfSpectralSequence( E, n );
        
        ## this is necessary for handling not only homological
        ## but also cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        degrees := List( bidegrees, a -> a[1] );
        
        gen_embs_n := rec( degrees := degrees,
                           bidegrees := bidegrees );
        
        for pq in bidegrees do
            if IsBound( gen_embs!.(String( pq )) ) then
                gen_embs_n.(String( pq[1] )) := gen_embs!.(String( pq ));
            fi;
        od;
        
        if IsSpectralSequenceOfFinitelyPresentedObjectsRep( E ) then
            return HomalgAscendingFiltration( gen_embs_n, IsFiltration, true );
        else
            return HomalgDescendingFiltration( gen_embs_n, IsFiltration, true );
        fi;
        
    fi;
    
    return fail;
    
end );

##
InstallMethod( FiltrationOfTotalDefectOfSpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    return FiltrationOfTotalDefectOfSpectralSequence( E, 0 );
    
end );

##
InstallMethod( FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( II_E, n )
    local BC, gen_embs, bidegrees, degrees, gen_embs_n, gen_emb, pq;
    
    BC := UnderlyingBicomplex( II_E );
    
    if not IsTransposedWRTTheAssociatedComplex( BC ) then
        Error( "this doesn't seem like the second spectral sequence\n" );
    fi;
    
    if IsBound( II_E!.GeneralizedEmbeddingsInStableSheetOfFirstSpectralSequence ) then
        
        gen_embs := II_E!.GeneralizedEmbeddingsInStableSheetOfFirstSpectralSequence;
        
        bidegrees := BidegreesOfSpectralSequence( II_E, n );
        
        ## this is necessary for handling not only homological
        ## but also cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( II_E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        degrees := List( bidegrees, a -> a[1] );
        
        gen_embs_n := rec( degrees := degrees,
                           bidegrees := bidegrees );
        
        for pq in bidegrees do
            if IsBound( gen_embs!.(String( pq )) ) then
                gen_embs_n.(String( pq[1] )) := gen_embs!.(String( pq ));
            fi;
        od;
        
        if IsSpectralSequenceOfFinitelyPresentedObjectsRep( II_E ) then
            return HomalgAscendingFiltration( gen_embs_n, IsFiltration, true );
        else
            return HomalgDescendingFiltration( gen_embs_n, IsFiltration, true );
        fi;
        
    fi;
    
    return fail;
    
end );

##
InstallMethod( FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( II_E )
    
    return FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence( II_E, 0 );
    
end );

##
InstallMethod( FiltrationBySpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, n )
    local BC, filt;
    
    BC := UnderlyingBicomplex( E );
    
    if HasGeneralizedEmbeddingsInTotalDefects( E ) then
        filt := FiltrationOfTotalDefectOfSpectralSequence( E, n );
    elif IsTransposedWRTTheAssociatedComplex( BC ) then
        filt := FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence( E, n );
    else
        return fail;
    fi;
    
    ## enrich the filtration
    filt!.SecondSpectralSequence := E;
    
    return filt;
    
end );

##
InstallMethod( FiltrationBySpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    return FiltrationBySpectralSequence( E, 0 );
    
end );

##
InstallMethod( PurityFiltration,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, F, G, II_E, filt, non_zero_p, l, p, I_E, iso;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        F := RightDualizingFunctor( R );	# Hom(-,R) for right modules
        G := LeftDualizingFunctor( R );		# Hom(-,R) for left modules
    else
        F := LeftDualizingFunctor( R );		# Hom(-,R) for left modules
        G := RightDualizingFunctor( R );	# Hom(-,R) for right modules
    fi;
    
    II_E := GrothendieckSpectralSequence( F, G, M, [ 0 ] );
    
    filt := FiltrationBySpectralSequence( II_E );
    
    ByASmallerPresentation( filt );
    
    ## set different porperties and attributes of the pure parts
    Perform( DegreesOfFiltration( filt ),
        function( p )
            local L;
            L := CertainObject( filt, p );
            if not IsZero( L ) then
                SetCodimOfModule( L, -p );
                SetIsPure( L, true );
                SetCodegreeOfPurity( L, StaircaseOfStability( II_E, [ p, -p ], 2 ) );
            fi;
        end );
    
    ## set the codegree of purity for the torsion free factor (in case it is already computed)
    if HasTorsionFreeFactorEpi( M ) and CertainObject( II_E, [ 0, 0 ] ) <> fail then
        SetCodegreeOfPurity( TorsionFreeFactor( M ), StaircaseOfStability( II_E, [ 0, 0 ], 2 ) );
    fi;
    
    ## the rank of the 0-th part is the rank of the module M
    if HasRankOfModule( M ) and RankOfModule( M ) > 0 then
        SetRankOfModule( CertainObject( filt, 0 ), RankOfModule( M ) );
    elif HasRankOfModule( CertainObject( filt, 0 ) ) then
        SetRankOfModule( M, RankOfModule( CertainObject( filt, 0 ) ) );
    fi;
    
    non_zero_p := Filtered( DegreesOfFiltration( filt ), p -> not IsZero( CertainObject( filt, p ) ) );
    
    l := Length( non_zero_p );
    
    ## if only one graded part is non-trivial, the module M is pure
    if l > 0 then
        p := non_zero_p[l];
        
        SetCodimOfModule( M, -p );
        
        if l = 1 then
            SetIsPure( M, true );
            SetCodegreeOfPurity( M, StaircaseOfStability( II_E, [ p, -p ], 2 ) );
        else
            SetIsPure( M, false );
            SetCodegreeOfPurity( M, infinity );
        fi;
    fi;
    
    SetIsPurityFiltration( filt, true );
    
    ## construct the isomorphism
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FG( M ) -> M:
    
    ## the associated first spectral sequence
    I_E := AssociatedFirstSpectralSequence( II_E );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M )
    iso := I_E!.NaturalTransformations.(String( [ 0, 0 ] ));
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FreeHull( FG( M ) )
    iso := PreCompose( iso, I_E!.NaturalGeneralizedEmbeddings.(String( [ 0, 0 ])) );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FreeHull( FG( M ) ) -> FreeHull( M )
    iso := iso / NatTrIdToHomHom_R( FreeHullModule( M ) );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FreeHull( FG( M ) ) -> FreeHull( M ) -> M
    ## finally giving the isomorphism
    ## L_0( (R^0 F) G )( M ) -> M
    iso := PreCompose( iso, FreeHullEpi( M ) );
    
    Assert( 1, IsIsomorphism( iso ) );
    
    SetIsIsomorphism( iso, true );
    
    ## transfer the known properties/attributes in both directions
    UpdateModulesByMap( iso );
    
    ## enrich the filtration
    filt!.Isomorphism := iso;
    
    return filt;
    
end );

