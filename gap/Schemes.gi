#############################################################################
##
##  Schemes.gi                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for schemes.
##
#############################################################################

# a new representation for the GAP-category IsScheme

##  <#GAPDoc Label="IsProjSchemeRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsProjSchemeRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of schemes. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsScheme"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsProjSchemeRep",
        IsScheme,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfProjSchemes",
        NewFamily( "TheFamilyOfProjSchemes" ) );

# a new type:
BindGlobal( "TheTypeProjSchemes",
        NewType( TheFamilyOfProjSchemes,
                IsProjSchemeRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DimensionOfAmbientSpace,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    
    return Dimension( StructureSheafOfAmbientSpace( X ) );
    
end );

##
InstallMethod( VanishingIdeal,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    local J;
    
    J := IdealSheaf( X );
    
    return UnderlyingModule( J );
    
end );

##
InstallMethod( UnderlyingModule,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    local OX;
    
    OX := StructureSheaf( X );
    
    OX := AsModuleOverStructureSheafOfAmbientSpace( OX );
    
    return UnderlyingModule( OX );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Proj,
        "constructor for Proj schemes",
        [ IsHomalgRing ],
        
  function( S )
    local X, O, J;
    
    if IsBound( S!.Proj ) then
        return S!.Proj;
    fi;
    
    X := rec( );
    
    O := StructureSheafOfProj( S );
    
    ObjectifyWithAttributes(
            X, TheTypeProjSchemes,
            StructureSheaf, O,
            IsProjective, true
            );
    
    if HasDefiningIdeal( S ) then
        J := DefiningIdeal( S );
        SetIdealSheaf( X, HomalgSheaf( J ) );
    fi;
    
    ## save the proj scheme in the graded ring
    S!.Proj := X;
    
    return X;
    
end );

##
InstallMethod( Scheme,
        "constructor for Proj schemes",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( J )
    
    if not IsList( DegreesOfGenerators( J ) ) then
        TryNextMethod( );
    fi;
    
    return Proj( HomalgRing( J ) / J );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    local prop_attr, print_non_empty, dim;
    
    Print( "<A" );
    
    prop_attr := "";
    
    print_non_empty := true;
    
    if HasIsProjective( X ) and IsProjective( X ) then
        Append( prop_attr, " projective" );
    fi;
    
    if HasIsSmooth( X ) then
        if IsSmooth( X ) then
            Append( prop_attr, " smooth" );
        else
            Append( prop_attr, " singular" );
            print_non_empty := false;
        fi;
    fi;
    
    if HasDimension( X ) then
        dim := Dimension( X );
        if dim < 0 then
            Append( prop_attr, " scheme" );
        elif dim = 0 then
            Append( prop_attr, " 0-dimensional scheme" );
        elif dim = 1 then
            Append( prop_attr, " curve" );
        elif dim = 2 then
            Append( prop_attr, " surface" );
        else
            Append( prop_attr,  Concatenation( " ", String( dim ), "-fold" ) );
        fi;
    else
        Append( prop_attr, " scheme" );
    fi;
    
    if HasGenus( X ) then
        Append( prop_attr, Concatenation( " of genus ", String( Genus( X ) ) ) );
    fi;
    
    if HasDegreeAsSubscheme( X ) then
        Append( prop_attr, Concatenation( " and degree ", String( DegreeAsSubscheme( X ) ) ) );
    fi;
    
    if print_non_empty and HasIsEmpty( X ) and not IsEmpty( X ) then
        Print( " non-empty" );
    fi;
    
    Print( prop_attr, ">" );
    
end );

##
InstallMethod( ViewObj,
        "for schemes",
        [ IsScheme and IsEmpty ],
        
  function( X )
    local dim;
    
    Print( "<An empty" );
    
    if HasIsProjective( X ) and IsProjective( X ) then
        Print( " (projective)" );
    fi;
    
    Print( "scheme>" );
    
end );

##
InstallMethod( Display,
        "for Proj schemes",
        [ IsProjSchemeRep and IsProjective ],
        
  function( X )
    
    Display( HomalgRing( StructureSheaf( X ) ) );
    
    Print( "\nProj of the above graded ring\n" );
    
end );

