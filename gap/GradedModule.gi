#############################################################################
##
##  GradedModule.gi             GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations for graded homalg modules.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_GRADED_MODULES,
        rec(
            category := rec(
                            description := "f.p. graded modules and their maps over computable graded rings",
                            short_description := "_for_fp_graded_modules",
                            TryPostDivideWithoutAids := true, # see homalg/ToolFunctors.gi
                            MorphismConstructor := GradedMap,
                            TypeOfElements := TheTypeHomalgModuleElement,
                            InternalHom := GradedHom,
                            InternalExt := GradedExt,
                            ),
            ModulesSave := [ ],
            MorphismsSave := [ ],
            # this sets the bound at which modules are cut of when computing ModuleOfGlobalSections.
            # it should be zero to ensure that global sections sets the correct transformation
            LowerTruncationBound := 0
           )
);

####################################
#
# representations:
#
####################################

DeclareRepresentation( "IsGradedModuleOrGradedSubmoduleRep",
        IsHomalgGradedModule and
        IsStaticFinitelyPresentedObjectOrSubobjectRep and
        IsHomalgGradedRingOrGradedModuleRep,
        [ ] );

DeclareRepresentation( "IsGradedModuleRep",
        IsGradedModuleOrGradedSubmoduleRep and
        IsStaticFinitelyPresentedObjectRep,
        [ "UnderlyingModule", "SetOfDegreesOfGenerators" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgGradedModules",
        NewFamily( "TheFamilyOfHomalgGradedModules" ) );

# two new types:
BindGlobal( "TheTypeHomalgGradedLeftModule",
           NewType( TheFamilyOfHomalgGradedModules, IsHomalgLeftObjectOrMorphismOfLeftObjects and IsGradedModuleRep )
          );

BindGlobal( "TheTypeHomalgGradedRightModule",
           NewType( TheFamilyOfHomalgGradedModules, IsHomalgRightObjectOrMorphismOfRightObjects and IsGradedModuleRep )
          );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MapHavingCertainGeneratorsAsItsImage,
        "for two homalg modules, submodules, or maps",
        [ IsGradedModuleRep, IsList ],
        
  function( M, l )
    local n, certain_part, mat;
    
    return GradedMap( MapHavingCertainGeneratorsAsItsImage( UnderlyingModule( M ), l ), "create", M );
    
end );

##
InstallMethod( LockObjectOnCertainPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt ],
        
  function( M, p )
    
    ## first save the current setting
    M!.LockObjectOnCertainPresentation := PositionOfTheDefaultPresentation( M );
    
    SetPositionOfTheDefaultPresentation( M, p );
    
    LockObjectOnCertainPresentation( UnderlyingModule( M ), p );
    
end );

##
InstallMethod( LockObjectOnCertainPresentation,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    LockObjectOnCertainPresentation( M, PositionOfTheDefaultPresentation( M ) );
    
end );

##
InstallMethod( UnlockObject,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    UnlockObject( UnderlyingModule( M ) );
    
    ## first restore the saved settings
    if IsBound( M!.LockObjectOnCertainPresentation ) then
        SetPositionOfTheDefaultPresentation( M, M!.LockObjectOnCertainPresentation );
        Unbind( M!.LockObjectOnCertainPresentation );
    fi;
    
end );

##
InstallMethod( UnderlyingModule,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return M!.UnderlyingModule;
    
end );

##
InstallMethod( SetOfDegreesOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return  M!.SetOfDegreesOfGenerators;
    
end );

##
InstallMethod( AnyParametrization,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
  local par;
    par := AnyParametrization( UnderlyingModule( M ) );
    return GradedMap( par, M, "create", HomalgRing( M ) );
end );

##
InstallMethod( CurrentResolution,
        "for graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( q, M )
  local S, res, degrees, deg, len, CEpi, d_j, F_j, graded_res, j;
    
    S := HomalgRing( M );
    
    res := Resolution( q, UnderlyingModule( M ) );
    degrees := ObjectDegreesOfComplex( res );
    len := Length( degrees );
    
    if HasCurrentResolution( M ) then
      graded_res := CurrentResolution( M );
      deg := ObjectDegreesOfComplex( graded_res );
      j := Length( deg );
      j := deg[j];
      d_j := CertainMorphism( graded_res, j );
    else
      j := res!.degrees[2];
      CEpi := GradedMap( CokernelEpi( res!.(j) ), "create", M );
      Assert( 1, IsMorphism( CEpi ) );
      SetIsMorphism( CEpi, true );
      d_j := GradedMap( res!.(j), "create", Source( CEpi ), S );
      Assert( 1, IsMorphism( d_j ) );
      SetIsMorphism( d_j, true );
      SetCokernelEpi( d_j, CEpi );
      graded_res := HomalgComplex( d_j );
      SetCurrentResolution( M, graded_res );
    fi;

    F_j := Source( d_j );
    
    if len >= j+2 then
      for j in [ res!.degrees[j+2] .. res!.degrees[len] ] do
        if IsIdenticalObj( F_j, 0 * S ) or IsIdenticalObj( F_j, S * 0 ) then
          # take care not to create the graded zero morphism between distinguished zero modules again each step
          d_j := TheZeroMorphism( F_j, F_j );
          Add( graded_res, d_j );
          # no need for resetting F_j, since all other modules will be zero, too
        else
          d_j := GradedMap( res!.(j), "create", F_j, S );
          Assert( 1, IsMorphism( d_j ) );
          SetIsMorphism( d_j, true );
          Add( graded_res, d_j );
          F_j := Source( d_j );
        fi;
      od;
    fi;

    if HasIsAcyclic( res ) and IsAcyclic( res ) then
      SetIsAcyclic( graded_res, true );
    fi;
    if HasIsRightAcyclic( res ) and HasIsRightAcyclic( res ) then
      SetIsRightAcyclic( graded_res, true );
    fi;
    
    if IsBound( res!.LengthOfResolution ) then
      graded_res!.LengthOfResolution := res!.LengthOfResolution;
    fi;
    
    return graded_res;
    
end );

##
InstallMethod( PresentationMorphism,
        "for homalg modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, pos )
    local rel, pres, epi;
    
    if IsBound(M!.PresentationMorphisms.( pos )) then
        return M!.PresentationMorphisms.( pos );
    fi;
    
    pres := PresentationMorphism( UnderlyingModule( M ), pos );

    epi := GradedMap( CokernelEpi( pres ), "create", M );
    
    Assert( 2, IsMorphism( epi ) );
    SetIsMorphism( epi, true );
    
    pres := GradedMap( pres, "create", Source( epi ) );
    
    Assert( 2, IsMorphism( pres ) );
    SetIsMorphism( pres, true );
    
    SetCokernelEpi( pres, epi );
    
    M!.PresentationMorphisms.( pos ) := pres;
    
    return pres;
    
end );

##  <#GAPDoc Label="MonomialMap">
##  <ManSection>
##    <Oper Arg="d, M" Name="MonomialMap"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The map from a free graded module onto all degree <A>d</A> monomial generators
##      of the finitely generated &homalg; module <A>M</A>.
##      <#Include Label="MonomialMap:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( MonomialMap,
        "for homalg modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( d, M )
    local S, degrees, mon, i, result;
    
    S := HomalgRing( M );
    
    degrees := DegreesOfGenerators( M );
    
    degrees := List( degrees, HomalgElementToInteger );
    
    mon := rec( );
    
    for i in Set( degrees ) do
        mon.(String( d - i )) := MonomialMatrix( d - i , S );
    od;
    
    mon := List( degrees, i -> mon.(String(d - i)) );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mon := List( mon, Involution );
    fi;
    
    if mon <> [ ] then
        mon := DiagMat( mon );
    else
        mon := HomalgZeroMatrix( 0, 0, UnderlyingNonGradedRing( S ) );
    fi;
    
    mon := MatrixOverGradedRing( mon, S );
    
    result:= GradedMap( mon, "free", M );
    
    Assert( 2, IsMorphism( result ) );
    SetIsMorphism( result, true );
    
    return result;
    
end );

##
InstallMethod( MonomialMap,
        "for homalg modules",
        [ IsHomalgElement, IsGradedModuleRep ],
        
  function( d, M )
    
    return MonomialMap( HomalgElementToInteger( d ), M );
    
end );

##  <#GAPDoc Label="RandomMatrix">
##  <ManSection>
##    <Oper Arg="S,T" Name="RandomMatrix"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random matrix between the graded source module <A>S</A> and the graded target module <A>T</A>.
##      <#Include Label="RandomMatrix:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrix,
        "for homalg modules",
        [ IsHomalgGradedModule, IsHomalgGradedModule ],
        
  function( S, T )
    local left, degreesS, degreesT, R;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( S );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( T ) <> left then
        Error( "both modules must either be left or either be right modules" );
    fi;
    
    degreesS := DegreesOfGenerators( S );
    degreesT := DegreesOfGenerators( T );
    
    R := HomalgRing( S );
    
    if left then
        return RandomMatrixBetweenGradedFreeLeftModules( degreesS, degreesT, R );
    else
        return RandomMatrixBetweenGradedFreeRightModules( degreesT, degreesS, R );
    fi;
    
end );

##
InstallMethod( \/,        ### defines: / (SubfactorModule)
        "for a homalg matrix and a graded module",
        [ IsHomalgMatrix, IsGradedModuleOrGradedSubmoduleRep ], 10000,
        
  function( mat, M )
#     local B, N, gen, S, SF;
    local mat2, res;
    
    if IsHomalgMatrixOverGradedRingRep( mat ) then
      mat2 := UnderlyingMatrixOverNonGradedRing( mat );
    else
      mat2 := mat;
    fi;
    
    res := mat2 / UnderlyingModule( M );
    
    return GradedModule( res, HomalgRing( M ) );
    
end );

##
InstallMethod( \/,        ## needed by _Functor_Kernel_OnObjects since SyzygiesGenerators returns a set of relations
        "for a set of homalg relations and a graded module",
        [ IsHomalgRelations, IsGradedModuleOrGradedSubmoduleRep ], 10000,
        
  function( rel, M )
    
    return MatrixOfRelations( rel ) / M;
    
end );

##
InstallMethod( Annihilator,
        "for homalg relations",
        [ IsHomalgMatrixOverGradedRingRep, IsHomalgRelations ],
        
  function( mat, rel )
    
    return GradedModule( Annihilator( UnderlyingMatrixOverNonGradedRing( mat ), rel ), HomalgRing( mat ) );
    
end );

##
InstallMethod( CompleteComplexByLinearResolution,
        "for homalg cocomplexes",
        [ IsInt, IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( n, C )
    local i, phi, S;
    
    for i in [ 1 .. n ] do
        
        phi := LowestDegreeMorphism( C );
        
        S := Source( phi );
        
        phi := MatrixOfMap( phi );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
            phi := LinearSyzygiesGeneratorsOfRows( phi );
        else
            phi := LinearSyzygiesGeneratorsOfColumns( phi );
        fi;
        
        phi := GradedMap( phi, "free", S );
        
        Assert( 2, IsMorphism( phi ) );
        SetIsMorphism( phi, true );
        
        Add( phi, C );
    od;
    
    return C;

end );

####################################
#
# constructors:
#
####################################

##
InstallMethod( GradedModule,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep, IsList, IsHomalgGradedRingRep ],
        
  function( module, degrees, S )
    local degree_group, weights, i, GradedModule, setofdegrees, type, ring;
    
    if IsGradedModuleRep( module ) then
        return module;
    fi;
    
#     if not Length( degrees ) = 0 then
#     
#         if not IsHomalgElement( degrees[ 1 ] ) and not Set( degrees ) = [ 0 ] then
#             
#             weights := GeneratingElements( DegreeGroup( S ) );
#             
#             if not IsInt( degrees[ 1 ] ) then
#                 
#                 if not Length( weights ) = Length( degrees[ 1 ] ) then
#                     Error(" number of generators of DegreeGroup does not match length of degrees.");
#                 fi;
#                 
#             fi;
#             
#             for i in [ 1 .. Length( weights ) ] do
#                 
#                 degrees[ i ] := degrees[ i ] * weights[ i ];
#                 
#             od;
#             
#             degrees := Flat( degrees );
#             
#         fi;
#     
#     fi;
    
    degree_group := DegreeGroup( S );
    
    if not Length( degrees ) = 0 then
        
        weights := GeneratingElements( degree_group );
        
        if IsInt( degrees[ 1 ] ) then
            
            if Set( degrees ) = [ 0 ] then
                
                degrees := ListWithIdenticalEntries( Length( degrees ), TheZeroElement( degree_group ) );
                
            elif Length( weights ) = 1 then
                
                degrees := List( degrees, HomalgElementToInteger );
                
                degrees := List( degrees, i -> i * weights[ 1 ] );
                
            else
                
                Error( "input weights do not match generators of degree group" );
                
            fi;
            
        elif IsList( degrees[ 1 ] ) then
            
            if Length( degrees[ 1 ] ) = Length( weights ) then
                
                degrees := List( degrees, i -> HomalgModuleElement( i, degree_group ) );
                
            else
                
                Error( "something went terribly wrong" );
                
            fi;
            
        elif not IsHomalgElement( degrees[ 1 ] ) then
            
            Error( "wrong input degrees" );
            
        fi;
        
    fi;
    
    if IsBound( module!.GradedVersions ) then
        for i in module!.GradedVersions do
            if IsIdenticalObj( HomalgRing( i ), S ) and degrees = DegreesOfGenerators( i ) then
                return i;
            fi;
        od;
    fi;
    
    if not IsIdenticalObj( UnderlyingNonGradedRing( S ), HomalgRing( module ) ) and
       not IsIdenticalObj( S, HomalgRing( module ) ) then
        Error( "Underlying rings do not match" );
    fi;
    
    if not ( Length( degrees ) = NrGenerators( module ) ) then
        Error( "The number of degrees ", Length( degrees ),
               " has to equal the number of Generators ", NrGenerators( module ), "\n" );
    fi;
    
    if IsBound( module!.distinguished ) and module!.distinguished and HasIsZero( module ) and IsZero( module ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
            if IsBound( S!.ZeroLeftModule ) then
                return S!.ZeroLeftModule;
            fi;
        else
            if IsBound( S!.ZeroRightModule ) then
                return S!.ZeroRightModule;
            fi;
        fi;
    fi;
    
    setofdegrees := CreateSetOfDegreesOfGenerators( degrees, PositionOfTheDefaultPresentation( module ) );
    
    GradedModule := rec(
                        adjective := "graded",
                        string := "module",
                        string_plural := "modules",
                        ring := S,
                        category := HOMALG_GRADED_MODULES.category,
                        Resolutions := rec( ),
                        PresentationMorphisms := rec(),
                        SetOfDegreesOfGenerators := setofdegrees
                        );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
        type := TheTypeHomalgGradedLeftModule;
        ring := LeftActingDomain;
    else
        type := TheTypeHomalgGradedRightModule;
        ring := RightActingDomain;
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            GradedModule, type,
            UnderlyingModule, module,
            ring, S
            );
    
    if IsBound( module!.distinguished ) and module!.distinguished and HasIsZero( module ) and IsZero( module ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
            GradedModule!.distinguished := true;
            S!.ZeroLeftModule := GradedModule;
        else
            GradedModule!.distinguished := true;
            S!.ZeroRightModule := GradedModule;
        fi;
    fi;
    
    MatchPropertiesAndAttributes( GradedModule, module, LIGrMOD.exchangeable_properties, LIGrMOD.exchangeable_attributes );
    
#    if AssertionLevel() >= 10 then
#        for i in [ 1 .. Length( HOMALG_GRADED_MODULES.ModulesSave ) ] do
#            Assert( 10, 
#              not IsIdenticalObj( UnderlyingModule( HOMALG_GRADED_MODULES.ModulesSave[i] ), UnderlyingModule( GradedModule ) ) 
#              or IsIdenticalObj( HOMALG_GRADED_MODULES.ModulesSave[i], GradedModule ),
#            "a module is about to be graded (at least) twice. This might be intentionally. Set AssertionLevel to 11 to get an error message" );
#            Assert( 11, 
#              not IsIdenticalObj( UnderlyingModule( HOMALG_GRADED_MODULES.ModulesSave[i] ), UnderlyingModule( GradedModule ) ) 
#              or IsIdenticalObj( HOMALG_GRADED_MODULES.ModulesSave[i], GradedModule ) );
#        od;
#        Add( HOMALG_GRADED_MODULES.ModulesSave, GradedModule );
#    fi;
    
    if not IsBound( module!.GradedVersions ) then
        module!.GradedVersions := [ GradedModule ];
    else
        Add( module!.GradedVersions, GradedModule );
    fi;
    
    return GradedModule;
    
end );

##
InstallMethod( GradedModule,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep, IsInt, IsHomalgGradedRingRep ],
        
  function( module, d, S )
    local gens;
    
    gens := GeneratingElements( DegreeGroup( S ) );
    
    if Length( gens ) > 0 then
        
        gens := gens[ 1 ];
        
    else
        
        gens := TheZeroElement( DegreeGroup( S ) );
        
    fi;
    
    return GradedModule( module, ListWithIdenticalEntries( NrGenerators( module ), d * gens ), S );
end );

##
InstallMethod( GradedModule,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep, IsHomalgElement, IsHomalgGradedRingRep ],
        
  function( module, d, S )
    
    ## User should take care that d is element in the DegreeGroup of s.
    return GradedModule( module, ListWithIdenticalEntries( NrGenerators( module ), d ), S );
end );

##
InstallMethod( GradedModule,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep, IsHomalgGradedRingRep ],
        
  function( module, S )
    return GradedModule( module, TheZeroElement( DegreeGroup( S ) ), S );
end );

##
InstallMethod( GradedModule,
        "for a homalg submodule",
        [ IsFinitelyPresentedSubmoduleRep, IsHomalgGradedRingRep ],
        
  function( J, S )
    local map;
    
    map := MorphismHavingSubobjectAsItsImage( J );
    
    map := GradedMap( map, "create", ListWithIdenticalEntries( NrGenerators( Range( map ) ), TheZeroElement( DegreeGroup( S ) ) ), S );
    
    return ImageSubobject( map );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRingRep ],
        
  function( mat, degrees, S )
    local M;
    
    if Length( degrees ) <> NrColumns( mat ) then
        Error( "the number of degrees must coincide with the number of columns\n" );
    fi;
    
    if IsHomalgMatrixOverGradedRingRep( mat ) then
        M := LeftPresentation( UnderlyingMatrixOverNonGradedRing( mat ) );
    else
        M := LeftPresentation( mat );
    fi;
    
    return GradedModule( M, degrees, S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsList ],
        
  function( mat, degrees )
    
    return LeftPresentationWithDegrees( mat, degrees, HomalgRing( mat ) );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRingRep ],
        
  function( mat, degree, S )
    local gens;
    
    gens := GeneratingElements( DegreeGroup( S ) );
    
    if Length( gens ) > 0 then
        
        gens := gens[ 1 ];
        
    else
        
        gens := TheZeroElement( DegreeGroup( S ) );
        
    fi;
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), degree * gens ), S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsHomalgElement, IsHomalgGradedRingRep ],
        
  function( mat, degree, S )
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), degree ), S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsInt ],
        
  function( mat, degree )
    local ring, gens;
    
    ring := HomalgRing( mat );
    
    gens := GeneratingElements( DegreeGroup( ring ) );
    
    if Length( gens ) > 0 then
        
        gens := gens[ 1 ];
        
    else
        
        gens := TheZeroElement( DegreeGroup( ring ) );
        
    fi;
    
    return LeftPresentationWithDegrees( mat, degree * gens , ring );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsHomalgElement ],
        
  function( mat, degree )
    
    return LeftPresentationWithDegrees( mat, degree, HomalgRing( mat ) );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( mat, S )
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), TheZeroElement( DegreeGroup( S ) ) ), S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep ],
        
  function( mat )
    
    return LeftPresentationWithDegrees( mat, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRingRep ],
        
  function( mat, degrees, S )
    local M;
    
    if Length( degrees ) <> NrRows( mat ) then
        Error( "the number of degrees must coincide with the number of rows\n" );
    fi;
    
    if IsHomalgMatrixOverGradedRingRep( mat ) then
        M := RightPresentation( UnderlyingMatrixOverNonGradedRing( mat ) );
    else
        M := RightPresentation( mat );
    fi;
    
    return GradedModule( M, degrees, S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsList ],
        
  function( mat, degrees )
  
    return RightPresentationWithDegrees( mat, degrees, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRingRep ],
        
  function( mat, degree, S )
    local gens;
    
    gens := GeneratingElements( DegreeGroup( S ) );
    
    if Length( gens ) > 0 then
        
        gens := gens[ 1 ];
        
    else
        
        gens := TheZeroElement( DegreeGroup( S ) );
        
    fi;
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), degree * gens ), S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsHomalgElement, IsHomalgGradedRingRep ],
        
  function( mat, degree, S )
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), degree ), S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep, IsInt ],
        
  function( mat, degree )
    
    return RightPresentationWithDegrees( mat, degree, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( mat, S )
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), TheZeroElement( DegreeGroup( S ) ) ), S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrixOverGradedRingRep ],
        
  function( mat )
    
    return RightPresentationWithDegrees( mat, HomalgRing( mat ) );
    
end );

##
InstallMethod( FreeLeftModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsHomalgGradedRingRep, IsList ],
        
  function( S, degrees )
    
    return GradedModule( HomalgFreeLeftModule( Length( degrees ), UnderlyingNonGradedRing( S ) ), degrees, S );
    
end );

##
InstallMethod( FreeLeftModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsList, IsHomalgGradedRingRep ],
        
  function( degrees, S )
    
    return GradedModule( HomalgFreeLeftModule( Length( degrees ), UnderlyingNonGradedRing( S ) ), degrees, S );
    
end );

##
InstallMethod( FreeLeftModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsHomalgRing, IsList ],
        
  function( S, degrees )
    
    return LeftPresentationWithDegrees( HomalgZeroMatrix( 0, Length( degrees ), S ), degrees );
    
end );

##
InstallMethod( FreeLeftModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsInt, IsHomalgRing, IsInt ],
        
  function( rank, S, degree )
    
    return FreeLeftModuleWithDegrees( S, ListWithIdenticalEntries( rank, degree ) );
    
end );

InstallMethod( FreeLeftModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsInt, IsHomalgRing, IsHomalgElement ],
        
  function( rank, S, degree )
    
    return FreeLeftModuleWithDegrees( S, ListWithIdenticalEntries( rank, degree ) );
    
end );

##
InstallMethod( FreeLeftModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsInt, IsHomalgRing ],
        
  function( rank, S )
    
    return FreeLeftModuleWithDegrees( rank, S, 0 );
    
end );

##
InstallMethod( FreeRightModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsHomalgGradedRingRep, IsList ],
        
  function( S, degrees )
    
    return GradedModule( HomalgFreeRightModule( Length( degrees ), UnderlyingNonGradedRing( S ) ), degrees, S );
    
end );

##
InstallMethod( FreeRightModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsList, IsHomalgGradedRingRep ],
        
  function( degrees, S )
    
    return GradedModule( HomalgFreeRightModule( Length( degrees ), UnderlyingNonGradedRing( S ) ), degrees, S );
    
end );

##
InstallMethod( FreeRightModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsHomalgRing, IsList ],
        
  function( S, degrees )
    
    return RightPresentationWithDegrees( HomalgZeroMatrix( Length( degrees ), 0, S ), degrees );
    
end );

##
InstallMethod( FreeRightModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsInt, IsHomalgRing, IsInt ],
        
  function( rank, S, degree )
    
    return FreeRightModuleWithDegrees( S, ListWithIdenticalEntries( rank, degree ) );
    
end );

InstallMethod( FreeRightModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsInt, IsHomalgRing, IsHomalgElement ],
        
  function( rank, S, degree )
    
    return FreeRightModuleWithDegrees( S, ListWithIdenticalEntries( rank, degree ) );
    
end );

##
InstallMethod( FreeRightModuleWithDegrees,
        "constructor for homalg graded free modules",
        [ IsInt, IsHomalgRing ],
        
  function( rank, S )
    
    return FreeRightModuleWithDegrees( rank, S, 0 );
    
end );

##
InstallMethod( ZeroLeftModule,
        "for homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    if IsBound(S!.ZeroLeftModule) then
        return S!.ZeroLeftModule;
    fi;
    
    return GradedModule( 0 * UnderlyingNonGradedRing( S ), S );
    
end );

##
InstallMethod( ZeroRightModule,
        "for homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    if IsBound(S!.ZeroRightModule) then
        return S!.ZeroRightModule;
    fi;
    
    return GradedModule( UnderlyingNonGradedRing( S ) * 0, S );
    
end );

##
InstallMethod( PresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep,
          IsRelationsOfFinitelyPresentedModuleRep,
          IsList,
          IsHomalgGradedRingRep ],
        
  function( gen, rel, degrees, S )
    local module;
    
    module := Presentation( gen, rel );
    
    return GradedModule( module, degrees, S );
    
end );

##
InstallMethod( PresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep,
          IsRelationsOfFinitelyPresentedModuleRep,
          IsInt,
          IsHomalgGradedRingRep ],
        
  function( gen, rel, degree, S )
    local module, degree_group;
    
    degree_group := DegreeGroup( S );
    
    module := Presentation( gen, rel );
    
    return GradedModule( module, HomalgModuleElement( [ degree ], degree_group ), S );
    
end );

##
InstallMethod( PresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep,
          IsRelationsOfFinitelyPresentedModuleRep,
          IsHomalgElement,
          IsHomalgGradedRingRep ],
        
  function( gen, rel, degree, S )
    local module;
    
    module := Presentation( gen, rel );
    
    return GradedModule( module, degree, S );
    
end );

##
InstallMethod( PresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep,
          IsRelationsOfFinitelyPresentedModuleRep,
          IsHomalgGradedRingRep ],
        
  function( gen, rel, S )
    local module;
    
    module := Presentation( gen, rel );
    
    return GradedModule( module, S );
    
end );

##
InstallOtherMethod( Zero,
        "for homalg modules",
        [ IsGradedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ], 10001,  ## FIXME: is it O.K. to use such a high ranking
        
  function( M )
    
    return ZeroRightModule( HomalgRing( M ) );
    
end );

##
InstallOtherMethod( Zero,
        "for homalg modules",
        [ IsGradedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ], 10001,  ## FIXME: is it O.K. to use such a high ranking
        
  function( M )
    
    return ZeroLeftModule( HomalgRing( M ) );
    
end );

##
InstallMethod( \*,
        "constructor for homalg free graded modules",
        [ IsInt, IsHomalgGradedRingRep ],
        
  function( rank, S )
    
    if rank = 0 then
        return ZeroLeftModule( S );
    elif rank = 1 then
        return AsLeftObject( S );
    elif rank > 1 then
        return FreeLeftModuleWithDegrees( rank, S );
    fi;
    
    Error( "virtual modules are not supported (yet)\n" );
    
end );

##
InstallMethod( \*,
        "constructor for homalg free graded modules",
        [ IsHomalgGradedRingRep, IsInt ],
        
  function( S, rank )
    
    if rank = 0 then
        return ZeroRightModule( S );
    elif rank = 1 then
        return AsRightObject( S );
    elif rank > 1 then
        return FreeRightModuleWithDegrees( rank, S );
    fi;
    
    Error( "virtual modules are not supported (yet)\n" );
    
end );

##
InstallMethod( AsLeftObject,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local left;
    
    if IsBound(S!.AsGradedLeftObject) then
        return S!.AsGradedLeftObject;
    fi;
    
    left := GradedModule( 1 * UnderlyingNonGradedRing( S ), S );
    
    left!.distinguished := true;
    
    left!.not_twisted := true;
    
    S!.AsGradedLeftObject := left;
    
    return left;
    
end );

##
InstallMethod( AsRightObject,
        "for homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local right;
    
    if IsBound(S!.AsRightObject) then
        return S!.AsRightObject;
    fi;
    
    right := GradedModule( UnderlyingNonGradedRing( S ) * 1, S );
    
    right!.distinguished := true;
    
    right!.not_twisted := true;
    
    S!.AsRightObject := right;
    
    return right;
    
end );


##
InstallMethod( POW,
        "constructor for homalg graded free modules of rank 1",
        [ IsGradedModuleRep, IsInt ],
        
  function( M, twist )    ## M must be either 1 * R or R * 1
    local S, G, w1, t, On;
    
    S := HomalgRing( M );
    
    G := DegreeGroup( S );
    
    t := HomalgModuleElement( ListWithIdenticalEntries( NrGenerators( G ), twist ), G );
    
    if IsIdenticalObj( M, 1 * S ) then
        
        if not IsBound( S!.left_twists ) then
            S!.left_twists := rec( );
        fi;
        
        if not IsBound( S!.left_twists.(String( t )) ) then
            
            On := GradedModule( 1 * UnderlyingNonGradedRing( S ), -t, S );
            
            On!.distinguished := true;
            
            if twist = 0 then
                On!.not_twisted := true;
            fi;
            
            S!.left_twists.(String( t )) := On;
            
        fi;
        
        return S!.left_twists.(String( t ));
        
    elif IsIdenticalObj( M, S * 1 ) then
        
        if not IsBound( S!.right_twists ) then
            S!.right_twists := rec( );
        fi;
        
        if not IsBound( S!.right_twists.(String( t )) ) then
            
            On := GradedModule( UnderlyingNonGradedRing( S ) * 1, -t, S );
            
            On!.distinguished := true;
            
            if twist = 0 then
                On!.not_twisted := true;
            fi;
            
            S!.right_twists.(String( t )) := On;
            
        fi;
        
        return S!.right_twists.(String( t ));
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( POW,
        "constructor for homalg graded free modules",
        [ IsGradedModuleRep, IsList ],
        
  function( M, twist )
    local S, G, twist_set, weights, On;
    
    S := HomalgRing( M );
    
    G := DegreeGroup( S );
    
    twist_set := Set( Flat( twist ) );
    
    weights := GeneratingElements( G );
    
    if Length( twist ) <> NrGenerators( G ) then
        
        Error( "something went terribly wrong\n" );
        
    fi;
    
    twist := HomalgModuleElement( twist, G );
    
    if IsIdenticalObj( M, 1 * S ) then
        
        if not IsBound( S!.left_twists ) then
            S!.left_twists := rec( );
        fi;
        
        if not IsBound( S!.left_twists.(String( twist )) ) then
            
            On := FreeLeftModuleWithDegrees( S, -twist );
            
            On!.distinguished := true;
            
            if twist_set = [ 0 ] then
                On!.not_twisted := true;
            fi;
            
            S!.left_twists.(String( twist )) := On;
            
        fi;
        
        return S!.left_twists.(String( twist ));
        
    elif IsIdenticalObj( M, S * 1 ) then
        
        if not IsBound( S!.right_twists ) then
            S!.right_twists := rec( );
        fi;
        
        if not IsBound( S!.right_twists.(String( twist )) ) then
            
            On := FreeRightModuleWithDegrees( S, -twist );
            
            On!.distinguished := true;
            
            if twist_set = [ 0 ] then
                On!.not_twisted := true;
            fi;
            
            S!.right_twists.(String( twist )) := On;
            
        fi;
        
        return S!.right_twists.(String( twist ));
        
    fi;
    
    TryNextMethod( );
    
end );

InstallMethod( POW,
        "constructor for homalg graded free modules",
        [ IsGradedModuleRep, IsHomalgElement ],
        
  function( M, twist )
    local S, G, w1, t, On;
    
    S := HomalgRing( M );
    
    t := twist;
    
    if IsIdenticalObj( M, 1 * S ) then
        
        if not IsBound( S!.left_twists ) then
            S!.left_twists := rec( );
        fi;
        
        if not IsBound( S!.left_twists.(String( t )) ) then
            
            On := GradedModule( 1 * UnderlyingNonGradedRing( S ), -t, S );
            
            On!.distinguished := true;
            
            if twist = 0 then
                On!.not_twisted := true;
            fi;
            
            S!.left_twists.(String( t )) := On;
            
        fi;
        
        return S!.left_twists.(String( t ));
        
    elif IsIdenticalObj( M, S * 1 ) then
        
        if not IsBound( S!.right_twists ) then
            S!.right_twists := rec( );
        fi;
        
        if not IsBound( S!.right_twists.(String( t )) ) then
            
            On := GradedModule( UnderlyingNonGradedRing( S ) * 1, -t, S );
            
            On!.distinguished := true;
            
            if twist = 0 then
                On!.not_twisted := true;
            fi;
            
            S!.right_twists.(String( t )) := On;
            
        fi;
        
        return S!.right_twists.(String( t ));
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( POW,
        "constructor for homalg graded free modules of rank 1",
        [ IsHomalgGradedRingRep, IsInt ],
        
  function( S, twist )
    
    return ( 1 * S )^twist;
    
end );

##
InstallMethod( POW,
        "constructor for homalg graded free modules",
        [ IsHomalgGradedRingRep, IsList ],
        
  function( S, twist )
    
    return ( 1 * S )^twist;
    
end );


##
InstallMethod( POW,
        "constructor for homalg graded free modules",
        [ IsHomalgGradedRingRep, IsHomalgElement ],
        
  function( S, twist )
    
    return ( 1 * S )^twist;
    
end );
##
InstallMethod( Pullback,
        "for a ring map and a graded module",
        [ IsHomalgRingMap, IsGradedModuleRep ],
        
  function( phi, M )
    local rel, degrees, weights;
    
    rel := MatrixOfRelations( M );
    
    rel := Pullback( phi, rel );
    
    degrees := DegreesOfGenerators( M );
    
    weights := Set( List( ImagesOfRingMap( phi ), Degree ) );
    
    if Length( weights ) <> 1 then
        Error( "different weights are not supported yet\n" );
    fi;
    
    degrees := degrees * weights[1];
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return LeftPresentationWithDegrees( rel, degrees );
    else
        return RightPresentationWithDegrees( rel, degrees );
    fi;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for graded homalg modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( o )
    
    if IsBound( o!.distinguished ) then
        Print( "<The graded" );
    else
        Print( "<A graded" );
    fi;
    
    Print( ViewString( UnderlyingModule( o ) ) );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
        "for graded homalg modules",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( o )
    local deg;
    
    deg := DegreesOfGenerators( o );
    
    if Length( deg ) > 1 then
        Display( UnderlyingModule( o ) );
        Print( "\n(graded, degrees of generators: ");
        ViewObj( deg );
        Print( ")\n" );
    elif Length( deg ) = 1 then
        Display( UnderlyingModule( o ) );
        Print( "\n(graded, degree of generator: ");
        ViewObj( deg[ 1 ] );
        Print( ")\n" );
    else
        Display( UnderlyingModule( o ) );
        Print( "\n(graded)\n" );
    fi;
    
end );
