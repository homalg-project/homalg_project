#############################################################################
##
##  HomalgElement.gi                                          homalg package
##
##  Copyright 2011 Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for homalg elements.
##
#############################################################################

##  <#GAPDoc Label="ObjectElements:intro">
##  An element of an object <M>M</M> is internally represented by a morphism from the <Q>structure object</Q>
##  to the object <M>M</M>. In particular, the data structure for object elements
##  automatically profits from the intrinsic realization of morphisms in the &homalg; project.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsElementOfAnObjectGivenByAMorphismRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsElementOfAnObjectGivenByAMorphismRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of elements of finitley presented objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgElement"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsElementOfAnObjectGivenByAMorphismRep",
        IsHomalgElement,
        [ ] );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgElement, IsHomalgElement,
        [ "IsZero" ],
        UnderlyingMorphism );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgElement, [ "IsZero" ], UnderlyingMorphism );

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DecideZero,
        "for homalg elements",
        [ IsHomalgElement ],
        
  function( m )
    
    DecideZero( UnderlyingMorphism( m ) );
    
    return m;
    
end );

##
InstallMethod( LT,
        "for two homalg elements",
        [ IsHomalgElement, IsHomalgElement ],
        
  function( m, n )
    
    ## String must call DecideZero
    return String( m ) < String( n );
    
end );

##
InstallMethod( \=,
        "for two homalg elements",
        [ IsHomalgElement, IsHomalgElement ],
        
  function( m, n )
    
    return UnderlyingMorphism( m ) = UnderlyingMorphism( n );
    
end );

##
InstallMethod( \+,
        "for two homalg elements",
        [ IsHomalgElement, IsHomalgElement ],
        
  function( m, n )
    
    return HomalgElement( UnderlyingMorphism( m ) + UnderlyingMorphism( n ) );
    
end );

##
InstallMethod( \+,
        "for homalg ring elements",
        [ IS_RAT, IsHomalgElement ],
        
  function( a, b )
    
    return a * One( b ) + b;
    
end );

##
InstallMethod( \+,
        "for homalg ring elements",
        [ IsHomalgElement, IS_RAT ],
        
  function( a, b )
    
    return a + b * One( a );
    
end );

##
InstallMethod( \-,
        "for two homalg elements",
        [ IsHomalgElement, IsHomalgElement ],
        
  function( m, n )
    
    return HomalgElement( UnderlyingMorphism( m ) - UnderlyingMorphism( n ) );
    
end );

##
InstallMethod( AdditiveInverseMutable,
        "for homalg elements",
        [ IsHomalgElement ],
        
  function( m )
    
    return HomalgElement( -UnderlyingMorphism( m ) );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( HomalgElement,
        "for homalg static morphisms",
        [ IsHomalgStaticMorphism ],
        
  function( m )
    local S, type, e;
    
    S := Source( m );
    
    type := CategoryOfObject( S )!.TypeOfElements;
    
    e := rec( );
    
    ## Objectify
    ObjectifyWithAttributes(
            e, type,
            UnderlyingMorphism, m,
            SuperObject, Range( m ) );
    
    return e;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg elements",
        [ IsHomalgElement ],
        
  function( o )
    
    Print( "<An element in " );
    ViewObj( SuperObject( o ) );
    Print( ">" );
    
end );

##
InstallMethod( Display,
        "for homalg elements",
        [ IsHomalgElement ],
        
  function( m )
    
    Display( UnderlyingMorphism( m ) );
    
end );

##
InstallMethod( Display,
        "for homalg elements",
        [ IsHomalgElement and IsZero ], 2001,
        
  function( m )
    
    Print( 0, "\n" );
    
end );
