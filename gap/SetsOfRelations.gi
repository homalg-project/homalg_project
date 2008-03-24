#############################################################################
##
##  SetsOfRelations.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for sets of relations.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsSetsOfRelations:
DeclareRepresentation( "IsSetsOfRelationsRep",
        IsSetsOfRelations,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgSetsOfRelationsFamily",
        NewFamily( "HomalgSetsOfRelationsFamily" ) );

# a new type:
BindGlobal( "HomalgSetsOfRelationsType",
        NewType( HomalgSetsOfRelationsFamily ,
                IsSetsOfRelationsRep ) );

####################################
#
# methods for operations:
#
####################################

InstallMethod( PositionOfLastStoredSetOfRelations,
        "for sets of relations",
        [ IsSetsOfRelationsRep ],
        
  function( rels )
    
    return Length( rels!.ListOfPositionsOfKnownSetsOfRelations );
    
end );


####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( CreateSetsOfRelationsForLeftModule,
  function( arg )
    local relations;
    
    if Length( arg ) = 1 then
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := arg[1] );
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 and LowercaseString( arg[1]{[1..3]} ) = "unk" then
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    else
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := HomalgRelationsForLeftModule( arg[1], arg[2] ) );
    fi;
    
    ## Objectify:
    Objectify( HomalgSetsOfRelationsType, relations );
    
    return relations;
    
end );
  
InstallGlobalFunction( CreateSetsOfRelationsForRightModule,
  function( arg )
    local relations;
    
    if Length( arg ) = 1 then
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := arg[1] );
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 and LowercaseString( arg[1]{[1..3]} ) = "unk" then
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    else
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := HomalgRelationsForRightModule( arg[1], arg[2] ) );
    fi;
    
    ## Objectify:
    Objectify( HomalgSetsOfRelationsType, relations );
    
    return relations;
    
end );
  
####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for sets of relations",
        [ IsSetsOfRelationsRep ],
        
  function( o )
    local l;
    
    l := Length( o!.ListOfPositionsOfKnownSetsOfRelations );
    
    if l = 1 then
        Print( "<A set containing a single set of relations of a homalg module>" );
    else
        Print( "<A set containing ", l, " sets of relations of a homalg module>" );
    fi;
    
end );

