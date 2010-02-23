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
InstallMethod( KernelEmb,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( phi )
    
    return EmbeddingInSuperObject( KernelSubmodule( phi ) );
    
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
    
    return UnderlyingObject( KernelSubmodule( phi ) );
    
end );

