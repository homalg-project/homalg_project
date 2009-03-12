#############################################################################
##
##  Filtrations.gi              homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for (spectral) filtrations.
##
#############################################################################

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

