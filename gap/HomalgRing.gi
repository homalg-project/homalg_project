#############################################################################
##
##  HomalgRing.gi               homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the category IsHomalgRing:
DeclareRepresentation( "IsHomalgInternalRingRep",
        IsHomalgRing,
        [ "ring", "HomalgTable" ] );

DeclareRepresentation( "IsHomalgExternalRingRep",
        IsHomalgRing,
        [ "ring", "HomalgTable" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgRingsFamily",
        NewFamily( "HomalgRingsFamily" ) );

# two new types:
BindGlobal( "HomalgInternalRingType",
        NewType( HomalgRingsFamily ,
                IsHomalgInternalRingRep ) );

BindGlobal( "HomalgExternalRingType",
        NewType( HomalgRingsFamily ,
                IsHomalgExternalRingRep ) );

####################################
#
# global variables:
#
####################################

InstallValue( SimpleLogicalImplicationsForHomalgRings,
        [ ## listed alphabetically (ignoring left/right):
          
          [ IsEuclideanRing,
            "implies", IsLeftPrincipalIdealRing ],
          
          ## Serre's theorem: IsRegular <=> IsGlobalDimensionFinite:
          
          [ IsRegular,
            "implies", IsGlobalDimensionFinite ],
          
          [ IsGlobalDimensionFinite,
            "implies", IsRegular ],
          
          ##
          
          [ IsIntegralDomain, "and", IsLeftPrincipalIdealRing,
            "imply", IsGlobalDimensionFinite ],
          
          [ IsIntegralDomain, "and", IsRightPrincipalIdealRing,
            "imply", IsGlobalDimensionFinite ],
          
          ##
          
          [ IsCommutative, "and", IsRightNoetherian,
            "imply", IsLeftNoetherian ],
          
          [ IsCommutative, "and", IsLeftNoetherian,
            "imply", IsRightNoetherian ],
          
          ##
          
          [ IsLeftPrincipalIdealRing,
            "implies", IsLeftNoetherian ],
          
          [ IsRightPrincipalIdealRing,
            "implies", IsRightNoetherian ],
          
          ##
          
          [ IsCommutative, "and", IsRightOreDomain,
            "implies", IsLeftOreDomain ],
          
          [ IsCommutative, "and", IsLeftOreDomain,
            "implies", IsRightOreDomain ],
          
          ##
          
          [ IsIntegralDomain, "and", IsLeftNoetherian,
            "implies", IsLeftOreDomain ],
          
          [ IsIntegralDomain, "and", IsRightNoetherian,
            "implies", IsRightOreDomain ],
          
          ##
          
          [ IsCommutative, "and", IsRightPrincipalIdealRing,
            "implies", IsLeftPrincipalIdealRing ],
          
          [ IsCommutative, "and", IsLeftPrincipalIdealRing,
            "implies", IsRightPrincipalIdealRing ] ] );

####################################
#
# logical implications methods:
#
####################################

#LogicalImplicationsForHomalg( SimpleLogicalImplicationsForHomalgRings );

## FIXME: find a way to activate the above line and to delete the following
for property in SimpleLogicalImplicationsForHomalgRings do;
    
    if Length( property ) = 3 then
        
        InstallTrueMethod( property[3],
                property[1] );
        
        InstallImmediateMethod( property[1],
                IsHomalgModule and Tester( property[3] ), 0, ## NOTE: don't drop the Tester here!
                
          function( M )
            if Tester( property[3] )( M ) and not property[3]( M ) then  ## FIXME: find a way to get rid of Tester here
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    elif Length( property ) = 5 then
        
        InstallTrueMethod( property[5],
                property[1] and property[3] );
        
        InstallImmediateMethod( property[1],
                IsHomalgModule and Tester( property[3] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[3] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
               and property[3]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( property[3],
                IsHomalgModule and Tester( property[1] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[1] )( M ) and Tester( property[5] )( M ) ## FIXME: find a way to get rid of the Testers here
               and property[1]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    fi;
    
od;

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( Zero,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( R )
    
    return Zero( R!.ring );
    
end );

##
InstallMethod( Zero,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    local RP;
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.Zero) then
        if IsFunction( RP!.Zero ) then
            return RP!.Zero( R );
        else
            return RP!.Zero;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( One,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( R )
    
    return One( R!.ring );
    
end );

##
InstallMethod( One,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    local RP;
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.One) then
        if IsFunction( RP!.One ) then
            return RP!.One( R );
        else
            return RP!.One;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( MinusOne,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( R )
    
    return -One( R!.ring );
    
end );

##
InstallMethod( MinusOne,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    local RP;
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.MinusOne) then
        if IsFunction( RP!.MinusOne ) then
            return RP!.MinusOne( R );
        else
            return RP!.MinusOne;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgPointer,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return HomalgPointer( R!.ring );
    
end );

##
InstallMethod( HomalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return HomalgExternalCASystem( R!.ring );
    
end );

##
InstallMethod( HomalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return HomalgExternalCASystemVersion( R!.ring );
    
end );

##
InstallMethod( HomalgStream,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return HomalgStream( R!.ring );
    
end );

##
InstallMethod( HomalgExternalCASystemPID,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return HomalgExternalCASystemPID( R!.ring );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( RingForHomalg,
  function( arg )
    local nargs, homalg_ring, table;
    
    nargs := Length( arg );
    
    homalg_ring := rec( ring := arg[1] );
    
    if nargs = 1 then
        table := CreateHomalgTable( arg[1] );
    else
        table := arg[nargs];
    fi;
    
    if IsSemiringWithOneAndZero( arg[1] ) then
        
        ## Objectify:
        ObjectifyWithAttributes(
                homalg_ring, HomalgInternalRingType,
                HomalgTable, table );
    
    elif IsHomalgExternalObjectRep( arg[1] ) then
        
        ## Objectify:
        ObjectifyWithAttributes(
                homalg_ring, HomalgExternalRingType,
                HomalgTable, table );
    
    fi;
    
    return homalg_ring;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( o )
    
    Print( "<A homalg internal ring>" );
    
end );

InstallMethod( ViewObj,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( o )
    
    Print( "<A homalg external ring>" );
    
end );

InstallMethod( Display,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( o )
    local RP;
    
    RP := HomalgTable( o );
    
    if IsBound(RP!.RingName) then
        if IsFunction( RP!.RingName ) then
            Print( RP!.RingName( o ) );
        else
            Print( RP!.RingName, "\n" );
        fi;
    else
        TryNextMethod( );
    fi;
	
end );

