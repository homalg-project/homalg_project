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
InstallMethod( GrothendieckSpectralSequence,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep ],
        
  function( Functor_F, Functor_G, M )
    local F, G, P, GP, CE, FCE, BC, Tot, I_E, tBC, II_E, I_E2, II_E2,
          II_E_infinity, grothendieck, grothendieck1, grothendieck2,
          co, n, Totn, bidegrees, l, pq, p, q, tot_embs, monomorphism_aid_map1,
          gen_emb1, gen_emb2, I_En, gen_emb, monomorphism_aid_map, gen_map;
    
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
    
    ## the associated total complex
    Tot := TotalComplex( BC );
    
    ## the spectral sequence associated to BC,
    ## also called the first spectral sequence of the bicomplex BC;
    ## its limit sheet is the second sheet,
    ## where it also becomes intrinsic (in the abelian category)
    I_E := HomalgSpectralSequence( BC );
    
    ## the transposed bicomplex associated to FCE
    tBC := TransposedBicomplex( BC );
    
    ## the spectral sequence associated to tBC,
    ## also called the second spectral sequence of the bicomplex BC;
    ## it becomes intrinsic at the second level R^(-p) F R^q G => L_(p+q) FG
    II_E := HomalgSpectralSequence( 2, tBC );
    
    ## the limit sheet of the first spectral sequence
    I_E2 := CertainSheet( I_E, 2 );
    
    ## the intrinsic sheet of the second spectral sequence
    II_E2 := CertainSheet( II_E, 2 );
    
    ## the limit sheet of the second spectral sequence
    II_E_infinity := HighestLevelSheetInSpectralSequence( II_E );
    
    grothendieck := rec( );
    grothendieck1 := rec( );
    grothendieck2 := rec( );
    
    if IsComplexOfFinitelyPresentedObjectsRep( Tot ) then
        co := 1;
    else
        co := -1;
    fi;
    
    for n in Filtered( ObjectDegreesOfComplex( Tot ), j -> j >= 0 ) do	## the (co)homologies vanish in negative total degrees
        
        Totn := CertainObject( Tot, n );
        
        ## the embeddings from BC^{p,q} -> Tot^n
        if IsBound( Totn!.EmbeddingsInObjectOfTotalComplex ) then
            tot_embs := Totn!.EmbeddingsInObjectOfTotalComplex;
        else
            tot_embs := fail;	## happens at the ends of the total complex
        fi;
        
        ## for the first spectral sequence I_E
        gen_emb1 := I_E2!.absolute_embeddings.(String([ n, 0 ]));
        
        if tot_embs <> fail then
            gen_emb1 := PreCompose( gen_emb1, tot_embs.(String([ n, 0 ])) );
        fi;
        
        ## CertainMorphism( Tot, n + co ) is the minimum of what
        ## gen_emb1 needs to master the lifts below
        gen_emb1 := AddToMorphismAidMap( gen_emb1, CertainMorphism( Tot, n + co ) );
        
        ## store the morphism aid map
        if HasMorphismAidMap( gen_emb1 ) then
            monomorphism_aid_map1 := MorphismAidMap( gen_emb1 );
        else
            monomorphism_aid_map1 := 0;
        fi;
        
        ## check assertion
        Assert( 1, IsGeneralizedMonomorphism( gen_emb1 ) );
        
        SetIsGeneralizedMonomorphism( gen_emb1, true );
        
        grothendieck1.(String([ n, 0 ])) := gen_emb1;
        
        ## for the second spectral sequence II_E
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        l := Length( bidegrees );
        
        for pq in bidegrees do
            
            q := pq[1];		## we flip p and q of the bicomplex since we take
            p := pq[2];		## the second spectral sequence as our reference
            
            gen_emb2 := II_E_infinity!.absolute_embeddings.(String([ p, q ]));
            
            if tot_embs <> fail then
                gen_emb2 := PreCompose( gen_emb2, tot_embs.(String([ q, p ])) );	## note the flip [ q, p ]
            fi;
            
            ## check assertion
            Assert( 1, IsGeneralizedMonomorphism( gen_emb2 ) );
            
            SetIsGeneralizedMonomorphism( gen_emb2, true );
            
            grothendieck2.(String([ p, q ])) := gen_emb2;
            
        od;
        
        ## this is necessary for handling not only homological
        ## but also cohomological spectral sequences
        if IsSpectralSequenceOfFinitelyPresentedObjectsRep( II_E ) then
            bidegrees := Reversed( bidegrees );			## note the "Reversed"
        fi;
        
        ## prepare a copy of gen_emb1 without the morphism aid map
        ## (will be added below)
        I_En := Source( gen_emb1 );
        
        gen_emb1 := HomalgMap( MatrixOfMap( gen_emb1 ), I_En, Totn );
        
        monomorphism_aid_map := 0;
        
        ## contruct the generalized embeddings filtering
        ## I_E^{n,0} = H^n( Tot( BC ) ) by II_E^{p,q}
        for pq in bidegrees do
            
            q := pq[1];		## we flip p and q of the bicomplex since we take
            p := pq[2];		## the second spectral sequence as our reference
            
            gen_emb2 := grothendieck2.(String([ p, q ]));
            
            ## prepare gen_emb1 to master the coming lift
            gen_emb1 := AddToMorphismAidMap( gen_emb1, monomorphism_aid_map1 );		## this works without side effects
            
            ## check assertion
            Assert( 1, IsGeneralizedMorphism( gen_emb1 ) );
            
            SetIsGeneralizedMorphism( gen_emb1, true );
            
            ## gen_emb1 now has enough aid
            ## to lift gen_emb2 (literal and unliteral)
            gen_emb := gen_emb2 / gen_emb1;
            
            ## this last line is one of the highlights in the code,
            ## where generalized embeddings play a decisive role
            ## (see the functors PostDivide and Compose)
            
            ## prepare for the next step
            monomorphism_aid_map1 := gen_emb2;
            
            ## start to make the gen_emb's the generalized embeddings
            ## of the filtration induced by the second spectral sequence
            gen_map := OnAFreeSource( gen_emb );
            
            if IsHomalgMap( monomorphism_aid_map ) then
                ## add monomorphism_aid_map from the previous set
                SetMorphismAidMap( gen_emb, monomorphism_aid_map );
                
                ## for the next step
                monomorphism_aid_map := StackMaps( monomorphism_aid_map, gen_map );
            else
                ## the initial step
                monomorphism_aid_map := gen_map;
            fi;
            
            ## IsIsomorphism would first checks IsEpimorphism and if false
            ## it would simply return false without cheching IsMonomorphism
            IsEpimorphism( gen_emb );
            IsMonomorphism( gen_emb );
            
            ## at least the lowest one is a generalized isomrphism
            IsGeneralizedIsomorphism( gen_emb );
            
            ## check assertion
            Assert( 1, IsGeneralizedMonomorphism( gen_emb ) );
            
            SetIsGeneralizedMonomorphism( gen_emb, true );
            
            grothendieck.(String([ p, q ])) := gen_emb;
            
        od;
        
        ## the lowest one is a generalized isomorphism
        p := bidegrees[l][2];
        q := bidegrees[l][1];
        
        ## check assertion
        Assert( 1, IsGeneralizedIsomorphism( grothendieck.(String([ p, q ])) ) );
        
        SetIsGeneralizedIsomorphism( grothendieck.(String([ p, q ])), true );
        
        ## the higest one is a monomorphism
        p := bidegrees[1][2];
        q := bidegrees[1][1];
        
        ## check assertion
        Assert( 1, IsMonomorphism( grothendieck.(String([ p, q ])) ) );
        
        SetIsMonomorphism( grothendieck.(String([ p, q ])), true );
        
    od;
    
    ## first enrich I_E
    SetGeneralizedEmbeddingsInTotalObjects( I_E, grothendieck1 );
    
    ## now its time to enrich II_E
    SetGeneralizedEmbeddingsInTotalObjects( II_E, grothendieck2 );
    
    ## even with
    II_E!.FirstSpectralSequence := I_E;
    
    ## and finally
    II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence := grothendieck;
    
    return II_E;
    
end );

##
InstallMethod( FiltrationOfObjectInStableSecondSheetOfI_E,
        "for Grothendieck spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsInt ],
        
  function( II_E, n )
    local gen_embs, BC, bidegrees, degrees, gen_embs_n, gen_emb, pq;
    
    if IsBound( II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence ) then
        
        gen_embs := II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence;
        
        BC := UnderlyingBicomplex( II_E );
        
        bidegrees := Reversed( BidegreesOfObjectOfTotalComplex( BC, n ) );
        
        degrees := List( bidegrees, a -> AbsInt( a[1] ) );
        
        gen_embs_n := rec( degrees := degrees,
                           bidegrees := bidegrees );
        
        for pq in bidegrees do
            if IsBound( gen_embs!.(String( pq )) ) then
                gen_embs_n.(String( AbsInt( pq[1] ))) := gen_embs!.(String( pq ));
            fi;
        od;
        
        if IsSpectralSequenceOfFinitelyPresentedObjectsRep( II_E ) then
            return HomalgDescendingFiltration( gen_embs_n, IsFiltration, true );
        else
            return HomalgAscendingFiltration( gen_embs_n, IsFiltration, true );
        fi;
        
    fi;
    
    return fail;
    
end );

##
InstallMethod( FiltrationOfObjectInStableSecondSheetOfI_E,
        "for Grothendieck spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( II_E )
    
    return FiltrationOfObjectInStableSecondSheetOfI_E( II_E, 0 );
    
end );

##
InstallMethod( PurityFiltration,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( M )
    local R, Functor_R_Hom, Functor_Hom_R, II_E, filt;
    
    R := HomalgRing( M );
    
    Functor_R_Hom := LeftDualizingFunctor( R );		# Hom(-,R) for left modules
    Functor_Hom_R := RightDualizingFunctor( R );	# Hom(-,R) for right modules
    
    II_E := GrothendieckSpectralSequence( Functor_Hom_R, Functor_R_Hom, M );
    
    filt := FiltrationOfObjectInStableSecondSheetOfI_E( II_E );
    
    Perform( DegreesOfFiltration( filt ), function( p ) local L; L := CertainObject( filt, p ); if not IsZero( L ) then SetCodimOfModule( L, p ); SetIsPure( L, true ); ByASmallerPresentation( L ); fi; end );
    
    SetIsPurityFiltration( filt, true );
    
    return filt;
    
end );

##
InstallMethod( PurityFiltration,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( M )
    local R, Functor_R_Hom, Functor_Hom_R, II_E, filt;
    
    R := HomalgRing( M );
    
    Functor_R_Hom := LeftDualizingFunctor( R );		# Hom(-,R) for left modules
    Functor_Hom_R := RightDualizingFunctor( R );	# Hom(-,R) for right modules
    
    II_E := GrothendieckSpectralSequence( Functor_R_Hom, Functor_Hom_R, M );
    
    filt := FiltrationOfObjectInStableSecondSheetOfI_E( II_E );
    
    Perform( DegreesOfFiltration( filt ), function( p ) local L; L := CertainObject( filt, p ); if not IsZero( L ) then SetCodimOfModule( L, p ); SetIsPure( L, true ); ByASmallerPresentation( L ); fi; end );
    
    SetIsPurityFiltration( filt, true );
    
    return filt;
    
end );

