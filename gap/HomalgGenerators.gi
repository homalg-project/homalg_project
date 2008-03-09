#############################################################################
##
##  HomalgGenerators.gi      homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for a set of generators.
##
#############################################################################

####################################
#
# representations:
#
####################################

## CAUTION: in the code we use the the following two reps are the only ones!!!!

# two new representations for the category IsHomalgGenerators:
DeclareRepresentation( "IsHomalgLeftGeneratorsRep",
        IsHomalgGenerators,
        [ "generators", "relations_of_hullmodule" ] );

DeclareRepresentation( "IsHomalgRightGeneratorsRep",
        IsHomalgGenerators,
        [ "generators", "relations_of_hullmodule" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgGeneratorsFamily",
        NewFamily( "HomalgGeneratorsFamily" ) );

# two new types:
BindGlobal( "HomalgLeftGeneratorsType",
        NewType(  HomalgGeneratorsFamily,
                IsHomalgLeftGeneratorsRep ) );

BindGlobal( "HomalgRightGeneratorsType",
        NewType(  HomalgGeneratorsFamily,
                IsHomalgRightGeneratorsRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return gen!.generators;
    
end );

##
InstallMethod( HomalgRing,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return HomalgRing( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( RelationsOfHullModule,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return gen!.relations_of_hullmodule;
    
end );

##
InstallMethod( MatrixOfRelations,
        "for sets of generators of homalg modules",
        [ IsHomalgGenerators ],
        
  function( gen )
    
    return MatrixOfRelations( RelationsOfHullModule( gen ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of generators of homalg modules",
        [ IsHomalgLeftGeneratorsRep ],
        
  function( gen )
    
    return NrRows( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of generators of homalg modules",
        [ IsHomalgRightGeneratorsRep ],
        
  function( gen )
    
    return NrColumns( MatrixOfGenerators( gen ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of generators of homalg modules",
	[ IsHomalgLeftGeneratorsRep ],
        
  function( gen )
    local bas;
    
    if not IsBound( gen!.BasisOfModule ) then
        gen!.BasisOfModule := BasisOfRows( MatrixOfGenerators( gen ) );
        SetCanBeUsedToEffectivelyDecideZero( gen, false );
    fi;
    
    bas := HomalgGeneratorsForLeftModule( gen!.BasisOfModule, HomalgRing( gen ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
    
    return HomalgRelationsForLeftModule( MatrixOfGenerators( bas ) ); ## FIXME
end );

##
InstallMethod( BasisOfModule,
        "for sets of generators of homalg modules",
	[ IsHomalgRightGeneratorsRep ],
        
  function( gen )
    local bas;
    
    if not IsBound( gen!.BasisOfModule ) then
        gen!.BasisOfModule := BasisOfColumns( MatrixOfGenerators( gen ) );
        SetCanBeUsedToEffectivelyDecideZero( gen, false );
    fi;
    
    bas := HomalgGeneratorsForRightModule( gen!.BasisOfModule, HomalgRing( gen ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
        
    return HomalgRelationsForRightModule( MatrixOfGenerators( bas ) ); ## FIXME
end );

##
InstallMethod( DecideZero,
        "for sets of generators of homalg modules",
	[ IsHomalgGenerators ],
        
  function( gen )
    
    if HasIsReduced( gen ) and IsReduced( gen ) then
        return MatrixOfGenerators( gen );
    elif not IsBound( gen!.DecideZero ) then
        gen!.DecideZero := DecideZero( MatrixOfGenerators( gen ), RelationsOfHullModule( gen ) );
        SetIsReduced( gen, false );
    fi;
    
    return gen!.DecideZero;
end );

##
InstallMethod( DecideZero,
        "for sets of generators of homalg modules",
	[ IsHomalgGenerators, IsHomalgRelations ],
        
  function( gen, rel )
    
    if not IsBound( gen!.DecideZero ) then
        gen!.DecideZero := DecideZero( MatrixOfGenerators( gen ), rel );
        SetIsReduced( gen, false );
    fi;
    
    return gen!.DecideZero;
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgGeneratorsForLeftModule,
  function( arg )
    local nargs, ar, R, generators, relations_of_hullmodule, gen;
    
    nargs := Length( arg );
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRing( ar ) then
            R := ar;
            break;
        fi;
    od;
    
    if IsHomalgMatrix( arg[1] ) then
        generators := arg[1];
    elif IsBound( R ) then
        generators := HomalgMatrix( arg[1], R );
    else
        Error( "if the first argument isn't of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing; but recieved: ", arg[nargs], "\n" );
    fi;
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRelations( ar ) then
            relations_of_hullmodule := ar;
            break;
        elif IsHomalgMatrix( ar ) then
            relations_of_hullmodule := HomalgRelationsForLeftModule( ar );
            break;
        elif nargs > 2 then
            if IsBound( R ) then
                relations_of_hullmodule := HomalgRelationsForLeftModule( ar, R );
                break;
            else
                Error( "if more than two arguments are provided and the second argument is neither of type IsHomalgRelations nor of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing; but recieved: ", arg[nargs], "\n" );
            fi;
        fi;
    od;
    
    if not IsBound( R ) then
        R := HomalgRing( generators );
    fi;
    
    if not IsBound( relations_of_hullmodule ) then
        relations_of_hullmodule :=
          HomalgRelationsForLeftModule( HomalgMatrix( "zero", 0, NrRows( generators ), R ), R );
    fi;
    
    gen := rec( generators := generators,
                relations_of_hullmodule := relations_of_hullmodule );
    
    ## Objectify:
    Objectify( HomalgLeftGeneratorsType, gen );
    
    return gen;
    
end );

InstallGlobalFunction( HomalgGeneratorsForRightModule,
  function( arg )
    local nargs, ar, R, generators, relations_of_hullmodule, gen;
    
    nargs := Length( arg );
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRing( ar ) then
            R := ar;
            break;
        fi;
    od;
    
    if IsHomalgMatrix( arg[1] ) then
        generators := arg[1];
    elif IsBound( R ) then
        generators := HomalgMatrix( arg[1], R );
    else
        Error( "if the first argument isn't of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing; but recieved: ", arg[nargs], "\n" );
    fi;
    
    for ar in arg{ [ 2 .. nargs ] } do
        if IsHomalgRelations( ar ) then
            relations_of_hullmodule := ar;
            break;
        elif IsHomalgMatrix( ar ) then
            relations_of_hullmodule := HomalgRelationsForRightModule( ar );
            break;
        elif nargs > 2 then
            if IsBound( R ) then
                relations_of_hullmodule := HomalgRelationsForRightModule( ar, R );
                break;
            else
                Error( "if more than two arguments are provided and the second argument is neither of type IsHomalgRelations nor of type IsHomalgMatrix, then the last argument must be of type IsHomalgRing; but recieved: ", arg[nargs], "\n" );
            fi;
        fi;
    od;
    
    if not IsBound( R ) then
        R := HomalgRing( generators );
    fi;
    
    if not IsBound( relations_of_hullmodule ) then
        relations_of_hullmodule :=
          HomalgRelationsForLeftModule( HomalgMatrix( "zero", 0, NrRows( generators ), R ), R );
    fi;
    
    gen := rec( generators := generators,
                relations_of_hullmodule := relations_of_hullmodule );
    
    ## Objectify:
    Objectify( HomalgRightGeneratorsType, gen );
    
    return gen;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg generators",
        [ IsHomalgGenerators ],
        
  function( o )
    local m;
    
    m := NrGenerators( o );
    
    if m = 0 then
        Print( "<An empty set of generators of a homalg " );
    elif m = 1 then
        Print( "<A set consisting of a single generator of a homalg " );
    else
        Print( "<A set of ", m, " generators of a homalg " );
    fi;
    
    if IsHomalgLeftGeneratorsRep( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

InstallMethod( Display,
        "for homalg generators",
        [ IsHomalgGenerators ],
        
  function( o )
    
    Display( MatrixOfGenerators( o ) );
    
end );
