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

# a new representation for the category IsSetsOfGenerators:
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
  function( mat, R )
    local generators;
    
    if IsString( mat ) and Length( mat ) > 2 and LowercaseString( mat{[1..3]} ) = "unk" then
        generators := rec( ListOfPositionsOfKnownSetsOfGenerators := [ 1 ],
                          1 := "unknown generators" );
    else
        generators := rec( ListOfPositionsOfKnownSetsOfGenerators := [ 1 ],
                          1 := HomalgGeneratorsForLeftModule( mat, R ) );
    fi;
    
    ## Objectify:
    Objectify( TheTypeHomalgSetsOfGenerators, generators );
    
    return generators;
    
end );
  
InstallGlobalFunction( CreateSetsOfGeneratorsForRightModule,
  function( mat, R )
    local generators;
    
    if IsString( mat ) and Length( mat ) > 2 and LowercaseString( mat{[1..3]} ) = "unk" then
        generators := rec( ListOfPositionsOfKnownSetsOfGenerators := [ 1 ],
                          1 := "unknown generators" );
    else
        generators := rec( ListOfPositionsOfKnownSetsOfGenerators := [ 1 ],
                          1 := HomalgGeneratorsForRightModule( mat, R ) );
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

