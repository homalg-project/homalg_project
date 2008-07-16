#############################################################################
##
##  LIMOD.gi                    LIMOD subpackage             Mohamed Barakat
##
##         LIMOD = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIMOD subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMOD,
        rec(
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgModules,
        [ ## IsTorsionFreeModule:
          
          [ IsZero,
            "implies", IsFree ],
          
          [ IsFree,
            "implies", IsStablyFree ],
          
          [ IsStablyFree,
            "implies", IsProjective ],
          
          [ IsProjective,
            "implies", IsReflexive ],
          
          [ IsReflexive,
            "implies", IsTorsionFree ],
          
          ## IsTorsionModule:
          
          [ IsZero,
            "implies", IsHolonomic ],
          
          [ IsHolonomic,
            "implies", IsTorsion ],
          
          [ IsHolonomic,
            "implies", IsArtinian ],
          
          ## IsCyclicModule:
          
          [ IsZero,
            "implies", IsCyclic ],
          
          ## IsZero:
          
          [ IsTorsion, "and", IsTorsionFree,
            "imply", IsZero ]
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgModules, IsHomalgModule );

####################################
#
# immediate methods for properties:
#
####################################

## strictly less relations than generators => not IsTorsion
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, b, i, rel;
    
    l := SetsOfRelations( M )!.ListOfPositionsOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [ 1.. Length( l ) ] do;
        
        rel := SetsOfRelations( M )!.(i);
        
        if not IsString( rel ) then
            if HasNrGenerators( rel ) and HasNrRelations( rel ) and
               NrGenerators( rel ) > NrRelations( rel ) then
                b := true;
                break;
            fi;
        fi;
        
    od;
    
    if b then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

## a presentation must be on a single generator
InstallImmediateMethod( IsCyclic,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, b, i, rel;
    
    l := SetsOfRelations( M )!.ListOfPositionsOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [ 1.. Length( l ) ] do;
        
        rel := SetsOfRelations( M )!.(i);
        
        if not IsString( rel ) then
            if HasNrGenerators( rel ) and NrGenerators( rel ) = 1 then
                return true;
            fi;
        fi;
        
    od;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    
    if HasNrRelations( M ) = true and NrRelations( M ) = 0 then	## NrRelations is not an attribute and HasNrRelations might return fail!
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RankOfModule,
        IsFinitelyPresentedModuleRep and IsFree, 0,
        
  function( M )
    
    if HasNrRelations( M ) = true and NrRelations( M ) = 0 then	## NrRelations is not an attribute and HasNrRelations might return fail!
        return NrGenerators( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep and HasRankOfModule, 0,
        
  function( M )
    
    return RankOfModule( M ) = 0;
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsTorsionFree,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsZero( TorsionSubmodule( M ) );
    
end );

##
InstallMethod( IsTorsion,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsZero( TorsionFreeFactor( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsTorsionFree( M ) and IsZero( Ext( 2, AuslanderDual( M ) ) );
    
end );

##
InstallMethod( IsProjective,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, K;
    
    R := HomalgRing( M );
    
    if HasIsCommutative( R ) and IsCommutative( R ) then
        K := SyzygiesModule( M );
        return IsZero( Ext( 1, M, K ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    
    if not IsReflexive( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( DegreeOfTorsionFreeness,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local DM, R, gdim, k;
    
    DM := AuslanderDual( M );
    
    if IsTorsionFree( M ) then
        k := 2;
    else
        return 0;
    fi;
    
    if IsReflexive( M ) then
        k := 3;
    fi;	## do not return 1 in case the ring has global dimension 0
    
    R := HomalgRing( M );
    
    if not HasGlobalDimension( R ) then
        return fail;
    fi;
    
    gdim := GlobalDimension( R );
    
    while k <= gdim do
        if not IsZero( Ext( k, DM ) ) then
            return k - 1;
        fi;
        k := k + 1;
    od;
    
    return gdim;
    
end );

##
InstallMethod( CodimOfModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, gdim, k;
    
    if IsTorsion( M ) then
        k := 1;
    else
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    if not HasGlobalDimension( R ) then
        return fail;
    fi;
    
    gdim := GlobalDimension( R );
    
    while k <= gdim do
        if not IsZero( Ext( k, M ) ) then
            return k;
        fi;
        k := k + 1;
    od;
    
    return gdim;
    
end );

