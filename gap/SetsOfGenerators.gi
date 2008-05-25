#############################################################################
##
##  SetsOfGenerators.gi         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for sets of generators.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsSetsOfGenerators:
DeclareRepresentation( "IsSetsOfGeneratorsRep",
        IsSetsOfGenerators,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgSetsOfGenerators",
        NewFamily( "TheFamilyOfHomalgSetsOfGenerators" ) );

# a new type:
BindGlobal( "TheTypeHomalgSetsOfGenerators",
        NewType( TheFamilyOfHomalgSetsOfGenerators,
                IsSetsOfGeneratorsRep ) );

####################################
#
# methods for operations:
#
####################################

InstallMethod( PositionOfLastStoredSetOfGenerators,
        "for sets of generators",
        [ IsSetsOfGeneratorsRep ],
        
  function( gens )
    
    return Length( gens!.ListOfPositionsOfKnownSetsOfGenerators );
    
end );


####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( CreateSetsOfGeneratorsForLeftModule,
  function( arg )
    local nargs, generators;
    
    nargs := Length( arg );
    
    generators := rec( ListOfPositionsOfKnownSetsOfGenerators := [ 1 ] );
    
    if IsHomalgGeneratorsOfFinitelyGeneratedModuleRep( arg[1] )
       and IsHomalgGeneratorsOfLeftModule( arg[1] ) then
        generators.1 := arg[1];
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 and LowercaseString( arg[1]{[1..3]} ) = "unk" then
        generators.1 := "unknown generators";
    else
        generators.1 := CallFuncList( HomalgGeneratorsForLeftModule, arg );
    fi;
    
    ## Objectify:
    Objectify( TheTypeHomalgSetsOfGenerators, generators );
    
    return generators;
    
end );
  
InstallGlobalFunction( CreateSetsOfGeneratorsForRightModule,
  function( arg )
    local generators;
    
    generators := rec( ListOfPositionsOfKnownSetsOfGenerators := [ 1 ] );
    
    if IsHomalgGeneratorsOfFinitelyGeneratedModuleRep( arg[1] )
       and IsHomalgGeneratorsOfRightModule( arg[1] ) then
        generators.1 := arg[1];
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 and LowercaseString( arg[1]{[1..3]} ) = "unk" then
        generators.1 := "unknown generators";
    else
        generators.1 := CallFuncList( HomalgGeneratorsForRightModule, arg );
    fi;
    
    ## Objectify:
    Objectify( TheTypeHomalgSetsOfGenerators, generators );
    
    return generators;
    
end );
  
####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for sets of generators",
        [ IsSetsOfGeneratorsRep ],
        
  function( o )
    local l;
    
    l := Length( o!.ListOfPositionsOfKnownSetsOfGenerators );
    
    if l = 1 then
        Print( "<A set containing a single set of generators of a homalg module>" );
    else
        Print( "<A set containing ", l, " sets of generators of a homalg module>" );
    fi;
    
end );

