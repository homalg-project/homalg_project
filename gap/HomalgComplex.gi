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
# logical implications methods:
#
####################################

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# logical implications methods:
#
####################################

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsComplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfLeftModules ],
        
  function( C )
    
end );

##
InstallMethod( IsComplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfRightModules ],
        
  function( C )
    
end );

##
InstallMethod( IsZeroComplex,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return HomalgRing( C!.( C!.indices[1] ) );
    
end );

##
InstallMethod( IsSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices;
    
    indices := C!.indices;
    
    if Length( indices ) = 1 then
        if IsHomalgModule( C!.( indices[1] ) ) then
            return true;
        else
            return IsMorphism( C!.( indices[1] ) );
        fi;
    fi;
    
    
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgComplex,
  function( arg )
    local nargs, C, complex, indices, left, type;
    
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
    
    if nargs > 1 and ( IsInt( arg[2] ) or ( IsList( arg[2] ) and Length( arg[2] ) > 0 and ForAll( arg[2], IsInt ) ) ) then
        indices := [ arg[2] ];
    else
        indices := [ 0 ];
    fi;
    
    if IsHomalgModule( arg[1] ) then
        C.indices := indices;
        if IsLeftModule( arg[1] ) then
            left := true;
        else
            left := false;
        fi;
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
    local first_attribute;
    
    first_attribute := false;
    
    Print( "<A" );
    
    #if IsZeroComplex( o ) then ## if this method applies and HasIsZeroComplex is set we already know that o is a non-zero complex of homalg modules
    #    Print( " non-zero" );
    #    first_attribute := true;
    #fi;
    
    #if IsShortExactSequence( o ) then
    #    Print( " short exact sequence of" ); 
    #elif IsExactSequence( o ) then
    #    if first_attribute then
    #        Print( " exact sequence of" );
    #    else
    #        Print( "n exact sequence of" );
    #    fi;
    #elif IsComplex( o ) then
    #    if IsComplex( o ) then
    #        Print( " complex of" );
    #    else
    #        Print( " non-complex of" );
    #    fi;
    #else
        Print( " \"complex\" of" );
    #fi;
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );

##
InstallMethod( Display,
        "for homalg morphisms",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet", "\n" );
    
end );

