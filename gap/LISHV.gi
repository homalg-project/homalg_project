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
              "CodimOfSheaf",
              "PurityFiltration",
              "CodegreeOfPurity" ]
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

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgSheaves, IsHomalgSheaf );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgSheaf and HasCodimOfSheaf, 0,
        
  function( E )
    
    return CodimOfSheaf( E ) = infinity;
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsHomalgSheaf, 0,
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    if HasIsTorsion( M ) then
        return IsTorsion( M );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsArtinian( M );
    
end );

##
InstallMethod( IsTorsion,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsTorsion( M );
    
end );

##
InstallMethod( IsTorsionFree,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsArtinian( TorsionSubmodule( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return IsTorsionFree( E ) and IsArtinian( Ext( 2, AuslanderDual( M ) ) );
    
end );

## FIXME: why can't HasCodegreeOfPurity be put in the header?
InstallMethod( IsReflexive,
        "for sheaves",
        [ IsHomalgSheaf ],
        
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
InstallMethod( RankOfSheaf,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    local M;
    
    M := UnderlyingModule( E );
    
    return RankOfModule( M );
    
end );

##
InstallMethod( Rank,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    
    return RankOfSheaf( E );
    
end );

##
InstallMethod( CodimOfSheaf,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    local M, codim;
    
    M := UnderlyingModule( E );
    
    codim := CodimOfModule( M );
    
    if codim > DimensionOfAmbientSpace( E ) then
       return infinity;
    fi;
    
    return codim;
    
end );

##
InstallMethod( CodegreeOfPurity,
        "for sheaves",
        [ IsHomalgSheaf ], 1001,
        
  function( E )
    
    if IsReflexive( E ) then
        return [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "for sheaves",
        [ IsHomalgSheaf ], 1001,
        
  function( E )
    
    if not IsTorsionFree( E ) and not IsTorsion( E ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

