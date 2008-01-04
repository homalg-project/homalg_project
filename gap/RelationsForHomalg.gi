#############################################################################
##
##  RelationsForHomalg.gi       homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for a set of relations.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the category IsRelationsForHomalg:
DeclareRepresentation( "IsLeftRelationsForHomalgRep",
        IsRelationsForHomalg,
        [ "ring", "relations" ] );

DeclareRepresentation( "IsRightRelationsForHomalgRep",
        IsRelationsForHomalg,
        [ "ring", "relations" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "RelationsForHomalgFamily",
        NewFamily( "RelationsForHomalgFamily" ));

# two new types:
BindGlobal( "LeftRelationsForHomalgType",
        NewType(  RelationsForHomalgFamily,
                IsLeftRelationsForHomalgRep ));

BindGlobal( "RightRelationsForHomalgType",
        NewType(  RelationsForHomalgFamily,
                IsRightRelationsForHomalgRep ));

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( RelationsOfLeftModule,
  function( rel, R )
    local relations;
    
    if IsMatrixForHomalg( rel ) then
        relations := rec( ring := R,
                          relations := rel );
    else
        relations := rec( ring := R,
                          relations := MatrixForHomalg( rel ) );
    fi;
    
    ## Objectify:
    Objectify( LeftRelationsForHomalgType, relations );
    
    return relations;
    
end );

InstallGlobalFunction( RelationsOfRightModule,
  function( rel, R )
    local relations;
    
    if IsMatrixForHomalg( rel ) then
        relations := rec( ring := R,
                          relations := rel );
    else
        relations := rec( ring := R,
                          relations := MatrixForHomalg( rel ) );
    fi;
    
    ## Objectify:
    Objectify( RightRelationsForHomalgType, relations );
    
    return relations;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg relations",
        [ IsRelationsForHomalg ],
        
  function( o )
    
    Print( "<A set of relations of a homalg" );
    
    if IsLeftRelationsForHomalgRep( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " module>" );
    
end );

