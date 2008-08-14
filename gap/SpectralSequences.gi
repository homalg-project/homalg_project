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
    local F, G, P, GP, CE, FCE, BC, Tot, H, I_E, tBC, II_E, I_E2, II_E2,
          II_E_infinity, grothendieck0, grothendieck1, grothendieck2,
          i, pq, p, q, tot_embs, gen_emb0, gen_emb1, gen_emb2, gen_emb,
          monomorphism_modulo_myimage;
    
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
    
    ## the (co)homology graded object of the total complex:
    H := DefectOfExactness( Tot );
    
    ## test for zero defects in H:
    IsZero( H );
    
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
    
    grothendieck0 := rec( );
    grothendieck1 := rec( );
    grothendieck2 := rec( );
    
    for i in ObjectDegreesOfComplex( Tot ) do
        if IsBound( CertainObject( Tot, i )!.EmbeddingsInObjectOfTotalComplex ) then
            tot_embs := CertainObject( Tot, i )!.EmbeddingsInObjectOfTotalComplex;
        else
            tot_embs := fail;
        fi;
        
        gen_emb0 := CertainObject( H, i )!.NaturalEmbedding;
        
        for pq in BiDegreesOfObjectOfTotalComplex( BC, i ) do
            
            q := pq[1];		## we flip p and q of the bicomplex since we take
            p := pq[2];		## the second spectral sequence as our reference
            
            gen_emb1 := I_E2!.absolute_embeddings.(String([ q, p ]));			## note the flip [ q, p ]
            gen_emb2 := II_E_infinity!.absolute_embeddings.(String([ p, q ]));
            
            if tot_embs <> fail then
                gen_emb1 := PreCompose( gen_emb1, tot_embs.(String([ q, p ])) );	## note the flip [ q, p ]
                gen_emb2 := PreCompose( gen_emb2, tot_embs.(String([ q, p ])) );	## note the flip [ q, p ]
            fi;
            
            gen_emb1 := gen_emb1 / gen_emb0;
            IsIsomorphism( gen_emb1 );
            
            gen_emb2 := gen_emb2 / gen_emb0;
            IsMonomorphism( gen_emb2 );
            
            grothendieck1.(String([ q, p ])) := gen_emb1;				## note the flip [ q, p ]
            grothendieck2.(String([ p, q ])) := gen_emb2;
            
        od;
        
        if i >= 0 then
            monomorphism_modulo_myimage := 0;
            for pq in Reversed( BiDegreesOfObjectOfTotalComplex( BC, i ) ) do		## note the "Reversed"
                
                q := pq[1];		## we flip p and q of the bicomplex since we take
                p := pq[2];		## the second spectral sequence as our reference
                
                gen_emb := grothendieck2.(String([ p, q ])) / grothendieck1.(String([ i, 0 ]));
                
                if IsHomalgMap( monomorphism_modulo_myimage ) then
                    SetMonomorphismModuloImage( gen_emb, monomorphism_modulo_myimage );
                    monomorphism_modulo_myimage := StackMaps( monomorphism_modulo_myimage, gen_emb );
                else
                    monomorphism_modulo_myimage := gen_emb;
                fi;
                
                ## IsIsomorphism would first checks IsEpimorphism and if false
                ## it would simply returns false without cheching IsMonomorphism
                IsMonomorphism( gen_emb );
                IsEpimorphism( gen_emb );
                
                IsGeneralizedEmbedding( gen_emb );
                
                grothendieck0.(String([ p, q ])) := gen_emb;
                
            od;
        fi;
    od;
    
    ## first enrich I_E
    SetGeneralizedEmbeddingsInTotalDefects( I_E, grothendieck1 );
    
    ## now its time to enrich II_E
    SetGeneralizedEmbeddingsInTotalDefects( II_E, grothendieck2 );
    
    ## even with
    II_E!.FirstSpectralSequence := I_E;
    
    ## and finally
    II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence := grothendieck0;
    
    return II_E;
    
end );

##
InstallMethod( GeneralizedEmbeddingsInStableSecondSheetOfI_E,
        "for Grothendieck spectral sequences",
        [ IsSpectralSequenceOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( II_E, p )
    local gen_embs, BC, bidegrees, gen_embs_p, gen_emb, pq;
    
    if IsBound( II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence ) then
        
        gen_embs := II_E!.GeneralizedEmbeddingsInStableSecondSheetOfFirstSpectralSequence;
        
        BC := UnderlyingBicomplex( II_E );
        
        bidegrees := BiDegreesOfObjectOfTotalComplex( BC, p );
        
        gen_embs_p := rec( bidegrees := bidegrees );
        
        for pq in Reversed( bidegrees ) do
            if IsBound( gen_embs!.(String( pq )) ) then
                gen_embs_p.(String( AbsInt( pq[1] ))) := gen_embs!.(String( pq ));
            fi;
        od;
        
        return gen_embs_p;
        
    fi;
    
    return fail;
    
end );

##
InstallMethod( GeneralizedEmbeddingsInStableSecondSheetOfI_E,
        "for Grothendieck spectral sequences",
        [ IsSpectralSequenceOfFinitelyPresentedObjectsRep ],
        
  function( II_E )
    
    return GeneralizedEmbeddingsInStableSecondSheetOfI_E( II_E, 0 );
    
end );
