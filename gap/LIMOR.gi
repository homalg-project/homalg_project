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
InstallImmediateMethod( IsZero,
        IsHomalgMap, 0,
        
  function( phi )
    
    if ( HasIsZero( Source( phi ) ) and IsZero( Source( phi ) ) ) or
       ( HasIsZero( Range( phi ) ) and IsZero( Range( phi ) ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    
    if HasIsZero( MatrixOfMap( phi ) ) and IsZero( MatrixOfMap( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    local index_pair, matrix;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        
        matrix := phi!.reduced_matrices.( String( index_pair ) );
        
        if HasIsZero( matrix ) then
            return IsZero( matrix );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSplitEpimorphism,
        IsMapOfFinitelyGeneratedModulesRep and IsEpimorphism, 0,
        
  function( phi )
    local T;
    
    T := Range( phi );
    
    if HasIsProjective( T ) and IsProjective( T ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

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
InstallMethod( IsMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( Source( phi ) ) * MatrixOfMap( phi );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMap( phi ) * MatrixOfRelations( Source( phi ) );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsZero,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( DecideZero( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Cokernel( phi ) );
    
end );

##
InstallMethod( IsMonomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

##
InstallMethod( IsIsomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsHomalgSelfMap( phi ) and IsIsomorphism( phi );
    
end );

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

