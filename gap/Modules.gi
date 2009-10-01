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

##
InstallMethod( ListOfDegreesOfMultiGradedRing,
        "for homalg rings",
        [ IsInt, IsHomalgRing, IsHomogeneousList ],	## FIXME: is IsHomogeneousList too expensive?
        
  function( l, R, weights )
    local indets, n, B, j, w, wlist, i, k;
    
    if l < 1 then
        Error( "the first argument must be a positiv integer\n" );
    fi;
    
    indets := Indeterminates( R );
    
    if not Length( weights ) = Length( indets ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if IsList( weights[1] ) and Length( weights[1] ) = l then
        return List( [ 1 .. l ], i -> List( weights, w -> w[i] ) );
    fi;
    
    ## the rest handles the (improbable?) case of successive extensions
    ## without multiple weights
    
    if l = 1 then
        return [ weights ];
    fi;
    
    n := Length( weights );
    
    if not HasBaseRing( R ) then
        Error( "no 1. base ring found\n" );
    fi;
    
    B := BaseRing( R );
    j := Length( Indeterminates( B ) );
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 0 ),
                 ListWithIdenticalEntries( n - j, 1 )
                 );
    
    wlist := [ ListN( w, weights, \* ) ];
    
    for i in [ 2 .. l - 1 ] do
        
        if not HasBaseRing( B ) then
            Error( "no ", i, ". base ring found\n" );
        fi;
        
        B := BaseRing( B );
        k := Length( Indeterminates( B ) );
        
        w := Concatenation(
                     ListWithIdenticalEntries( k, 0 ),
                     ListWithIdenticalEntries( j - k, 1 ),
                     ListWithIdenticalEntries( n - j, 0 )
                     );
        
        Add( wlist, ListN( w, weights, \* ) );
        
        j := k;
        
    od;
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 1 ),
                 ListWithIdenticalEntries( n - j, 0 )
                 );
    
    Add( wlist, ListN( w, weights, \* ) );
    
    return wlist;
    
end );

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
        [ IsInt, IsHomalgRing, IsList ],
        
  function( d, R, weights )
    local RP, vars, mon;
    
    RP := homalgTable( R );
    
    if d < 0 then	## we only accept weights 1 or 0
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    vars := Indeterminates( R );
    
    if not Length( weights ) = Length( Indeterminates( R ) ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if not Set( weights ) = [ 1 ] then
        
        ## the variables of weight 1
        vars := vars{Filtered( [ 1 .. Length( weights ) ], p -> weights[p] = 1 )};
        
    fi;
    
    if IsBound(RP!.MonomialMatrix) then
        mon := RP!.MonomialMatrix( d, vars, R );	## the external object
        mon := HomalgMatrix( mon, R );
        SetNrColumns( mon, 1 );
        if d = 0 then
            IsIdentityMatrix( mon );
        fi;
        return mon;
    fi;
    
    if IsHomalgExternalRingRep( R ) then
        Error( "could not find a procedure called MonomialMatrix in the homalgTable of the external ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TryNextMethod( );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsInt, IsHomalgRing ],
        
  function( d, R )
    
    return MonomialMatrix( d, R, WeightsOfIndeterminates( R ) );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsList, IsHomalgRing, IsList ],
        
  function( d, R, weights )
    local l, mon, w;
    
    if not Length( weights ) = Length( Indeterminates( R ) ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    l := Length( d );
    
    w := ListOfDegreesOfMultiGradedRing( l, R, weights );
    
    mon := List( [ 1 .. l ] , i -> MonomialMatrix( d[i], R, w[i] ) );
    
    return Iterated( mon, KroneckerMat );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsList, IsHomalgRing ],
        
  function( d, R )
    
    return MonomialMatrix( d, R, WeightsOfIndeterminates( R ) );
    
end );

##  <#GAPDoc Label="MonomialMap">
##  <ManSection>
##    <Oper Arg="d, M" Name="MonomialMap"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The map from a free graded module onto all degree <A>d</A> monomial generators
##      of the finitely generated &homalg; module <A>M</A>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
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

##  <#GAPDoc Label="RandomMatrixBetweenGradedFreeLeftModules">
##  <ManSection>
##    <Oper Arg="weightsS,weightsT,R" Name="RandomMatrixBetweenGradedFreeLeftModules"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random <M>r \times c </M>-matrix between the graded free <E>left</E> modules
##      <M><A>R</A>^{(-<A>weightsS</A>)} \to <A>R</A>^{(-<A>weightsT</A>)}</M>,
##      where <M>r = </M><C>Length</C><M>(</M><A>weightsS</A><M>)</M> and
##      <M>c = </M><C>Length</C><M>(</M><A>weightsT</A><M>)</M>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> rand := RandomMatrixBetweenGradedFreeLeftModules( [ 2, 3, 4 ], [ 1, 2 ], R );
##  <A homalg external 3 by 2 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( rand );
##  a-2*b+2*c,                                                2,                 
##  a^2-a*b+b^2-2*b*c+5*c^2,                                  3*c,               
##  2*a^3-3*a^2*b+2*a*b^2+3*a^2*c+a*b*c-2*b^2*c-3*b*c^2-2*c^3,a^2-4*a*b-3*a*c-c^2
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrixBetweenGradedFreeLeftModules,
        "for homalg rings",
        [ IsList, IsList, IsHomalgRing ],
        
  function( weightsS, weightsT, R )
    local RP, r, c, rand, i, j, mon;
    
    RP := homalgTable( R );
    
    r := Length( weightsS );
    c := Length( weightsT );
    
    if weightsT = [ ] then
        return HomalgZeroMatrix( 0, c, R );
    elif weightsS = [ ] then
        return HomalgZeroMatrix( r, 0, R );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, weightsT, weightsS );	## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return rand;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := MonomialMatrix( weightsS[i] - weightsT[j], R );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG.ZZ ) ) * mon;
            mon := GetEntryOfHomalgMatrix( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return HomalgMatrix( rand, r, c, R );
    
end );

##  <#GAPDoc Label="RandomMatrixBetweenGradedFreeRightModules">
##  <ManSection>
##    <Oper Arg="weightsT,weightsS,R" Name="RandomMatrixBetweenGradedFreeRightModules"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random <M>r \times c </M>-matrix between the graded free <E>right</E> modules
##      <M><A>R</A>^{(-<A>weightsS</A>)} \to <A>R</A>^{(-<A>weightsT</A>)}</M>,
##      where <M>r = </M><C>Length</C><M>(</M><A>weightsT</A><M>)</M> and
##      <M>c = </M><C>Length</C><M>(</M><A>weightsS</A><M>)</M>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> rand := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], R );
##  <A homalg external 2 by 3 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( rand );
##  a-2*b-c,a*b+b^2-b*c,2*a^3-a*b^2-4*b^3+4*a^2*c-3*a*b*c-b^2*c+a*c^2+5*b*c^2-2*c^3,
##  -5,     -2*a+c,     -2*a^2-a*b-2*b^2-3*a*c                                      
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrixBetweenGradedFreeRightModules,
        "for homalg rings",
        [ IsList, IsList, IsHomalgRing ],
        
  function( weightsT, weightsS, R )
    local RP, r, c, rand, i, j, mon;
    
    RP := homalgTable( R );
    
    r := Length( weightsT );
    c := Length( weightsS );
    
    if weightsT = [ ] then
        return HomalgZeroMatrix( 0, c, R );
    elif weightsS = [ ] then
        return HomalgZeroMatrix( r, 0, R );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, weightsT, weightsS );	## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return rand;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := MonomialMatrix( weightsS[j] - weightsT[i], R );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG.ZZ ) ) * mon;
            mon := GetEntryOfHomalgMatrix( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return HomalgMatrix( rand, r, c, R );
    
end );

##  <#GAPDoc Label="RandomMatrix">
##  <ManSection>
##    <Oper Arg="S,T" Name="RandomMatrix"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random matrix between the graded source module <A>S</A> and the graded target module <A>T</A>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> rand := RandomMatrix( ( R * 1 )^[ 1, 2 ], ( R * 1 )^[ 2, 3, 4 ] );
##  <A homalg external 3 by 2 matrix>
##  ]]></Example>
##      <Log><![CDATA[
##  -3*a-b,                                                  -1,                   
##  -a^2+a*b+2*b^2-2*a*c+2*b*c+c^2,                          -a+c,                 
##  -2*a^3+5*a^2*b-3*b^3+3*a*b*c+3*b^2*c+2*a*c^2+2*b*c^2+c^3,-3*b^2-2*a*c-2*b*c+c^2
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrix,
        "for homalg rings",
        [ IsHomalgModule, IsHomalgModule ],
        
  function( S, T )
    local left, degreesS, degreesT, R;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( S );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( T ) <> left then
        Error( "both modules must either be left or either be right modules" );
    fi;
    
    degreesS := DegreesOfGenerators( S );
    degreesT := DegreesOfGenerators( T );
    
    if not IsList( degreesS ) then
        Error( "the source module is not graded\n" );
    elif not IsList( degreesT ) then
        Error( "the target module is not graded\n" );
    fi;
    
    R := HomalgRing( S );
    
    if left then
        return RandomMatrixBetweenGradedFreeLeftModules( degreesS, degreesT, R );
    else
        return RandomMatrixBetweenGradedFreeRightModules( degreesT, degreesS, R );
    fi;
    
end );

##  <#GAPDoc Label="BasisOfHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="BasisOfHomogeneousPart"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The resulting &homalg; matrix consists of a <M>R</M>-basis of the <A>d</A>-th homogeneous part
##      of the finitely generated &homalg; <M>S</M>-module <A>M</A>, where <M>R</M> is the ground ring
##      of the graded ring <M>S</M> with <M>S_0=R</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
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
##      The submodule of the &homalg; module <A>M</A> generated by the image of the <A>d</A>-th monomial map
##      (&see; <Ref Oper="MonomialMap"/>), or equivalently, by the basis of the <A>d</A>-th homogeneous part of <A>M</A>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> n := SubmoduleGeneratedByHomogeneousPart( 1, M );
##  <A graded left submodule given by 7 generators>
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
##  gap> Display( n );
##  x^2,0,0,
##  x*y,0,0,
##  y^2,0,0,
##  0,  x,0,
##  0,  y,0,
##  0,  z,0,
##  0,  0,1 
##  
##  A left submodule generated by the 7 rows of the above matrix
##  ]]></Log>
##      <Example><![CDATA[
##  gap> N := UnderlyingObject( n );
##  <A graded left module presented by yet unknown relations for 7 generators>
##  ]]></Example>
##      <Log><![CDATA[
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
    
    return Subobject( BasisOfHomogeneousPart( d, M ), M );
    
end );

##
InstallMethod( SubmoduleGeneratedByHomogeneousPart,
        "for homalg submodules",
        [ IsInt, IsFinitelyPresentedSubmoduleRep ],
        
  function( d, N )
    
    return SubmoduleGeneratedByHomogeneousPart( d, UnderlyingObject( N ) );
    
end );

##  <#GAPDoc Label="RepresentationOfRingElement">
##  <ManSection>
##    <Oper Arg="r, M, d" Name="RepresentationOfRingElement"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The &homalg; matrix induced by the homogeneous degree <E><M>1</M></E> ring element <A>r</A>
##      (of the underlying &homalg; graded ring <M>S</M>) regarded as a <M>R</M>-linear map
##      between the <A>d</A>-th and the <M>(</M><A>d</A><M>+1)</M>-st homogeneous part of the finitely generated
##      &homalg; <M>S</M>-module <M>M</M>, where <M>R</M> is the ground ring of the graded ring <M>S</M>
##      with <M>S_0=R</M>. The basis of both vector spaces is given by <Ref Oper="BasisOfHomogeneousPart"/>. The
##      entries of the matrix lie in the ground ring <M>R</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> x := Indeterminate( S, 1 );
##  x
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
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
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
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
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
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
    local left, rep, weights, presentation, certain_relations, M_d, M_dp1,
          m_d, m_dp1, degrees_d, degrees_dp1, pos_d, pos_dp1, AM_d, AM_dp1;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    rep := RepresentationMatrixOfKoszulId( d, M, A );
    
    ## now determine the source and target modules
    
    weights := WeightsOfIndeterminates( HomalgRing( M ) );
    
    if Set( weights ) = [ 1 ] then
        
        if left then
            AM_d := HomalgFreeLeftModuleWithDegrees( NrRows( rep ), A, -d );
            AM_dp1 := HomalgFreeLeftModuleWithDegrees( NrColumns( rep ), A, -d - 1 );
        else
            AM_d := HomalgFreeRightModuleWithDegrees( NrColumns( rep ), A, -d );
            AM_dp1 := HomalgFreeRightModuleWithDegrees( NrRows( rep ), A, -d - 1 );
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
        
        m_d := PresentationMap( M_d );
        m_dp1 := PresentationMap( M_dp1 );
        
        degrees_d := DegreesOfGenerators( Source( m_d ) );
        degrees_dp1 := DegreesOfGenerators( Source( m_dp1 ) );
        
        pos_d := Filtered( [ 1 .. Length( degrees_d ) ], p -> degrees_d[p] = d );
        pos_dp1 := Filtered( [ 1 .. Length( degrees_dp1 ) ], p -> degrees_dp1[p] = d + 1 );
        
        AM_d := certain_relations( MatrixOfMap( m_d ), pos_d );
        AM_dp1 := certain_relations( MatrixOfMap( m_dp1 ), pos_dp1 );
        
        AM_d := presentation( A * AM_d, -DegreesOfGenerators( M_d ) );
        AM_dp1 := presentation( A * AM_dp1, -DegreesOfGenerators( M_dp1 ) );
        
    fi;
    
    return HomalgMap( rep, AM_d, AM_dp1 );
    
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
##  <A graded non-zero cyclic left module presented by
##  2 relations for a cyclic generator>
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

##  <#GAPDoc Label="HomogeneousPartOverCoefficientsRing">
##  <ManSection>
##    <Oper Arg="d, M" Name="HomogeneousPartOverCoefficientsRing"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The degree <M>d</M> homogeneous part of the graded <M>R</M>-module <A>M</A>
##      as a module over the coefficient ring or field of <M>R</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x, y^2, z^3 ]", 3, 1, S );;
##  gap> M := Subobject( M, ( 1 * S )^0 );
##  <A graded (left) ideal given by 3 generators>
##  gap> CastelnuovoMumfordRegularity( M );
##  4
##  gap> M1 := HomogeneousPartOverCoefficientsRing( 1, M );
##  <A free left module of rank 1 on a free generator>
##  gap> gen1 := GeneratorsOfModule( M1 );
##  <A set consisting of a single generator of a homalg left module>
##  gap> Display( M1 );
##  Q^(1 x 1)
##  gap> M2 := HomogeneousPartOverCoefficientsRing( 2, M );
##  <A free left module of rank 4 on free generators>
##  gap> Display( M2 );
##  Q^(1 x 4)
##  gap> gen2 := GeneratorsOfModule( M2 );
##  <A set of 4 generators of a homalg left module>
##  gap> M3 := HomogeneousPartOverCoefficientsRing( 3, M );
##  <A free left module of rank 9 on free generators>
##  gap> Display( M3 );
##  Q^(1 x 9)
##  gap> gen3 := GeneratorsOfModule( M3 );
##  <A set of 9 generators of a homalg left module>
##  ]]></Example>
##      <Log><![CDATA[
##  gap> Display( gen1 );
##  x
##  
##  a set consisting of a single generator given by (the row of) the above matrix
##  gap> Display( gen2 );
##  x^2,
##  x*y,
##  x*z,
##  y^2 
##  
##  a set of 4 generators given by the rows of the above matrix
##  gap> Display( gen3 );
##  x^3,  
##  x^2*y,
##  x^2*z,
##  x*y*z,
##  x*z^2,
##  x*y^2,
##  y^3,  
##  y^2*z,
##  z^3   
##  
##  a set of 9 generators given by the rows of the above matrix
##  ]]></Log>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomogeneousPartOverCoefficientsRing,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleOrSubmoduleRep ],
        
  function( d, M )
    local R, k, N, gen, l, rel;
    
    R := HomalgRing( M );
    
    if not HasCoefficientsRing( R ) then
        TryNextMethod( );
    fi;
    
    k := CoefficientsRing( R );
    
    N := SubmoduleGeneratedByHomogeneousPart( d, M );
    
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
    
    return Presentation( gen, rel );
    
end );

