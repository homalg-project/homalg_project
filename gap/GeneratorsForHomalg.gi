#############################################################################
##
##  GeneratorsForHomalg.gi      homalg package               Mohamed Barakat
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

# two new representations for the category IsGeneratorsForHomalg:
DeclareRepresentation( "IsLeftGeneratorsForHomalgRep",
        IsGeneratorsForHomalg,
        [ "generators", "relations_of_hullmodule" ] );

DeclareRepresentation( "IsRightGeneratorsForHomalgRep",
        IsGeneratorsForHomalg,
        [ "generators", "relations_of_hullmodule" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "GeneratorsForHomalgFamily",
        NewFamily( "GeneratorsForHomalgFamily" ));

# two new types:
BindGlobal( "LeftGeneratorsForHomalgType",
        NewType(  GeneratorsForHomalgFamily,
                IsLeftGeneratorsForHomalgRep ));

BindGlobal( "RightGeneratorsForHomalgType",
        NewType(  GeneratorsForHomalgFamily,
                IsRightGeneratorsForHomalgRep ));

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( Reduce,
        "for a set of generators of a homalg module",
	[ IsGeneratorsForHomalg ],
        
  function( gen )
    
    if HasIsReduced( gen ) and IsReduced( gen ) then
        return gen!.generators;
    elif not IsBound( gen!.Reduce ) then
        gen!.Reduce := Reduce( gen!.generators, gen!.relations );
        SetIsReduced( gen, false );
    fi;
    
    return gen!.Reduce;
end );

##
InstallMethod( NrGenerators,
        "for a set of generators of a homalg module",
        [ IsLeftGeneratorsForHomalgRep ],
        
  function( gen )
    
    return NrRows ( gen!.generators );
    
end );

##
InstallMethod( NrGenerators,
        "for a set of generators of a homalg module",
        [ IsRightGeneratorsForHomalgRep ],
        
  function( gen )
    
    return NrColumns ( gen!.generators );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( CreateGeneratorsForLeftModule,
  function( arg )
    local nar, ar, R, generators, relations_of_hullmodule, gen;
    
    nar := Length( arg );
    
    for ar in arg{[2..nar]} do
        if IsRingForHomalg( ar ) then
            R := ar;
            break;
        fi;
    od;
    
    if IsMatrixForHomalg( arg[1] ) then
        generators := arg[1];
    elif IsBound( R ) then
        generators := MatrixForHomalg( arg[1], R );
    else
        Error( "if the first argument isn't of type IsMatrixForHomalg, then the last argument must be of type IsRingForHomalg; but recieved: ", arg[nar], "\n" );
    fi;
    
    for ar in arg{[2..nar]} do
        if IsRelationsForHomalg( ar ) then
            relations_of_hullmodule := ar;
            break;
        elif IsMatrixForHomalg( ar ) then
            relations_of_hullmodule := CreateRelationsForLeftModule( ar );
            break;
        elif nar > 2 then
            if IsBound( R ) then
                relations_of_hullmodule := CreateRelationsForLeftModule( ar, R );
                break;
            else
                Error( "if more than two arguments are provided and the second argument is neither of type IsRelationsForHomalg nor of type IsMatrixForHomalg, then the last argument must be of type IsRingForHomalg; but recieved: ", arg[nar], "\n" );
            fi;
        else
            relations_of_hullmodule := CreateRelationsForLeftModule( MatrixForHomalg( "zero", 0, NrRows( generators ), R ), R );
        fi;
    od;
    
    gen := rec( generators := generators,
                relations_of_hullmodule := relations_of_hullmodule );
    
    ## Objectify:
    Objectify( LeftGeneratorsForHomalgType, gen );
    
    return gen;
    
end );

InstallGlobalFunction( CreateGeneratorsForRightModule,
  function( arg )
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg generators",
        [ IsGeneratorsForHomalg ],
        
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
    
    if IsLeftGeneratorsForHomalgRep( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

