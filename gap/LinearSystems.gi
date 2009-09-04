#############################################################################
##
##  LinearSystems.gi            Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for linear systems.
##
#############################################################################

# a new representation for the GAP-category IsLinearSystem

##  <#GAPDoc Label="IsLinearSystemRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="L" Name="IsLinearSystemRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of linear systems. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsLinearSystem"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsLinearSystemRep",
        IsLinearSystem,
        [ "module" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfLinearSystems",
        NewFamily( "TheFamilyOfLinearSystems" ) );

# a new type:
BindGlobal( "TheTypeLinearSystems",
        NewType( TheFamilyOfLinearSystems,
                IsLinearSystemRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingModule,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return L!.module;
    
end );

##
InstallMethod( HomalgRing,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return HomalgRing( UnderlyingModule( L ) );
    
end );

##
InstallMethod( GeneratorsOfLinearSystem,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return GeneratorsOfModule( UnderlyingModule( L ) );
    
end );

##
InstallMethod( HomalgRingOfGenerators,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return HomalgRing( GeneratorsOfLinearSystem( L ) );
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return MatrixOfGenerators( UnderlyingModule( L ) );
    
end );

##
InstallMethod( Degree,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return DegreeOfLinearSystem( L );
    
end );

##
InstallMethod( InducedRingMap,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    local S, T, images, phi;
    
    ## the source ring
    S := AssociatedGradedPolynomialRing( L );
    
    ## the target ring
    T := HomalgRingOfGenerators( L );
    
    ## the substitutions
    images := MatrixOfGenerators( L );
    
    images := EntriesOfHomalgMatrix( images );
    
    phi := RingMap( images, S, T );
    
    SetDegreeOfMorphism( phi, 0 );
    
    return phi;
    
end );

##
InstallMethod( InducedMorphismToProjectiveSpace,
        "for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return Proj( InducedRingMap( L ) );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( AsLinearSystem,
        "constructor for linear systems",
        [ IsHomalgModule, IsString ],
        
  function( M, x )
    local L, dim;
    
    L := rec( module := M );
    
    dim := NrGenerators( M );
    
    ObjectifyWithAttributes(
            L, TheTypeLinearSystems,
            Dimension, dim - 1
            );
    
    L!.variable_name := x;
    
    return L;
    
end );

##
InstallMethod( AsLinearSystem,
        "constructor for linear systems",
        [ IsHomalgModule ],
        
  function( M )
    
    return AsLinearSystem( M, "x" );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for linear systems",
        [ IsLinearSystemRep ],
        
  function( L )
    local dim;
    
    Print( "<A" );
    
    if HasIsComplete( L ) then
        if IsComplete( L ) then
            Print( " complete" );
        else
            Print( "n incomplete" );
        fi;
    fi;
    
    Print( " linear system" );
    
    if HasDimension( L ) then
        dim := Dimension( L );
        Print( " of dimension ", dim );
        if dim = 1 then
            Print( " (pencil)" );
        elif dim = 2 then
            Print( " (net)" );
        elif dim = 3 then
            Print( " (web)" );
        fi;
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for linear systems",
        [ IsLinearSystemRep and IsEmpty ],
        
  function( L )
    
    Print( "<An empty linear system>" );
    
end );

##
InstallMethod( Display,
        "for linear systems",
        [ IsLinearSystemRep ],
        
  function( L )
    local M, dim;
    
    M := UnderlyingModule( L );
    
    Display( MatrixOfGenerators( M ) );
    
    dim := NrGenerators( M );
    
    Print( "\na linear system generated by the " );
    
    if dim <> 1 then
        Print( dim, " " );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "row" );
    else
        Print( "column" );
    fi;
    
    if dim <> 1 then
        Print( "s" );
    fi;
    
    Print( " of the above matrix\n" );
    
end );
