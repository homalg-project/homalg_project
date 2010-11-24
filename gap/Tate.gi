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
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x3";;
##  gap> A := KoszulDualRing( S, "e0..e3" );;
##  ]]></Example>
##  In the following we construct the different exterior powers of the cotangent bundle
##  shifted by <M>1</M>. Observe how a single <M>1</M> travels along the diagnoal
##  in the window <M>[ -3 .. 0 ] x [ 0 .. 3 ]</M>. <Br/><Br/>
##  First we start with the structure sheaf with its Tate resolution:
##      <Example><![CDATA[
##  gap> O := S^0;
##  <The graded free left module of rank 1 on a free generator>
##  gap> T := TateResolution( O, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti := BettiDiagram( T );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti );
##  total:  35 20 10  4  1  1  4 10 20 35 56  ?  ?  ?
##  ---------|--|--|--|--|--|--|--|--|--|--|--|--|--|
##      3:  35 20 10  4  1  .  .  .  .  .  .  0  0  0
##      2:   *  .  .  .  .  .  .  .  .  .  .  .  0  0
##      1:   *  *  .  .  .  .  .  .  .  .  .  .  .  0
##      0:   *  *  *  .  .  .  .  .  1  4 10 20 35 56
##  ---------|--|--|--|--|--|--|--|--V--|--|--|--|--|
##  twist:  -8 -7 -6 -5 -4 -3 -2 -1  0  1  2  3  4  5
##  -------------------------------------------------
##  Euler:   ?  ?  ? -4 -1  0  0  0  1  4 10 20 35 56
##  ]]></Example>
##  The Castelnuovo-Mumford regularity of the <E>underlying module</E> is distinguished
##  among the list of twists by the character <C>'V'</C> pointing to it. It is <E>not</E>
##  an invariant of the sheaf (see the next diagram). <Br/><Br/>
##  The residue class field (i.e. S modulo the maximal homogeneous ideal):
##      <Example><![CDATA[
##  gap> k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );
##  <A 4 x 1 matrix over an external ring>
##  gap> k := LeftPresentationWithDegrees( k );
##  <A graded cyclic left module presented by 4 relations for a cyclic generator>
##  ]]></Example>
##  Another way of constructing the structure sheaf:
##      <Example><![CDATA[
##  gap> U0 := SyzygiesObject( 1, k );
##  <A graded torsion-free left module presented by yet unknown relations for 4 ge\
##  nerators>
##  gap> T0 := TateResolution( U0, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti0 := BettiDiagram( T0 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti0 );
##  total:  35 20 10  4  1  1  4 10 20 35 56  ?  ?  ?
##  ---------|--|--|--|--|--|--|--|--|--|--|--|--|--|
##      3:  35 20 10  4  1  .  .  .  .  .  .  0  0  0
##      2:   *  .  .  .  .  .  .  .  .  .  .  .  0  0
##      1:   *  *  .  .  .  .  .  .  .  .  .  .  .  0
##      0:   *  *  *  .  .  .  .  .  1  4 10 20 35 56
##  ---------|--|--|--|--|--|--|--|--|--V--|--|--|--|
##  twist:  -8 -7 -6 -5 -4 -3 -2 -1  0  1  2  3  4  5
##  -------------------------------------------------
##  Euler:   ?  ?  ? -4 -1  0  0  0  1  4 10 20 35 56
##  ]]></Example>
##  The cotangent bundle:
##      <Example><![CDATA[
##  gap> cotangent := SyzygiesObject( 2, k );
##  <A graded torsion-free left module presented by yet unknown relations for 6 ge\
##  nerators>
##  gap> IsFree( cotangent );
##  false
##  gap> Rank( cotangent );
##  3
##  gap> cotangent;
##  <A graded reflexive non-projective rank 3 left module presented by 4 relations\
##   for 6 generators>
##  gap> ProjectiveDimension( cotangent );
##  2
##  ]]></Example>
##  the cotangent bundle shifted by <M>1</M> with its Tate resolution:
##      <Example><![CDATA[
##  gap> U1 := cotangent * S^1;
##  <A graded non-torsion left module presented by 4 relations for 6 generators>
##  gap> T1 := TateResolution( U1, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti1 := BettiDiagram( T1 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti1 );
##  total:  120  70  36  15   4   1   6  20  45  84 140   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:  120  70  36  15   4   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   1   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   6  20  45  84 140
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -15  -4   0   0  -1   0   6  20  45  84 140
##  ]]></Example>
##  The second power <M>U^2</M> of the shifted cotangent bundle <M>U=U^1</M> and its Tate resolution:
##      <Example><![CDATA[
##  gap> U2 := SyzygiesObject( 3, k ) * S^2;
##  <A graded rank 3 left module presented by 1 relation for 4 generators>
##  gap> T2 := TateResolution( U2, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti2 := BettiDiagram( T2 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti2 );
##  total:  140  84  45  20   6   1   4  15  36  70 120   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:  140  84  45  20   6   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   1   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   4  15  36  70 120
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -20  -6   0   1   0   0   4  15  36  70 120
##  ]]></Example>
##  The third power <M>U^3</M> of the shifted cotangent bundle <M>U=U^1</M> and its Tate resolution:
##      <Example><![CDATA[
##  gap> U3 := SyzygiesObject( 4, k ) * S^3;
##  <A graded free left module of rank 1 on a free generator>
##  gap> Display( U3 );
##  Q[x0,x1,x2,x3]^(1 x 1)	 (graded, generators degrees: [ 1 ])
##  gap> T3 := TateResolution( U3, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti3 := BettiDiagram( T3 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti3 );
##  total:   56  35  20  10   4   1   1   4  10  20  35   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:   56  35  20  10   4   1   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   1   4  10  20  35
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -10  -4  -1   0   0   0   1   4  10  20  35
##  ]]></Example>
##  Another way to construct <M>U^2=U^(3-1)</M>:
##      <Example><![CDATA[
##  gap> u2 := Hom( U1, S^(-1) );
##  <A graded torsion-free right module on 4 generators satisfying yet unknown rel\
##  ations>
##  gap> t2 := TateResolution( u2, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of right modules at degrees 
##  [ -5 .. 5 ]>
##  gap> BettiDiagram( t2 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of right modules at degrees [ -5 .. 5 ]>>
##  gap> Display( last );
##  total:  140  84  45  20   6   1   4  15  36  70 120   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:  140  84  45  20   6   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   1   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   4  15  36  70 120
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -20  -6   0   1   0   0   4  15  36  70 120
##  ]]></Example>
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
    local A, degree_lowest, degree_highest, M, CM, d_low, d_high, tate, T, i, source, target, K, Kres, result;
      
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
    
    if IsGradedModuleRep( M ) and IsBound( M!.TateResolution ) then
    
      T := M!.TateResolution;
      tate := HighestDegreeMorphism( T );
      d_high := T!.degrees[ Length( T!.degrees ) ] - 1;
      d_low := T!.degrees[ 1 ];
      
    else
    
      d_high := Maximum( CM + 1, degree_lowest );
      d_low := d_high;
      tate := RepresentationMapOfKoszulId( d_high, M, A );
      T := HomalgCocomplex( tate, d_high );
    
    fi;
    
    ## above the Castelnuovo-Mumford regularity
    for i in [ d_high + 1 .. degree_highest - 1 ] do
        
        source := Range( tate );
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( i, M, A );
        
        target := Range( tate );
        
        tate := MatrixOfMap( tate );
        
        if IsHomalgGradedRingRep( HomalgRing( M ) ) then
          tate := GradedMap( tate, source, target );
        else
          tate := HomalgMap( tate, source, target );
        fi;
        
        Add( T, tate );
    od;
    
    ## below the Castelnuovo-Mumford regularity
    if degree_lowest < d_low then
        
        tate := LowestDegreeMorphism( T );
        
        K := Kernel( tate );
        
        ## get rid of the units in the presentation of the kernel K
        ByASmallerPresentation( K );
        
        Kres := Resolution( d_low - degree_lowest, K );
        
        tate := PreCompose( HullEpi( K ), KernelEmb( tate ) );
        
        Add( tate, T );
        
        for i in [ 1 .. d_low - degree_lowest - 1 ] do
            Add( CertainMorphism( Kres, i ), T );
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
      M!.TateResolution := T;
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
InstallGlobalFunction( _Functor_TateResolution_OnGradedMaps, ### defines: TateResolution (morphism part)
       [ IsGradedModuleOrGradedSubmoduleRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( l, phi )
    local A, degree_lowest, degree_highest, degree_highest2, CM, T_source, T_range, T, T2, ii, i;
      
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
    degree_highest2 := Maximum( degree_highest, CM + 2 );
    
    T_source := TateResolution( Source( phi ), A, degree_lowest, degree_highest2 );
    T_range := TateResolution( Range( phi ), A, degree_lowest, degree_highest2 );
    
    i := degree_highest2 - 1;
    T2 := HomalgChainMap( GradedMap( A * MatrixOfMap( HomogeneousPartOverCoefficientsRing( i, phi ) ), CertainObject( T_source, i ), CertainObject( T_range, i ) ), T_source, T_range, i );
    if degree_highest2 = degree_highest then
        T := HomalgChainMap( LowestDegreeMorphism( T2 ), degree_highest );
    fi;
    
    for ii in [ degree_lowest .. degree_highest2 - 2 ] do
        
        i := ( degree_highest2 - 2 ) + degree_lowest - ii;
        
        if i > CM then
            Add( GradedMap( A * MatrixOfMap( HomogeneousPartOverCoefficientsRing( i, phi ) ), CertainObject( T_source, i ), CertainObject( T_range, i ) ), T2 );
        else
            Add( CompleteImageSquare( CertainMorphism( T_source, i ), LowestDegreeMorphism( T2 ), CertainMorphism( T_range, i ) ), T2 );
        fi;
        
        if i <= degree_highest and not IsBound( T ) then
            T := HomalgChainMap( LowestDegreeMorphism( T2 ), TateResolution( Source( phi ), A, degree_lowest, degree_highest ), TateResolution( Range( phi ), A, degree_lowest, degree_highest ), degree_highest );
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
                [ "OnMorphisms", _Functor_TateResolution_OnGradedMaps ],
                [ "IsIdentityOnObjects", true ]
                )
        );

Functor_TateResolution_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_TateResolution_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_TateResolution_ForGradedModules );