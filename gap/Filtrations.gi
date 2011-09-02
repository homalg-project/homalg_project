#############################################################################
##
##  Filtrations.gi              homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, RWTH-Aachen
##
##  Implementation stuff for (spectral) filtrations.
##
#############################################################################

##
InstallMethod( FiltrationOfTotalDefect,
        "for spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( E, n )
    local gen_embs, bidegrees, degrees, gen_embs_n, pq;
    
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
    local BC, gen_embs, bidegrees, degrees, gen_embs_n, pq;
    
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
    
    ## enrich the filtration with the spectral sequence used to construct it
    SetSpectralSequence( filt, E );
    
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
InstallMethod( SetAttributesByPurityFiltrationViaBidualizingSpectralSequence,
        "for (ascending) purity filtrations",
        [ IsFiltrationOfFinitelyPresentedObjectRep and
          IsAscendingFiltration and
          IsPurityFiltration ],
        
  function( filt )
    local II_E, M, non_zero_p, l, p;
    
    if not HasSpectralSequence( filt ) then
        Error( "this purity filtration does not have the attribute SpectralSequence;",
               "maybe it was not computed using the bidualizing spectral sequence\n" );
    fi;
    
    II_E := SpectralSequence( filt );
    
    M := UnderlyingObject( filt );
    
    ## set different porperties and attributes of the pure parts
    Perform( DegreesOfFiltration( filt ),
        function( p )
            local L;
            L := CertainObject( filt, p );
            if not IsZero( L ) then
                SetCodegreeOfPurity( L, StaircaseOfStability( II_E, [ p, -p ], 2 ) );
            fi;
        end );
    
    ## set the codegree of purity for the torsion-free factor (in case it is already computed)
    if HasTorsionFreeFactorEpi( M ) and CertainObject( II_E, [ 0, 0 ] ) <> fail then
        SetCodegreeOfPurity( TorsionFreeFactor( M ), StaircaseOfStability( II_E, [ 0, 0 ], 2 ) );
    fi;
    
    non_zero_p := Filtered( DegreesOfFiltration( filt ), p -> not IsZero( CertainObject( filt, p ) ) );
    
    l := Length( non_zero_p );
    
    ## if only one graded part is non-trivial, the object M is pure
    if l > 0 then
        p := non_zero_p[l];
        
        SetGrade( M, -p );
        
        if l = 1 then
            SetCodegreeOfPurity( M, StaircaseOfStability( II_E, [ p, -p ], 2 ) );
        else
            SetCodegreeOfPurity( M, infinity );
        fi;
    fi;
    
end );

##
InstallMethod( SetAttributesByPurityFiltration,
        "for (ascending) purity filtrations",
        [ IsFiltrationOfFinitelyPresentedObjectRep and
          IsAscendingFiltration and
          IsPurityFiltration ],
        
  function( filt )
    local M, degrees, pure_degrees, L, non_zero_p, l, p, M0;
    
    M := UnderlyingObject( filt );
    
    degrees := DegreesOfFiltration( filt );
    
    pure_degrees := degrees{[ 2 .. Length( degrees ) ]};
    
    ## set different porperties and attributes of the pure parts
    Perform( pure_degrees,
        function( p )
            local L;
            L := CertainObject( filt, p );
            if not IsZero( L ) then
                SetGrade( L, -p );
                SetIsPure( L, true );
            fi;
        end );
    
    p := degrees[1];
    
    L := CertainObject( filt, p );
    
    if not IsZero( L ) then
        SetGrade( L, -p );
        if HasIsCompletePurityFiltration( filt ) and
           IsCompletePurityFiltration( filt ) then
            SetIsPure( L, true );
        fi;
    fi;
    
    non_zero_p := Filtered( degrees, p -> not IsZero( CertainObject( filt, p ) ) );
    
    l := Length( non_zero_p );
    
    ## if only one graded part is non-trivial, the object M is pure
    if l > 0 then
        p := non_zero_p[l];
        
        SetGrade( M, -p );
        
        if l = 1 then
            if HasIsCompletePurityFiltration( filt ) and
               IsCompletePurityFiltration( filt ) then
                SetIsPure( M, true );
            fi;
        else
            SetIsPure( M, false );
        fi;
    fi;
    
    M0 := CertainObject( filt, 0 );
    
    ## the rank of the 0-th part M0 is the rank of the object M
    if HasRankOfObject( M ) and RankOfObject( M ) > 0 then
        SetRankOfObject( M0, RankOfObject( M ) );
    elif HasRankOfObject( M0 ) then
        SetRankOfObject( M, RankOfObject( M0 ) );
    fi;
    
end );

##
InstallMethod( PurityFiltrationViaBidualizingSpectralSequence,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )	## does not set the attribute PurityFiltration
    local II_E, filt, I_E, iso;
    
    II_E := BidualizingSpectralSequence( M, [ 0 ] );
    
    ## the underlying object of this filtraton is L_0( (R^0 F) G )( M )
    ## and not M
    filt := FiltrationBySpectralSequence( II_E );
    
    ## construct the isomorphism
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FG( M ) -> M:
    
    ## the associated first spectral sequence
    I_E := AssociatedFirstSpectralSequence( II_E );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M )
    iso := I_E!.NaturalTransformations.(String( [ 0, 0 ] ));
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> CoveringObject( FG( M ) )
    iso := PreCompose( iso, I_E!.NaturalGeneralizedEmbeddings.(String( [ 0, 0 ])) );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> CoveringObject( FG( M ) ) -> CoveringObject( M )
    iso := iso / NatTrIdToHomHom_R( CoveringObject( M ) );	## lift
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> CoveringObject( FG( M ) ) -> CoveringObject( M ) -> M
    ## finally giving the isomorphism
    ## L_0( (R^0 F) G )( M ) -> M
    iso := PreCompose( iso, CoveringEpi( M ) );
    
    Assert( 1, IsIsomorphism( iso ) );
    
    SetIsIsomorphism( iso, true );
    
    ## transfer the known properties/attributes in both directions
    UpdateObjectsByMorphism( iso );
    
    ## finally compose with the natural isomorphism
    ## to compute the induced filtraton on M
    filt := filt * iso;
    
    ## start with this as it might help to find more properties/attributes
    ByASmallerPresentation( filt );
    
    SetIsPurityFiltration( filt, true );
    
    SetIsCompletePurityFiltration( filt, true );
    
    SetSpectralSequence( filt, II_E );
    
    SetAttributesByPurityFiltration( filt );
    
    SetAttributesByPurityFiltrationViaBidualizingSpectralSequence( filt );
    
    M!.PurityFiltrationViaBidualizingSpectralSequence := filt;
    
    return filt;
    
end );

##
InstallMethod( PurityFiltration,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  PurityFiltrationViaBidualizingSpectralSequence );

##
InstallMethod( OnPresentationAdaptedToFiltration,
        "for filtrations of homalg static objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    local iso;
    
    iso := IsomorphismOfFiltration( filt );
    
    return PushPresentationByIsomorphism( iso );
    
end );

##
InstallMethod( IsomorphismOfFiltration,
        "for filtrations of homalg objects",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    local M, degrees, l, p, gen_iso, pi, iota, filt_p_1, i, Fp_1, Mp,
          d1, d0, eta0, epi, eta, emb, chi, alpha;
    
    M := UnderlyingObject( filt );
    
    degrees := DegreesOfFiltration( filt );
    
    ## the length of the filtration is guaranteed to be > 0
    l := Length( degrees );
    
    p := degrees[l];
    
    ## M_p -> F_p( M )
    ## the generalized isomorphism of the p-th graded part M_p
    ## onto the (filtered) object M
    gen_iso := CertainMorphism( filt, p );
    
    ## end the recursion
    if l = 1 then
        
        Assert( 1, IsIsomorphism( gen_iso ) );
        
        SetIsIsomorphism( gen_iso, true );
        
        ## transfer the known properties/attributes in both directions
        UpdateObjectsByMorphism( gen_iso );
        
        return gen_iso;
        
    fi;
    
    ## pi: M = F_p( M ) -> M_p
    ## the epimorphism F_p( M ) onto M_p
    pi  := gen_iso ^ -1;
    
    ## iota: F_{p-1}( M ) -> F_p( M )
    ## the embedding iota_p of F_{p-1}( M ) into F_p( M )
    iota := KernelEmb( pi );
    
    ## the degrees of the induced filtration on F_{p-1}( M )
    degrees := degrees{[ 1 .. l - 1 ]};
    
    ## the induced filtration on F_{p-1}( M );
    filt_p_1 := rec( degrees := degrees );
    
    for i in degrees do
        filt_p_1.(String( i )) := CertainMorphism( filt, i ) / iota;
    od;
    
    filt_p_1 := HomalgAscendingFiltration( filt_p_1, IsFiltration, true );
    
    ## F_{p-1}( M ) adapted to the filtration (recursively)
    Fp_1 := OnPresentationAdaptedToFiltration( filt_p_1 );
    
    ## the p-th graded part M_p
    Mp := Range( pi );
    
    ## d1: K_1 -> P_0
    ## the embedding of the first syzygies object K_1 = K_1( M_p )
    ## into the free hull P_0 of M_p
    d1 := SyzygiesObjectEmb( Mp );
    
    ## d0: P_0 -> M_p
    ## the epimorphism from the free hull P_0 (of M_p) onto M_p
    d0 := CoveringEpi( Mp );
    
    ## make a copy without the morphism aid map
    gen_iso := RemoveMorphismAid( gen_iso );
    
    ## eta0: P_0 -> F_p( M )
    ## the first lift of the identity map of M_p to a map between P_0 and F_p( M )
    eta0 := DecideZero( PreCompose( d0, gen_iso ) );
    
    ## epi: P_0 + F_{p-1}( M ) -> F_p( M )
    ## the epimorphism from the direct sum P_0 + F_{p-1}( M ) onto F_p( M )
    epi := CoproductMorphism( -eta0, iota );
    
    ## eta: K_1 -> F_{p-1}( M )
    ## the 1-cocycle of the extension 0 -> F_{p-1} -> F_p -> M_p -> 0
    eta := DecideZero( CompleteImageSquare( d1, eta0, iota ) );
    
    Assert( 1, IsMorphism( eta ) );
    
    SetIsMorphism( eta, true );
    
    ## K_1 -> P_0 + F_{p-1}( M )
    ## the cokernel of (the embedding) K_1 -> P_0 + F_{p-1}( M ) is
    ## 1) isomorphic to F_p( M )
    ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
    emb := ProductMorphism( d1, eta );
    
    ## P_0 + F_{p-1}( M ) -> Cokernel( K_1 -> P_0 + F_{p-1}( M ) )
    ## the natural epimorphism from the direct sum P_0 + F_{p-1}( M )
    ## onto the cokernel of K_1 -> P_0 + F_{p-1}( M ), where the latter, by construction,
    ## 1) is isomorphic to F_p( M ) and
    ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
    chi := CokernelEpi( emb );
    
    ## the isomorphism between Cokernel( K_1 -> P_0 + F_{p-1}( M ) ) and F_p( M ),
    ## where the former is, by contruction, equipped with a presentation
    ## adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
    alpha := PreDivide( chi, epi );
    
    ## freeze the computed triangular presentation
    LockObjectOnCertainPresentation( Source( alpha ) );
    
    Assert( 1, IsIsomorphism( alpha ) );
    
    SetIsIsomorphism( alpha, true );
    
    return alpha;
    
end );

##
InstallMethod( FilteredByPurity,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    local filt;
    
    filt := PurityFiltration( M );
    
    return OnPresentationAdaptedToFiltration( filt );
    
end );
