#############################################################################
##
##  RingForHomalg.gi            homalg package               Mohamed Barakat
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

# two new representations for the category IsRingForHomalg:
DeclareRepresentation( "IsInternalRingRep",
        IsRingForHomalg,
        [ "ring", "HomalgTable" ] );

DeclareRepresentation( "IsExternalRingRep",
        IsRingForHomalg,
        [ "ring", "HomalgTable" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgRingsFamily",
        NewFamily( "HomalgRingsFamily" ));

# two new types:
BindGlobal( "HomalgInternalRingType",
        NewType( HomalgRingsFamily ,
                IsInternalRingRep ));

BindGlobal( "HomalgExternalRingType",
        NewType( HomalgRingsFamily ,
                IsExternalRingRep ));

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
                IsModuleForHomalg and Tester( property[3] ), 0, ## NOTE: don't drop the Tester here!
                
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
                IsModuleForHomalg and Tester( property[3] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[3] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
               and property[3]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( property[3],
                IsModuleForHomalg and Tester( property[1] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
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
        [ IsInternalRingRep ],
        
  function( R )
    
    return Zero( R!.ring );
    
end );

##
InstallMethod( One,
        "for homalg rings",
        [ IsInternalRingRep ],
        
  function( R )
    
    return One( R!.ring );
    
end );

##
InstallMethod( MinusOne,
        "for homalg rings",
        [ IsInternalRingRep ],
        
  function( R )
    
    return -One( R!.ring );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( RingForHomalg,
  function( arg )
    local nar, homalg_ring, type;
    
    nar := Length( arg );
    
    homalg_ring := rec( ring := arg[1] );
    
    if IsSemiringWithOneAndZero( arg[1] ) then
        
        type := HomalgInternalRingType;
        
    else
        
        type := HomalgExternalRingType;
        
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            homalg_ring, type,
            HomalgTable, arg[nar] );
    
    return homalg_ring;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg rings",
        [ IsInternalRingRep ],
        
  function( o )
    
    Print( "<A homalg internal ring>" );
    
end );

InstallMethod( ViewObj,
        "for homalg rings",
        [ IsExternalRingRep ],
        
  function( o )
    
    Print( "<A homalg external ring>" );
    
end );

