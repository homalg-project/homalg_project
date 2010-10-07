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
    local M, non_zero_p, l, p, M0;
    
    M := UnderlyingObject( filt );
    
    ## set different porperties and attributes of the pure parts
    Perform( DegreesOfFiltration( filt ),
        function( p )
            local L;
            L := CertainObject( filt, p );
            if not IsZero( L ) then
                SetGrade( L, -p );
                SetIsPure( L, true );
            fi;
        end );
    
    non_zero_p := Filtered( DegreesOfFiltration( filt ), p -> not IsZero( CertainObject( filt, p ) ) );
    
    l := Length( non_zero_p );
    
    ## if only one graded part is non-trivial, the object M is pure
    if l > 0 then
        p := non_zero_p[l];
        
        SetGrade( M, -p );
        
        if l = 1 then
            SetIsPure( M, true );
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
        
  function( M )
    local R, F, G, II_E, filt, I_E, iso;
    
    ## does not set the attribute PurityFiltration
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        F := RightDualizingFunctor( R );	# Hom(-,R) for right objects
        G := LeftDualizingFunctor( R );		# Hom(-,R) for left objects
    else
        F := LeftDualizingFunctor( R );		# Hom(-,R) for left objects
        G := RightDualizingFunctor( R );	# Hom(-,R) for right objects
    fi;
    
    II_E := GrothendieckSpectralSequence( F, G, M, [ 0 ] );
    
    ## the underlying object of this filtraton is L_0( (R^0 F) G )( M )
    ## and not M
    filt := FiltrationBySpectralSequence( II_E );
    
    ## construct the isomorphism
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FG( M ) -> M:
    
    ## the associated first spectral sequence
    I_E := AssociatedFirstSpectralSequence( II_E );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M )
    iso := I_E!.NaturalTransformations.(String( [ 0, 0 ] ));
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FreeHull( FG( M ) )
    iso := PreCompose( iso, I_E!.NaturalGeneralizedEmbeddings.(String( [ 0, 0 ])) );
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FreeHull( FG( M ) ) -> FreeHull( M )
    iso := iso / NatTrIdToHomHom_R( HullObjectInResolution( M ) );	## lift
    
    ## L_0( (R^0 F) G )( M ) -> L_0( FG )( M ) -> FreeHull( FG( M ) ) -> FreeHull( M ) -> M
    ## finally giving the isomorphism
    ## L_0( (R^0 F) G )( M ) -> M
    iso := PreCompose( iso, FreeHullEpi( M ) );
    
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
    
    SetSpectralSequence( filt, II_E );
    
    SetAttributesByPurityFiltration( filt );
    
    SetAttributesByPurityFiltrationViaBidualizingSpectralSequence( filt );
    
    return filt;
    
end );

##
InstallMethod( PurityFiltration,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return PurityFiltrationViaBidualizingSpectralSequence( M );
    
end );

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
InstallMethod( FilteredByPurity,
        "for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    local filt;
    
    filt := PurityFiltration( M );
    
    return OnPresentationAdaptedToFiltration( filt );
    
end );
