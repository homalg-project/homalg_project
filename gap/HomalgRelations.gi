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
####################################

# a new representation for the category IsHomalgRelations:
DeclareRepresentation( "IsHomalgRelationsOfFinitelyPresentedModuleRep",
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
BindGlobal( "HomalgRelationsOfLeftModuleType",
        NewType(  HomalgRelationsFamily,
                IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ) );

BindGlobal( "HomalgRelationsOfRightModuleType",
        NewType(  HomalgRelationsFamily,
                IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( rel )
    
    return rel!.relations;
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( rel )
    
    return HomalgRing( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
	[ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local mat, bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfRows( mat );
        
        if bas = mat and IsReducedModuloRingRelations( mat ) then
            SetCanBeUsedToDecideZeroEffectively( rel, true );
	    rel!.relations := bas; ## CAUTION: be very careful here!!!
	    return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZeroEffectively( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
    fi;
    
    bas := HomalgRelationsForLeftModule( bas );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
	[ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local mat, bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfColumns( mat );
        
        if bas <> mat then
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZeroEffectively( rel, false );
        else
            SetCanBeUsedToDecideZeroEffectively( rel, true );
        fi;
    else
        bas := rel!.BasisOfModule;
    fi;
    
    bas := HomalgRelationsForRightModule( bas );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
	[ IsHomalgRelations and CanBeUsedToDecideZeroEffectively ],
        
  function( rel )
    
    return rel;
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgMatrix, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return DecideZeroRows( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgMatrix, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return DecideZeroColumns( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel_, rel )
    
    return HomalgRelationsForLeftModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
	[ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel_, rel )
    
    return HomalgRelationsForRightModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
	[ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfRowsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToDecideZeroEffectively( rel, false );
    fi;
    
    bas := HomalgRelationsForLeftModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
        
    return bas;
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
	[ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumnsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToDecideZeroEffectively( rel, false );
    fi;
    
    bas := HomalgRelationsForRightModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
    
end );

##
InstallMethod( DecideZeroEffectively,
        "modulo a set of relations of a homalg module",
	[ IsHomalgMatrix, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return DecideZeroRowsEffectively( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZeroEffectively,
        "modulo a set of relations of a homalg module",
	[ IsHomalgMatrix, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return DecideZeroColumnsEffectively( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfRows( MatrixOfRelations( M1 ), MatrixOfRelations( M2 ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( M )
    
    return SyzygiesGeneratorsOfRows( MatrixOfRelations( M ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule, IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( M1, M2 )
    
    return SyzygiesGeneratorsOfColumns( MatrixOfRelations( M1 ), MatrixOfRelations( M2 ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( M )
    
    return SyzygiesGeneratorsOfColumns( MatrixOfRelations( M ) );
    
end );

##
InstallMethod( NonZeroGenerators,		### defines: NonZeroGenerators
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( M )
    local R, RP, id, gen;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    id := HomalgMatrix( "identity", NrGenerators( M ), R );
    
    if IsHomalgRelationsOfLeftModule( M ) then
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
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( _M )
    local R, RP, M;
    
    R := HomalgRing( _M );
    
    RP := HomalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    if IsHomalgRelationsOfLeftModule( _M ) then
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
    Objectify( HomalgRelationsOfLeftModuleType, relations );
    
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
    Objectify( HomalgRelationsOfRightModuleType, relations );
    
    return relations;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg relations",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
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
    
    if IsHomalgRelationsOfLeftModule( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

InstallMethod( Display,
        "for homalg relations",
        [ IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( o )
    
    Display( MatrixOfRelations( o ) );
    
end );
