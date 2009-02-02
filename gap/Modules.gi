#############################################################################
##
##  Modules.gi                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations of procedures for modules.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="MonomialMatrix">
##  <ManSection>
##    <Oper Arg="d, R" Name="MonomialMatrix"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The column matrix of <A>d</A>-th monomials of the &homalg; graded ring <A>R</A>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> m := MonomialMatrix( 2, S );
##  <A homalg external (unknown number of rows) by 1 matrix>
##  gap> NrRows( m );
##  6
##  gap> m;
##  <A homalg external 6 by 1 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( m );
##  z^2,
##  y*z,
##  y^2,
##  x*z,
##  x*y,
##  x^2 
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsInt, IsHomalgRing ],
        
  function( d, R )
    local RP, mon;
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) = [ 1 ] and
       d < 0 then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    if IsBound(RP!.MonomialMatrix) then
        mon := RP!.MonomialMatrix( d, R );	## the external object
        mon := HomalgMatrix( mon, R );
        SetNrColumns( mon, 1 );
        if d = 0 then
            IsIdentityMatrix( mon );
        fi;
        return mon;
    fi;
    
    if IsHomalgExternalRingRep( R ) then
        Error( "could not find a procedure called MonomialMatrix in the homalgTable to apply on a an external ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TryNextMethod( );
    
end );

##  <#GAPDoc Label="MonomialMap">
##  <ManSection>
##    <Oper Arg="i, M" Name="MonomialMap"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The map from a free graded module onto all degree <A>d</A> monomial generators
##      of the finitely generated &homalg; module <M>M</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> m := MonomialMap( 1, M );
##  <A homomorphism of left modules>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( m );
##  z^2,0,0,
##  y*z,0,0,
##  y^2,0,0,
##  x*z,0,0,
##  x*y,0,0,
##  x^2,0,0,
##  0,  x,0,
##  0,  y,0,
##  0,  z,0,
##  0,  0,1 
##  
##  (target generators degrees: [ -1, 0, 1 ])
##  
##  the map is currently represented by the above 10 x 3 matrix
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( MonomialMap,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( d, M )
    local R, degrees, mon, i;
    
    R := HomalgRing( M );
    
    if IsList( DegreesOfGenerators( M ) ) then
        degrees := DegreesOfGenerators( M );
    else
        degrees := ListWithIdenticalEntries( NrGenerators( M ), 0 );
    fi;
    
    mon := rec( );
    
    for i in Set( degrees ) do
        mon.(String( d - i )) := MonomialMatrix( d - i, R );
    od;
    
    mon := List( degrees, i -> mon.(String(d - i)) );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mon := List( mon, Involution );
    fi;
    
    if mon <> [ ] then
        mon := DiagMat( mon );
    else
        mon := HomalgZeroMatrix( 0, 0, R );
    fi;
    
    return HomalgMap( mon, "free", M );
    
end );

##  <#GAPDoc Label="BasisOfHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="BasisOfHomogeneousPart"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The resulting &homalg; matrix consists of a <M>k</M>-basis of the <A>d</A>-th homogeneous part
##      of the finitely generated &homalg; <M>S</M>module <M>M</M>, where <M>k</M> is the ground field
##      of the graded ring <M>S</M> and <M>k=S_0</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> m := BasisOfHomogeneousPart( 1, M );
##  <An unevaluated homalg external 7 by 3 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( m );
##  y^2,0,0,
##  x*y,0,0,
##  x^2,0,0,
##  0,  x,0,
##  0,  y,0,
##  0,  z,0,
##  0,  0,1 
##  ]]></Log>
##  Compare with <Ref Oper="MonomialMap"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfHomogeneousPart,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( d, M )
    local M_d, diff, bas;
    
    ## the map of generating monomials of degree d
    M_d := MonomialMap( d, M );
    
    ## the matrix of generating monomials of degree d
    M_d := MatrixOfMap( M_d );
    
    ## the basis monomials are not altered by reduction
    diff := M_d - DecideZero( M_d, M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        bas := ZeroRows( diff );
        return CertainRows( M_d, bas );
    else
        bas := ZeroColumns( diff );
        return CertainColumns( M_d, bas );
    fi;
    
end );

##  <#GAPDoc Label="SubmoduleGeneratedByHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="SubmoduleGeneratedByHomogeneousPart"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The submodule of the &homalg; module <M>M</M> generated by the image of the <A>d</A>-th monomial map
##      (&see; <Ref Oper="MonomialMap"/>).
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> N := SubmoduleGeneratedByHomogeneousPart( 1, M );
##  <A graded left module presented by 11 relations for 7 generators>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( M );
##  z,  0,    0,  
##  0,  y^2*z,z^2,
##  x^3,y^2,  z   
##  
##  (graded, generators degrees: [ -1, 0, 1 ])
##  
##  Cokernel of the map
##  
##  Q[x,y,z]^(1x3) --> Q[x,y,z]^(1x3),
##  
##  currently represented by the above matrix
##  gap> Display( N );
##  z,0, 0, 0,    0,  0,0,   
##  0,z, 0, 0,    0,  0,0,   
##  0,0, z, 0,    0,  0,0,   
##  0,0, 0, 0,    -z, y,0,   
##  x,-y,0, 0,    0,  0,0,   
##  0,x, -y,0,    0,  0,0,   
##  0,0, x, 0,    y,  0,z,   
##  0,0, 0, -y,   x,  0,0,   
##  0,0, 0, -z,   0,  x,0,   
##  0,0, 0, 0,    y*z,0,z^2, 
##  0,0, 0, y^2*z,0,  0,x*z^2
##  
##  (graded, generators degrees: [ 1, 1, 1, 1, 1, 1, 1 ])
##  
##  Cokernel of the map
##  
##  Q[x,y,z]^(1x11) --> Q[x,y,z]^(1x7),
##  
##  currently represented by the above matrix
##  ]]></Log>
##      <Example><![CDATA[
##  gap> gens := GeneratorsOfModule( N );
##  <A set of 7 generators of a homalg left module>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( gens );
##  a set of 7 generators given by the rows of the matrix
##  
##  y^2,0,0,
##  x*y,0,0,
##  x^2,0,0,
##  0,  x,0,
##  0,  y,0,
##  0,  z,0,
##  0,  0,1 
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SubmoduleGeneratedByHomogeneousPart,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( d, M )
    local M_geq_d;
    
    M_geq_d := BasisOfHomogeneousPart( d, M );
    
    M_geq_d := HomalgMap( M_geq_d, "free", M );
    
    M_geq_d := ImageSubmodule( M_geq_d );
    
    return M_geq_d;
    
end );

##  <#GAPDoc Label="RepresentationOfRingElement">
##  <ManSection>
##    <Oper Arg="r, M, d" Name="RepresentationOfRingElement"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The &homalg; matrix induced by the homogeneous degree <E><M>1</M></E> ring element <A>r</A>
##      (of the underlying &homalg; graded ring <M>S</M>) regarded as a <M>k</M>-linear map
##      between the <A>d</A>-th and the <M>(</M><A>d</A><M>+1)</M>-st homogeneous part of the finitely generated
##      &homalg; <M>S</M>-module <M>M</M>, where <M>k</M> is the ground field of the graded ring <M>S</M>
##      and <M>k=S_0</M>. The basis of both vector spaces is given by <Ref Oper="BasisOfHomogeneousPart"/>. The
##      entries of the matrix lie in the ground field <M>k</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> x := Indeterminate( S, 1 );
##  x
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationOfRingElement( x, M, 0 );
##  <An unevaluated homalg external 3 by 7 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( m );
##  0,0,1,0,0,0,0,
##  0,1,0,0,0,0,0,
##  0,0,0,1,0,0,0 
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationOfRingElement,
        "for homalg ring elements",
        [ IsRingElement, IsFinitelyPresentedModuleRep, IsInt ],
        
  function( r, M, d )
    local bd, bdp1, mat;
    
    bd := BasisOfHomogeneousPart( d, M );
    
    bdp1 := BasisOfHomogeneousPart( d + 1, M );
    
    bd := r * bd;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return RightDivide( bd, bdp1, RelationsOfModule( M ) );
    else
        return LeftDivide( bdp1, bd, RelationsOfModule( M ) );
    fi;
    
end );

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
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationMatrixOfKoszulId( 0, M );
##  <An unevaluated homalg external 3 by 7 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( m );
##  0,b,a,0,0,0,0,
##  b,a,0,0,0,0,0,
##  0,0,0,a,b,c,0 
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationMatrixOfKoszulId,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep, IsHomalgRing and IsExteriorRing ],
        
  function( d, M, A )
    local vars, dual, reps;
    
    vars := Indeterminates( HomalgRing( M ) );
    dual := Indeterminates( A );
    
    ## this whole computation is over R = HomalgRing( M )
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
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
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
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationMapOfKoszulId( 0, M );
##  <A homomorphism of left modules>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( m );
##  0,b,a,0,0,0,0,
##  b,a,0,0,0,0,0,
##  0,0,0,a,b,c,0 
##  
##  (target generators degrees: [ -1, -1, -1, -1, -1, -1, -1 ])
##  
##  the map is currently represented by the above 3 x 7 matrix
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationMapOfKoszulId,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep, IsHomalgRing and IsExteriorRing ],
        
  function( d, M, A )
    local tate, F_source, F_target;
    
    tate := RepresentationMatrixOfKoszulId( d, M, A );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        F_source := HomalgFreeLeftModuleWithDegrees( NrRows( tate ), A, -d );
        F_target := HomalgFreeLeftModuleWithDegrees( NrColumns( tate ), A, -d - 1 );
    else
        F_source := HomalgFreeRightModuleWithDegrees( NrColumns( tate ), A, -d );
        F_target := HomalgFreeRightModuleWithDegrees( NrRows( tate ), A, -d - 1 );
    fi;
    
    return HomalgMap( tate, F_source, F_target );
    
end );

##
InstallMethod( RepresentationMapOfKoszulId,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
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
##  <A non-zero graded left module presented by 2 relations for 3 generators>
##  gap> CastelnuovoMumfordRegularity( M );
##  1
##  gap> R := KoszulRightAdjoint( M, -5, 5 );
##  <A cocomplex containing 10 morphisms of left modules at degrees [ -5 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, 1, 5 );
##  <An acyclic cocomplex containing 4 morphisms of left modules at degrees [ 1 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, 0, 5 );
##  <A cocomplex containing 5 morphisms of left modules at degrees [ 0 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, -5, 5 );
##  <A cocomplex containing 10 morphisms of left modules at degrees [ -5 .. 5 ]>
##  gap> H := Cohomology( R );
##  <A graded cohomology object consisting of 11 left modules at degrees [ -5 .. 5 ]>
##  gap> ByASmallerPresentation( H );
##  <A non-zero graded cohomology object consisting of 11 left modules at degrees [ -5 .. 5 ]>
##  gap> Cohomology( R, -2 );
##  <A zero left module>
##  gap> Cohomology( R, -3 );
##  <A zero left module>
##  gap> Cohomology( R, -1 );
##  <A non-zero cyclic graded left module presented by 2 relations for a cyclic generator>
##  gap> Cohomology( R, 0 );
##  <A cyclic graded left module presented by 3 relations for a cyclic generator>
##  gap> Cohomology( R, 1 );
##  <A cyclic graded left module presented by 2 relations for a cyclic generator>
##  gap> Cohomology( R, 2 );
##  <A zero left module>
##  gap> Cohomology( R, 3 );
##  <A zero left module>
##  gap> Cohomology( R, 4 );
##  <A zero left module>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( Cohomology( R, -1 ) );
##  Q{a,b,c}/< b, a >	(graded, generator degree: 3)
##  gap> Display( Cohomology( R, 0 ) );
##  Q{a,b,c}/< c, b, a >	(graded, generator degree: 3)
##  gap> Display( Cohomology( R, 1 ) );
##  Q{a,b,c}/< b, a >	(graded, generator degree: 1)
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KoszulRightAdjoint,
        "for homalg modules",
        [ IsHomalgRingOrFinitelyPresentedObjectRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( _M, A, degree_lowest, degree_highest )
    local M, d, tate, C, i, source, target;
    
    if IsHomalgRing( _M ) then
        M := HomalgFreeRightModuleWithDegrees( 1, _M );
    else
        M := _M;
    fi;
    
    if degree_lowest >= degree_highest then
        
        d := degree_lowest;
        
        tate := RepresentationMapOfKoszulId( d, M, A );
        
        C := HomalgCocomplex( tate, d );
        
        return C;
        
    fi;
    
    ## the following code could be simplified if we drop
    ## the ability to check the below assertions,
    ## and to be able to check the assertions we construct
    ## the resulting complex in two stages:
    ## above and below the Castelnuovo-Mumford regularity
    ## (of course one of the two stages might be empty)
    
    d := CastelnuovoMumfordRegularity( M );
    
    if degree_highest - 1 >= d then
        
        d := Maximum( d, degree_lowest );
        
        tate := RepresentationMapOfKoszulId( d, M, A );
        
        C := HomalgCocomplex( tate, d );
        
        ## above the Castelnuovo-Mumford regularity we have acyclicity
        for i in [ d + 1 .. degree_highest - 1 ] do
            
            source := Range( tate );
            
            ## the Koszul map has linear entries by construction
            tate := RepresentationMapOfKoszulId( i, M, A );
            
            target := Range( tate );
            
            tate := MatrixOfMap( tate );
            
            tate := HomalgMap( tate, source, target );
            
            Add( C, tate );
        od;
        
        ## check assertion
        Assert( 1, IsAcyclic( C ) );
        
        SetIsAcyclic( C, true );
        
    else
        
        d := degree_highest - 1;
        
        tate := RepresentationMapOfKoszulId( d, M, A );
        
        C := HomalgCocomplex( tate, d );
        
    fi;
    
    tate := LowestDegreeMorphism( C );
    
    ## below the Castelnuovo-Mumford regularity we don't have acyclicity
    for i in [ 1 .. d - degree_lowest ] do
        
        target := Source( tate );
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( d - i, M, A );
        
        source := Source( tate );
        
        tate := MatrixOfMap( tate );
        
        tate := HomalgMap( tate, source, target );
        
        Add( tate, C );
        
    od;
    
    ## check assertion
    Assert( 1, IsComplex( C ) );
    
    SetIsComplex( C, true );
    
    C!.display_twist := true;
    
    return C;
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg modules",
        [ IsHomalgRingOrFinitelyPresentedObjectRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return KoszulRightAdjoint( M, A, degree_lowest, degree_highest );
    
end );

