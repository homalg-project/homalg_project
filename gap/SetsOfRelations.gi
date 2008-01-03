#############################################################################
##
##  SetsOfRelations.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
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

InstallMethod( NumberOfLastStoredSet,
        "for sets of relations",
        [ IsSetsOfRelationsRep ],
        
  function( rels )
    
    return Length( rels!.ListOfNumbersOfKnownSetsOfRelations );
    
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
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    else
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := RelationsOfLeftModule( mat, R ) );
    fi;
    
    ## Objectify:
    Objectify( SetsOfRelationsType, relations );
    
    return relations;
    
end );
  
InstallGlobalFunction( CreateSetsOfRelationsForRightModule,
  function( mat, R )
    local relations;
    
    if IsString( mat ) and mat <> [] and LowercaseString(mat{[1..3]}) = "unk" then
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    else
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := RelationsOfRightModule( mat, R ) );
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
    
    Print( "<Sets of relations of a homalg module>" );
    
end );

