#############################################################################
##
##  LISHV.gi                    LISHV subpackage             Mohamed Barakat
##
##         LISHV = Logical Implications for homalg SHeaVes
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for the LISHV subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LISHV,
        rec(
            color := "\033[4;30;46m",
            intrinsic_attributes :=
            [ "RankOfSheaf",
              "Codim",
              "DegreeOfTorsionFreeness",
              "PurityFiltration",
              "CodegreeOfPurity",
              "CastelnuovoMumfordRegularity" ]
            )
        );

##
InstallValue( LogicalImplicationsForHomalgSheaves,
        [ ## IsTorsionFree:
          
          [ IsZero,
            "implies", IsFree ],
          
          [ IsFree,
            "implies", IsStablyFree ],
          
          [ IsFree,
            "implies", IsDirectSumOfLineBundles ],
          
          [ IsDirectSumOfLineBundles,
            "implies", IsLocallyFree ],
          
          [ IsLocallyFree,
            "implies", IsReflexive ],
          
          [ IsReflexive,
            "implies", IsTorsionFree ],
          
          [ IsTorsionFree,
            "implies", IsPure ],
          
          ## IsTorsion:
          
          [ IsZero,
            "implies", IsTorsion ],
          
          ## IsZero:
          
          [ IsTorsion, "and", IsTorsionFree,
            "imply", IsZero ]
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgSheaves, IsSheafOfModules );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsSheafOfModules and HasCodim, 0,
        
  function( E )
    
    return Codim( E ) = infinity;
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules, 0,
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    if HasIsTorsion( M ) then
        return IsTorsion( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules and HasRankOfSheaf, 0,
        
  function( M )
    
    return RankOfSheaf( M ) = 0;
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules and HasTorsionFreeFactorEpi and HasIsZero, 0,
        
  function( M )
    local F;
    
    F := Range( TorsionFreeFactorEpi( M ) );
    
    if not IsZero( M ) and HasIsZero( F ) then
        if IsZero( F ) then
            return true;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules and HasCodim, 0,
        
  function( M )
    
    if Codim( M ) > 0 then
        return true;
    elif HasIsZero( M ) and not IsZero( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsSheafOfModules and HasTorsionSubmoduleEmb and HasIsZero, 0,
        
  function( M )
    local T;
    
    T := Source( TorsionSubmoduleEmb( M ) );
    
    if not IsZero( M ) and HasIsZero( T ) then
        if IsZero( T ) then
            return true;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsReflexive,
        IsSheafOfModules and IsTorsionFree and HasCodegreeOfPurity, 0,
        
  function( M )
    
    return CodegreeOfPurity( M ) = [ 0 ];
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( RankOfSheaf,
        IsSheafOfModules, 0,
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    if HasRankOfModule( M ) then
        return RankOfModule( M );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsArtinian( M );
    
end );

##
InstallMethod( IsTorsion,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsTorsion( M );
    
end );

##
InstallMethod( IsTorsionFree,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsArtinian( TorsionSubmodule( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsTorsionFree( E ) and IsArtinian( Ext( 2, AuslanderDual( M ) ) );
    
end );

## FIXME: why can't HasCodegreeOfPurity be put in the header?
InstallMethod( IsReflexive,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    
    if HasCodegreeOfPurity( E ) then
        return IsTorsionFree( E ) and CodegreeOfPurity( E ) = [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( Support,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return Scheme( Annihilator( M ) );
    
end );

##
InstallMethod( RankOfSheaf,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return RankOfModule( M );
    
end );

##
InstallMethod( Rank,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    
    return RankOfSheaf( E );
    
end );

##
InstallMethod( Codim,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M, codim;
    
    M := UnderlyingModule( E );
    
    codim := Codim( M );
    
    if codim > DimensionOfAmbientSpace( E ) then
       return infinity;
    fi;
    
    return codim;
    
end );

##
InstallMethod( CodegreeOfPurity,
        "for sheaves",
        [ IsSheafOfModules ], 1001,
        
  function( E )
    
    if IsReflexive( E ) then
        return [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "for sheaves",
        [ IsSheafOfModules ], 1001,
        
  function( E )
    
    if not IsTorsionFree( E ) and not IsTorsion( E ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

