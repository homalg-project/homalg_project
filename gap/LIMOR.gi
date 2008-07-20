#############################################################################
##
##  LIMOR.gi                    LIMOR subpackage             Mohamed Barakat
##
##         LIMOR = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIMOR subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMOR,
        rec(
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgMorphisms,
        [ 
          
          [ IsMonomorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsMorphism ],
          
          [ IsAutomorphism,
            "implies", IsIsomorphism ],
          
          [ IsIsomorphism,
            "implies", IsSplitMonomorphism ],
          
          [ IsIsomorphism,
            "implies", IsSplitEpimorphism ],
          
          [ IsSplitEpimorphism,
            "implies", IsEpimorphism ],
          
          [ IsSplitMonomorphism,
            "implies", IsMonomorphism ],
          
          [ IsEpimorphism, "and", IsMonomorphism,
            "imply", IsIsomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgEndomorphisms,
        [ 
          
          [ IsIsomorphism,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgChainMaps,
        [ 
          
          [ IsGradedMorphism,
            "implies", IsMorphism ],
          
          [ IsIsomorphism,
            "implies", IsQuasiIsomorphism ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgMorphisms, IsHomalgMorphism );

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgEndomorphisms, IsHomalgEndomorphism );

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgChainMaps, IsHomalgChainMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsAutomorphism,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if not IsIdenticalObj( Source( phi ), Range( phi ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsGradedMorphism,
        IsHomalgChainMap, 0,
        
  function( phi )
    local S, T;
    
    S := Source( phi );
    T := Range( phi );
    
    if HasIsGradedObject( S ) and HasIsGradedObject( T ) then
        return IsGradedObject( S ) and IsGradedObject( T );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsIsomorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return IsMonomorphism( phi ) and IsEpimorphism( phi );
    
end );

##
InstallMethod( IsGradedMorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsGradedObject( Source( phi ) ) and IsGradedObject( Range( phi ) );
    
end );

##
InstallMethod( IsQuasiIsomorphism,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsIsomorphism( DefectOfExactness( phi ) );
    
end );

