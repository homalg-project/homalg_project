#############################################################################
##
##  HomalgRelations.gi          homalg package               Mohamed Barakat
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
# CAUTION: in the code we use the the following two reps are the only ones!!!!
#
####################################

# two new representations for the category IsHomalgRelations:
DeclareRepresentation( "IsHomalgLeftRelationsRep",
        IsHomalgRelations,
        [ "relations" ] );

DeclareRepresentation( "IsHomalgRightRelationsRep",
        IsHomalgRelations,
        [ "relations" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgRelationsFamily",
        NewFamily( "HomalgRelationsFamily" ) );

# two new types:
BindGlobal( "HomalgLeftRelationsType",
        NewType(  HomalgRelationsFamily,
                IsHomalgLeftRelationsRep ) );

BindGlobal( "HomalgRightRelationsType",
        NewType(  HomalgRelationsFamily,
                IsHomalgRightRelationsRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( rel )
    
    return rel!.relations;
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgLeftRelationsRep, IsHomalgLeftRelationsRep ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgRightRelationsRep, IsHomalgRightRelationsRep ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( rel )
    
    return HomalgRing( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsHomalgLeftRelationsRep ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsHomalgRightRelationsRep ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsHomalgLeftRelationsRep ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsHomalgRightRelationsRep ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
	[ IsHomalgLeftRelationsRep ],
        
  function( rel )
    local mat, bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfRows( mat );
        
        if bas <> mat then
            rel!.BasisOfModule := bas;
            SetCanBeUsedToEffectivelyDecideZero( rel, false );
        else
            SetCanBeUsedToEffectivelyDecideZero( rel, true );
        fi;
    else
        bas := rel!.BasisOfModule;
    fi;
    
    bas := HomalgRelationsForLeftModule( bas );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
	[ IsHomalgRightRelationsRep ],
        
  function( rel )
    local mat, bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfColumns( mat );
        
        if bas <> mat then
            rel!.BasisOfModule := bas;
            SetCanBeUsedToEffectivelyDecideZero( rel, false );
        else
            SetCanBeUsedToEffectivelyDecideZero( rel, true );
        fi;
    else
        bas := rel!.BasisOfModule;
    fi;
    
    bas := HomalgRelationsForLeftModule( bas );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
	[ IsHomalgRelations and CanBeUsedToEffectivelyDecideZero ],
        
  function( rel )
    
    return rel;
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgMatrix, IsHomalgLeftRelationsRep ],
        
  function( mat, rel )
    
    return DecideZeroRows( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgMatrix, IsHomalgRightRelationsRep ],
        
  function( mat, rel )
    
    return DecideZeroColumns( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgLeftRelationsRep, IsHomalgLeftRelationsRep ],
        
  function( rel_, rel )
    
    return HomalgRelationsForLeftModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgRightRelationsRep, IsHomalgRightRelationsRep ],
        
  function( rel_, rel )
    
    return HomalgRelationsForRightModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
	[ IsHomalgLeftRelationsRep ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfRowsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToEffectivelyDecideZero( rel, false );
    fi;
    
    bas := HomalgRelationsForLeftModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
        
    return bas;
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
	[ IsHomalgRightRelationsRep ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumnsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToEffectivelyDecideZero( rel, false );
    fi;
    
    bas := HomalgRelationsForRightModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToEffectivelyDecideZero( bas, true );
    
    return bas;
    
end );

##
InstallMethod( EffectivelyDecideZero,
        "modulo a set of relations of a homalg module",
	[ IsHomalgMatrix, IsHomalgLeftRelationsRep ],
        
  function( mat, rel )
    
    return EffectivelyDecideZeroRows( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( EffectivelyDecideZero,
        "modulo a set of relations of a homalg module",
	[ IsHomalgMatrix, IsHomalgRightRelationsRep ],
        
  function( mat, rel )
    
    return EffectivelyDecideZeroColumns( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgLeftRelationsRep, IsHomalgLeftRelationsRep ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfRows( MatrixOfRelations( M1 ), MatrixOfRelations( M2 ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgLeftRelationsRep ],
        
  function( M )
    
    return SyzygiesGeneratorsOfRows( MatrixOfRelations( M ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRightRelationsRep, IsHomalgRightRelationsRep ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfColumns( MatrixOfRelations( M1 ), MatrixOfRelations( M2 ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRightRelationsRep ],
        
  function( M )
    
    return SyzygiesGeneratorsOfColumns( MatrixOfRelations( M ) );
    
end );

##
InstallMethod( NonZeroGenerators,		### defines: NonZeroGenerators
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( M )
    local R, RP, id, gen;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    id := HomalgMatrix( "identity", NrGenerators( M ), R );
    
    if IsHomalgLeftRelationsRep( M ) then
        gen := HomalgGeneratorsForLeftModule( id, BasisOfModule( M ) );
        gen := DecideZero( gen );
        return NonZeroRows( gen );
    else
        gen := HomalgGeneratorsForRightModule( id, BasisOfModule( M ) );
        gen := DecideZero( gen );
        return NonZeroColumns( gen );
    fi;
    
end );

##
InstallMethod( GetRidOfTrivialRelations,	### defines: GetRidOfTrivialRelations (BetterBasis)
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( _M )
    local R, RP, M;
    
    R := HomalgRing( _M );
    
    RP := HomalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    if IsHomalgLeftRelationsRep( _M ) then
        if IsBound(RP!.SimplifyBasisOfRows) then
            M := RP!.SimplifyBasisOfRows( _M );
        else
            M := MatrixOfRelations( _M );
        fi;
        
        return HomalgRelationsForLeftModule( CertainRows( M, NonZeroRows( M ) ) );
    else
        if IsBound(RP!.SimplifyBasisOfColumns) then
            M := RP!.SimplifyBasisOfColumns( _M );
        else
            M := MatrixOfRelations( _M );
        fi;
        
        return HomalgRelationsForRightModule( CertainColumns( M, NonZeroColumns( M ) ) );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgRelationsForLeftModule,
  function( arg )
    local relations;
    
    if IsHomalgMatrix( arg[1] ) then
        relations := rec( relations := arg[1] );
    else
        relations := rec( relations := HomalgMatrix( arg[1], arg[2] ) );
    fi;
    
    ## Objectify:
    Objectify( HomalgLeftRelationsType, relations );
    
    return relations;
    
end );

InstallGlobalFunction( HomalgRelationsForRightModule,
  function( arg )
    local relations;
    
    if IsHomalgMatrix( arg[1] ) then
        relations := rec( relations := arg[1] );
    else
        relations := rec( relations := HomalgMatrix( arg[1], arg[2] ) );
    fi;
    
    ## Objectify:
    Objectify( HomalgRightRelationsType, relations );
    
    return relations;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg relations",
        [ IsHomalgRelations ],
        
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
    
    if IsHomalgLeftRelationsRep( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

InstallMethod( Display,
        "for homalg relations",
        [ IsHomalgRelations ],
        
  function( o )
    
    Display( MatrixOfRelations( o ) );
    
end );
