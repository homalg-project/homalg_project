#############################################################################
##
##  MorphismsOfSchemes.gi       Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for morphisms of schemes.
##
#############################################################################

# a new representation for the GAP-category IsScheme

##  <#GAPDoc Label="IsMorphismOfProjSchemesRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsMorphismProjSchemesRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of schemes. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsMorphismOfProjSchemes"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsMorphismOfProjSchemesRep",
        IsMorphismOfSchemes,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfMorphismsOfProjSchemes",
        NewFamily( "TheFamilyOfMorphismsOfProjSchemes" ) );

# a new type:
BindGlobal( "TheTypeMorphismOfProjSchemes",
        NewType( TheFamilyOfMorphismsOfProjSchemes,
                IsMorphismOfProjSchemesRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AssociatedRingMap,
        "for morphisms of Proj schemes",
        [ IsMorphismOfProjSchemesRep ],
        
  function( f )
    
    return f!.ringmap;
    
end );

##
InstallMethod( ImageScheme,
        "for morphisms of Proj schemes",
        [ IsMorphismOfProjSchemesRep ],
        
  function( f )
    local phi, ker;
    
    phi := AssociatedRingMap( f );
    
    ker := KernelSubobject( phi );
    
    return Scheme( ker );
    
end );

##
InstallMethod( ImageScheme,
        "for morphisms of Proj schemes",
        [ IsMorphismOfProjSchemesRep, IsProjSchemeRep ],
        
  function( f, X )
    local phi, images, S, T, J, g;
    
    phi := AssociatedRingMap( f );
    
    images := ImagesOfRingMap( phi );
    
    S := Source( phi );
    
    T := Range( phi );
    
    J := UnderlyingModule( IdealSheaf( X ) );
    
    T := T / J;
    
    g := RingMap( images, S, T );
    
    SetDegreeOfMorphism( g, 0 );
    
    g := Proj( g );
    
    return ImageScheme( g );
    
end );

##
InstallMethod( ImageScheme,
        "for morphisms of Proj schemes",
        [ IsProjSchemeRep, IsMorphismOfProjSchemesRep ],
        
  function( X, f )
    
    return ImageScheme( f, X );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Proj,
        "constructor for morphisms of Proj schemes",
        [ IsHomalgRingMap ],
        
  function( phi )
    local S, T, f;
    
    if IsBound( phi!.Proj ) then
        return phi!.Proj;
    fi;
    
    if not HasDegreeOfMorphism( phi ) then
        TryNextMethod( );
    fi;
    
    S := Proj( Range( phi ) );
    
    T := Proj( Source( phi ) );
    
    f := rec( ringmap := phi );
    
    ObjectifyWithAttributes(
            f, TheTypeMorphismOfProjSchemes,
            Source, S,
            Range, T,
            IsProjective, true
            );
    
    ## save the morphism of proj schemes in the graded map of graded rings
    phi!.Proj := f;
    
    return f;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for morphisms of Proj schemes",
        [ IsMorphismOfProjSchemesRep ],
        
  function( f )
    
    Print( "<A projective morphism of schemes>" );
    
end );

##
InstallMethod( Display,
        "for morphisms of schemes",
        [ IsMorphismOfProjSchemesRep ],
        
  function( f )
    local phi;
    
    phi := AssociatedRingMap( f );
    
    Display( Source( f ) );
    Print( "  |\n  |\n" );
    ViewObj( phi!.images );
    Print( "\n  |\n  v\n" );
    Display( Range( f ) );
    
end );

