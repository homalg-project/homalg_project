#############################################################################
##
##  HomalgRingMaps.gi           MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations of procedures for ring maps.
##
#############################################################################

##  <#GAPDoc Label="RingMaps:intro">
##  A &homalg; ring map is a data structure for maps between finitely generated rings. &homalg; more or less provides the basic
##  declarations and installs the generic methods for ring maps, but it is up to other high level packages to install methods
##  applicable to specific rings. For example, the package &Sheaves; provides methods for ring maps of (finitely generated) affine rings.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgRingMapRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsHomalgRingMapRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of &homalg; ring maps. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgRingMap"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgRingMapRep",
        IsHomalgRingMap,
        [ ] );

# a new family:
BindGlobal( "TheFamilyOfHomalgRingMaps",
        NewFamily( "TheFamilyOfHomalgRingMaps" ) );

# two new types:
BindGlobal( "TheTypeHomalgRingMap",
        NewType( TheFamilyOfHomalgRingMaps,
                IsHomalgRingMapRep ) );

BindGlobal( "TheTypeHomalgRingSelfMap",
        NewType( TheFamilyOfHomalgRingMaps,
                IsHomalgRingMapRep and IsHomalgRingSelfMap ) );

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
    
    return EntriesOfHomalgMatrix( ImagesOfRingMapAsColumnMatrix( phi ) );
    
end );

##
InstallMethod( PreCompose,
        "for two homalg ring maps",
        [ IsHomalgRingMap, IsHomalgRingMap ],
        
  function( psi, phi )
    local S, T;
    
    S := Source( psi );
    T := Range( phi );
    
    psi := ImagesOfRingMapAsColumnMatrix( psi );
    
    return RingMap( Pullback( phi, psi ), S, T );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="RingMap">
##  <ManSection>
##    <Oper Arg="images, S, T" Name="RingMap" Label="constructor for ring maps"/>
##    <Returns>a &homalg; ring map</Returns>
##    <Description>
##      This constructor returns a ring map (homomorphism) of finitely generated rings/algebras. It is represented by the
##      images <A>images</A> of the set of generators of the source &homalg; ring <A>S</A> in terms of the
##      generators of the target ring <A>T</A> (&see; <Ref Sect="Rings:Constructors"/>). Unless the source ring is free
##      <E>and</E> given on free ring/algebra generators the returned map will cautiously be indicated using
##      parenthesis: <Q>homomorphism</Q>.
##      If source and target are identical objects, and only then, the ring map is created as a selfmap.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( RingMap,
        "for a homalg matrix and two homalg rings",
        [ IsHomalgMatrix, IsHomalgRing, IsHomalgRing ],
        
  function( images, S, T )
    local c, map, type;
    
    c := NrColumns( images );
    
    if not ( c = 1 or NrRows( images ) = 1 ) then
        Error( "the matrix must either has one row or one column\n" );
    fi;
    
    if c > 1 then
        images := Involution( images );
    fi;
    
    if not IsIdenticalObj( T, HomalgRing( images ) ) then
        images := T * images;
    fi;
    
    map := rec( );
    
    if IsIdenticalObj( S, T ) then
        type := TheTypeHomalgRingSelfMap;
    else
        type := TheTypeHomalgRingMap;
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            map, type,
            ImagesOfRingMapAsColumnMatrix, images,
            Source, S,
            Range, T );
    
    return map;
    
end );

##
InstallMethod( RingMap,
        "for a list and two homalg rings",
        [ IsList, IsHomalgRing, IsHomalgRing ],
        
  function( images, S, T )
    local matrix, map;
    
    matrix := HomalgMatrix( images, Length( images ), 1, T );
    
    map := RingMap( matrix, S, T );
    
    SetImagesOfRingMap( map, images );
    
    return map;
    
end );

##
InstallMethod( RingMap,
        "for a homalg matrix and a homalg ring",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( mat, R )
    local r, indets;
    
    r := NrRows( mat );
    
    if NrColumns( mat ) <> r then
        Error( "the matrix is not quadratic\n" );
    fi;
    
    indets := Indeterminates( R );
    
    if Length( indets ) <> r then
        Error( "the number of indeterminates does not match the number of rows of the matrix\n" );
    fi;
    
    indets := HomalgMatrix( indets, r, 1, R );
    
    if not IsIdenticalObj( R, HomalgRing( mat ) ) then
        mat := R * mat;
    fi;
    
    return RingMap( mat * indets, R, R );
    
end );

##
InstallMethod( RingMap,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return RingMap( mat, HomalgRing( mat ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingMap ],
        
  function( o )
    
    Print( "<A" );
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            Print( " homomorphism of" );
        else
            Print( " non-well-defined map of" );
        fi;
    else
        Print( " \"homomorphism\" of" );
    fi;
    
    Print( " rings>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingMap and IsMonomorphism ], 996,
        
  function( o )
    
    Print( "<A monomorphism of rings>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingMap and IsEpimorphism ], 997,
        
  function( o )
    
    Print( "<An epimorphism of rings>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingMap and IsIsomorphism ], 1000,
        
  function( o )
    
    Print( "<An isomorphism of rings>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingSelfMap ],
        
  function( o )
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero map of homalg rings
        Print( " non-zero" );
    elif not ( HasIsMorphism( o ) and not IsMorphism( o ) ) then
        Print( "n" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            Print( " endomorphism of" );
        else
            Print( " non-well-defined self-map of" );
        fi;
    else
        Print( " endo\"morphism\" of" );
    fi;
    
    Print( " rings>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingSelfMap and IsMonomorphism ],
        
  function( o )
    
    Print( "<A monic endomorphism of a ring>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingSelfMap and IsEpimorphism ], 996,
        
  function( o )
    
    Print( "<An epic endomorphism a ring>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingSelfMap and IsAutomorphism ], 999,
        
  function( o )
    
    Print( "<An automorphism of a ring>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg ring maps",
        [ IsHomalgRingSelfMap and IsIdentityMorphism ], 1000,
        
  function( o )
    
    Print( "<The identity morphism of a ring>" );
    
end );    

##
InstallMethod( Display,
        "for homalg ring maps",
        [ IsHomalgRingMapRep ],
        
  function( o )
    
    ViewObj( Range( o ) );
    Print( "\n\  ^\n  |\n" );
    ViewObj( ImagesOfRingMap( o ) );
    Print( "\n  |\n  |\n" );
    ViewObj( Source( o ) );
    Print( "\n" );
    
end );

