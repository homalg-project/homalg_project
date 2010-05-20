#############################################################################
##
##  RingMaps.gi                 Sheaves package              Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
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
##      The kernel ideal of the ring map <A>phi</A> (as a submodule).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KernelSubobject,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
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
    
    if HasDegreeOfMorphism( phi ) then
        S := S^0;
    fi;
    
    return Subobject( rel, S );
    
end );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="SegreEmbedding">
##  <ManSection>
##    <Meth Arg="R" Name="SegreEmbedding"/>
##    <Returns>a &homalg; ring map</Returns>
##    <Description>
##      The Segre embedding.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SegreEmbedding,
        "for homalg ring maps",
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
    
    SetIsEpimorphism( segre, true );
    
    SetDegreeOfMorphism( segre, 0 );
    
    return segre;
    
end );

