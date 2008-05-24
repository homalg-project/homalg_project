#############################################################################
##
##  HomalgChainMap.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg chain maps.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the category IsHomalgChainMap:
DeclareRepresentation( "IsChainMapOfFinitelyPresentedModulesRep",
        IsHomalgChainMap,
        [  ] );

DeclareRepresentation( "IsCochainMapOfFinitelyPresentedModulesRep",
        IsHomalgChainMap,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgChainMaps",
        NewFamily( "TheFamilyOfHomalgChainMaps" ) );

# eight new types:
BindGlobal( "TheTypeHomalgChainMapOfLeftModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedModulesRep and IsHomalgChainMapOfLeftModules ) );

BindGlobal( "TheTypeHomalgChainMapOfRightModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedModulesRep and IsHomalgChainMapOfRightModules ) );

BindGlobal( "TheTypeHomalgCochainMapOfLeftModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedModulesRep and IsHomalgChainMapOfLeftModules ) );

BindGlobal( "TheTypeHomalgCochainMapOfRightModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedModulesRep and IsHomalgChainMapOfRightModules ) );

BindGlobal( "TheTypeHomalgChainSelfMapOfLeftModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedModulesRep and IsHomalgChainSelfMap and IsHomalgChainMapOfLeftModules ) );

BindGlobal( "TheTypeHomalgChainSelfMapOfRightModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsChainMapOfFinitelyPresentedModulesRep and IsHomalgChainSelfMap and IsHomalgChainMapOfRightModules ) );

BindGlobal( "TheTypeHomalgCochainSelfMapOfLeftModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedModulesRep and IsHomalgChainSelfMap and IsHomalgChainMapOfLeftModules ) );

BindGlobal( "TheTypeHomalgCochainSelfMapOfRightModules",
        NewType( TheFamilyOfHomalgChainMaps,
                IsCochainMapOfFinitelyPresentedModulesRep and IsHomalgChainSelfMap and IsHomalgChainMapOfRightModules ) );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    local morphisms;
    
    morphisms := MorphismsOfChainMap( c );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    local indices, l, S, T;
    
    if not IsComplex( Source( c ) ) then
        return false;
    elif not IsComplex( Target( c ) ) then
        return false;
    fi;
    
    indices := DegreesOfChainMap( c );
    
    l := Length( indices );
    
    indices := indices{[ 1 .. l - 1 ]};
    
    S := Source( c );
    T := Target( c );
    
    if l = 1 then
        if Length( ObjectDegreesOfComplex( S ) ) = 1 then
            return true;
        else
            Error( "not implemented for chain maps containing as single morphism\n" );
        fi;
    elif IsChainMapOfFinitelyPresentedModulesRep( c ) and IsHomalgChainMapOfLeftModules( c ) then
        return ForAll( indices, i -> CertainMorphism( c, i + 1 ) * CertainMorphism( T, i + 1 ) = CertainMorphism( S, i + 1 ) * CertainMorphism( c, i ) );
    elif IsCochainMapOfFinitelyPresentedModulesRep( c ) and IsHomalgChainMapOfRightModules( c ) then
        return ForAll( indices, i -> CertainMorphism( T, i ) * CertainMorphism( c, i ) = CertainMorphism( c, i + 1 ) * CertainMorphism( S, i ) );
    elif IsChainMapOfFinitelyPresentedModulesRep( c ) and IsHomalgChainMapOfRightModules( c ) then
        return ForAll( indices, i -> CertainMorphism( T, i + 1 ) * CertainMorphism( c, i + 1 ) = CertainMorphism( c, i ) * CertainMorphism( S, i + 1 ) );
    else
        return ForAll( indices, i -> CertainMorphism( c, i ) * CertainMorphism( T, i ) = CertainMorphism( S, i ) * CertainMorphism( c, i + 1 ) );
    fi;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( IsLeft,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return IsHomalgChainMapOfLeftModules( c );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return HomalgRing( Source( c ) );
    
end );

##
InstallMethod( DegreesOfChainMap,		## this might differ from ObjectDegreesOfComplex( Source( c ) ) when the chain map is not full
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return c!.indices;
    
end );

##
InstallMethod( ObjectDegreesOfComplex,		## this is not a mistake
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return ObjectDegreesOfComplex( Source( c ) );
    
end );

##
InstallMethod( MorphismDegreesOfComplex,	## this is not a mistake
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return MorphismDegreesOfComplex( Source( c ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( c, i )
    
    if IsBound( c!.(String( i )) ) and IsHomalgMorphism( c!.(String( i )) ) then
        return c!.(String( i ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( MorphismsOfChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    local indices;
    
    indices := DegreesOfChainMap( c );
    
    return List( indices, i -> CertainMorphism( c, i ) );
    
end );

##
InstallMethod( LowestDegreeInChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return ObjectDegreesOfComplex( c )[1];
    
end );

##
InstallMethod( HighestDegreeInChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    local indices;
    
    indices := ObjectDegreesOfComplex( c );
    
    return indices[Length( indices )];
    
end );

##
InstallMethod( LowestDegreeMorphismInChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return CertainMorphism( c, LowestDegreeInChainMap( c ) );
    
end );

##
InstallMethod( HighestDegreeMorphismInChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    
    return CertainMorphism( c, HighestDegreeInChainMap( c ) );
    
end );

##
InstallMethod( SupportOfChainMap,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( c )
    local indices, morphisms, l;
    
    indices := DegreesOfChainMap( c );
    morphisms := MorphismsOfChainMap( c );
    
    l := Length( indices );
    
    return indices{ Filtered( [ 1 .. l ], i -> not IsZero( morphisms[i] ) ) };
    
end );

##
InstallMethod( Add,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsHomalgMorphism ],
        
  function( c, phi )
    local indices, l;
    
    indices := DegreesOfChainMap( c );
    
    l := Length( indices );
    
    l := indices[l] + 1;
    
    if not l in ObjectDegreesOfComplex( c ) then
        Error( "there is no module in the source complex with index ", l, "\n" );
    fi;
    
    if not IsIdenticalObj( CertainObject( Source( c ), l ), Source( phi ) ) then
        Error( "the ", l, ". module of the source complex in the chain map and the source of the new morphism are not identically the same module\n" );
    elif not IsIdenticalObj( CertainObject( Target( c ), l ), Target( phi ) ) then
        Error( "the ", l, ". module of the target complex in the chain map and the target of the new morphism are not identically the same module\n" );
    fi;
    
    Add( indices, l );
    
    c!.(String( l )) := phi;
    
    homalgResetFiltersOfChainMap( c );
    
    return c;
    
end );

####################################
#
# global functions:
#
####################################

InstallGlobalFunction( homalgResetFiltersOfChainMap,
  function( c )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfChainMaps ) then
        HOMALG.PropertiesOfChainMaps :=
          [ IsZero, IsChainMap ];
    fi;
    
    for property in HOMALG.PropertiesOfChainMaps do
        ResetFilterObj( c, property );
    od;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgChainMap,
  function( arg )
    local nargs, morphism, left, source, target, indices, degree,
          chainmap, type, c;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    if nargs > 0 and IsHomalgMorphism( arg[1] ) then
        left := IsHomalgMorphismOfLeftModules( arg[1] );
    else
        Error( "the first argument must be a morphism" );
    fi;
    
    morphism := arg[1];
    
    if nargs > 1 and IsHomalgComplex( arg[2] ) then
        if not IsBound( left ) then
            left := IsHomalgComplexOfLeftModules( arg[2] );
        fi;
        source := arg[2];
    fi;
    
    if nargs > 2 and IsHomalgComplex( arg[3] ) then
        if ( not IsHomalgComplexOfLeftModules( arg[3] ) and left ) or
           ( IsHomalgComplexOfLeftModules( arg[3] ) and not left ) then
            Error( "both complexes must either be both left or both right complexes\n" );
        fi;
        target := arg[3];
    else
        target := source;
    fi;
    
    if IsInt( arg[nargs] ) then
        indices := [ arg[nargs] ];
        degree := 0;
    elif IsList( arg[nargs] ) and Length( arg[nargs] ) = 2 and ForAll( arg[nargs], IsInt ) then
        indices := [ arg[nargs][1] ];
        degree := arg[nargs][2];
    else
        indices := [ ObjectDegreesOfComplex( source )[1] ];
        degree := 0;
    fi;
    
    if not IsIdenticalObj( Source( morphism ), CertainObject( source, indices[1] ) ) then
        Error( "the morphism and the source complex do not match\n" );
    elif not IsIdenticalObj( Target( morphism ), CertainObject( target, indices[1] ) ) then
        Error( "the morphism and the target complex do not match\n" );
    fi;
    
    c := rec( indices := indices );
    
    c.(String( indices[1] )) := morphism;
    
    if IsComplexOfFinitelyPresentedModulesRep( source ) and
       IsComplexOfFinitelyPresentedModulesRep( target ) then
        chainmap := true;
    elif IsCocomplexOfFinitelyPresentedModulesRep( source ) and
      IsComplexOfFinitelyPresentedModulesRep( target ) then
        chainmap := false;
    else
        Error( "source and target must either be both complexes or both cocomplexes\n" );
    fi;
    
    if IsIdenticalObj( source, target ) then
        if chainmap then
            if left then
                type := TheTypeHomalgChainSelfMapOfLeftModules;
            else
                type := TheTypeHomalgChainSelfMapOfRightModules;
            fi;
        else
            if left then
                type := TheTypeHomalgCochainSelfMapOfLeftModules;
            else
                type := TheTypeHomalgCochainSelfMapOfRightModules;
            fi;
        fi;
    else
        if chainmap then
            if left then
                type := TheTypeHomalgChainMapOfLeftModules;
            else
                type := TheTypeHomalgChainMapOfRightModules;
            fi;
        else
            if left then
                type := TheTypeHomalgCochainMapOfLeftModules;
            else
                type := TheTypeHomalgCochainMapOfRightModules;
            fi;
        fi;
    fi;
    
    ## Objectify
    ObjectifyWithAttributes(
            c, type,
            Source, source,
            Target, target,
            DegreeOfChainMap, degree
            );
    
    return c;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( o )
    local first_attribute, indices, l;
    
    first_attribute := false;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg (co)chain map
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    if HasIsChainMap( o ) then
        if IsChainMap( o ) then
            if IsChainMapOfFinitelyPresentedModulesRep( o ) then
                Print( " chain map" );
            else
                Print( " cochain map" );
            fi;
        else
            if IsChainMapOfFinitelyPresentedModulesRep( o ) then
                Print( " non-chain map" );
            else
                Print( " non-cochain map" );
            fi;
        fi;
    else
        if IsChainMapOfFinitelyPresentedModulesRep( o ) then
            Print( " \"chain map\"" );
        else
            Print( " \"cochain map\"" );
        fi;
    fi;
    
    if HasDegreeOfChainMap( o ) and DegreeOfChainMap( o ) <> 0 then
        Print( " of degree ", DegreeOfChainMap( o ) );
    fi;
    
    Print( " containing " );
    
    indices := DegreesOfChainMap( o );
    
    l := Length( indices );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgChainMapOfLeftModules( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        Print( " morphism at " );
        
        if IsCochainMapOfFinitelyPresentedModulesRep( o ) then
            Print( "co" );
        fi;
        
        Print( "homology degree ", indices[1], ">" );
        
    else
        
        Print( l, " morphisms" );
        
        Print( " of " );
        
        if IsHomalgChainMapOfLeftModules( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        Print( " modules>" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg chain maps",
        [ IsChainMapOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgChainMapOfLeftModules( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " chain map>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgChainMapOfLeftModules( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " cochain map>" );
    
end );

##
InstallMethod( Display,
        "for homalg chain maps",
        [ IsChainMapOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet <--", "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet -->", "\n" );
    
end );

