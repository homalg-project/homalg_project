#############################################################################
##
##  GradedSubmodule.gi      Graded Modules package
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for graded submodules.
##
#############################################################################

####################################
#
# representations:
#
####################################

DeclareRepresentation( "IsGradedSubmoduleRep",
        IsGradedModuleOrGradedSubmoduleRep and
        IsStaticFinitelyPresentedSubobjectRep,
        [ "map_having_subobject_as_its_image" ] );

####################################
#
# families and types:
#
####################################

# two new types:
BindGlobal( "TheTypeHomalgLeftGradedSubmodule",
        NewType( TheFamilyOfHomalgModules,
                IsGradedSubmoduleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightGradedSubmodule",
        NewType( TheFamilyOfHomalgModules,
                IsGradedSubmoduleRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallOtherMethod( OnBasisOfPresentation,
        "for homalg graded submodules",
        [ IsGradedSubmoduleRep ],
        
  function( J )
    
    OnBasisOfPresentation( UnderlyingModule( J ) );
    
    return J;
    
end );

##
InstallOtherMethod( OnLessGenerators,
        "for homalg graded submodules",
        [ IsGradedSubmoduleRep ],
        
  function( J )
    
    OnLessGenerators( UnderlyingModule( J ) );
    
    return J;
    
end );

##
InstallMethod( MatchPropertiesAndAttributesOfSubobjectAndUnderlyingObject,
        "for a graded submodule and its underlying graded module",
        [ IsGradedSubmoduleRep, IsGradedModuleRep ],
        
  function( I, M )
    
    ## we don't check if M is the underlying object of I
    ## to avoid infinite loops as EmbeddingInSuperObject
    ## will be invoked
    if ConstructedAsAnIdeal( I ) then
        
        MatchPropertiesAndAttributes( I, M,
                LIGrMOD.intrinsic_properties_shared_with_subobjects_and_ideals,
                LIGrMOD.intrinsic_attributes_shared_with_subobjects_and_ideals );
        
    else
        
        MatchPropertiesAndAttributes( I, M,
                LIGrMOD.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                LIGrMOD.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals );
        
    fi;
    
end );

##
InstallMethod( MorphismHavingSubobjectAsItsImage,
        "for a graded submodule",
        [ IsGradedSubmoduleRep ],
  function( M )
    local psi, uM, uphi, phi, upsi;
    
    if HasEmbeddingInSuperObject( M ) then
        return EmbeddingInSuperObject( M );
    fi;
    
    psi := M!.map_having_subobject_as_its_image;
    uM := UnderlyingModule( M );
    
    if HasEmbeddingInSuperObject( uM ) then
        uphi := EmbeddingInSuperObject( uM );
        phi := GradedMap( uphi, "create", Range( psi ) );
        SetEmbeddingInSuperObject( M, phi );
        return phi;
    fi;
    
    # this is mohamed's fault
    upsi := uM!.map_having_subobject_as_its_image;
    if not IsIdenticalObj( UnderlyingMorphism( psi ), upsi ) then
       psi := GradedMap( upsi, "create", Range( psi ) );
       M!.map_having_subobject_as_its_image := psi;
    fi;
    
    return psi;
    
end );

##
InstallMethod( Saturate,
        "for homalg submodules",
        [ IsGradedSubmoduleRep ],
        
  function( I )
    local S, max;
    
    if not ( HasConstructedAsAnIdeal( I ) and ConstructedAsAnIdeal( I ) ) then
        TryNextMethod( );
    fi;
    
    S := HomalgRing( I );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( I ) then
        max := MaximalGradedLeftIdeal( S );
    else
        max := MaximalGradedRightIdeal( S );
    fi;
    
    return Saturate( I, max );
    
end );

##
InstallMethod( RadicalIdealMembership,
        "for a homogeneous ideal and an element",
        [ IsHomalgRingElement, IsGradedSubmoduleRep ],
        
  function( M, I )
    
    return RadicalIdealMembership( UnderlyingNonGradedRingElement( M ), UnderlyingModule( I ) );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Subobject,
        "for homalg graded modules",
        [ IsHomalgMatrix, IsGradedModuleRep ],
        
  function( gen, M )
    local gen2, gen_map;
    
    if IsIdenticalObj( HomalgRing( gen ), HomalgRing( UnderlyingModule( M ) ) ) then
      gen2 := gen;
    elif IsIdenticalObj( HomalgRing( gen ), HomalgRing( M ) ) then
      gen2 := UnderlyingMatrixOverNonGradedRing( gen );
    else
      Error( "the matrix and the module are not defined over identically the same ring\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if NrColumns( gen ) <> NrGenerators( M ) then
            Error( "the first argument is matrix with ", NrColumns( gen )," columns while the second argument is a module on ", NrGenerators( M ), " generators\n" );
        fi;
    else
        if NrRows( gen ) <> NrGenerators( M ) then
            Error( "the first argument is matrix with ", NrRows( gen )," rows while the second argument is a module on ", NrGenerators( M ), " generators\n" );
        fi;
    fi;
    
    gen_map := GradedMap( gen2, "free", M  );
    
    return ImageSubobject( gen_map );
end );

##
InstallMethod( Subobject,
        "for homalg graded modules",
        [ IsHomalgRelations, IsGradedModuleRep ],
        
  function( rel, M )
    return Subobject( MatrixOfRelations( rel ), M );
end );

##
InstallMethod( ImageSubobject,
        "graded submodule constructor",
        [ IsHomalgGradedMap ],
        
  function( phi )
    local img, T, S, N, entry;
    
    img := ImageSubobject( UnderlyingMorphism( phi ) );
    
    T := Range( phi );
    
    S := HomalgRing( T );
    
    N := rec(
             ring := S,
             map_having_subobject_as_its_image := phi
             );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgLeftGradedSubmodule,
                UnderlyingModule, img,
                ConstructedAsAnIdeal, ConstructedAsAnIdeal( img ),
                LeftActingDomain, S );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgRightGradedSubmodule,
                UnderlyingModule, img,
                ConstructedAsAnIdeal, ConstructedAsAnIdeal( img ),
                RightActingDomain, S );
    fi;
    
    ## immediate methods will check if they can set
    ## SetIsTorsionFree( N, true ); and SetIsTorsion( N, true );
    ## by checking if the corresponding property for T is true
    
    if ConstructedAsAnIdeal( img ) then
        
        entry := ToDoListEntryToMaintainEqualAttributes( [ [ N, "EmbeddingInSuperObject" ] ],
                                                         [ N, [ UnderlyingObject, N ] ],
                                                         Concatenation( LIGrMOD.intrinsic_properties_shared_with_subobjects_and_ideals,
                                                                        LIGrMOD.intrinsic_attributes_shared_with_subobjects_and_ideals ) );
        
        AddToToDoList( entry );
        
        entry := ToDoListEntryToMaintainEqualAttributes( [ [ N, "FactorObject" ] ],
                                                        [ N, [ FactorObject, N ] ],
                                                        Concatenation( LIGrMOD.intrinsic_properties_shared_with_factors_modulo_ideals,
                                                                        LIGrMOD.intrinsic_attributes_shared_with_factors_modulo_ideals ) );
        
        AddToToDoList( entry );
        
    else
        
        entry := ToDoListEntryToMaintainEqualAttributes( [ [ N, "EmbeddingInSuperObject" ] ],
                                                         [ N, [ UnderlyingObject, N ] ],
                                                         Concatenation( LIGrMOD.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                                                                        LIGrMOD.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals ) );
        
        AddToToDoList( entry );
        
    fi;
    
    return N;
    
end );

InstallMethod( GradedLeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local S;
    
    S := HomalgRing( gen );
    
    return Subobject( gen, ( NrColumns( gen ) * S )^0 );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgRing ],
        
  function( S )
    
    return GradedLeftSubmodule( HomalgIdentityMatrix( 1, S ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local S;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    S := HomalgRing( gen[1] );
    
    return GradedLeftSubmodule( HomalgMatrix( gen, Length( gen ), 1, S ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsHomalgGradedRingElementRep ],
        
  function( f )
    
    ## WARNING: we do not check that f is homogeneous
    
    if not IsBound( f!.GradedLeftSubmodule ) then
        f!.GradedLeftSubmodule := GradedLeftSubmodule( [ f ] );
    fi;
    
    return f!.GradedLeftSubmodule;
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgGradedRingRep ],
        
  function( gen, S )
    local Gen;
    
    if gen = [ ] then
        return GradedLeftSubmodule( S );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, S );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return GradedLeftSubmodule( HomalgMatrix( Gen, Length( Gen ), 1, S ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgGradedRingRep ],
        
  function( gen, S )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return GradedLeftSubmodule( SplitString( Gen, "," ), S );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, ( R * NrRows( gen ) )^0 );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return GradedRightSubmodule( HomalgIdentityMatrix( 1, S ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local S;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    S := HomalgRing( gen[1] );
    
    return GradedRightSubmodule( HomalgMatrix( gen, 1, Length( gen ), S ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsHomalgGradedRingElementRep ],
        
  function( f )
    
    ## WARNING: we do not check that f is homogeneous
    
    if not IsBound( f!.GradedRightSubmodule ) then
        f!.GradedRightSubmodule := GradedRightSubmodule( [ f ] );
    fi;
    
    return f!.GradedRightSubmodule;
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgRing ],
        
  function( gen, S )
    local Gen;
    
    if gen = [ ] then
        return GradedRightSubmodule( S );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, S );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return GradedRightSubmodule( HomalgMatrix( Gen, 1, Length( Gen ), S ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgRing ],
        
  function( gen, S )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return GradedRightSubmodule( SplitString( Gen, "," ), S );
    
end );

##
InstallMethod( GradedLeftIdealOfMinors,
        "constructor for homalg ideals",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    
    return GradedLeftSubmodule( Minors( d, M ) );
    
end );

##
InstallMethod( GradedLeftIdealOfMaximalMinors,
        "constructor for homalg ideals",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GradedLeftSubmodule( MaximalMinors( M ) );
    
end );

##
InstallMethod( GradedRightIdealOfMinors,
        "constructor for homalg ideals",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    
    return GradedRightSubmodule( Minors( d, M ) );
    
end );

##
InstallMethod( GradedRightIdealOfMaximalMinors,
        "constructor for homalg ideals",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GradedRightSubmodule( MaximalMinors( M ) );
    
end );

##
InstallMethod( MaximalGradedLeftIdeal,
        "constructor for the maximal homogeneous ideal",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return ImageSubobject( MaximalIdealAsLeftMorphism( S ) );
    
end );

##
InstallMethod( MaximalGradedRightIdeal,
        "constructor for the maximal homogeneous ideal",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return ImageSubobject( MaximalIdealAsRightMorphism( S ) );
    
end );

##
InstallMethod( ResidueClassRingAsGradedLeftModule,
        "constructor for the residue class ring modulo the maximal graded ideal",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return FactorObject( MaximalGradedLeftIdeal( S ) );
    
end );

##
InstallMethod( ResidueClassRingAsGradedRightModule,
        "constructor for the residue class ring modulo the maximal graded ideal",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return FactorObject( MaximalGradedRightIdeal( S ) );
    
end );

##
InstallOtherMethod( \*,
        "for homalg graded modules",
        [ IsGradedSubmoduleRep, IsGradedModuleRep ],
        
  function( J, M )
    local JM, scalar;
    
    JM := UnderlyingModule( J ) * UnderlyingModule( M );
    
    scalar := GradedMap( JM!.map_having_subobject_as_its_image, "create", M );
    
    return ImageSubobject( scalar );
    
end );

##
InstallOtherMethod( \*,
        "for homalg submodules",
        [ IsGradedSubmoduleRep, IsGradedSubmoduleRep ],
        
  function( I, J )
    local super, sub;
    
    super := SuperObject( I );
    
    if not IsIdenticalObj( super, SuperObject( J ) ) then
        Error( "the super objects must coincide\n" );
    elif not ( ConstructedAsAnIdeal( I ) and ConstructedAsAnIdeal( J ) ) then
        Error( "can only multiply ideals in a common ring\n" );
    fi;
    
    sub := UnderlyingModule( I ) * UnderlyingModule( J );
    
    sub := GradedMap( sub!.map_having_subobject_as_its_image, "create", super );
    
    return ImageSubobject( sub );
    
end );

##
InstallMethod( \/,
        "for homalg ideals",
        [ IsHomalgGradedRingRep, IsGradedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( S, J )
    
    if not IsIdenticalObj( HomalgRing( J ), S ) then
        Error( "the given ring and the ring of the ideal are not identical\n" );
    fi;
    
    return ResidueClassRing( J );
    
end );

##
InstallMethod( JacobianIdeal,
        "for homalg ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    local R, var, jac;
    
    R := HomalgRing( I );
    
    var := Indeterminates( R );
    
    var := HomalgMatrix( var, 1, Length( var ), R );
    
    jac := Diff( var, MatrixOfGenerators( I ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( I ) then
        return LeftIdealOfMaximalMinors( jac );
    else
        return RightIdealOfMaximalMinors( jac );
    fi;
    
end );

##
InstallMethod( JacobianIdeal,
        "for homalg ideals",
        [ IsGradedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    local R, var, jac;
    
    R := HomalgRing( I );
    
    var := Indeterminates( R );
    
    var := HomalgMatrix( var, Length( var ), 1, R );
    
    jac := Diff( var, MatrixOfGenerators( I ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( I ) then
        return GradedLeftIdealOfMaximalMinors( jac );
    else
        return GradedRightIdealOfMaximalMinors( jac );
    fi;
    
end );

##
InstallMethod( JacobianIdeal,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( f )
    
    return JacobianIdeal( LeftSubmodule( f ) );
    
end );

##
InstallMethod( JacobianIdeal,
        "for homalg ideals",
        [ IsHomalgGradedRingElementRep ],
        
  function( f )
    
    return JacobianIdeal( GradedLeftSubmodule( f ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################
