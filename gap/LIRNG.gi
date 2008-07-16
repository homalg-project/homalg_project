#############################################################################
##
##  LIRNG.gi                    LIRNG subpackage             Mohamed Barakat
##
##         LIRNG = Logical Implications for homalg RiNGs
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIRNG subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIRNG,
        rec(
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgRings,
        [ ## listed alphabetically (ignoring left/right):
          
          ##
          
          [ IsIntegersForHomalg,
            "implies", IsPrincipalIdealRing ],
          
          [ IsFieldForHomalg,
            "implies", IsPrincipalIdealRing ],
          
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

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRings, IsHomalgRing );

##
InstallTrueMethod( IsLeftPrincipalIdealRing, IsHomalgRing and IsEuclideanRing );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsLeftGlobalDimensionFinite,
        IsHomalgRing and HasLeftGlobalDimension, 0,
        
  function( R )
    
    return LeftGlobalDimension( R ) < infinity;
    
end );

##
InstallImmediateMethod( IsRightGlobalDimensionFinite,
        IsHomalgRing and HasRightGlobalDimension, 0,
        
  function( R )
    
    return RightGlobalDimension( R ) < infinity;
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( LeftGlobalDimension,
        IsHomalgRing and HasGlobalDimension, 0,
        
  function( R )
    
    return GlobalDimension( R );
    
end );

##
InstallImmediateMethod( RightGlobalDimension,
        IsHomalgRing and HasGlobalDimension, 0,
        
  function( R )
    
    return GlobalDimension( R );
    
end );

