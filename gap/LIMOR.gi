#############################################################################
##
##  LIMOR.gi                    LIMOR subpackage             Mohamed Barakat
##
##         LIMOR = Logical Implications for homalg MORphisms
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
          
          [ IsMorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsMonomorphism,
            "implies", IsMorphism ],
          
          [ IsMonomorphism,
            "implies", IsGeneralizedMonomorphism ],
          
          [ IsGeneralizedMonomorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsEpimorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsGeneralizedEpimorphism ],
          
          [ IsGeneralizedEpimorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsAutomorphism,
            "implies", IsIsomorphism ],
          
          [ IsIsomorphism,
            "implies", IsGeneralizedIsomorphism ],
          
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
          
          [ IsGeneralizedIsomorphism,
            "implies", IsGeneralizedMonomorphism ],
          
          [ IsGeneralizedIsomorphism,
            "implies", IsGeneralizedEpimorphism ],
          
          [ IsGeneralizedEpimorphism, "and", IsGeneralizedMonomorphism,
            "imply", IsGeneralizedIsomorphism ],
          
          [ IsGeneralizedEpimorphism, "and", IsMorphism,
            "imply", IsEpimorphism ],
          
          [ IsGeneralizedMonomorphism, "and", IsMorphism,
            "imply", IsMonomorphism ],
          
          [ IsIdentityMorphism,
            "implies", IsAutomorphism ],
          
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
        IsHomalgMorphism, 0,
        
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
InstallMethod( IsZero,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( DecideZero( phi ) );
    
end );

##
InstallMethod( IsZero,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local morphisms;
    
    morphisms := MorphismsOfChainMap( cm );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( Source( phi ) ) * MatrixOfMap( phi );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMap( phi ) * MatrixOfRelations( Source( phi ) );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local degrees, l, S, T;
    
    if not IsComplex( Source( cm ) ) then
        return false;
    elif not IsComplex( Range( cm ) ) then
        return false;
    fi;
    
    degrees := DegreesOfChainMap( cm );
    
    l := Length( degrees );
    
    degrees := degrees{[ 1 .. l - 1 ]};
    
    S := Source( cm );
    T := Range( cm );
    
    if l = 1 then
        if Length( ObjectDegreesOfComplex( S ) ) = 1 then
            return true;
        else
            Error( "not implemented for chain maps containing as single morphism\n" );
        fi;
    elif IsChainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( cm, i + 1 ) * CertainMorphism( T, i + 1 ) = CertainMorphism( S, i + 1 ) * CertainMorphism( cm, i ) );
    elif IsCochainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgRightObjectOrMorphismOfRightObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( T, i ) * CertainMorphism( cm, i ) = CertainMorphism( cm, i + 1 ) * CertainMorphism( S, i ) );
    elif IsChainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgRightObjectOrMorphismOfRightObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( T, i + 1 ) * CertainMorphism( cm, i + 1 ) = CertainMorphism( cm, i ) * CertainMorphism( S, i + 1 ) );
    else
        return ForAll( degrees, i -> CertainMorphism( cm, i ) * CertainMorphism( T, i ) = CertainMorphism( S, i ) * CertainMorphism( cm, i + 1 ) );
    fi;
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi );		## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    
    return IsMorphism( AssociatedMap( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Cokernel( phi ) );
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMap( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsEpimorphism( mu );
    
end );

##
InstallMethod( IsEpimorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return IsMorphism( cm ) and ForAll( MorphismsOfChainMap( cm ), IsEpimorphism );	## not true for split epimorphisms
    
end );

##
InstallMethod( IsMonomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMonomorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMap( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsMonomorphism( mu );
    
end );

##
InstallMethod( IsMonomorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return IsMorphism( cm ) and ForAll( MorphismsOfChainMap( cm ), IsMonomorphism );	## not true for split monomorphisms
    
end );

##
InstallMethod( IsIsomorphism,
        "LIMOR: for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsIsomorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAidMap ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMap( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    SetIsGeneralizedMonomorphism( phi, IsMonomorphism( mu ) );
    
    return IsIsomorphism( mu );
    
end );

##
InstallMethod( IsAutomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsHomalgSelfMap( phi ) and IsIsomorphism( phi );
    
end );

##
InstallMethod( IsGradedMorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsGradedObject( Source( phi ) ) and IsGradedObject( Range( phi ) );
    
end );

##
InstallMethod( IsQuasiIsomorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsIsomorphism( DefectOfExactness( phi ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( ImageSubmodule,
        "LIMOR: submodule constructor",
        [ IsHomalgMap ],
        
  function( phi )
    local R, T, ideal, N;
    
    R := HomalgRing( phi );
    
    T := Range( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( T ) then
        ideal := IsIdenticalObj( T, 1 * R ) or IsIdenticalObj( T, ( 1 * R )^0 );
    else
        ideal := IsIdenticalObj( T, R * 1 ) or IsIdenticalObj( T, ( R * 1 )^0 );
    fi;
    
    N := rec( map_having_subobject_as_its_image := phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgLeftFinitelyGeneratedSubmodule,
                ConstructedAsAnIdeal, ideal,
                LeftActingDomain, R );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgRightFinitelyGeneratedSubmodule,
                ConstructedAsAnIdeal, ideal,
                RightActingDomain, R );
    fi;
    
    return N;
    
end );

##
InstallMethod( KernelSubmodule,
        "LIMOR: for homalg maps",
        [ IsHomalgMap ],
        
  function( psi )
    
    return Subobject( ReducedSyzygiesGenerators( psi ), Source( psi ) );
    
end );

