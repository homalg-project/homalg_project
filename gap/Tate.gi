#############################################################################
##
##  Tate.gi                     Graded Modules package
##
##  Copyright 2008-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations of procedures for the pair of adjoint Tate functors.
##
#############################################################################

##
## Removes the morphism of lowest degree in the complex T and instead adds another (minimal) morphism there having the same image.
InstallMethod( MinimizeLowestDegreeMorphism,
        "for homalg modules",
        [ IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( T )
    local N, phi, TT;
    
    N := UnderlyingObject( ImageSubobject( LowestDegreeMorphism( T ) ) );
    ByASmallerPresentation( N );
    phi := NaturalGeneralizedEmbedding( N );
    phi := PreCompose( CokernelEpi( PresentationMorphism( N ) ), phi );
    if Length( ObjectDegreesOfComplex( T ) ) = 2 then
        TT := HomalgCocomplex( phi, LowestDegree( T ) );
    else
        TT := Subcomplex( T, LowestDegree( T ) + 1, HighestDegree( T ) );
        Add( phi, TT );
    fi;
    
    return TT;
    
end );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="TateResolution">
##  <ManSection>
##    <Oper Arg="M, degree_lowest, degree_highest" Name="TateResolution"/>
##    <Returns>a &homalg; cocomplex</Returns>
##    <Description>
##      Compute the Tate resolution of the sheaf <A>M</A>.
##      <#Include Label="TateResolution:example1">
##  In the following we construct the different exterior powers of the cotangent bundle
##  shifted by <M>1</M>. Observe how a single <M>1</M> travels along the diagnoal
##  in the window <M>[ -3 .. 0 ] x [ 0 .. 3 ]</M>. <Br/><Br/>
##  First we start with the structure sheaf with its Tate resolution:
##      <#Include Label="TateResolution:example2">
##  The Castelnuovo-Mumford regularity of the <E>underlying module</E> is distinguished
##  among the list of twists by the character <C>'V'</C> pointing to it. It is <E>not</E>
##  an invariant of the sheaf (see the next diagram). <Br/><Br/>
##  The residue class field (i.e. S modulo the maximal homogeneous ideal):
##      <#Include Label="TateResolution:example3">
##  Another way of constructing the structure sheaf:
##      <#Include Label="TateResolution:example4">
##  The cotangent bundle:
##      <#Include Label="TateResolution:example5">
##  the cotangent bundle shifted by <M>1</M> with its Tate resolution:
##      <#Include Label="TateResolution:example6">
##  The second power <M>U^2</M> of the shifted cotangent bundle <M>U=U^1</M> and its Tate resolution:
##      <#Include Label="TateResolution:example7">
##  The third power <M>U^3</M> of the shifted cotangent bundle <M>U=U^1</M> and its Tate resolution:
##      <#Include Label="TateResolution:example8">
##  Another way to construct <M>U^2=U^(3-1)</M>:
##      <#Include Label="TateResolution:example9">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##  gap> Display(S);
##  Q[x0,x1,x2,x3]
##  gap> Display(A);
##  Q{e0,e1,e2,e3}
##  gap> Display(cotangent);
##  x1,-x2,x3,0,  0,  0, 
##  x0,0,  0, -x2,x3, 0, 
##  0, x0, 0, -x1,0,  x3,
##  0, 0,  x0,0,  -x1,x2 
##  
##  (graded, generators degrees: [ 2, 2, 2, 2, 2, 2 ])
##  
##  Cokernel of the map
##  
##  R^(1x4) --> R^(1x6), ( for R := Q[x0,x1,x2,x3] )
##  
##  currently represented by the above matrix
##
InstallGlobalFunction( _Functor_TateResolution_OnGradedModules , ### defines: TateResolution (object part)
        [ IsHomalgRing and IsExteriorRing, IsInt, IsInt, IsHomalgModule ],
        
  function( l, _M )
    local A, degree_lowest, degree_highest, M, CM, p, d_low, d_high, tate, T, i, K, Kres, result, ll, iso;
      
      if not Length( l ) = 3 then
          Error( "wrong number of elements in zeroth parameter, expected an exterior algebra and two integers" );
      else
          A := l[1];
          degree_lowest := l[2];
          degree_highest := l[3];
          if not ( IsHomalgRing( A ) and IsExteriorRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) ) then
              Error( "wrong number of elements in zeroth parameter, expected an exterior algebra and two integers" );
          fi;
      fi;
    
    if IsHomalgRing( _M ) then
        M := FreeRightModuleWithDegrees( 1, _M );
    else
        M := _M;
    fi;
    
    CM := CastelnuovoMumfordRegularity( M );
    
    if not IsBound( M!.TateResolution ) then
      M!.TateResolution := rec( );
    fi;
    
    p := PositionOfTheDefaultPresentation( M );
    
    if IsGradedModuleRep( M ) and IsBound( M!.TateResolution!.(p) ) then
    
      T := M!.TateResolution!.(p);
      tate := HighestDegreeMorphism( T );
      d_high := T!.degrees[ Length( T!.degrees ) ] - 1;
      d_low := T!.degrees[ 1 ];
      
    else
    
      d_high := Maximum( CM , degree_lowest );
      d_low := d_high;
      tate := RepresentationMapOfKoszulId( d_high, M, A );
      T := HomalgCocomplex( tate, d_high );
    
    fi;
    
    ## above the Castelnuovo-Mumford regularity
    for i in [ d_high + 1 .. degree_highest - 1 ] do
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( i, M, A );
        
        Add( T, tate );
    od;
     
     ## below the Castelnuovo-Mumford regularity
     if degree_lowest < d_low then
        
        # The morphism of lowest degree is not part of a minimal complex.
        # However, its image is the kernel of the following map.
        # Thus, we find a minimal map having the same image.
        T := MinimizeLowestDegreeMorphism( T );
        
        tate := LowestDegreeMorphism( T );
        
        K := Kernel( tate );
        
        ## get rid of the units in the presentation of the kernel K
        ByASmallerPresentation( K );
        
        Kres := Resolution( d_low - degree_lowest, K );
        
        tate := PreCompose( CoveringEpi( K ), KernelEmb( tate ) );
        
        Add( tate, T );
     
        for i in [ 1 .. d_low - degree_lowest - 1 ] do
        
            tate := CertainMorphism( Kres, i );
            
            Add( tate, T );
            
        od;
        
    fi;
    
    ## check assertion
    Assert( 1, IsAcyclic( T ) );
    
    SetIsAcyclic( T, true );
    
    ## pass some options to the operation BettiDiagram (applied on complexes):
    
    T!.display_twist := true;
    
    ## starting from the Castelnuovo-Mumford regularity
    ## (and going right) all higher cohomologies vanish
    T!.higher_vanish := CM;
    
    if IsGradedModuleRep( M ) then
      M!.TateResolution!.(p) := T;
    fi;
    
    result := Subcomplex( T, degree_lowest, degree_highest );
    
    ## check assertion
    Assert( 1, IsAcyclic( result ) );
    
    SetIsAcyclic( result, true );
    
    ## pass some options to the operation BettiDiagram (applied on complexes):
    
    result!.display_twist := true;
    
    ## starting from the Castelnuovo-Mumford regularity
    ## (and going right) all higher cohomologies vanish
    result!.higher_vanish := CM;
    
    return result;
    
    
end );

##
InstallMethod( TateResolution,
        "for homalg modules",
        [ IsHomalgModule, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return TateResolution( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( TateResolution,
        "for homalg modules",
        [ IsHomalgModule, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    
    return TateResolution( [ A, degree_lowest, degree_highest ], M );
    
end );

##
InstallMethod( TateResolution,
        "for homalg modules",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return TateResolution( phi, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( TateResolution,
        "for homalg modules",
        [ IsMapOfGradedModulesRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    
    return TateResolution( [ A, degree_lowest, degree_highest ], phi );
    
end );

##
InstallGlobalFunction( _Functor_TateResolution_OnGradedMaps, ### defines: TateResolution (morphism part)
       [ IsGradedModuleOrGradedSubmoduleRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local l, A, degree_lowest, degree_highest, degree_highest2, CM, T_source, T_range, T, T2, ii, i;
    
    l := arg_before_pos[1];
    
    if not Length( l ) = 3 then
        Error( "wrong number of elements in zeroth parameter, expected an exterior algebra and two integers" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not ( IsHomalgRing( A ) and IsExteriorRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) ) then
            Error( "wrong number of elements in 0th parameter, expected an exterior algebra and two integers" );
        fi;
    fi;
    
    CM := CastelnuovoMumfordRegularity( phi );
    degree_highest2 := Maximum( degree_highest, CM + 1 );
    
    # we need to compute the module down from the CastelnuovoMumfordRegularity
    T_source := TateResolution( Source( phi ), A, degree_lowest, degree_highest2 );
    T_range := TateResolution( Range( phi ), A, degree_lowest, degree_highest2 );
    
    i := degree_highest2;
    T2 := HomalgChainMorphism( A * HomogeneousPartOverCoefficientsRing( i, phi ), T_source, T_range, i );
    if degree_highest2 = degree_highest then
        T := HomalgChainMorphism( LowestDegreeMorphism( T2 ), F_source, F_target, i );
    fi;
    
    for ii in [ degree_lowest .. degree_highest2 - 1 ] do
        
        i := ( degree_highest2 - 1 ) + degree_lowest - ii;
        
        Add( CompleteImageSquare( CertainMorphism( T_source, i ), LowestDegreeMorphism( T2 ), CertainMorphism( T_range, i ) ), T2 );
        
        if i <= degree_highest and not IsBound( T ) then
            T := HomalgChainMorphism( LowestDegreeMorphism( T2 ), F_source, F_target, i );
        elif i < degree_highest then
            Add( LowestDegreeMorphism( T2 ), T );
        fi;
        
    od;

    return T;
    
end );

InstallValue( Functor_TateResolution_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "TateResolution" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "TateResolution" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsList ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_TateResolution_OnGradedModules ],
                [ "OnMorphisms", _Functor_TateResolution_OnGradedMaps ]
                )
        );

Functor_TateResolution_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TateResolution_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_TateResolution_ForGradedModules );

##
## LinearStrandOfTateResolution
##

InstallMethod( ResolveLinearly,
        "for homalg cocomplexes",
        [ IsInt, IsHomalgComplex, IsInt ],
        
  function( n, T, shift )
    local know_regularity, i, tate, K, deg, certain_deg, phi, regularity;
    
    know_regularity := false;
    
    for i in [ 1 .. n ] do
        
        tate := LowestDegreeMorphism( T );
        
        K := Kernel( tate );
        
        ## get rid of the units in the presentation of the kernel K
        ByASmallerPresentation( K );
        
        tate := PreCompose( CoveringEpi( K ), KernelEmb( tate ) );
        
        # phi is the embedding of the right degree into the module
        deg := DegreesOfGenerators( Source( tate ) );
        certain_deg := Filtered( [ 1 .. Length( deg ) ], a -> deg[a] = Minimum( ObjectDegreesOfComplex( T ) ) - 1 + shift );
        
        if [ 1 .. Length( deg ) ] <> certain_deg then
        
            if not know_regularity then
                regularity := Minimum( ObjectDegreesOfComplex( T ) );
                know_regularity := true;
            fi;
            
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( tate ) then
                phi := GradedMap( CertainRows( HomalgIdentityMatrix( NrGenerators( Source( tate ) ), HomalgRing( tate ) ), certain_deg ), "free", Source( tate ) );
            else
                phi := GradedMap( CertainColumns( HomalgIdentityMatrix( NrGenerators( Source( tate ) ), HomalgRing( tate ) ), certain_deg ), "free", Source( tate ) );
            fi;
            
            Assert( 2, IsMorphism( phi ) );
            SetIsMorphism( phi, true );
            
            tate := PreCompose( phi, tate );
            
        fi;
        
        Assert( 1, IsMorphism( tate ) );
        SetIsMorphism( tate, true );
        
        Add( tate, T );
    
    od;
        
    if know_regularity then
        return regularity;
    else
        return fail;
    fi;
    
end );

InstallMethod( ResolveLinearly,
        "for homalg cocomplexes",
        [ IsInt, IsHomalgComplex ],
        
  function( n, T )
    
    return ResolveLinearly( n, T, 0 );
    
end );

##
InstallGlobalFunction( _Functor_LinearStrandOfTateResolution_OnGradedModules , ### defines: StrandOfTateResolution (object part)
        [ IsHomalgRing and IsExteriorRing, IsInt, IsInt, IsHomalgModule ],
        
  function( l, _M )
    local A, degree_lowest, degree_highest, n, M, CM, p, d_low, d_high, tate, T, i, know_regularity, ii, K, deg, certain_deg, phi, regularity, result;
    
    if not Length( l ) = 3 then
        Error( "wrong number of elements in zeroth parameter, expected an exterior algebra and two integers" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not ( IsHomalgRing( A ) and IsExteriorRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) )then
            Error( "wrong number of elements in zeroth parameter, expected an exterior algebra and two integers." );
        fi;
    fi;
    
    n := Length( Indeterminates( A ) );
    
    if IsHomalgRing( _M ) then
        M := FreeRightModuleWithDegrees( 1, _M );
    else
        M := _M;
    fi;
    
    CM := CastelnuovoMumfordRegularity( M );
    
    p := PositionOfTheDefaultPresentation( M );
    
    if not IsBound( M!.LinearStrandOfTateResolution ) then
        M!.LinearStrandOfTateResolution := rec( );
    fi;
    
    if IsGradedModuleRep( M ) and IsBound( M!.LinearStrandOfTateResolution!.(p) ) then
        
        T := M!.LinearStrandOfTateResolution!.(p);
        tate := HighestDegreeMorphism( T );
        d_high := T!.degrees[ Length( T!.degrees ) ] - 1;
        d_low := T!.degrees[ 1 ];
        
    else
        
        d_high := Maximum( CM, degree_lowest );
        d_low := d_high;
        tate := RepresentationMapOfKoszulId( d_high, M, A );
        T := HomalgCocomplex( tate, d_high );
    
    fi;
    
    ## above the Castelnuovo-Mumford regularity
    for i in [ d_high + 1 .. degree_highest - 1 ] do
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( i, M, A );
        
        Add( T, tate );
    od;
    
    know_regularity := false;
    
    ## below the Castelnuovo-Mumford regularity
    if degree_lowest < d_low then
        
        # The morphism of lowest degree is not part of a minimal complex.
        # However, its image is the kernel of the following map.
        # Thus, we find a minimal map having the same image.
        if LowestDegree( T ) = CM then
            T := MinimizeLowestDegreeMorphism( T );
        fi;
        
        regularity := ResolveLinearly( d_low - degree_lowest, T, n );
        
        if regularity = fail then
            know_regularity := false;
        else
            know_regularity := true;
        fi;
    fi;
    
    ## pass some options to the operation BettiDiagram (applied on complexes):
    
    T!.display_twist := true;
    
    ## starting from the Castelnuovo-Mumford regularity
    ## (and going right) all higher cohomologies vanish
    T!.higher_vanish := CM;
    
    if IsGradedModuleRep( M ) then
        M!.LinearStrandOfTateResolution!.(p) := T;
    fi;
    
    result := Subcomplex( T, degree_lowest, degree_highest );
    
    ## pass some options to the operation BettiDiagram (applied on complexes):
    
    result!.display_twist := true;
    
    ## starting from the Castelnuovo-Mumford regularity
    ## (and going right) all higher cohomologies vanish
    result!.higher_vanish := CM;
    
    if know_regularity then
        result!.regularity := Maximum( HOMALG_GRADED_MODULES!.LowerTruncationBound, regularity );
    else
        result!.regularity := degree_lowest;
    fi;
    
    Assert( 1, IsComplex( result ) );
    SetIsComplex( result, true );
    
    return result;
    
end );

##
InstallMethod( LinearStrandOfTateResolution,
        "for homalg modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return LinearStrandOfTateResolution( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( LinearStrandOfTateResolution,
        "for homalg modules",
        [ IsGradedModuleRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    
    return LinearStrandOfTateResolution( [ A, degree_lowest, degree_highest ], M );
    
end );

##
InstallMethod( LinearStrandOfTateResolution,
        "for homalg modules",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return LinearStrandOfTateResolution( phi, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( LinearStrandOfTateResolution,
        "for homalg modules",
        [ IsMapOfGradedModulesRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    
    return LinearStrandOfTateResolution( [ A, degree_lowest, degree_highest ], phi );
    
end );

##
InstallGlobalFunction( _Functor_LinearStrandOfTateResolution_OnGradedMaps, ### defines: StrandOfTateResolution (morphism part)
       [ IsGradedModuleOrGradedSubmoduleRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local l, A, degree_lowest, degree_highest, n, degree_highest2, CM, T_source, T_range, T, T2, ii, i;
    
    l := arg_before_pos[1];
    
    if not Length( l ) = 3 then
        Error( "wrong number of elements in zeroth parameter, expected an exterior algebra and two integers" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not ( IsHomalgRing( A ) and IsExteriorRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) ) then
            Error( "wrong number of elements in 0th parameter, expected an exterior algebra and two integers" );
        fi;
    fi;
    
    n := Length( Indeterminates( A ) );
    
    CM := CastelnuovoMumfordRegularity( phi );
    degree_highest2 := Maximum( degree_highest, CM + 1 );
    
    # We need to compute the module down from the CastelnuovoMumfordRegularity
    # So the Ts are just longer versions of the Fs
    T_source := LinearStrandOfTateResolution( Source( phi ), A, degree_lowest, degree_highest2 );
    T_range := LinearStrandOfTateResolution( Range( phi ), A, degree_lowest, degree_highest2 );
    
    i := degree_highest2;
    T2 := HomogeneousPartOverCoefficientsRing( i, phi );
    
    T2 := A^(-n) * ( A * T2 );
    T2 := HomalgChainMorphism( T2, T_source, T_range, i );
    if degree_highest2 = degree_highest then
        T := HomalgChainMorphism( LowestDegreeMorphism( T2 ), F_source, F_target, i );
    fi;
    
    for ii in [ degree_lowest .. degree_highest2 - 1 ] do
        
        i := ( degree_highest2 - 1 ) + degree_lowest - ii;
        
        Add( CompleteImageSquare( CertainMorphism( T_source, i ), LowestDegreeMorphism( T2 ), CertainMorphism( T_range, i ) ), T2 );
        
        if i <= degree_highest and not IsBound( T ) then
            T := HomalgChainMorphism( LowestDegreeMorphism( T2 ), F_source, F_target, i );
        elif i < degree_highest then
            Add( LowestDegreeMorphism( T2 ), T );
        fi;
        
    od;

    return T;
    
end );

InstallValue( Functor_LinearStrandOfTateResolution_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "LinearStrandOfTateResolution" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "LinearStrandOfTateResolution" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsList ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_LinearStrandOfTateResolution_OnGradedModules ],
                [ "OnMorphisms", _Functor_LinearStrandOfTateResolution_OnGradedMaps ]
                )
        );

Functor_LinearStrandOfTateResolution_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_LinearStrandOfTateResolution_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_LinearStrandOfTateResolution_ForGradedModules );
