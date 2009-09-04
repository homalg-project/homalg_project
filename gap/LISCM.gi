#############################################################################
##
##  LISCM.gi                    LISCM subpackage             Mohamed Barakat
##
##         LISCM = Logical Implications for SCheMes
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for the LISCM subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LISCM,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ "IsProjective",
	      "IsReduced",
              "IsSmooth" ],
            intrinsic_attributes :=
            [ "Genus",
              "Dimension" ]
            )
        );

##
InstallValue( LogicalImplicationsForSchemes,
        [ 
          
          
          ] );

####################################
#
# logical implications methods:
#
####################################

#InstallLogicalImplicationsForHomalg( LogicalImplicationsForSchemes, IsScheme );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsEmpty,
        IsScheme and HasSingularLocus, 0,
        
  function( X )
    local sing;
    
    sing := SingularLocus( X );
    
    if HasIsEmpty( sing ) and not IsEmpty( sing ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSmooth,
        IsScheme and HasSingularLocus, 0,
        
  function( X )
    local sing;
    
    sing := SingularLocus( X );
    
    if HasIsEmpty( sing ) then
        return IsEmpty( sing );
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
InstallMethod( IsEmpty,
        "LISCM: for schemes",
        [ IsScheme ],
        
  function( X )
    local J;
    
    J := UnderlyingModule( X );
    
    return J = HomalgRing( J );
    
end );

####################################
#
# methods for attributes:
#
####################################

