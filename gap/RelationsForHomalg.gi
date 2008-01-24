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
InstallMethod( MatrixOfRelations,
        "for sets of relations of a homalg module",
        [ IsRelationsForHomalg ],
        
  function( rel )
    
    return rel!.relations;
    
end );

##
InstallMethod( HomalgRing,
        "for sets of relations of a homalg module",
        [ IsRelationsForHomalg ],
        
  function( rel )
    
    return HomalgRing( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,
        "for sets of relations of a homalg module",
        [ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,
        "for sets of relations of a homalg module",
        [ IsRightRelationsForHomalgRep ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,
        "for sets of relations of a homalg module",
        [ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,
        "for sets of relations of a homalg module",
        [ IsRightRelationsForHomalgRep ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of a homalg module",
	[ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfRows( MatrixOfRelations( rel ) );
        SetCanBeUsedToEffectivelyDecideZero( rel, false );
    fi;
    
    bas := CreateRelationsForLeftModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
        
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of a homalg module",
	[ IsRightRelationsForHomalgRep ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumns( MatrixOfRelations( rel ) );
        SetCanBeUsedToEffectivelyDecideZero( rel, false );
    fi;
    
    bas := CreateRelationsForRightModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
        
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of a homalg module",
	[ IsRelationsForHomalg and CanBeUsedToEffectivelyDecideZero ],
        
  function( rel )
    
    return MatrixOfRelations( rel );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of a homalg module",
	[ IsMatrixForHomalg, IsLeftRelationsForHomalgRep ],
        
  function( mat, rel )
    
    return DecideZeroRows( mat, BasisOfModule( rel ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of a homalg module",
	[ IsMatrixForHomalg, IsRightRelationsForHomalgRep ],
        
  function( mat, rel )
    
    return DecideZeroColumns( mat, BasisOfModule( rel ) );
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of a homalg module",
	[ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfRowsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToEffectivelyDecideZero( rel, false );
    fi;
    
    bas := CreateRelationsForLeftModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
        
    return bas;
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of a homalg module",
	[ IsRightRelationsForHomalgRep ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumnsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToEffectivelyDecideZero( rel, false );
    fi;
    
    bas := CreateRelationsForRightModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
    
    return bas;
    
end );

##
InstallMethod( EffectivelyDecideZero,
        "for sets of relations of a homalg module",
	[ IsMatrixForHomalg, IsLeftRelationsForHomalgRep ],
        
  function( mat, rel )
    
    return EffectivelyDecideZeroRows( mat, BasisOfModule( rel ) );
    
end );

##
InstallMethod( EffectivelyDecideZero,
        "for sets of relations of a homalg module",
	[ IsMatrixForHomalg, IsRightRelationsForHomalgRep ],
        
  function( mat, rel )
    
    return EffectivelyDecideZeroColumns( mat, BasisOfModule( rel ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of a homalg module",
        [ IsLeftRelationsForHomalgRep, IsLeftRelationsForHomalgRep ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfRows( MatrixOfRelations( M1 ), MatrixOfRelations( M2 ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of a homalg module",
        [ IsLeftRelationsForHomalgRep, IsList and IsEmpty ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfRows( MatrixOfRelations( M1 ), [ ] );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of a homalg module",
        [ IsRightRelationsForHomalgRep, IsRightRelationsForHomalgRep ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfColumns( MatrixOfRelations( M1 ), MatrixOfRelations( M2 ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of a homalg module",
        [ IsRightRelationsForHomalgRep, IsList and IsEmpty ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfColumns( MatrixOfRelations( M1 ), [ ] );
    
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
    local m, n;
    
    m := NrRelations( o );
    n := NrGenerators( o );
    
    if m = 0 then
        Print( "<An empty set of relations " );
    elif m = 1 then
        Print( "<A set containing a single relation " );
    else
        Print( "<A set of ", m, " relations " );
    fi;
    
    if n = 0 then
        Print( "on an empty set of generators " );
    elif n = 1 then
        Print( "on a single generator " );
    else
        Print( "on ", n, " generators " );
    fi;
    
    Print( "of a homalg " );
    
    if IsLeftRelationsForHomalgRep( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

