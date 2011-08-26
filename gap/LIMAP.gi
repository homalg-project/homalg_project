#############################################################################
##
##  LIMAP.gi                    LIMAP subpackage             Mohamed Barakat
##
##         LIMAP = Logical Implications for homalg ring MAPs
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for the LIMAP subpackage.
##
#############################################################################

####################################
#
# representations:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsMonomorphism,
        "LIMAP: for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

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
    
    return Subobject( rel, S );
    
end );

##
InstallMethod( KernelEmb,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    
    return EmbeddingInSuperObject( KernelSubobject( phi ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( ImagesOfRingMap,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    
    return phi!.images;
    
end );

##  <#GAPDoc Label="Kernel:ringmap">
##  <ManSection>
##    <Meth Arg="phi" Name="Kernel" Label="for ring maps"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The kernel ideal of the ring map <A>phi</A> as an abstract module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Kernel,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    
    return UnderlyingObject( KernelSubobject( phi ) );
    
end );

