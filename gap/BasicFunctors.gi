#############################################################################
##
##  BasicFunctors.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for basic functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## additive functors [HS. Prop. II.9.5] preserves chain complexes [HS. p. 118]
## half exact functors are additive [HS. p. 132 & Ex. IV.5.8]
## a right adjoint functor is left exact [W. Thm. 2.6.1]
## a left adjoint functor is right exact [W. Thm. 2.6.1]
##

##
InstallMethod( CokernelNaturalGeneralizedIsomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local coker, emb;
    
    coker := Cokernel( phi );
    
    ## sometimes a module is automatically assigned to a map as its Cokernel:
    ## this happens when M is resolved with F_0 --(d_0)--> M --> 0, then M is automatically assigned as the cokernel of d_0,
    ## and the component coker!.NaturalGeneralizedEmbedding is not set
    if IsBound( coker!.NaturalGeneralizedEmbedding ) then
        emb := NaturalGeneralizedEmbedding( coker );
    fi;
    
    ## since the cokernel module can very well be predefined as the outcome of a different functor than Cokernel
    ## (for example Resolution (of modules and complexes) sets CokernelEpi automatically!):
    if not ( IsBound( emb ) and IsIdenticalObj( Range( emb ), Source( phi ) ) ) then
        
        emb := GeneralizedInverse( CokernelEpi( phi ) );
        
    fi;
    
    return emb;
    
end );

##
InstallMethod( ImageObjectEpi,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local emb, epi, ker_emb;
    
    emb := ImageObjectEmb( phi );
    
    epi := phi / emb;	## lift
    
    ## check assertion
    Assert( 4, IsEpimorphism( epi ) );
    
    SetIsEpimorphism( epi, true );
    
    ## Abelian category: [HS, Prop. II.9.6]
    if HasKernelEmb( phi ) then
        ker_emb := KernelEmb( phi );
        SetKernelEmb( epi, ker_emb );
        if not HasCokernelEpi( ker_emb ) then
            SetCokernelEpi( ker_emb, epi );
        fi;
    fi;
    
    return epi;
    
end );

##
## Kernel
##

InstallGlobalFunction( _Functor_Kernel_OnObjects,	### defines: Kernel(Emb)
  function( psi )
    local S, ker_subobject, ker, emb, img_epi, T, coker, im;
    
    if HasKernelEmb( psi ) then
        return Source( KernelEmb( psi ) );
    fi;
    
    S := Source( psi );
    
    ## in case of modules: this involves computing relative syzygies:
    ker_subobject := KernelSubobject( psi );
    
    ## in case of modules: this involves a second syzygies computation:
    ## (the number of generators of ker might be less than the number of generators of ker_subobject)
    ker := UnderlyingObject( ker_subobject );
    
    ## the natural embedding of ker in Source( psi ):
    emb := EmbeddingInSuperObject( ker_subobject );
    
    ## set the attribute KernelEmb (specific for Kernel):
    SetKernelEmb( psi, emb );
    
    #=====# end of the core procedure #=====#
    
    ## Abelian category: [HS, Prop. II.9.6]
    if HasImageObjectEpi( psi ) then
        img_epi := ImageObjectEpi( psi );
        SetCokernelEpi( emb, img_epi );
        if not HasKernelEmb( img_epi ) then
            SetKernelEmb( img_epi, emb );
        fi;
    elif HasIsEpimorphism( psi ) and IsEpimorphism( psi ) then
        SetCokernelEpi( emb, psi );
    fi;
    
    ## save the natural embedding in the kernel (thanks GAP):
    ker!.NaturalGeneralizedEmbedding := emb;
    
    ## figure out an upper bound for the projective dimension of ker:
    if not HasProjectiveDimension( ker ) and HasIsProjective( S ) and IsProjective( S ) then
        T := Range( psi );
        if HasIsProjective( T ) and IsProjective( T ) then	## typical for M^* which is a K_2(D(M)) (up to projective equivalence)
            SetUpperBoundForProjectiveDimension( ker, -2 );	## since ker = K_2( coker )
            if HasCokernelEpi( psi ) then
                coker := Range( CokernelEpi( psi ) );		## S & T projective, then pd( ker ) = pd( coker ) - 2
                if HasProjectiveDimension( coker ) then
                    SetProjectiveDimension( ker, Maximum( 0, ProjectiveDimension( coker ) - 2 ) );
                elif IsBound( coker!.UpperBoundForProjectiveDimension ) then
                    SetUpperBoundForProjectiveDimension( ker, coker!.UpperBoundForProjectiveDimension - 2 );
                fi;
            elif HasImageObjectEmb( psi ) then
                im := Source( ImageObjectEmb( psi ) );	## S projective, then pd( ker ) = pd( im ) - 1
                if HasProjectiveDimension( im ) then
                    SetProjectiveDimension( ker, Maximum( 0, ProjectiveDimension( im ) - 1 ) );
                elif IsBound( im!.UpperBoundForProjectiveDimension ) then
                    SetUpperBoundForProjectiveDimension( ker, im!.UpperBoundForProjectiveDimension - 1 );
                fi;
            fi;
        else
            SetUpperBoundForProjectiveDimension( ker, -1 );	## since ker = K_1( im )
            if HasImageObjectEmb( psi ) then
                im := Source( ImageObjectEmb( psi ) );	## S projective, then pd( ker ) = pd( im ) - 1
                if HasProjectiveDimension( im ) then
                    SetProjectiveDimension( ker, Maximum( 0, ProjectiveDimension( im ) - 1 ) );
                elif IsBound( im!.UpperBoundForProjectiveDimension ) then
                    SetUpperBoundForProjectiveDimension( ker, im!.UpperBoundForProjectiveDimension - 1 );
                fi;
            fi;
        fi;
    fi;
    
    return ker;
    
end );

##  <#GAPDoc Label="functor_Kernel:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_Kernel,
        CreateHomalgFunctor(
                [ "name", "Kernel" ],
                [ "operation", "Kernel" ],
                [ "natural_transformation", "KernelEmb" ],
                [ "special", true ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep,
                          [ IsHomalgChainMap, IsKernelSquare ] ] ] ],
                [ "OnObjects", _Functor_Kernel_OnObjects ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_Kernel!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## DefectOfExactness
##

InstallGlobalFunction( _Functor_DefectOfExactness_OnObjects,	### defines: DefectOfExactness (DefectOfHoms)
  function( cpx_post_pre )
    local pre, post;
    
    if not IsATwoSequence( cpx_post_pre ) then
        Error( "expecting a complex containing two morphisms marked as IsATwoSequence\n" );
    fi;
    
    pre := HighestDegreeMorphism( cpx_post_pre );
    post := LowestDegreeMorphism( cpx_post_pre );
    
    return KernelSubobject( post ) / ImageSubobject( pre );
    
end );

##  <#GAPDoc Label="Functor_DefectOfExactness:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_DefectOfExactness,
        CreateHomalgFunctor(
                [ "name", "DefectOfExactness" ],
                [ "operation", "DefectOfExactness" ],
                [ "special", true ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsHomalgComplex and IsATwoSequence,
                          [ IsHomalgChainMap, IsLambekPairOfSquares ] ] ] ],
                [ "OnObjects", _Functor_DefectOfExactness_OnObjects ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_DefectOfExactness!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

functor_DefectOfExactness!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

## for convenience
InstallMethod( DefectOfExactness,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi, psi )
    
    return DefectOfExactness( AsATwoSequence( phi, psi ) );
    
end );

####################################
#
# methods for operations & attributes:
#
####################################

##
## Kernel( phi ) and KernelEmb( phi )
##

##  <#GAPDoc Label="functor_Kernel">
##  <ManSection>
##    <Var Name="functor_Kernel"/>
##    <Description>
##      The functor that associates to a map its kernel.
##      <#Include Label="functor_Kernel:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Kernel:map">
##  <ManSection>
##    <Oper Arg="phi" Name="Kernel" Label="for maps"/>
##    <Description>
##      The following example also makes use of the natural transformation <C>KernelEmb</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -3, -6, \
##  > 0, 1,  6, 11, \
##  > 1, 0, -3, -6  \
##  > ]", 3, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> ker := Kernel( phi );
##  <A cyclic left module presented by yet unknown relations for a cyclic generato\
##  r>
##  gap> Display( ker );
##  Z/< -3 >
##  gap> ByASmallerPresentation( last );
##  <A cyclic torsion left module presented by 1 relation for a cyclic generator>
##  gap> Display( ker );
##  Z/< 3 >
##  gap> iota := KernelEmb( phi );
##  <A monomorphism of left modules>
##  gap> Display( iota );
##  [ [  0,  2,  4 ] ]
##  
##  the map is currently represented by the above 1 x 3 matrix
##  gap> DefectOfExactness( iota, phi );
##  <A zero left module>
##  gap> ByASmallerPresentation( iota );
##  <A monomorphism of left modules>
##  gap> Display( iota );
##  [ [  2,  0 ] ]
##  
##  the map is currently represented by the above 1 x 2 matrix
##  gap> PostInverse( iota );
##  false
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctor( functor_Kernel );

##
## DefectOfExactness( cpx_post_pre )
##

##  <#GAPDoc Label="functor_DefectOfExactness">
##  <ManSection>
##    <Var Name="functor_DefectOfExactness"/>
##    <Description>
##      The functor that associates to a pair of composable maps with a zero compositum the defect of exactness,
##      i.e. the kernel of the outer map modulo the image of the inner map.
##      <#Include Label="Functor_DefectOfExactness:code">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DefectOfExactness">
##  <ManSection>
##    <Oper Arg="phi, psi" Name="DefectOfExactness"/>
##    <Description>
##      We follow the associative convention for applying maps.
##      For left modules <A>phi</A> is applied first and from the right.
##      For right modules <A>psi</A> is applied first and from the left.
##      <P/>
##      The following example also makes use of the natural transformation <C>KernelEmb</C>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4, 0,   5, 6, 7, 0 ]", 2, 4, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );;
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 3,  3,  3, \
##  > 0, 3, 10, 17, \
##  > 1, 3,  3,  3, \
##  > 0, 0,  0,  0  \
##  > ]", 4, 4, ZZ );;
##  gap> phi := HomalgMap( mat, M, N );;
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> iota := KernelEmb( phi );
##  <A monomorphism of left modules>
##  gap> DefectOfExactness( iota, phi );
##  <A zero left module>
##  gap> hom_iota := Hom( iota );	## a shorthand for Hom( iota, ZZ );
##  <A homomorphism of right modules>
##  gap> hom_phi := Hom( phi );	## a shorthand for Hom( phi, ZZ );
##  <A homomorphism of right modules>
##  gap> DefectOfExactness( hom_iota, hom_phi );
##  <A cyclic right module on a cyclic generator satisfying yet unknown relations>
##  gap> ByASmallerPresentation( last );
##  <A cyclic torsion right module on a cyclic generator satisfying 1 relation>
##  gap> Display( last );
##  Z/< 2 >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallFunctor( functor_DefectOfExactness );

