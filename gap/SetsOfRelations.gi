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
BindGlobal( "SetsOfRelationsFamily",
        NewFamily( "SetsOfRelationsFamily" ));

# a new type:
BindGlobal( "SetsOfRelationsType",
        NewType( SetsOfRelationsFamily ,
                IsSetsOfRelationsRep ));

####################################
#
# methods for operations:
#
####################################

InstallMethod( PositionOfLastStoredSet,
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
  function( mat, R )
    local relations;
    
    if IsString( mat ) and mat <> [] and LowercaseString(mat{[1..3]}) = "unk" then
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    else
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := CreateRelationsForLeftModule( mat, R ) );
    fi;
    
    ## Objectify:
    Objectify( SetsOfRelationsType, relations );
    
    return relations;
    
end );
  
InstallGlobalFunction( CreateSetsOfRelationsForRightModule,
  function( mat, R )
    local relations;
    
    if IsString( mat ) and mat <> [] and LowercaseString(mat{[1..3]}) = "unk" then
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    else
        relations := rec( ListOfPositionsOfKnownSetsOfRelations := [ 1 ],
                          1 := CreateRelationsForRightModule( mat, R ) );
    fi;
    
    ## Objectify:
    Objectify( SetsOfRelationsType, relations );
    
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

