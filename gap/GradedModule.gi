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
                            MorphismConstructor := GradedMap
                            ),
            ModulesSave := [ ],
            MorphismsSave := [ ]
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

DeclareRepresentation( "IsGradedSubmoduleRep",
        IsGradedModuleOrGradedSubmoduleRep and
        IsStaticFinitelyPresentedSubobjectRep,
        [ "map_having_subobject_as_its_image" ] );


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
      d_j := GradedMap( res!.(j), "create", Source( CEpi ), S );
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
    pres := GradedMap( pres, "create", Source( epi ) );
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
    local S, degrees, mon, i;
    
    S := HomalgRing( M );
    
    degrees := DegreesOfGenerators( M );
    
    mon := rec( );
    
    for i in Set( degrees ) do
        mon.(String( d - i )) := MonomialMatrix( d - i, S );
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
    
    mon := HomogeneousMatrix( mon, S );
    
    return GradedMap( mon, "free", M );
    
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
        [ IsHomalgModule, IsHomalgModule ],
        
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

##  <#GAPDoc Label="BasisOfHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="BasisOfHomogeneousPart"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The resulting &homalg; matrix consists of a <M>R</M>-basis of the <A>d</A>-th homogeneous part
##      of the finitely generated &homalg; <M>S</M>-module <A>M</A>, where <M>R</M> is the ground ring
##      of the graded ring <M>S</M> with <M>S_0=R</M>.
##      <#Include Label="BasisOfHomogeneousPart:example">
##  Compare with <Ref Oper="MonomialMap"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfHomogeneousPart,
        "for homalg modules",
        [ IsInt, IsHomalgModule ],
        
  function( d, M )
    local homogeneous_parts, p, bases, M_d, diff, bas;
    
    if IsBound( M!.HomogeneousParts ) then
      homogeneous_parts := M!.HomogeneousParts;
    else
      homogeneous_parts := rec( );
      M!.HomogeneousParts := homogeneous_parts;
    fi;
    
    p := PositionOfTheDefaultPresentation( M );
    
    if IsBound( homogeneous_parts!.p ) then
        bases := homogeneous_parts!.p;
        if IsBound( bases.(String( d )) ) then
            return bases.(String( d ));
        fi;
    else
        bases := rec( );
        homogeneous_parts!.p := bases;
    fi;
    
    ## the map of generating monomials of degree d
    M_d := MonomialMap( d, M );
    
    ## the matrix of generating monomials of degree d
    M_d := MatrixOfMap( M_d );
    
    ## the basis monomials are not altered by reduction
    diff := M_d - DecideZero( M_d, M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        bas := ZeroRows( diff );
        bas := CertainRows( M_d, bas );
    else
        bas := ZeroColumns( diff );
        bas := CertainColumns( M_d, bas );
    fi;
    
    bases.(String( d )) := bas;
    
    return bas;
    
end );

##  <#GAPDoc Label="RepresentationOfRingElement">
##  <ManSection>
##    <Oper Arg="r, M, d" Name="RepresentationOfRingElement"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The &homalg; matrix induced by the homogeneous degree <E><M>1</M></E> ring element <A>r</A>
##      (of the underlying &homalg; graded ring <M>S</M>) regarded as a <M>R</M>-linear map
##      between the <A>d</A>-th and the <M>(</M><A>d</A><M>+1)</M>-st homogeneous part of the finitely generated
##      &homalg; <M>S</M>-module <M>M</M>, where <M>R</M> is the ground ring of the graded ring <M>S</M>
##      with <M>S_0=R</M>. The basis of both vector spaces is given by <Ref Oper="BasisOfHomogeneousPart"/>. The
##      entries of the matrix lie in the ground ring <M>R</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> x := Indeterminate( S, 1 );
##  x
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationOfRingElement( x, M, 0 );
##  <An unevaluated 3 x 7 matrix over an external ring>
##   gap> Display( m );
##   0,0,1,0,0,0,0,
##   0,1,0,0,0,0,0,
##   0,0,0,1,0,0,0 
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationOfRingElement,
        "for homalg ring elements",
        [ IsRingElement, IsHomalgModule, IsInt ],
        
  function( r, M, d )
    local bd, bdp1, mat;
    
    bd := BasisOfHomogeneousPart( d, M );
    
    bdp1 := BasisOfHomogeneousPart( d + 1, M );
    
    bd := r * bd;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return RightDivide( bd, bdp1, MatrixOfRelations( M ) );
    else
        return LeftDivide( bdp1, bd, MatrixOfRelations( M ) );
    fi;
    
end );

##  <#GAPDoc Label="HomogeneousPartOverCoefficientsRing">
##  <ManSection>
##    <Oper Arg="d, M" Name="HomogeneousPartOverCoefficientsRing"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The degree <M>d</M> homogeneous part of the graded <M>R</M>-module <A>M</A>
##      as a module over the coefficient ring or field of <M>R</M>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x, y^2, z^3 ]", 3, 1, S );;
##  gap> M := Subobject( M, ( 1 * S )^0 );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> CastelnuovoMumfordRegularity( M );
##  4
##  gap> M1 := HomogeneousPartOverCoefficientsRing( 1, M );
##  <A free left module of rank 1 on a free generator>
##  gap> gen1 := GeneratorsOfModule( M1 );
##  <A set consisting of a single generator of a homalg left module>
##  gap> Display( M1 );
##  Q^(1 x 1)
##  gap> M2 := HomogeneousPartOverCoefficientsRing( 2, M );
##  <A free left module of rank 4 on free generators>
##  gap> Display( M2 );
##  Q^(1 x 4)
##  gap> gen2 := GeneratorsOfModule( M2 );
##  <A set of 4 generators of a homalg left module>
##  gap> M3 := HomogeneousPartOverCoefficientsRing( 3, M );
##  <A free left module of rank 9 on free generators>
##  gap> Display( M3 );
##  Q^(1 x 9)
##  gap> gen3 := GeneratorsOfModule( M3 );
##  <A set of 9 generators of a homalg left module>
##   gap> Display( gen1 );
##   x
##   
##   a set consisting of a single generator given by (the row of) the above matrix
##   gap> Display( gen2 );
##   x^2,
##   x*y,
##   x*z,
##   y^2 
##   
##   a set of 4 generators given by the rows of the above matrix
##   gap> Display( gen3 );
##   x^3,  
##   x^2*y,
##   x^2*z,
##   x*y*z,
##   x*z^2,
##   x*y^2,
##   y^3,  
##   y^2*z,
##   z^3   
##   
##   a set of 9 generators given by the rows of the above matrix
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
# todo: remove
InstallMethod( HomogeneousPartOverCoefficientsRing,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleOrSubmoduleRep ],
        
  function( d, M )
    local S, k, N, gen, l, rel;
    
    S := HomalgRing( M );
    
    if not HasCoefficientsRing( S ) then
        TryNextMethod( );
    fi;
    
    k := CoefficientsRing( S );
    
    N := SubmoduleGeneratedByHomogeneousPart( d, M );
    
    gen := GeneratorsOfModule( N );
    
    gen := NewHomalgGenerators( MatrixOfGenerators( gen ), gen );
    
    gen!.ring := k;
    
    l := NrGenerators( gen );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        rel := HomalgZeroMatrix( 0, l, k );
        rel := HomalgRelationsForLeftModule( rel );
    else
        rel := HomalgZeroMatrix( l, 0, k );
        rel := HomalgRelationsForRightModule( rel );
    fi;
    
    return Presentation( gen, rel );
    
end );

##
InstallMethod( Saturate,
        "for homalg submodules",
        [ IsGradedSubmoduleRep ],
        
  function( I )
    local degrees, max;
    
    degrees := DegreesOfGenerators( I );
    
    if not ( HasConstructedAsAnIdeal( I ) and ConstructedAsAnIdeal( I ) ) then
      TryNextMethod( );
    fi;
    
    max := Indeterminates( HomalgRing( I ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( I ) then
      max := GradedLeftSubmodule( max );
    else
      max := GradedRightSubmodule( max );
    fi;
    
    return Saturate( I, max );
    
end );

InstallMethod( \/,        ### defines: / (SubfactorModule)
        "for a homalg matrix and a graded module",
        [ IsHomalgMatrix, IsGradedModuleOrGradedSubmoduleRep ], 10000,
        
  function( mat, M )
#     local B, N, gen, S, SF;
    local mat2, res;
    
    if IsHomalgHomogeneousMatrixRep( mat ) then
      mat2 := UnderlyingNonHomogeneousMatrix( mat );
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
    local i, GradedModule, setofdegrees, type, ring;
    
    if IsGradedModuleRep( module ) then
        return module;
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
    
    if IsBound( module!.distinguished ) and module!.distinguished and IsZero( module ) then
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
                        string := "graded module",
                        string_plural := "graded modules",
                        ring := S,
                        category := HOMALG_GRADED_MODULES.category,
                        UnderlyingModule := module,
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
            ring, S
            );
    
    if IsBound( module!.distinguished ) and module!.distinguished and IsZero( module ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
            GradedModule!.distinguished := true;
            S!.ZeroLeftModule := GradedModule;
        else
            GradedModule!.distinguished := true;
            S!.ZeroRightModule := GradedModule;
        fi;
    fi;

    if AssertionLevel() >= 10 then
        for i in [ 1 .. Length( HOMALG_GRADED_MODULES.ModulesSave ) ] do
            Assert( 10, 
              not IsIdenticalObj( UnderlyingModule( HOMALG_GRADED_MODULES.ModulesSave[i] ), UnderlyingModule( GradedModule ) ) 
              or IsIdenticalObj( HOMALG_GRADED_MODULES.ModulesSave[i], GradedModule ),
            "a module is about to be graded (at least) twice. This might be intentionally. Set AssertionLevel to 11 to get an error message" );
            Assert( 11, 
              not IsIdenticalObj( UnderlyingModule( HOMALG_GRADED_MODULES.ModulesSave[i] ), UnderlyingModule( GradedModule ) ) 
              or IsIdenticalObj( HOMALG_GRADED_MODULES.ModulesSave[i], GradedModule ) );
        od;
        Add( HOMALG_GRADED_MODULES.ModulesSave, GradedModule );
    fi;
    
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
    return GradedModule( module, ListWithIdenticalEntries( NrGenerators( module ), d ), S );
end );

##
InstallMethod( GradedModule,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep, IsHomalgGradedRingRep ],
        
  function( module, S )
    return GradedModule( module, 0, S );
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
    
    if IsHomalgHomogeneousMatrixRep( mat ) then
        M := LeftPresentation( UnderlyingNonHomogeneousMatrix( mat ) );
    else
        M := LeftPresentation( mat );
    fi;
    
    return GradedModule( M, degrees, S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep, IsList ],
        
  function( mat, degrees )
    
    return LeftPresentationWithDegrees( mat, degrees, HomalgRing( mat ) );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRingRep ],
        
  function( mat, degree, S )
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), degree ), S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep, IsInt ],
        
  function( mat, degree )
    
    return LeftPresentationWithDegrees( mat, degree, HomalgRing( mat ) );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( mat, S )
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), 0 ), S );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep ],
        
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
    
    if IsHomalgHomogeneousMatrixRep( mat ) then
        M := RightPresentation( UnderlyingNonHomogeneousMatrix( mat ) );
    else
        M := RightPresentation( mat );
    fi;
    
    return GradedModule( M, degrees, S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep, IsList ],
        
  function( mat, degrees )
  
    return RightPresentationWithDegrees( mat, degrees, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRingRep ],
        
  function( mat, degree, S )
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), degree ), S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep, IsInt ],
        
  function( mat, degree )
    
    return RightPresentationWithDegrees( mat, degree, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( mat, S )
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), 0 ), S );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor for homalg graded modules",
        [ IsHomalgHomogeneousMatrixRep ],
        
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
    local S, On, weights, w1, t;
    
    S := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( S );
    
    if weights = [ ] then
        Error( "an empty list of weights of indeterminates\n" );
    fi;
    
    w1 := weights[1];
    
    if IsInt( w1 ) then
        t := [ twist ];
    elif IsList( w1 ) then
        t := [ ListWithIdenticalEntries( Length( w1 ), twist ) ];
    else
        Error( "invalid first weight\n" );
    fi;
    
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
    local S, On;
    
    S := HomalgRing( M );
    
    if IsIdenticalObj( M, 1 * S ) then
        
        if not IsBound( S!.left_twists ) then
            S!.left_twists := rec( );
        fi;
        
        if not IsBound( S!.left_twists.(String( twist )) ) then
            
            On := FreeLeftModuleWithDegrees( S, -twist );
            
            On!.distinguished := true;
            
            if Set( Flat( twist ) ) = [ 0 ] then
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
            
            if Set( Flat( twist ) ) = [ 0 ] then
                On!.not_twisted := true;
            fi;
            
            S!.right_twists.(String( twist )) := On;
            
        fi;
        
        return S!.right_twists.(String( twist ));
        
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
InstallMethod( PrimaryDecomposition,
        "for homalg graded modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local degrees, graded, tr, subobject, mat, primary_decomposition;
    
    degrees := DegreesOfGenerators( M );
    
    graded := IsList( degrees ) and degrees <> [ ];
    
    if not graded then
        TryNextMethod( );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        tr := a -> a;
        subobject := GradedLeftSubmodule;
    else
        tr := Involution;
        subobject := GradedRightSubmodule;
    fi;
    
    mat := MatrixOfRelations( M );
    
    primary_decomposition := PrimaryDecompositionOp( tr( mat ) );
    
    primary_decomposition :=
      List( primary_decomposition,
            function( pp )
              local primary, prime;
              
              ##FIXME: fix the degrees
              primary := subobject( tr( pp[1] ) );
              prime := subobject( tr( pp[2] ) );
              
              return [ primary, prime ];
              
            end
          );
    
    return primary_decomposition;
    
end );

##
InstallMethod( PrimaryDecomposition,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local degrees, graded, tr, subobject, mat, primary_decomposition;
    
    primary_decomposition := PrimaryDecomposition( UnderlyingModule( M ) );
    
    primary_decomposition :=
      List( primary_decomposition,
            function( pp )
              local primary, prime;
              
              ##FIXME: fix the degrees
              primary := ImageSubobject( GradedMap( pp[1]!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              prime := ImageSubobject( GradedMap( pp[2]!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              
              return [ primary, prime ];
              
            end
          );
    
    return primary_decomposition;
    
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
    
    Print( ViewObjString( UnderlyingModule( o ) ) );
    
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
        Print( Concatenation( "\n(graded, degrees of generators: ", String( deg ), ")\n" ) );
    elif Length( deg ) = 1 then
        Display( UnderlyingModule( o ) );
        Print( Concatenation( "\n(graded, degree of generator: ", String( deg[ 1 ] ), ")\n" ) );
    else
        Display( UnderlyingModule( o ) );
        Print( "\n(graded)\n" );
    fi;
    
end );
