#############################################################################
##
##  RingMaps.gi                 Graded Modules package
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations of procedures for ring maps.
##
#############################################################################

####################################
#
# methods for attributes:
#
####################################

##  <#GAPDoc Label="KernelSubobject">
##  <ManSection>
##    <Meth Arg="phi" Name="KernelSubobject"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      The kernel ideal of the ring map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KernelSubobject,
        "for homalg ring maps",
        [ IsHomalgRingMap and HasDegreeOfMorphism ],
        
  function( phi )
    local G, S, T, indetsS, indetsT, rel;
    
    G := CoordinateRingOfGraph( phi );
    
    S := Source( phi );
    T := Range( phi );
    
    indetsT := G!.indetsT;
    
    rel := RingRelations( G );
    rel := MatrixOfRelations( rel );
    rel := EntriesOfHomalgMatrix( rel );
    
    rel := Eliminate( rel, indetsT );
    
    rel := S * rel;
    
    if IsBound( phi!.left ) and phi!.left = false then
        S := S * 1;
    else
        S := 1 * S;	## the default
    fi;
    
    S := S^0;
    
    return Subobject( rel, S );
    
end );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="SegreMap">
##  <ManSection>
##    <Meth Arg="R,s" Name="SegreMap"/>
##    <Returns>a &homalg; ring map</Returns>
##    <Description>
##      The ring map corresponding to the Segre embedding of <M>MultiProj(<A>R</A>)</M> into the projective space according to
##      <M>P(W_1)\times P(W_2) \to P(W_1\otimes W_2)</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SegreMap,
        "for homalg rings",
        [ IsHomalgRing, IsString ],
        
  function( R, s )
    local weights, l, segre, N, S;
    
    weights := WeightsOfIndeterminates( R );
    
    if weights = [ ] then
        Error( "empty list of weights\n" );
    elif not ForAll( weights, IsList ) then
        Error( "not all weights are multi-weights\n" );
    fi;
    
    l := Length( weights[1] );
    
    segre := MonomialMatrix( ListWithIdenticalEntries( l, 1 ), R );
    
    N := NrRows( segre );
    
    S := Concatenation( s, String( 0 ), "..", s, String( N - 1 ) );
    
    S := CoefficientsRing( R ) * S;
    
    segre := RingMap( segre, S, R );
    
    SetIsMorphism( segre, true );
    
    SetDegreeOfMorphism( segre, 0 );
    
    return segre;
    
end );

##  <#GAPDoc Label="PlueckerMap">
##  <ManSection>
##    <Meth Arg="l,n,A,s" Name="PlueckerMap"/>
##    <Returns>a &homalg; ring map</Returns>
##    <Description>
##      The ring map corresponding to the Plücker embedding of the Grassmannian <M>G_l(P^{<A>n</A>}(<A>A</A>))=G_l(P(W))</M>
##      into the projective space <M>P(\bigwedge^l W)</M>, where <M>W=V^*</M> is the <M><A>A</A></M>-dual of the free module
##      <M>V=A^{<A>n</A>+1}</M> of rank <M><A>n</A>+1</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( PlueckerMap,
        "for homalg rings",
        [ IsPosInt, IsPosInt, IsHomalgRing, IsString ],
        
  function( l, n, A, s )
    local var, R, mat, choose, S, pluecker;
    
    if l > n then
        Error( "the first argument must be less or equal to the second one\n" );
    fi;
    
    var := List( [ 0 .. n ], i -> List( [ 1 .. l ], j -> Concatenation( "x", String( j ), "_", String( i ) ) ) );
    
    var := Concatenation( var );
    
    R := PolynomialRing( A, var );
    
    mat := JoinStringsWithSeparator( var );
    
    mat := HomalgMatrix( mat, n+1, l, R );
    
    choose := Combinations( [ 1 .. n + 1 ], l );
    
    S := PolynomialRing( A, Concatenation( s, String( 0 ), "..", s, String( Length( choose ) - 1 ) ) );
    
    pluecker := List( choose, rows -> Determinant( CertainRows( mat, rows ) ) );
    
    pluecker := RingMap( pluecker, S, R );
    
    SetIsMorphism( pluecker, true );
    
    SetDegreeOfMorphism( pluecker, 0 );
    
    return pluecker;
    
end );

##  <#GAPDoc Label="VeroneseMap">
##  <ManSection>
##    <Meth Arg="n,d,A,s" Name="VeroneseMap"/>
##    <Returns>a &homalg; ring map</Returns>
##    <Description>
##      The ring map corresponding to the Veronese embedding of the projective space <M>P^{<A>n</A>}(<A>A</A>)=P(W)</M>
##      into the projective space <M>P(S^d W)</M>, where <M>W=V^*</M> is the <M><A>A</A></M>-dual of the free module
##      <M>V=A^{<A>n</A>+1}</M> of rank <M><A>n</A>+1</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( VeroneseMap,
        "for homalg rings",
        [ IsPosInt, IsPosInt, IsHomalgRing, IsString ],
        
  function( n, d, A, s )
    local var, R, veronese, S;
    
    var := List( [ 0 .. n ], i -> Concatenation( "x", String( i ) ) );
    
    R := PolynomialRing( A, var );
    
    veronese := MonomialMatrix( d, R );
    
    S := PolynomialRing( A, Concatenation( s, String( 0 ), "..", s, String( NrRows( veronese ) - 1 ) ) );
    
    veronese := EntriesOfHomalgMatrix( veronese );
    
    veronese := RingMap( veronese, S, R );
    
    SetIsMorphism( veronese, true );
    
    SetDegreeOfMorphism( veronese, 0 );
    
    return veronese;
    
end );

