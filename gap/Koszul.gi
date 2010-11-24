#############################################################################
##
##  Koszul.gi                                          GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations for functors L and R
##
#############################################################################

##  <#GAPDoc Label="RepresentationMatrixOfKoszulId">
##  <ManSection>
##    <Oper Arg="d, M" Name="RepresentationMatrixOfKoszulId"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      It is assumed that all indeterminates of the underlying &homalg; graded ring <M>S</M> are of degree <M>1</M>.
##      The output is the &homalg; matrix of the multiplication map
##      <Alt Only="LaTeX">$\mathrm{Hom}( A, M_d ) \to \mathrm{Hom}( A, M_{d+1} )$</Alt><Alt Not="LaTeX">
##      <M>Hom( A, M_{<A>d</A>} ) \to Hom( A, M_{<A>d</A>+1} )</M></Alt>, where <M>A</M> is the Koszul dual ring of <M>S</M>,
##      defined using the operation <C>KoszulDualRing</C>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> A := KoszulDualRing( S, "a,b,c" );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationMatrixOfKoszulId( 0, M );
##  <An unevaluated 3 x 7 matrix over an external ring>
##   gap> Display( m );
##   0,b,a,0,0,0,0,
##   b,a,0,0,0,0,0,
##   0,0,0,a,b,c,0 
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationMatrixOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep, IsHomalgGradedRing ],
        
  function( d, M, A )
    local S, vars, dual, weights, pos, reps;
    
    S := HomalgRing( M );
    
    vars := Indeterminates( S );
    dual := Indeterminates( A );
    
    weights := WeightsOfIndeterminates( S );
    
    if not Set( weights ) = [ 1 ] then
        
        pos := Filtered( [ 1 .. Length( weights ) ], p -> weights[p] = 1 );
        
        ## the variables of weight 1
        vars := vars{pos};
        dual := dual{pos};
        
    fi;
    
    ## this whole computation is over S = HomalgRing( M )
    reps := List( vars, v -> RepresentationOfRingElement( v, M, d ) );
    
    ## convert the matrices with constant coefficients
    ## to matrices of the Koszul dual ring A
    reps := List( reps, mat -> A * mat );
    
    ## this is over the Koszul dual ring A
    reps := List( [ 1 .. Length( vars ) ], i -> dual[i] * reps[i] );
    
    return Sum( reps );
    
end );

##
InstallMethod( RepresentationMatrixOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( d, M )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return RepresentationMatrixOfKoszulId( d, M, A );
    
end );

##  <#GAPDoc Label="RepresentationMapOfKoszulId">
##  <ManSection>
##    <Oper Arg="d, M" Name="RepresentationMapOfKoszulId"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      It is assumed that all indeterminates of the underlying &homalg; graded ring <M>S</M> are of degree <M>1</M>.
##      The output is the the multiplication map
##      <Alt Only="LaTeX">$\mathrm{Hom}( A, M_d ) \to \mathrm{Hom}( A, M_{d+1} )$</Alt><Alt Not="LaTeX">
##      <M>Hom( A, M_{<A>d</A>} ) \to Hom( A, M_{<A>d</A>+1} )</M></Alt>, where <M>A</M> is the Koszul dual ring of
##      <M>S</M>, defined using the operation <C>KoszulDualRing</C>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> A := KoszulDualRing( S, "a,b,c" );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationMapOfKoszulId( 0, M );
##  <A homomorphism of left modules>
##   gap> Display( m );
##   0,b,a,0,0,0,0,
##   b,a,0,0,0,0,0,
##   0,0,0,a,b,c,0 
##   
##   (target generators degrees: [ -1, -1, -1, -1, -1, -1, -1 ])
##   
##   the map is currently represented by the above 3 x 7 matrix
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationMapOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep, IsHomalgGradedRing ],
        
  function( d, M, A )
    local left, rep, weights, presentation, certain_relations, M_d, M_dp1,
          m_d, m_dp1, degrees_d, degrees_dp1, pos_d, pos_dp1, AM_d, AM_dp1;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    rep := RepresentationMatrixOfKoszulId( d, M, A );
    
    ## now determine the source and target modules
    
    weights := WeightsOfIndeterminates( HomalgRing( M ) );
    
    if Set( weights ) = [ 1 ] then
        
        if left then
            AM_d := FreeLeftModuleWithDegrees( NrRows( rep ), A, d );
            AM_dp1 := FreeLeftModuleWithDegrees( NrColumns( rep ), A, d + 1 );
        else
            AM_d := FreeRightModuleWithDegrees( NrColumns( rep ), A, d );
            AM_dp1 := FreeRightModuleWithDegrees( NrRows( rep ), A, d + 1 );
        fi;
        
    else
        
        if left then
            presentation := LeftPresentationWithDegrees;
            certain_relations := CertainRows;
        else
            presentation := RightPresentationWithDegrees;
            certain_relations := CertainColumns;
        fi;
        
        M_d := SubmoduleGeneratedByHomogeneousPart( d, M );
        M_dp1 := SubmoduleGeneratedByHomogeneousPart( d + 1, M );
        
        M_d := UnderlyingObject( M_d );
        M_dp1 := UnderlyingObject( M_dp1 );
        
        m_d := PresentationMorphism( M_d );
        m_dp1 := PresentationMorphism( M_dp1 );
        
        degrees_d := DegreesOfGenerators( Source( m_d ) );
        degrees_dp1 := DegreesOfGenerators( Source( m_dp1 ) );
        
        pos_d := Filtered( [ 1 .. Length( degrees_d ) ], p -> degrees_d[p] = d );
        pos_dp1 := Filtered( [ 1 .. Length( degrees_dp1 ) ], p -> degrees_dp1[p] = d + 1 );
        
        AM_d := certain_relations( MatrixOfMap( m_d ), pos_d );
        AM_dp1 := certain_relations( MatrixOfMap( m_dp1 ), pos_dp1 );
        
        AM_d := presentation( A * AM_d, -DegreesOfGenerators( M_d ) );
        AM_dp1 := presentation( A * AM_dp1, -DegreesOfGenerators( M_dp1 ) );
        
    fi;
    
    return GradedMap( rep, AM_d, AM_dp1 );
    
end );

##
InstallMethod( RepresentationMapOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( d, M )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return RepresentationMapOfKoszulId( d, M, A );
    
end );

##  <#GAPDoc Label="KoszulRightAdjoint">
##  <ManSection>
##    <Oper Arg="M, degree_lowest, degree_highest" Name="KoszulRightAdjoint"/>
##    <Returns>a &homalg; cocomplex</Returns>
##    <Description>
##      It is assumed that all indeterminates of the underlying &homalg; graded ring <M>S</M> are of degree <M>1</M>.
##      Compute the &homalg; <M>A</M>-cocomplex <M>C</M> of Koszul maps of the &homalg; <M>S</M>-module <A>M</A>
##      (&see; <Ref Oper="RepresentationMapOfKoszulId"/>) in the <M>[</M> <A>degree_lowest</A> .. <A>degree_highest</A> <M>]</M>.
##      The Castelnuovo-Mumford regularity of <A>M</A> is characterized as the highest degree <M>d</M>, such that
##      <M>C</M> is not exact at <M>d</M>. <M>A</M> is the Koszul dual ring of <M>S</M>,
##      defined using the operation <C>KoszulDualRing</C>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> A := KoszulDualRing( S, "a,b,c" );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> CastelnuovoMumfordRegularity( M );
##  1
##  gap> R := KoszulRightAdjoint( M, -5, 5 );
##  <A cocomplex containing 10 morphisms of left modules at degrees [ -5 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, 1, 5 );
##  <An acyclic cocomplex containing 4 morphisms of left modules at degrees 
##  [ 1 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, 0, 5 );
##  <A cocomplex containing 5 morphisms of left modules at degrees [ 0 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, -5, 5 );
##  <A cocomplex containing 10 morphisms of left modules at degrees [ -5 .. 5 ]>
##  gap> H := Cohomology( R );
##  <A graded cohomology object consisting of 11 left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> ByASmallerPresentation( H );
##  <A non-zero graded cohomology object consisting of 11 left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> Cohomology( R, -2 );
##  <A zero left module>
##  gap> Cohomology( R, -3 );
##  <A zero left module>
##  gap> Cohomology( R, -1 );
##  <A graded non-zero cyclic left module presented by 2 relations for a cyclic ge\
##  nerator>
##  gap> Cohomology( R, 0 );
##  <A graded cyclic left module presented by 3 relations for a cyclic generator>
##  gap> Cohomology( R, 1 );
##  <A graded cyclic left module presented by 2 relations for a cyclic generator>
##  gap> Cohomology( R, 2 );
##  <A zero left module>
##  gap> Cohomology( R, 3 );
##  <A zero left module>
##  gap> Cohomology( R, 4 );
##  <A zero left module>
##   gap> Display( Cohomology( R, -1 ) );
##   Q{a,b,c}/< b, a >  (graded, generator degree: 3)
##   gap> Display( Cohomology( R, 0 ) );
##   Q{a,b,c}/< c, b, a > (graded, generator degree: 3)
##   gap> Display( Cohomology( R, 1 ) );
##   Q{a,b,c}/< b, a >  (graded, generator degree: 1)
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KoszulAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    local d, tate, C, i, source, target;
    
    if degree_lowest >= degree_highest then
        
        d := degree_lowest;
        
        tate := RepresentationMapOfKoszulId( d, M, A );
        
        C := HomalgCocomplex( tate, d );
        
        return C;
        
    fi;
        
    tate := RepresentationMapOfKoszulId( degree_lowest, M, A );
    
    C := HomalgCocomplex( tate, degree_lowest );
    
    ## above the Castelnuovo-Mumford regularity we have acyclicity
    for i in [ degree_lowest + 1 .. degree_highest - 1 ] do
        
        source := Range( tate );
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( i, M, A );
        
        target := Range( tate );
        
        tate := MatrixOfMap( tate );
        
        tate := HomalgMap( tate, source, target );
        
        Add( C, tate );
    od;
    
    if CastelnuovoMumfordRegularity( M ) <= degree_lowest then
         
         ## check assertion
         Assert( 1, IsAcyclic( C ) );
         
         SetIsAcyclic( C, true );
         
    fi;
    
    ## check assertion
    Assert( 1, IsComplex( C ) );
    
    SetIsComplex( C, true );
    
    C!.display_twist := true;
    
    return C;
    
end );

##
InstallMethod( KoszulAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return KoszulAdjoint( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulAdjoint,
        "for homalg graded modules",
        [ IsStructureObject, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( S, A, degree_lowest, degree_highest )
    
    return KoszulAdjoint( FreeRightModuleWithDegrees( 1, S ), A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulAdjoint,
       "for homalg graded modules",
        [ IsStructureObject, IsInt, IsInt ],
        
  function( S, degree_lowest, degree_highest )
    
    return KoszulAdjoint( FreeRightModuleWithDegrees( 1, S ), degree_lowest, degree_highest );
    
end );

InstallMethod( KoszulAdjointOnMorphisms,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    local T_source, T_range, i, T, ii;
    
    T_source := KoszulAdjoint( Source( phi ), A, degree_lowest, degree_highest );
    T_range := KoszulAdjoint( Range( phi ), A, degree_lowest, degree_highest );
    
    # create the map in each step by converting its homogeneous part to the dual ring.
    i := degree_highest - 1;
    T := HomalgChainMap( GradedMap( A * MatrixOfMap( HomogeneousPartOverCoefficientsRing( i, phi ) ), CertainObject( T_source, i ), CertainObject( T_range, i ) ), T_source, T_range, i );
    
    for ii in [ degree_lowest .. degree_highest - 2 ] do
        
        i := ( degree_highest - 2 ) + degree_lowest - ii;
        
        Add( GradedMap( A * MatrixOfMap( HomogeneousPartOverCoefficientsRing( i, phi ) ), CertainObject( T_source, i ), CertainObject( T_range, i ) ), T );
        
    od;

    return T;
    
end );

##
InstallMethod( KoszulAdjointOnMorphisms,
        "for graded maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return KoszulAdjointOnMorphisms( phi, A, degree_lowest, degree_highest );
    
end );


##
## KoszulRightAdjoint
##

InstallGlobalFunction( _Functor_KoszulRightAdjoint_OnGradedModules , ### defines: KoszulRightAdjoint (object part)
        [ IsList, IsGradedModuleRep ],
        
  function( l, M )
    local A, degree_lowest, degree_highest;
    
    if not Length( l ) = 3 then
        Error( "wrong type of parameters" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not IsHomalgGradedRing( A ) and IsFreePolynomialRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) then
            Error( "wrong type of parameters" );
        fi;
    fi;
    
    return KoszulAdjoint( M, A, degree_lowest, degree_highest );
    
end );


##
InstallGlobalFunction( _Functor_KoszulRightAdjoint_OnGradedMaps, ### defines: KoszulRightAdjoint (morphism part)
        [ IsList, IsMapOfGradedModulesRep ],
  function( l, phi )
    local A, degree_lowest, degree_highest;
    
    if not Length( l ) = 3 then
        Error( "wrong type of parameters" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not IsHomalgGradedRing( A ) and IsFreePolynomialRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) then
            Error( "wrong type of parameters" );
        fi;
    fi;
    
    return KoszulAdjointOnMorphisms( phi, A, degree_lowest, degree_highest );
    
end );

InstallValue( Functor_KoszulRightAdjoint_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "KoszulRightAdjoint" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "KoszulRightAdjoint" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsList ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_KoszulRightAdjoint_OnGradedModules ],
                [ "OnMorphisms", _Functor_KoszulRightAdjoint_OnGradedMaps ],
                [ "IsIdentityOnObjects", true ]
                )
        );

Functor_KoszulRightAdjoint_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_KoszulRightAdjoint_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_KoszulRightAdjoint_ForGradedModules );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    local d, tate, C, i, source, target;
    
    S := HomalgRing( M );
    
    if not IsFreePolynomialRing( S ) and IsHomalgGradedRingRep( S ) then
        TryNextMethod();
    fi;
    
    A := KoszulDualRing( S );
    
    return KoszulRightAdjoint( [ A, degree_lowest, degree_highest ], M );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local S, A;
    
    S := HomalgRing( M );
    
    if not IsFreePolynomialRing( S ) and IsHomalgGradedRingRep( S ) then
        TryNextMethod();
    fi;
    
    A := KoszulDualRing( S );
    
    return KoszulRightAdjoint( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsFreePolynomialRing and IsHomalgGradedRingRep, IsHomalgGradedRingRep and IsExteriorRing, IsInt, IsInt ],
        
  function( S, A, degree_lowest, degree_highest )
    
    return KoszulRightAdjoint( FreeRightModuleWithDegrees( 1, S ), A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsFreePolynomialRing and IsHomalgGradedRingRep, IsInt, IsInt ],
        
  function( S, degree_lowest, degree_highest )
    
    return KoszulRightAdjoint( FreeRightModuleWithDegrees( 1, S ), degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    
    return KoszulRightAdjoint( [ A, degree_lowest, degree_highest ], phi );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return KoszulRightAdjoint( [ A, degree_lowest, degree_highest ], phi );
    
end );

