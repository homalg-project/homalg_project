#############################################################################
##
##  RelationsForHomalg.gi       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
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
        [ "relations" ] );

DeclareRepresentation( "IsRightRelationsForHomalgRep",
        IsRelationsForHomalg,
        [ "relations" ] );

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
# methods for operations:
#
####################################

##
InstallMethod( NrRelations,
        "for sets of relations of a homalg module",
        [ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    
    return NrRows( rel!.relations );
    
end );

##
InstallMethod( NrRelations,
        "for sets of relations of a homalg module",
        [ IsRightRelationsForHomalgRep ],
        
  function( rel )
    
    return NrColumns( rel!.relations );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of a homalg module",
	[ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    
    if not IsBound( rel!.BasisOfModule ) then
            rel!.BasisOfModule := BasisOfRows( rel!.relations );
            SetCanBeUsedToEffictivelyDecideZero( rel, false );
    fi;
    
    return rel!.BasisOfModule;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of a homalg module",
	[ IsRightRelationsForHomalgRep ],
        
  function( rel )
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumns( rel!.relations );
        SetCanBeUsedToEffictivelyDecideZero( rel, false );
    fi;
    
    return rel!.BasisOfModule;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of a homalg module",
	[ IsRelationsForHomalg and CanBeUsedToEffictivelyDecideZero ],
        
  function( rel )
    
    return rel!.relations;
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of a homalg module",
	[ IsMatrixForHomalg, IsLeftRelationsForHomalgRep ],
        
  function( mat, rel )
    
    BasisOfModule( rel );
    
    return DecideZeroRows( mat, rel!.relations );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of a homalg module",
	[ IsMatrixForHomalg, IsRightRelationsForHomalgRep ],
        
  function( mat, rel )
    
    BasisOfModule( rel );
    
    return DecideZeroColumns( mat, rel );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( CreateRelationsForLeftModule,
  function( arg )
    local relations;
    
    if IsMatrixForHomalg( arg[1] ) then
        relations := rec( relations := arg[1] );
    else
        relations := rec( relations := MatrixForHomalg( arg[1], arg[2] ) );
    fi;
    
    ## Objectify:
    Objectify( LeftRelationsForHomalgType, relations );
    
    return relations;
    
end );

InstallGlobalFunction( CreateRelationsForRightModule,
  function( arg )
    local relations;
    
    if IsMatrixForHomalg( arg[1] ) then
        relations := rec( relations := arg[1] );
    else
        relations := rec( relations := MatrixForHomalg( arg[1], arg[2] ) );
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
    local m;
    
    m := NrRelations( o );
    
    if m = 0 then
        Print( "<An empty set of relations of a homalg " );
    elif m = 1 then
        Print( "<A set containing a single relation of a homalg " );
    else
        Print( "<A set of ", m, " relations of a homalg " );
    fi;
    
    if IsLeftRelationsForHomalgRep( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

