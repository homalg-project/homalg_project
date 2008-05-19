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

# a new representation for the category IsHomalgComplex:
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
    
    modules := ModulesOfComplex( C );
    
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
    
    indices := MorphismIndicesOfComplex( C );
    
    indices := indices{[ 1 .. Length( indices ) - 1 ]};
    
    if indices = [ ] then
        return true;
    elif ( IsComplexOfFinitelyPresentedModulesRep( C ) and IsHomalgComplexOfLeftModules( C ) ) 
      or not ( IsComplexOfFinitelyPresentedModulesRep( C ) or IsHomalgComplexOfLeftModules( C ) ) then
        return ForAll( indices, i -> IsZero( C!.((i + 1)) * C!.(i) ) );
    else
        return ForAll( indices, i -> IsZero( C!.(i) * C!.((i + 1)) ) );
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
    
    indices := MorphismIndicesOfComplex( C );
    
    indices := indices{[ 1 .. Length( indices ) - 1 ]};
    
    if indices = [ ] then
        return true;
    elif ( IsComplexOfFinitelyPresentedModulesRep( C ) and IsHomalgComplexOfLeftModules( C ) ) 
      or not ( IsComplexOfFinitelyPresentedModulesRep( C ) or IsHomalgComplexOfLeftModules( C ) ) then
        return ForAll( indices, i -> IsZero( DefectOfHoms( [ C!.((i + 1)), C!.(i) ] ) ) );
    else
        return ForAll( indices, i -> IsZero( DefectOfHoms( [ C!.(i), C!.((i + 1)) ] ) ) );
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
InstallMethod( ModuleIndicesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return C!.indices;
    
end );

##
InstallMethod( HomalgRing,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l, o;
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        o := C!.(indices[1]);
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        o := C!.(indices[l]);
    else
        o := C!.(indices[1]);
    fi;
    
    return HomalgRing( o );
    
end );

##
InstallMethod( MorphismIndicesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l;
    
    indices := ModuleIndicesOfComplex( C );
    
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
InstallMethod( CertainMorphismOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    
    if IsBound( C!.(i) ) and IsHomalgMorphism( C!.(i) ) then
        return C!.(i);
    fi;
    
    return fail;
    
end );

##
InstallMethod( MorphismsOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    indices := MorphismIndicesOfComplex( C );
    
    if Length( indices ) = 0 then
        return [  ];
    fi;
    
    return List( indices, i -> C!.(i) );
    
end );

##
InstallMethod( ModulesOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local morphisms, l, modules;
    
    morphisms := MorphismsOfComplex( C );
    
    l := Length( morphisms );
    
    if l = 0 then
        return [ C!.( ModuleIndicesOfComplex( C )[1] ) ];
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        modules := List( morphisms, TargetOfMorphism );
        Add( modules, SourceOfMorphism( morphisms[l] ) );
    else
        modules := List( morphisms, SourceOfMorphism );
        Add( modules, TargetOfMorphism( morphisms[l] ) );
    fi;
    
    return modules;
    
end );

##
InstallMethod( CertainModuleOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    local indices, l;
    
    if IsBound( C!.(i) ) then
        if IsHomalgModule( C!.(i) ) then
            return C!.(i);
        else
            return SourceOfMorphism( C!.(i) );
        fi;
    fi;
    
    indices := ModuleIndicesOfComplex( C );
    l := Length( indices );
    
    if IsComplexOfFinitelyPresentedModulesRep( C ) and indices[1] = i then
        return TargetOfMorphism( C!.((i + 1)) );
    elif IsCocomplexOfFinitelyPresentedModulesRep( C ) and indices[l] = i then
        return TargetOfMorphism( C!.((i - 1)) );
    fi;
    
    return fail;
    
end );

##
InstallMethod( LowestDegreeModuleInComplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    local indices, l;
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        return C!.( indices[1] );
    else
        return TargetOfMorphism( C!.( indices[2] ) );
    fi;
    
end );

##
InstallMethod( LowestDegreeModuleInComplex,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    local indices, l;
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        return C!.( indices[1] );
    else
        return SourceOfMorphism( C!.( indices[1] ) );
    fi;
    
end );

##
InstallMethod( HighestDegreeModuleInComplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    local indices, l;
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        return C!.( indices[1] );
    else
        return SourceOfMorphism( C!.( indices[l] ) );
    fi;
    
end );

##
InstallMethod( HighestDegreeModuleInComplex,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    local indices, l;
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        return C!.( indices[1] );
    else
        return TargetOfMorphism( C!.( indices[l - 1] ) );
    fi;
    
end );

##
InstallMethod( SupportOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, modules, l;
    
    indices := ModuleIndicesOfComplex( C );
    modules := ModulesOfComplex( C );
    
    l := Length( indices );
    
    return indices{ Filtered( [ 1 .. l ], i -> not IsZero( modules[i] ) ) };
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep, IsHomalgMorphism ],
        
  function( C, phi )
    local indices, l;
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        
        if not IsIdenticalObj( C!.( indices[1] ), TargetOfMorphism( phi ) ) then
            Error( "the unique module in the complex and the target of the new morphism are not identical\n" );
        fi;
        
        Unbind( C!.( indices[1] ) );
        
        Add( indices, indices[1] + 1 );
        
        C!.( indices[1] + 1 ) := phi;
        
    else
        
        l := indices[l];
        
        if not IsIdenticalObj( SourceOfMorphism( C!.(l) ), TargetOfMorphism( phi ) ) then
            Error( "the source of the ", l, ". morphism in the complex (i.e. the highest one) and the target of the new morphism are not identically the same module\n" );
        fi;
        
        Add( indices, l + 1 );
        
        C!.((l + 1)) := phi;
        
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
    
    indices := ModuleIndicesOfComplex( C );
    
    l := Length( indices );
    
    if l = 1 then
        
        if not IsIdenticalObj( C!.( indices[1] ), SourceOfMorphism( phi ) ) then
            Error( "the unique module in the complex and the source of the new morphism are not identical\n" );
        fi;
        
        Add( indices, indices[1] + 1 );
        
        C!.( indices[1] ) := phi;
        
    else
        
        l := indices[l - 1];
        
        if not IsIdenticalObj( TargetOfMorphism( C!.(l) ), SourceOfMorphism( phi ) ) then
            Error( "the target of the ", l, ". morphism in the complex (i.e. the highest one) and the source of the new morphism are not identically the same module\n" );
        fi;
        
        Add( indices, l + 2 );
        
        C!.((l + 1)) := phi;
        
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
    
    T := HighestDegreeModuleInComplex( C );
    
    Add( C, HomalgMorphism( mat, "free", T ) );
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep, IsHomalgMatrix ],
        
  function( C, mat )
    local S;
    
    S := HighestDegreeModuleInComplex( C );
    
    Add( C, HomalgMorphism( mat, S, "free" ) );
    
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
          [ IsSequence, IsComplex, IsGradedObject, IsExactSequence, IsShortExactSequence ];
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
        if IsLeftModule( arg[1] ) then
            left := true;
        else
            left := false;
        fi;
        module := true;
    elif IsHomalgMorphism( arg[1] ) then
        if complex then
            C.indices := [ indices[1] - 1, indices[1] ];
        else
            C.indices := [ indices[1], indices[1] + 1 ];
        fi;
        if IsHomalgMorphismOfLeftModules( arg[1] ) then
            left := true;
        else
            left := false;
        fi;
    else
        Error( "the first argument must be either a module or morphism\n" );
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
    
    indices := ModuleIndicesOfComplex( o );
    
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
        
        Print( "homological degree ", indices[1], ">" );
        
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
    
    Print( "<A graded object consisting of " );
    
    indices := ModuleIndicesOfComplex( o );
    
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
    
    Print( " at homological degree" );
    
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
    
    Print( "<A graded object consisting of " );
    
    indices := ModuleIndicesOfComplex( o );
    
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
    
    Print( " at cohomological degree" );
    
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

