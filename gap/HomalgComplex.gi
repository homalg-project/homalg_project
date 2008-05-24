#############################################################################
##
##  HomalgComplex.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg complexes.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the category IsHomalgComplex:
DeclareRepresentation( "IsComplexOfFinitelyPresentedModulesRep",
        IsHomalgComplex,
        [  ] );

DeclareRepresentation( "IsCocomplexOfFinitelyPresentedModulesRep",
        IsHomalgComplex,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgComplexes",
        NewFamily( "TheFamilyOfHomalgComplexes" ) );

# four new types:
BindGlobal( "TheTypeHomalgComplexOfLeftModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsComplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfLeftModules ) );

BindGlobal( "TheTypeHomalgComplexOfRightModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsComplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfRightModules ) );

BindGlobal( "TheTypeHomalgCocomplexOfLeftModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsCocomplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfLeftModules ) );

BindGlobal( "TheTypeHomalgCocomplexOfRightModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsCocomplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfRightModules ) );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local modules;
    
    modules := ObjectsOfComplex( C );
    
    return ForAll( modules, IsZero );
    
end );

##
InstallMethod( IsGradedObject,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms;
    
    morphisms := MorphismsOfComplex( C );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms;
    
    morphisms := MorphismsOfComplex( C );
    
    return ForAll( morphisms, IsMorphism );
    
end );

##
InstallMethod( IsComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    if not IsSequence( C ) then
        return false;
    fi;
    
    indices := MorphismDegreesOfComplex( C );
    
    indices := indices{[ 1 .. Length( indices ) - 1 ]};
    
    if indices = [ ] then
        return true;
    elif ( IsComplexOfFinitelyPresentedModulesRep( C ) and IsHomalgComplexOfLeftModules( C ) ) 
      or ( IsCocomplexOfFinitelyPresentedModulesRep( C ) and IsHomalgComplexOfRightModules( C ) ) then
        return ForAll( indices, i -> IsZero( CertainMorphism( C, i + 1 ) * CertainMorphism( C, i ) ) );
    else
        return ForAll( indices, i -> IsZero( CertainMorphism( C, i ) * CertainMorphism( C, i + 1 ) ) );
    fi;
    
end );

##
InstallMethod( IsExactSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    if not IsSequence( C ) then
        return false;
    fi;
    
    indices := MorphismDegreesOfComplex( C );
    
    indices := indices{[ 1 .. Length( indices ) - 1 ]};
    
    if indices = [ ] then
        return true;
    elif ( IsComplexOfFinitelyPresentedModulesRep( C ) and IsHomalgComplexOfLeftModules( C ) ) 
      or not ( IsComplexOfFinitelyPresentedModulesRep( C ) or IsHomalgComplexOfLeftModules( C ) ) then
        return ForAll( indices, i -> IsZero( DefectOfExactness( [ CertainMorphism( C, i + 1 ), CertainMorphism( C, i ) ] ) ) );
    else
        return ForAll( indices, i -> IsZero( DefectOfExactness( [ CertainMorphism( C, i ), CertainMorphism( C, i + 1 ) ] ) ) );
    fi;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( IsLeft,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return IsHomalgComplexOfLeftModules( C );
    
end );

##
InstallMethod( ObjectDegreesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return C!.indices;
    
end );

##
InstallMethod( MorphismDegreesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l;
    
    indices := ObjectDegreesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        return [  ];
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        return indices{[ 2 .. l ]};
    else
        return indices{[ 1 .. l - 1 ]};
    fi;
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    
    if IsBound( C!.(String( i )) ) and IsHomalgMorphism( C!.(String( i )) ) then
        return C!.(String( i ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( CertainObject,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    local indices, l;
    
    if IsBound( C!.(String( i )) ) then
        if IsHomalgModule( C!.(String( i )) ) then
            return C!.(String( i ));
        else
            return Source( C!.(String( i )) );
        fi;
    fi;
    
    indices := ObjectDegreesOfComplex( C );
    l := Length( indices );
    
    if IsComplexOfFinitelyPresentedModulesRep( C ) and indices[1] = i then
        return Target( CertainMorphism( C, i + 1 ) );
    elif IsCocomplexOfFinitelyPresentedModulesRep( C ) and indices[l] = i then
        return Target( CertainMorphism( C, i - 1 ) );
    fi;
    
    return fail;
    
end );

##
InstallMethod( MorphismsOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    indices := MorphismDegreesOfComplex( C );
    
    if Length( indices ) = 0 then
        return [  ];
    fi;
    
    return List( indices, i -> CertainMorphism( C, i ) );
    
end );

##
InstallMethod( ObjectsOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms, l, modules;
    
    morphisms := MorphismsOfComplex( C );
    
    l := Length( morphisms );
    
    if l = 0 then
        return [ CertainObject( C, ObjectDegreesOfComplex( C )[1] ) ];
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        modules := List( morphisms, Target );
        Add( modules, Source( morphisms[l] ) );
    else
        modules := List( morphisms, Source );
        Add( modules, Target( morphisms[l] ) );
    fi;
    
    return modules;
    
end );

##
InstallMethod( LowestDegreeInComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return ObjectDegreesOfComplex( C )[1];
    
end );

##
InstallMethod( HighestDegreeInComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    indices := ObjectDegreesOfComplex( C );
    
    return indices[Length( indices )];
    
end );

##
InstallMethod( LowestDegreeObjectInComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return CertainObject( C, LowestDegreeInComplex( C ) );
    
end );

##
InstallMethod( HighestDegreeObjectInComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    indices := ObjectDegreesOfComplex( C );
    
    return CertainObject( C, HighestDegreeInComplex( C ) );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return HomalgRing( LowestDegreeObjectInComplex( C ) );
    
end );

##
InstallMethod( SupportOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, modules, l;
    
    indices := ObjectDegreesOfComplex( C );
    modules := ObjectsOfComplex( C );
    
    l := Length( indices );
    
    return indices{ Filtered( [ 1 .. l ], i -> not IsZero( modules[i] ) ) };
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep, IsHomalgMorphism ],
        
  function( C, phi )
    local indices, l;
    
    indices := ObjectDegreesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        
        if not IsIdenticalObj( CertainObject( C, indices[1] ), Target( phi ) ) then
            Error( "the unique module in the complex and the target of the new morphism are not identical\n" );
        fi;
        
        Unbind( C!.(String( indices[1] )) );
        
        Add( indices, indices[1] + 1 );
        
        C!.(String( indices[1] + 1 )) := phi;
        
    else
        
        l := indices[l];
        
        if not IsIdenticalObj( Source( CertainMorphism( C, l ) ), Target( phi ) ) then
            Error( "the source of the ", l, ". morphism in the complex (i.e. the highest one) and the target of the new morphism are not identically the same module\n" );
        fi;
        
        Add( indices, l + 1 );
        
        C!.(String( l + 1 )) := phi;
        
    fi;
    
    homalgResetFiltersOfComplex( C );
    
    return C;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep, IsHomalgMorphism ],
        
  function( C, phi )
    local indices, l;
    
    indices := ObjectDegreesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        
        if not IsIdenticalObj( CertainObject( C, indices[1] ), Source( phi ) ) then
            Error( "the unique module in the complex and the source of the new morphism are not identical\n" );
        fi;
        
        Add( indices, indices[1] + 1 );
        
        C!.(String( indices[1] )) := phi;
        
    else
        
        l := indices[l - 1];
        
        if not IsIdenticalObj( Target( CertainMorphism( C, l ) ), Source( phi ) ) then
            Error( "the target of the ", l, ". morphism in the complex (i.e. the highest one) and the source of the new morphism are not identically the same module\n" );
        fi;
        
        Add( indices, l + 2 );
        
        C!.(String( l + 1 )) := phi;
        
    fi;
    
    homalgResetFiltersOfComplex( C );
    
    return C;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep, IsHomalgMatrix ],
        
  function( C, mat )
    local T;
    
    T := HighestDegreeObjectInComplex( C );
    
    Add( C, HomalgMorphism( mat, "free", T ) );
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep, IsHomalgMatrix ],
        
  function( C, mat )
    local S;
    
    S := HighestDegreeObjectInComplex( C );
    
    Add( C, HomalgMorphism( mat, S, "free" ) );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), OnLessGenerators );
    
    return C;
    
end );

####################################
#
# global functions:
#
####################################

InstallGlobalFunction( homalgResetFiltersOfComplex,
  function( C )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfComplexes ) then
        HOMALG.PropertiesOfComplexes :=
          [ IsZero, IsSequence, IsComplex, IsGradedObject, IsExactSequence, IsShortExactSequence ];
    fi;
    
    for property in HOMALG.PropertiesOfComplexes do
        ResetFilterObj( C, property );
    od;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgComplex,
  function( arg )
    local nargs, C, complex, indices, left, module, type;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    C := rec( );
    
    if IsStringRep( arg[nargs] ) and ( arg[nargs] = "co" or arg[nargs] = "cocomplex" ) then
        complex := false;
    else
        complex := true;
    fi;
    
    if nargs > 1 and ( IsInt( arg[2] )
               or ( IsList( arg[2] ) and Length( arg[2] ) > 0 and ForAll( arg[2], IsInt ) ) ) then
        indices := [ arg[2] ];
    else
        indices := [ 0 ];
    fi;
    
    module := false;
    
    if IsHomalgModule( arg[1] ) then
        C.indices := indices;
        left := IsLeftModule( arg[1] );
        module := true;
    elif IsHomalgMorphism( arg[1] ) then
        if complex then
            C.indices := [ indices[1] - 1, indices[1] ];
        else
            C.indices := [ indices[1], indices[1] + 1 ];
        fi;
        left := IsHomalgMorphismOfLeftModules( arg[1] );
    else
        Error( "the first argument must be either a homalg module or a homalg morphism\n" );
    fi;
    
    C.( String( indices[1] ) ) := arg[1];
    
    if complex then
        if left then
            type := TheTypeHomalgComplexOfLeftModules;
        else
            type := TheTypeHomalgComplexOfRightModules;
        fi;
    else
        if left then
            type := TheTypeHomalgCocomplexOfLeftModules;
        else
            type := TheTypeHomalgCocomplexOfRightModules;
        fi;
    fi;
    
    ## Objectify
    Objectify( type, C );
    
    if module then
        SetIsGradedObject( C, true );
    fi;
    
    return C;
    
end );

InstallGlobalFunction( HomalgCocomplex,
  function( arg )
    
    return CallFuncList( HomalgComplex, Concatenation( arg, [ "cocomplex" ] ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( o )
    local first_attribute, indices, l;
    
    first_attribute := false;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg (co)complex
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    if HasIsShortExactSequence( o ) and IsShortExactSequence( o ) then
        Print( " short exact sequence" );
    elif HasIsExactSequence( o ) and IsExactSequence( o ) then
        if first_attribute then
            Print( " exact sequence" );
        else
            Print( "n exact sequence" );
        fi;
    elif HasIsComplex( o ) then
        if IsComplex( o ) then
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " complex" );
            else
                Print( " cocomplex" );
            fi;
        else
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " non-complex" );
            else
                Print( " non-cocomplex" );
            fi;
        fi;
    elif HasIsSequence( o ) then
        if IsSequence( o ) then
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " sequence" );
            else
                Print( " co-sequence" );
            fi;
        else
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " sequence of non-well-definded maps" );
            else
                Print( " co-sequence of non-well-definded maps" );
            fi;
        fi;
    else
        if IsComplexOfFinitelyPresentedModulesRep( o ) then
            Print( " \"complex\"" );
        else
            Print( " \"cocomplex\"" );
        fi;
    fi;
    
    Print( " containing " );
    
    indices := ObjectDegreesOfComplex( o );
    
    l := Length( indices );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgComplexOfLeftModules( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        Print( " module at " );
        
        if IsCocomplexOfFinitelyPresentedModulesRep( o ) then
            Print( "co" );
        fi;
        
        Print( "homology degree ", indices[1], ">" );
        
    else
        
        if l = 2 then
            Print( "a single morphism" );
        else
            Print( l - 1, " morphisms" );
        fi;
        
        Print( " of " );
        
        if IsHomalgComplexOfLeftModules( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        Print( " modules>" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsGradedObject ],
        
  function( o )
    local l, indices;
    
    Print( "<A graded homology object consisting of " );
    
    indices := ObjectDegreesOfComplex( o );
    
    l := Length( indices );
    
    if l = 1 then
        Print( "a single" );
    else
        Print( l );
    fi;
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " module" );
    
    if l > 1 then
        Print( "s" );
    fi;
    
    Print( " at degree" );
    
    if l = 1 then
        Print( " ", indices[1] );
    else
        Print( "s ", indices );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep and IsGradedObject ],
        
  function( o )
    local l, indices;
    
    Print( "<A graded cohomology object consisting of " );
    
    indices := ObjectDegreesOfComplex( o );
    
    l := Length( indices );
    
    if l = 1 then
        Print( "a single" );
    else
        Print( l );
    fi;
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " module" );
    
    if l > 1 then
        Print( "s" );
    fi;
    
    Print( " at cohomology degree" );
    
    if l = 1 then
        Print( " ", indices[1] );
    else
        Print( "s ", indices );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " complex>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " cocomplex>" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet <--", "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet -->", "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsGradedObject ],
        
  function( o )
    local i;
    
    for i in ObjectDegreesOfComplex( o ) do
        Print( "at homology degree ", i, "\n" );
        Display( CertainObject( o, i ) );
    od;
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep and IsGradedObject ],
        
  function( o )
    local i;
    
    for i in ObjectDegreesOfComplex( o ) do
        Print( "at cohomology degree ", i, "\n" );
        Display( CertainObject( o, i ) );
    od;
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

