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
# methods for operations:
#
####################################

##  <#GAPDoc Label="KernelSubmodule">
##  <ManSection>
##    <Meth Arg="phi" Name="KernelSubmodule"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      The kernel ideal of the ring map <A>phi</A> (as a submodule).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KernelSubmodule,
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
    
    S := 1 * S;
    
    if HasDegreeOfMorphism( phi ) then
        S := S^0;
    fi;
    
    return Subobject( rel, S );
    
end );

