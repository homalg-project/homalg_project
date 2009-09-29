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
              "ArithmeticGenus",
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

##
InstallMethod( DegreeAsSubscheme,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    
    if AffineDimension( UnderlyingModule( X ) ) <= 0 then
        return 0;
    fi;
    
    return AffineDegree( UnderlyingModule( X ) );
    
end );

##
InstallMethod( Degree,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    
    return DegreeAsSubscheme( X );
    
end );

##
InstallMethod( Dimension,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    
    return AffineDimension( UnderlyingModule( X ) ) - 1;
    
end );

##
InstallMethod( ArithmeticGenus,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local P_0;
    
    P_0 := ConstantTermOfHilbertPolynomial( UnderlyingModule( X ) );
    
    return (-1)^Dimension( X ) * ( P_0 - 1 );
    
end );

##
InstallMethod( IrreducibleComponents,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local primary_decomposition;
    
    primary_decomposition := PrimaryDecomposition( UnderlyingModule( X ) );
    
    return List( primary_decomposition, J -> Scheme( J[1] ) );
    
end );

##
InstallMethod( ReducedScheme,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local primary_decomposition;
    
    primary_decomposition := PrimaryDecomposition( UnderlyingModule( X ) );
    
    return Scheme( Intersect( List( primary_decomposition, J -> J[2] ) ) );
    
end );

