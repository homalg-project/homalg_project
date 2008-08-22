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
        "for homalg maps",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsFinitelyPresentedModuleRep ],
        
  function( Functor_F, Functor_G, M )
    local F, G, P, GP, CE, FCE, BC, Tot, I_E, tBC, II_E, I_E2, II_E2,
          II_E_infinity, grothendieck, grothendieck1, grothendieck2,
          co, n, ToTn, bidegrees, l, pq, p, q, tot_embs, gen_emb0,
          gen_emb1, gen_emb2, gen_emb, monomorphism_aid_map, gen_map;
    
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
        
        ToTn := CertainObject( Tot, n );
        
        if IsBound( ToTn!.EmbeddingsInObjectOfTotalComplex ) then
            tot_embs := ToTn!.EmbeddingsInObjectOfTotalComplex;
        else
            tot_embs := fail;	## happens at the ends of the total complex
        fi;
        
        monomorphism_aid_map := CertainMorphism( Tot, n + co );
        
        ## for the first spectral sequence I_E
        gen_emb1 := I_E2!.absolute_embeddings.(String([ n, 0 ]));
        
        if tot_embs <> fail then
            gen_emb1 := PreCompose( gen_emb1, tot_embs.(String([ n, 0 ])) );
        fi;
        
        if IsHomalgMap( monomorphism_aid_map ) then
            if HasMorphismAidMap( gen_emb1 ) then
                gen_emb1!.MorphismAidMap := StackMaps( MorphismAidMap( gen_emb1 ), monomorphism_aid_map );
            else
                SetMorphismAidMap( gen_emb1, monomorphism_aid_map );
            fi;
        fi;
        
        ## check assertion
        Assert( 1, IsGeneralizedMonomorphism( gen_emb1 ) );
        
        SetIsGeneralizedMonomorphism( gen_emb1, true );
        
        grothendieck1.(String([ n, 0 ])) := gen_emb1;
        
        ## for the second spectral sequence II_E
        bidegrees := BidegreesOfObjectOfTotalComplex( BC, n );
        
        l := Length( bidegrees );
        
        monomorphism_aid_map := 0;
        
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
        
        monomorphism_aid_map := 0;
        
        ## contruct the generalized embeddings filtering
        ## I_E^{n,0} = H^n( Tot( BC ) ) by II_E^{p,q}
        for pq in Reversed( bidegrees ) do		## note the "Reversed"
            
            q := pq[1];		## we flip p and q of the bicomplex since we take
            p := pq[2];		## the second spectral sequence as our reference
            
            gen_emb := grothendieck2.(String([ p, q ])) / grothendieck1.(String([ n, 0 ]));
            
            ## start to make the gen_emb's the generalized embeddings
            ## of the filtration induced by the second spectral sequence
            gen_map := HomalgMap( MatrixOfMap( gen_emb ), "free", Range( gen_emb ) );
            
            if IsHomalgMap( monomorphism_aid_map ) then
                SetMorphismAidMap( gen_emb, monomorphism_aid_map );
                monomorphism_aid_map := StackMaps( monomorphism_aid_map, gen_map );
            else
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
        p := bidegrees[1][2];
        q := bidegrees[1][1];
        
        ## check assertion
        Assert( 1, IsGeneralizedIsomorphism( grothendieck.(String([ p, q ])) ) );
        
        SetIsGeneralizedIsomorphism( grothendieck.(String([ p, q ])), true );
        
        ## the higest one is a monomorphism
        p := bidegrees[l][2];
        q := bidegrees[l][1];
        
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
        [ IsSpectralSequenceOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( II_E, p )
    local gen_embs, BC, bidegrees, degrees, gen_embs_p, gen_emb, pq;
    
    if IsBound( II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence ) then
        
        gen_embs := II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence;
        
        BC := UnderlyingBicomplex( II_E );
        
        bidegrees := Reversed( BidegreesOfObjectOfTotalComplex( BC, p ) );
        
        degrees := List( bidegrees, a -> AbsInt( a[1] ) );
        
        gen_embs_p := rec( degrees := degrees,
                           bidegrees := bidegrees );
        
        for pq in bidegrees do
            if IsBound( gen_embs!.(String( pq )) ) then
                gen_embs_p.(String( AbsInt( pq[1] ))) := gen_embs!.(String( pq ));
            fi;
        od;
        
        return HomalgDescendingFiltration( gen_embs_p, IsFiltration, true );
        
    fi;
    
    return fail;
    
end );

##
InstallMethod( FiltrationOfObjectInStableSecondSheetOfI_E,
        "for Grothendieck spectral sequences",
        [ IsSpectralSequenceOfFinitelyPresentedObjectsRep ],
        
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

