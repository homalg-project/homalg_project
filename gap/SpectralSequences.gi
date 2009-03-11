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
InstallMethod( AddTotalEmbeddingsToCollapsedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, p_range )
    local E_infinity, BC, Tot, embeddings, n, Totn, bidegrees, tot_embs,
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
            gen_emb := PreCompose( gen_emb, tot_embs.(String( [ n, 0 ] )) );
        fi;
        
        ## CertainMorphism( Tot, n ± 1 ) is the minimum of what
        ## gen_emb needs to master the lifts it will be used for.
        ## We distinguish between complexes and cocomplexes
        ## (or between homological and cohomological spectral sequences)
        if IsComplexOfFinitelyPresentedObjectsRep( Tot ) then
            gen_emb := GeneralizedMap( gen_emb, CertainMorphism( Tot, n + 1 ) );
        else
            gen_emb := AddToMorphismAidMap( gen_emb, CertainMorphism( Tot, n - 1 ) );
        fi;
        
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
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt, IsList ],
        
  function( E, r, p_range )
    local BC, tBC, tE, tE_infinity, embeddings1, embeddings2, Tot, filtration,
          n, Totn, bidegrees, tot_embs, gen_emb1, Hn,
          monomorphism_aid_map1, pq, pp, qq, p, q, gen_emb2, gen_emb;
    
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
    AddTotalEmbeddingsToCollapsedSpectralSequence( tE, p_range );
    AddTotalEmbeddingsToSpectralSequence( E, p_range );
    
    ## get them
    embeddings1 := GeneralizedEmbeddingsInTotalObjects( tE );
    embeddings2 := GeneralizedEmbeddingsInTotalObjects( E );
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    ## initialize an empty record to save the resulting embeddings
    filtration := rec( );
    
    for n in p_range do
        
        ## the n-th total object
        Totn := CertainObject( Tot, n );
        
        ## the bidegrees of total degree n
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        tot_embs := EmbeddingsInCoproductObject( Totn, bidegrees );
        
        ## for the collapsed spectral sequence tE
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
        
        ## in case E is a cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## in case E is a second spectral sequence
        if IsTransposedWRTTheAssociatedComplex( BC ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## construct the generalized embeddings filtering
        ## tE^{n,0} = H^n( Tot( BC ) ) by E^{p,q}
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
            
            gen_emb2 := embeddings2.(String( [ p, q ] ));
            
            ## prepare gen_emb1 to master the coming lift
            gen_emb1 := AddToMorphismAidMap( gen_emb1, monomorphism_aid_map1 );
            
            ## check assertion
            Assert( 1, IsGeneralizedMorphism( gen_emb1 ) );
            
            SetIsGeneralizedMorphism( gen_emb1, true );
            
            ## gen_emb1 now has enough aid to lift gen_emb2
            ## (literal and unliteral)
            gen_emb := gen_emb2 / gen_emb1;
            
            ## this last line is one of the highlights in the code,
            ## where generalized embeddings play a decisive role
            ## (see the functors PostDivide and Compose)
            
            filtration.(String( [ p, q ] )) := gen_emb;
            
            ## prepare the next step
            if tot_embs <> fail then
                monomorphism_aid_map1 := tot_embs.(String( [ pp, qq ] ));
            fi;
            
        od;
        
    od;
    
    ## enrich the spectral sequence E
    E!.GeneralizedEmbeddingsInStableSheetOfCollapsedTransposedSpectralSequence := filtration;
    
    ## finally enrich E with tE
    E!.FirstSpectralSequence := tE;
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, r )
    local p_range;
    
    ## the p-range of the collapsed transposed spectral sequence
    p_range := ObjectDegreesOfSpectralSequence( E )[2];
    
    return AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence( E, r, p_range );
    
end );

##
InstallMethod( AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    return AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence( E, -1 );
    
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
        
        ## in case E is a cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## in case E is a second spectral sequence
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
    local embeddings, BC, Tot, filtration, n, Totn, Hn, Hgen_emb, bidegrees,
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
        
        ## in case E is a cohomological spectral sequences
        if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( E ) then
            bidegrees := Reversed( bidegrees );
        fi;
        
        ## in case E is a second spectral sequence
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
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsInt, IsList ],
        
  function( BC, r, a, p_range )
    local E, Ea;
    
    #=====# begin of the core procedure #=====#
    
    E := HomalgSpectralSequence( BC, a );
    
    ## the intrinsic sheet of the spectral sequence
    #Ea := CertainSheet( E, a );
    
    AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence( E, r, p_range );
    
    return E;
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( BC, p_range )
    
    return SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence( BC, -1, -1, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsInt ],
        
  function( BC, r, a )
    local p_range;
    
    ## the p-range of the collapsed transposed spectral sequence
    p_range := ObjectDegreesOfBicomplex( BC )[2];
    
    return SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence( BC, r, a, p_range );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( BC )
    
    return SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence( BC, -1, -1 );
    
end );

##
InstallMethod( SpectralSequenceWithFiltrationOfTotalDefects,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt, IsList ],
        
  function( BC, a, p_range )
    local E;
    
    #=====# begin of the core procedure #=====#
    
    E := HomalgSpectralSequence( BC, a );
    
    ## filter the total defects with the stable objects
    ## of the second spectral sequence
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
    local tBC, II_E;
    
    tBC := TransposedBicomplex( BC );
    
    if IsBicomplexOfFinitelyPresentedObjectsRep( BC ) then
        return SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence( tBC, r, a, p_range );
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
    local p_range;
    
    if IsBicomplexOfFinitelyPresentedObjectsRep( BC ) then
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
    
    ## the spectral sequence II_E associated to the transposed of BC,
    ## also called the second spectral sequence of the bicomplex BC;
    ## it becomes intrinsic at the second level (w.r.t. some original data)
    ## (e.g. R^{-p} F R^q G => L_{p+q} FG)
    ## 
    ## ... together with the filtration II_E induces
    ## on the objects of the collapsed first spectral sequence
    ## (or, equivalently, on the defects of the associated total complex)
    ## 
    ## the first 2 means:
    ## compute the first spectral sequence till the second sheet, even if things stabilize earlier
    ## the second 2 means:
    ## the second sheet of the second spectral sequence is, in general, the first intrinsic sheet
    II_E := SecondSpectralSequenceWithFiltration( BC, 2, 2, p_range );
    
    ## astonishingly, the remaining code only causes
    ## hardly causes extra computations, if any;
    ## probably because of the cashing mechanisms
    ## (this was observed with Purity.g)
    
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
InstallMethod( FiltrationOfTotalDefect,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, n )
    local gen_embs, bidegrees, degrees, gen_embs_n, gen_emb, pq;
    
    if HasGeneralizedEmbeddingsInTotalDefects( E ) then
        
        gen_embs := GeneralizedEmbeddingsInTotalDefects( E );
        
        bidegrees := BidegreesOfSpectralSequence( E, n );
        
        ## in case E is a cohomological spectral sequences
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
InstallMethod( FiltrationOfTotalDefect,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    return FiltrationOfTotalDefect( E, 0 );
    
end );

##
InstallMethod( FiltrationOfObjectInCollapsedSheetOfTransposedSpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, n )
    local BC, gen_embs, bidegrees, degrees, gen_embs_n, gen_emb, pq;
    
    BC := UnderlyingBicomplex( E );
    
    if IsBound( E!.GeneralizedEmbeddingsInStableSheetOfCollapsedTransposedSpectralSequence ) then
        
        gen_embs := E!.GeneralizedEmbeddingsInStableSheetOfCollapsedTransposedSpectralSequence;
        
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
InstallMethod( FiltrationOfObjectInCollapsedSheetOfTransposedSpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    return FiltrationOfObjectInCollapsedSheetOfTransposedSpectralSequence( E, 0 );
    
end );

##
InstallMethod( FiltrationBySpectralSequence,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, n )
    local BC, filt;
    
    BC := UnderlyingBicomplex( E );
    
    if IsBound( E!.GeneralizedEmbeddingsInStableSheetOfCollapsedTransposedSpectralSequence ) then
        filt := FiltrationOfObjectInCollapsedSheetOfTransposedSpectralSequence( E, n );
    elif HasGeneralizedEmbeddingsInTotalDefects( E ) then
        filt := FiltrationOfTotalDefect( E, n );
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

