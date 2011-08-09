#############################################################################
##
##  LIOBJ.gi                    LIOBJ subpackage             Mohamed Barakat
##
##         LIOBJ = Logical Implications for homalg static OBJects
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIOBJ subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIOBJ,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ 
              "IsZero",
              "IsProjective",
              "IsProjectiveOfConstantRank",
              "IsReflexive",
              "IsTorsionFree",
              "IsArtinian",
              "IsTorsion",
              "IsPure",
              "IsInjective",
              "IsInjectiveCogenerator",
              ],
            intrinsic_attributes :=
            [ 
              "RankOfObject",
              "ProjectiveDimension",
              "DegreeOfTorsionFreeness",
              "Grade",
              "PurityFiltration",
              "CodegreeOfPurity",
              ],
            )
        );

##
InstallValue( LogicalImplicationsForHomalgStaticObjects,
        [ 
          ## IsInjective(Cogenerator):
          
          [ IsInjectiveCogenerator,
            "implies", IsInjective ],
          
          [ IsZero,
            "implies", IsInjective ],
          
	  ## IsTorsionFree:
          
          [ IsZero,
            "implies", IsProjective ],
          
          [ IsProjective,
            "implies", IsReflexive ],
          
          [ IsProjective, "and", HasConstantRank,
            "imply", IsProjectiveOfConstantRank ],
          
          [ IsProjectiveOfConstantRank,
            "implies", IsProjective ],
          
          [ IsProjectiveOfConstantRank,
            "implies", HasConstantRank ],
          
          [ IsReflexive,
            "implies", IsTorsionFree ],
          
          [ IsTorsionFree,
            "implies", IsPure ],
          
          ## IsTorsion:
          
          [ IsZero,
            "implies", IsArtinian ],
          
          [ IsZero,
            "implies", IsTorsion ],
          
          ## IsCyclic:
          
          [ IsZero,
            "implies", IsCyclic ],
          
          ## IsZero:
          
          [ IsTorsion, "and", IsTorsionFree,
            "imply", IsZero ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgStaticObjects, IsHomalgStaticObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIOBJ.intrinsic_properties, ValueGlobal ),
        IsStaticFinitelyPresentedSubobjectRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIOBJ.intrinsic_attributes, ValueGlobal ),
        IsStaticFinitelyPresentedSubobjectRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( NotConstructedAsAnIdeal,
        IsStaticFinitelyPresentedSubobjectRep and HasConstructedAsAnIdeal, 0,
        
  function( N )
    
    return not ConstructedAsAnIdeal( N );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsStaticFinitelyPresentedSubobjectRep, 0,
        
  function( J )
    local M;
    
    M := SuperObject( J );
    
    if HasIsTorsion( M ) and IsTorsion( M ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

## FALSE: R := Z / 6Z, and M = 2Z / 6Z
#InstallImmediateMethod( IsTorsion,
#        IsStaticFinitelyPresentedObjectRep and HasRankOfObject, 0,
#        
#  function( M )
#    
#    return RankOfObject( M ) = 0;
#    
#end );

##
InstallImmediateMethod( IsTorsion,
        IsStaticFinitelyPresentedObjectRep and HasTorsionFreeFactorEpi and HasIsZero, 0,
        
  function( M )
    local F;
    
    F := Range( TorsionFreeFactorEpi( M ) );
    
    if not IsZero( M ) and HasIsZero( F ) then
        return IsZero( F );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsStaticFinitelyPresentedObjectRep and HasGrade, 0,
        
  function( M )
    
    if Grade( M ) > 0 then
        return true;
    elif HasIsZero( M ) and not IsZero( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsStaticFinitelyPresentedSubobjectRep, 0,
        
  function( J )
    local M;
    
    M := SuperObject( J );
    
    if HasIsTorsionFree( M ) and IsTorsionFree( M ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsStaticFinitelyPresentedObjectRep and HasTorsionObjectEmb and HasIsZero, 0,
        
  function( M )
    local T;
    
    T := Source( TorsionObjectEmb( M ) );
    
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
InstallImmediateMethod( IsTorsionFree,
        IsStaticFinitelyPresentedObjectRep and HasGrade, 0,
        
  function( M )
    
    if IsPosInt( Grade( M ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsStaticFinitelyPresentedObjectRep and HasGrade and IsPure, 0,
        
  function( M )
    
    return Grade( M ) in [ 0, infinity ];
    
end );

##
InstallImmediateMethod( IsReflexive,
        IsStaticFinitelyPresentedObjectRep and IsTorsionFree and HasCodegreeOfPurity, 0,
        
  function( M )
    
    return CodegreeOfPurity( M ) = [ 0 ];
    
end );

##
InstallImmediateMethod( IsProjective,
        IsStaticFinitelyPresentedObjectRep and HasProjectiveDimension, 0,
        
  function( M )
    
    return ProjectiveDimension( M ) = 0;
    
end );

##
InstallImmediateMethod( IsPure,
        IsStaticFinitelyPresentedObjectRep and HasIsTorsion and HasIsTorsionFree, 0,
        
  function( M )
    
    if not IsTorsion( M ) and not IsTorsionFree( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( RankOfObject,
        IsStaticFinitelyPresentedObjectRep and HasPurityFiltration, 0,
        
  function( M )
    local M0;
    
    M0 := CertainObject( PurityFiltration( M ), 0 );
    
    if HasRankOfObject( M0 ) then
        return RankOfObject( M0 );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RankOfObject,
        IsStaticFinitelyPresentedObjectRep and IsTorsion, 0,
        
  function( M )
    
    return 0;
    
end );

##
InstallImmediateMethod( DegreeOfTorsionFreeness,
        IsStaticFinitelyPresentedObjectRep and HasIsTorsionFree, 0,
        
  function( M )
    local R;
    
    if not IsTorsionFree( M ) then
        return 0;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( DegreeOfTorsionFreeness,
        IsStaticFinitelyPresentedObjectRep and IsProjective, 0,
        
  function( M )
    
    return infinity;
    
end );

##
InstallImmediateMethod( Grade,
        IsStaticFinitelyPresentedObjectRep and IsTorsionFree and HasIsZero, 0,
        
  function( M )
    
    if not IsZero( M ) then
        return 0;
    else
        return infinity;
    fi;
    
end );

##
InstallImmediateMethod( Grade,
        IsStaticFinitelyPresentedObjectRep and IsZero, 10001,
        
  function( M )
    
    return infinity;
    
end );

##
InstallImmediateMethod( CodegreeOfPurity,
        IsStaticFinitelyPresentedObjectRep and IsZero, 0,
        
  function( M )
    
    return [ 0 ];
    
end );

##
InstallImmediateMethod( CodegreeOfPurity,
        IsStaticFinitelyPresentedObjectRep and HasIsPure, 0,
        
  function( M )
    
    if not IsPure( M ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( CodegreeOfPurity,
        IsStaticFinitelyPresentedObjectRep and HasIsReflexive, 0,
        
  function( M )
    
    if IsReflexive( M ) then
        return [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsTorsion,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return IsZero( TorsionFreeFactor( M ) );
    
end );

##
InstallMethod( IsTorsionFree,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return IsZero( TorsionObject( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return IsTorsionFree( M ) and IsZero( Ext( 2, AuslanderDual( M ) ) );
    
end );

##
InstallMethod( IsReflexive,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep and HasCodegreeOfPurity ],
        
  function( M )
    
    return IsTorsionFree( M ) and CodegreeOfPurity( M ) = [ 0 ];
    
end );

##
InstallMethod( IsProjective,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ], 1001,
        
  function( M )
    
    if not IsReflexive( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallGlobalFunction( IsProjectiveByCheckingForASplit,
  function( M )
    local b;
    
    b := IsSplitEpimorphism( CoveringEpi( M ) );
    
    if IsBool( b ) and not b = fail then
        SetIsProjective( M, b );
    fi;
    
    return b;
    
end );

##
InstallMethod( IsPure,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    PurityFiltration( M );
    
    if HasIsPure( M ) then
        return IsPure( M );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( RankOfObject,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    Resolution( M );
    
    if HasRankOfObject( M ) then
        return RankOfObject( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RankOfObject,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ], 1001,	## 10001 is above the getter method value and would lead to infinite loops
        
  function( M )
    
    if IsTorsion( M ) then
        return 0;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Rank,
        "LIOBJ: for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    
    return Rank( UnderlyingObject( M ) );
    
end );

##
InstallMethod( Rank,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    return RankOfObject( M );
    
end );

##
InstallMethod( Depth,
        "LIOBJ: for homalg static objects",
        [ IsHomalgStaticObject ],
        
  Grade );

##
InstallMethod( Grade,
        "LIOBJ: for a homalg ideal and a homalg static object",
        [ IsStaticFinitelyPresentedSubobjectRep and ConstructedAsAnIdeal, IsStaticFinitelyPresentedObjectRep ],
        
  function( J, N )
    
    return Grade( FactorObject( J ), N );
    
end );

##
InstallMethod( Grade,
        "LIOBJ: for a homalg ideal and a homalg static object",
        [ IsHomalgStaticObject, IsStructureObject ],
        
  function( M, R )
    local F;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        F := 1 * R;
    else
        F := R * 1;
    fi;
    
    return Grade( M, F );
    
end );

##
InstallMethod( Depth,
        "LIOBJ: for a homalg ideal and a homalg static object",
        [ IsStaticFinitelyPresentedSubobjectRep and ConstructedAsAnIdeal, IsStructureObjectOrObjectOrMorphism ],
        
  Grade );

##
InstallMethod( CodegreeOfPurity,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( M )
    
    PurityFiltration( M );
    
    if HasCodegreeOfPurity( M ) then
        return CodegreeOfPurity( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ], 1001,
        
  function( M )
    
    if IsReflexive( M ) then
        return [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "LIOBJ: for homalg static objects",
        [ IsStaticFinitelyPresentedObjectRep ], 1001,
        
  function( M )
    
    if not IsTorsionFree( M ) and not IsTorsion( M ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( EmbeddingInSuperObject,
        "for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    local emb;
    
    emb := ImageObjectEmb( M!.map_having_subobject_as_its_image );
    
    MatchPropertiesAndAttributesOfSubobjectAndUnderlyingObject( M, Source( emb ) );
    
    return emb;
    
end );

##
InstallMethod( FactorObject,
        "for homalg subobjects of static objects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( N )
    local F;
    
    F := FullSubobject( SuperObject( N ) ) / N;
    
    if HasConstructedAsAnIdeal( N ) and ConstructedAsAnIdeal( N ) then
        SetAnnihilator( F, N );
    fi;
    
    return F;
    
end );

##
InstallMethod( EndomorphismRing,
        "for homalg subobjects of static objects",
        [ IsHomalgStaticObject ],
        
  function( M )
    
    return End( M );
    
end );
