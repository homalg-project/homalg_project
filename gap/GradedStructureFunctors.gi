#############################################################################
##
##  GradedStructureFunctors.gi                         Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for some other graded functors.
##
#############################################################################

##  <#GAPDoc Label="BasisOfHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="BasisOfHomogeneousPart"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The resulting &homalg; matrix consists of a <M>R</M>-basis of the <A>d</A>-th homogeneous part
##      of the finitely generated &homalg; <M>S</M>-module <A>M</A>, where <M>R</M> is the ground ring
##      of the graded ring <M>S</M> with <M>S_0=R</M>.
##      <#Include Label="BasisOfHomogeneousPart:example">
##  Compare with <Ref Oper="MonomialMap"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfHomogeneousPart,
        "for homalg modules",
        [ IsInt, IsHomalgModule ],
        
  function( d, M )
    local homogeneous_parts, p, bases, p_old, T, M_d, diff, bas, source;
    
    if IsBound( M!.HomogeneousParts ) then
      homogeneous_parts := M!.HomogeneousParts;
    else
      homogeneous_parts := rec( );
      M!.HomogeneousParts := homogeneous_parts;
    fi;
    
    p := PositionOfTheDefaultPresentation( M );
    
    if IsBound( homogeneous_parts!.(d) ) then
    
        bases := homogeneous_parts!.(d);
        
        if IsBound( bases.(String( p )) ) then
            return bases.(String( p ));
        fi;
        
        p_old := Int( RecNames( bases )[1] );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            T := TransitionMatrix( M, p_old, p );
            bas := bases.(String( p_old )) * T;
        else
            T := TransitionMatrix( M, p, p_old );
            bas := T * bases.(String( p_old ));
        fi;
        
    else
    
        bases := rec( );
        homogeneous_parts!.(d) := bases;
    
        ## the map of generating monomials of degree d
        M_d := MonomialMap( d, M );
        
        ## the matrix of generating monomials of degree d
        M_d := MatrixOfMap( M_d );
        
        ## the basis monomials are not altered by reduction
        diff := M_d - DecideZero( M_d, M );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            bas := ZeroRows( diff );
            bas := CertainRows( M_d, bas );
        else
            bas := ZeroColumns( diff );
            bas := CertainColumns( M_d, bas );
        fi;
    
    fi;
    
    bases.(String( p )) := bas;
    
    return bas;
    
end );

##
## RepresentationMatrixOfRingElement
##

##  <#GAPDoc Label="RepresentationMatrixOfRingElement">
##  <ManSection>
##    <Oper Arg="r, M, d" Name="RepresentationMatrixOfRingElement"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The &homalg; matrix induced by the homogeneous degree <E><M>1</M></E> ring element <A>r</A>
##      (of the underlying &homalg; graded ring <M>S</M>) regarded as a <M>R</M>-linear map
##      between the <A>d</A>-th and the <M>(</M><A>d</A><M>+1)</M>-st homogeneous part of the finitely generated
##      &homalg; <M>S</M>-module <M>M</M>, where <M>R</M> is the ground ring of the graded ring <M>S</M>
##      with <M>S_0=R</M>. The basis of both vector spaces is given by <Ref Oper="BasisOfHomogeneousPart"/>. The
##      entries of the matrix lie in the ground ring <M>R</M>.
##      <#Include Label="RepresentationMatrixOfRingElement:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( _Functor_RepresentationMatrixOfRingElement_OnGradedModules , ### defines: RepresentationMatrixOfRingElement (object part)
        [ IsList, IsHomalgModule ],
        
  function( l, M )
    local r, d, bd, bdp1;
    
    if Length( l ) <> 2 then
        Error( "expected a ring element and an integer as zeroth parameter" );
    fi;
    
    r := l[1];
    d := l[2];
    
    if not IsRingElement( r ) or not IsInt( d ) then
        Error( "expected a ring element and an integer as zeroth parameter" );
    fi;
  
    bd := BasisOfHomogeneousPart( d, M );
    
    bdp1 := BasisOfHomogeneousPart( d + 1, M );
    
    bd := r * bd;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return RightDivide( bd, bdp1, MatrixOfRelations( M ) );
    else
        return LeftDivide( bdp1, bd, MatrixOfRelations( M ) );
    fi;
    
end );

InstallMethod( RepresentationMatrixOfRingElement,
        "for homalg ring elements",
        [ IsRingElement, IsHomalgModule, IsInt ],
        
  function( r, M, d )
    
    return RepresentationMatrixOfRingElement( [ r, d ], M );
    
end );

InstallValue( Functor_RepresentationMatrixOfRingElement_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "RepresentationMatrixOfRingElement" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "RepresentationMatrixOfRingElement" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsList ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_RepresentationMatrixOfRingElement_OnGradedModules ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_RepresentationMatrixOfRingElement_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_RepresentationMatrixOfRingElement_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_RepresentationMatrixOfRingElement_ForGradedModules );

##
## SubmoduleGeneratedByHomogeneousPart
##

##  <#GAPDoc Label="SubmoduleGeneratedByHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="SubmoduleGeneratedByHomogeneousPart"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The submodule of the &homalg; module <A>M</A> generated by the image of the <A>d</A>-th monomial map
##      (&see; <Ref Oper="MonomialMap"/>), or equivalently, by the basis of the <A>d</A>-th homogeneous part of <A>M</A>.
##      <#Include Label="SubmoduleGeneratedByHomogeneousPart:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( _Functor_SubmoduleGeneratedByHomogeneousPart_OnGradedModules , ### defines: SubmoduleGeneratedByHomogeneousPart (object part)
        [ IsInt, IsHomalgModule ],
        
  function( d, M )
    local deg, submodule;
    
    deg := DegreesOfGenerators( M );
    
    submodule := ImageSubobject( EmbeddingOfSubmoduleGeneratedByHomogeneousPart( d, M ) );
    
    if Length( deg ) = 0 or ( Length( deg ) = 1 and deg[1] = d ) then
    
        SetEmbeddingInSuperObject( submodule, TheIdentityMorphism( M ) );
        
    fi;
    
    return submodule;
    
end );

##
InstallGlobalFunction( _Functor_SubmoduleGeneratedByHomogeneousPart_OnGradedMaps, ### defines: SubmoduleGeneratedByHomogeneousPart (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local result;
    
    result := CompleteImageSquare( F_source!.map_having_subobject_as_its_image, phi, F_target!.map_having_subobject_as_its_image );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        Assert( 1, IsEpimorphism( result ) );
        SetIsEpimorphism( result, true );
    fi;
    if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
        Assert( 1, IsIsomorphism( result ) );
        SetIsIsomorphism( result, true );
    fi;
    if HasIsAutomorphism( phi ) and IsAutomorphism( phi ) then
        Assert( 1, IsAutomorphism( result ) );
        SetIsAutomorphism( result, true );
    fi;
    if HasIsZero( phi ) and IsZero( phi ) then
        Assert( 1, IsZero( result ) );
        SetIsZero( result, true );
    fi;

    return result;
    
end );

##
InstallMethod( SubmoduleGeneratedByHomogeneousPart,
        "for homalg submodules",
        [ IsInt, IsStaticFinitelyPresentedSubobjectRep and IsHomalgModule ],
        
  function( d, N )
    
    return SubmoduleGeneratedByHomogeneousPart( d, UnderlyingObject( N ) );
    
end );

##
InstallMethod( SubmoduleGeneratedByHomogeneousPartEmbed,
        "for homalg submodules",
        [ IsInt, IsGradedModuleRep ],
        
  function( d, N )
    
    return SubmoduleGeneratedByHomogeneousPart( d, N )!.map_having_subobject_as_its_image;
    
end );

InstallValue( Functor_SubmoduleGeneratedByHomogeneousPart_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "SubmoduleGeneratedByHomogeneousPart" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "SubmoduleGeneratedByHomogeneousPart" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_SubmoduleGeneratedByHomogeneousPart_OnGradedModules ],
                [ "OnMorphisms", _Functor_SubmoduleGeneratedByHomogeneousPart_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_SubmoduleGeneratedByHomogeneousPart_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_SubmoduleGeneratedByHomogeneousPart_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_SubmoduleGeneratedByHomogeneousPart_ForGradedModules );

##
## TruncatedSubmoduleEmbed
##
## (this functors differes from SubmoduleGeneratedByHomogeneousPartEmbed by returning a map that embeds the submodule into the module
##

##
InstallGlobalFunction( _Functor_TruncatedSubmoduleEmbed_OnGradedModules , ### defines: TruncatedSubmoduleEmbed (object part)
        [ IsInt, IsHomalgModule ],
        
  function( d, M )
    local deg, certain_deg1, certain_part, certain_deg2, mat, phi1, phi2, phi, M2;
    
    deg := DegreesOfGenerators( M );
    certain_deg1 := Filtered( [ 1 .. Length( deg ) ], a -> deg[a] >= d );
    if certain_deg1 = [ 1 .. Length( deg ) ] then
        return TheIdentityMorphism( M );
    fi;
    if certain_deg1 = [ ] then
        
        return ImageObjectEmb( SubmoduleGeneratedByHomogeneousPartEmbed( d, M ) );
        
    else
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            certain_part := CertainRows;
        else
            certain_part := CertainColumns;
        fi;
        
        certain_deg2 := Filtered( [ 1 .. Length( deg ) ], a -> deg[a] < d );
        
        mat := HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) );
        
        phi1 := GradedMap( certain_part( mat, certain_deg1 ), "free", M );
        phi2 := GradedMap( certain_part( mat, certain_deg2 ), "free", M );
        
        Assert( 1, IsMorphism( phi1 ) );
        SetIsMorphism( phi1, true );
        Assert( 1, IsMorphism( phi2 ) );
        SetIsMorphism( phi2, true );
        
        M2 := SubmoduleGeneratedByHomogeneousPart( d, ImageSubobject( phi2 ) );
        phi2 := M2!.map_having_subobject_as_its_image;
        
        phi2 := PreCompose( phi2, NaturalGeneralizedEmbedding( Range( phi2 ) ) );
        
        phi := CoproductMorphism( phi1, phi2 );
        
        return ImageObjectEmb( phi );
    
    fi;
    
end );

InstallValue( Functor_TruncatedSubmoduleEmbed_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "TruncatedSubmoduleEmbed" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "TruncatedSubmoduleEmbed" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_TruncatedSubmoduleEmbed_OnGradedModules ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_TruncatedSubmoduleEmbed_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TruncatedSubmoduleEmbed_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_TruncatedSubmoduleEmbed_ForGradedModules );

##
## TruncatedSubmoduleRecursiveEmbed
##

##
InstallGlobalFunction( _Functor_TruncatedSubmoduleRecursiveEmbed_OnGradedModules , ### defines: TruncatedSubmoduleRecursiveEmbed (object part)
        [ IsInt, IsHomalgModule ],
        
  function( d, M )
    
    return PostDivide( TruncatedSubmoduleEmbed( d + 1, M ), TruncatedSubmoduleEmbed( d, M ) );
    
end );

InstallValue( Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "TruncatedSubmoduleRecursiveEmbed" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "TruncatedSubmoduleRecursiveEmbed" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_TruncatedSubmoduleRecursiveEmbed_OnGradedModules ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules );

##
## HomogeneousPartOverCoefficientsRing
##

##  <#GAPDoc Label="HomogeneousPartOverCoefficientsRing">
##  <ManSection>
##    <Oper Arg="d, M" Name="HomogeneousPartOverCoefficientsRing"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The degree <M>d</M> homogeneous part of the graded <M>R</M>-module <A>M</A>
##      as a module over the coefficient ring or field of <M>R</M>.
##      <#Include Label="HomogeneousPartOverCoefficientsRing:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationOfMorphismOnHomogeneousParts,
        "for homalg ring elements",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, m, n )
    local S, M, N, M_le_m, M_le_m_epi, N_le_n, N_le_n_epi, phi_le_m;
    
    if m > n then
        Error( "The first given degree needs to be larger then the second one" );
    fi;
    
    S := HomalgRing( phi );
    
    M := Source( phi );
    
    N := Range( phi );
    
    M_le_m := SubmoduleGeneratedByHomogeneousPart( m, M );
    
    M_le_m_epi := M_le_m!.map_having_subobject_as_its_image;
    
    N_le_n := SubmoduleGeneratedByHomogeneousPart( n, N );
    
    N_le_n_epi := N_le_n!.map_having_subobject_as_its_image;
    
    return CompleteImageSquare( M_le_m_epi, phi, N_le_n_epi );
    
end );

InstallGlobalFunction( _Functor_HomogeneousPartOverCoefficientsRing_OnGradedModules , ### defines: HomogeneousPartOverCoefficientsRing (object part)
        [ IsInt, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( d, M )
    local S, k_graded, k, deg, mat, map_having_submodule_as_its_image,
          N, gen, l, rel, V, map, submodule;
    
    S := HomalgRing( M );
    
    k_graded := CoefficientsRing( S );
    k := UnderlyingNonGradedRing( k_graded );
    
    deg := DegreesOfGenerators( M );
    
    mat := BasisOfHomogeneousPart( d, M );
    map_having_submodule_as_its_image := GradedMap( mat, "free", M );
    Assert( 1, IsMorphism( map_having_submodule_as_its_image ) );
    SetIsMorphism( map_having_submodule_as_its_image, true );
    
    if deg = [] or Minimum( deg ) >= d then
        Assert( 1, IsEpimorphism( map_having_submodule_as_its_image ) );
        SetIsEpimorphism( map_having_submodule_as_its_image, true );
    fi;
    
    N := ImageSubobject( map_having_submodule_as_its_image );
    
    gen := GeneratorsOfModule( N );
    
    gen := NewHomalgGenerators( MatrixOfGenerators( gen ), gen );
    
    gen!.ring := k;
    
    l := NrGenerators( gen );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        rel := HomalgZeroMatrix( 0, l, k );
        rel := HomalgRelationsForLeftModule( rel );
    else
        rel := HomalgZeroMatrix( l, 0, k );
        rel := HomalgRelationsForRightModule( rel );
    fi;
    
    V := GradedModule( Presentation( gen, rel ), d, k_graded );
    
    map := GradedMap( HomalgIdentityMatrix( l, S ),
                   S * V, Source( map_having_submodule_as_its_image ) );
    
    Assert( 1, IsMorphism( map ) );
    SetIsMorphism( map, true );
    
    Assert( 1, IsIsomorphism( map ) );
    SetIsIsomorphism( map, true );
    
    map_having_submodule_as_its_image := PreCompose( map, map_having_submodule_as_its_image );
    
    SetEmbeddingOfSubmoduleGeneratedByHomogeneousPart( V, map_having_submodule_as_its_image );
    
    SetNaturalTransformation( 
        Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules,
        [ d, M ],
        "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
        map_having_submodule_as_its_image
    );
    
    return V;
    
end );


##
InstallGlobalFunction( _Functor_HomogeneousPartOverCoefficientsRing_OnGradedMaps, ### defines: HomogeneousPartOverCoefficientsRing (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local S, k, d, mat, result;
    
    S := HomalgRing( phi );
    
    if not HasCoefficientsRing( S ) then
        TryNextMethod( );
    fi;
    
    k := CoefficientsRing( S );
    
    d := arg_before_pos[1];
    
    mat := k * MatrixOfMap( RepresentationOfMorphismOnHomogeneousParts( phi, d, d ) );
    
    result := GradedMap( mat, F_source, F_target );
    
    Assert( 1, IsMorphism( result ) );
    if HasIsMorphism( phi ) then
        SetIsMorphism( result, IsMorphism( phi ) );
    fi;
    
    return result;
    
end );

InstallValue( Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "HomogeneousPartOverCoefficientsRing" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "HomogeneousPartOverCoefficientsRing" ],
                [ "natural_transformations", [ [ "EmbeddingOfSubmoduleGeneratedByHomogeneousPart", 2 ] ] ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_HomogeneousPartOverCoefficientsRing_OnGradedModules ],
                [ "OnMorphisms", _Functor_HomogeneousPartOverCoefficientsRing_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules );

##
## HomogeneousPartOfDegreeZeroOverCoefficientsRing
##

InstallGlobalFunction( _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedModules , ### defines: HomogeneousPartOfDegreeZeroOverCoefficientsRing (object part)
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    
    return HomogeneousPartOverCoefficientsRing( 0, M );
    
end );


##
InstallGlobalFunction( _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedMaps, ### defines: HomogeneousPartOfDegreeZeroOverCoefficientsRing (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    
    return HomogeneousPartOverCoefficientsRing( 0, phi );
    
end );

InstallValue( Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "HomogeneousPartOfDegreeZeroOverCoefficientsRing" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "HomogeneousPartOfDegreeZeroOverCoefficientsRing" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedModules ],
                [ "OnMorphisms", _Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedMaps ],
                [ "MorphismConstructor", HOMALG_MODULES.category.MorphismConstructor ]
                )
        );

Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules );
