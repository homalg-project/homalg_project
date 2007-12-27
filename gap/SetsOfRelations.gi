#############################################################################
##
##  SetsOfRelations.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for sets of relations.
##
#############################################################################

# a new representation for the category IsSetsOfRelations:
DeclareRepresentation( "IsSetsOfRelationsRep",
        IsSetsOfRelations,
        [ ] );

# a new family:
BindGlobal( "SetsOfRelationsFamily",
        NewFamily( "SetsOfRelationsFamily" ));

# a new type:
BindGlobal( "SetsOfRelationsType",
        NewType( SetsOfRelationsFamily ,
                IsSetsOfRelationsRep ));

######################
# constructor methods:
######################

InstallGlobalFunction( CreateSetsOfRelations,
  function( arg )
    local relations;
    
    if IsString( arg[1] ) and arg[1] <> [] and LowercaseString(arg[1]{[1..3]}) = "unk" then
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := "unknown relations" );
    elif IsMatrixForHomalg( arg[1] ) then
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := arg[1] );
    else
        relations := rec( ListOfNumbersOfKnownSetsOfRelations := [ 1 ],
                          1 := MatrixForHomalg( arg[1] ) );
    fi;
    
    ## Objectify:
    Objectify( SetsOfRelationsType, relations );
    
    return relations;
    
end );
  
###################################
# View, Print, and Display methods:
###################################

InstallMethod( ViewObj,
        "for sets of relations",
        [ IsSetsOfRelationsRep ],
        
  function( o )
    
    Print( "<An object containg sets of relations containing>" );
    
end );

