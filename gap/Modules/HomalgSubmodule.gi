#############################################################################
##
##  HomalgSubmodule.gi          Modules package              Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
##
##  Implementations for homalg submodules.
##
#############################################################################

####################################
#
# families and types:
#
####################################

# two new types:
BindGlobal( "TheTypeHomalgLeftFinitelyGeneratedSubmodule",
        NewType( TheFamilyOfHomalgModules,
                IsFinitelyPresentedSubmoduleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightFinitelyGeneratedSubmodule",
        NewType( TheFamilyOfHomalgModules,
                IsFinitelyPresentedSubmoduleRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( SetsOfGenerators,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return SetsOfGenerators( UnderlyingObject( M ) );
    
end );

##
InstallMethod( SetsOfRelations,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return SetsOfRelations( UnderlyingObject( M ) );
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return PositionOfTheDefaultSetOfRelations( UnderlyingObject( M ) );
    
end );

##
InstallMethod( MatrixOfSubobjectGenerators,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
  function( M )
    
    return MatrixOfMap( MapHavingSubobjectAsItsImage( M ) );
    
end );

##
InstallMethod( DecideZero,
        "for homalg modules",
        [ IsHomalgMatrix, IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( mat, N )
    
    return DecideZero( mat, MatrixOfGenerators( N ) );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( N )
    local M, phi, T;
    
    M := SuperObject( N );
    
    if not ( HasNrRelations( M ) and NrRelations( M ) = 0 ) then
        OnLessGenerators( UnderlyingObject( N ) );
        return N;
    fi;
    
    ## the super object M is free and currently presented on free generators
    
    phi := MapHavingSubobjectAsItsImage( N );
    
    T := Range( phi );
    
    phi := MatrixOfMap( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( N ) then
        phi := ReducedBasisOfRowModule( phi );
    else
        phi := ReducedBasisOfColumnModule( phi );
    fi;
    
    phi := HomalgMap( phi, "free", T );
    
    if HasEmbeddingInSuperObject( N ) then
        
        phi := ImageObjectEmb( phi );
        phi := phi / EmbeddingInSuperObject( N );	## lift
        
        Assert( 2, IsEpimorphism( phi ) );
        
        SetIsEpimorphism( phi, true );
        
        AsEpimorphicImage( phi );
        
    else
        ## psssssss, noone saw that ;-)
        N!.map_having_subobject_as_its_image := phi;
    fi;
    
    return N;
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    local emb;
    
    emb := EmbeddingInSuperObject( M );
    
    ByASmallerPresentation( Source( emb ) );
    
    DecideZero( emb );
    
    return M;
    
end );

##
InstallOtherMethod( \*,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( I, J )
    local super, genI, genJ;
    
    super := SuperObject( I );
    
    if not IsIdenticalObj( super, SuperObject( J ) ) then
        Error( "the super objects must coincide\n" );
    elif not ( ConstructedAsAnIdeal( I ) and ConstructedAsAnIdeal( J ) ) then
        Error( "can only multiply ideals in a common ring\n" );
    fi;
    
    genI := MatrixOfSubobjectGenerators( I );
    genJ := MatrixOfSubobjectGenerators( J );
    
    return Subobject( KroneckerMat( genI, genJ ), super );
    
end );

##
InstallOtherMethod( POW,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsInt ],
        
  function( I, pow )
    local R;
    
    R := HomalgRing( I );
    
    if pow < 0 then
        
        Error( "negative powers are not defined\n" );
        
    elif pow = 0 then
        
        return FullSubobject( SuperObject( I ) );
        
    elif pow = 1 then
        
        return I;
        
    else
        
        return Iterated( ListWithIdenticalEntries( pow, I ), \* );
        
    fi;
    
end );

##
InstallMethod( IsSubset,
        "for homalg submodules",
        [ IsHomalgModule, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )	## GAP-standard: is J a subset of K
    local M, mapJ, mapK, rel, div;
    
    M := SuperObject( J );
    
    if not IsFinitelyPresentedSubmoduleRep( K ) then
        return IsIdenticalObj( M, K );
    fi;
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    mapJ := MatrixOfSubobjectGenerators( J );
    mapK := MatrixOfSubobjectGenerators( K );
    
    rel := RelationsOfModule( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( J ) then;
        div := RightDivide( mapJ, mapK, rel );
    else
        div := LeftDivide( mapK, mapJ, rel );
    fi;
    
    return not IsBool( div );
    
end );

##
InstallMethod( \=,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsHomalgRing ],
        
  function( J, R )
    
    if not IsIdenticalObj( HomalgRing( J ), R ) then
        Error( "the given ring and the ring of the submodule are not identical\n" );
    fi;
    
    return IsSubset( J, FullSubobject( SuperObject( J ) ) );
    
end );

##
InstallMethod( \=,
        "for homalg submodules",
        [ IsHomalgRing, IsFinitelyPresentedSubmoduleRep ],
        
  function( R, J )
    
    return J = R;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( \*,
        "for homalg submodules",
        [ IsHomalgRing, IsFinitelyPresentedSubmoduleRep ], 10001,
        
  function( R, M )
    
    return ImageSubobject( R * OnAFreeSource( MapHavingSubobjectAsItsImage( M ) ) );
    
end );

##  <#GAPDoc Label="Subobject:matrix">
##  <ManSection>
##    <Oper Arg="mat,M" Name="Subobject" Label="constructor for submodules using matrices"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated left/right submodule of the &homalg; module <A>M</A> with generators given by the
##      rows/columns of the &homalg; matrix <A>mat</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Subobject,
        "constructor for homalg submodules",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( gen, M )
    local gen_map;
    
    if not IsIdenticalObj( HomalgRing( gen ), HomalgRing( M ) ) then
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
    
    gen_map := HomalgMap( gen, "free", M  );
    
    return ImageSubobject( gen_map );
    
end );

##  <#GAPDoc Label="Subobject:list">
##  <ManSection>
##    <Oper Arg="gens,M" Name="Subobject" Label="constructor for submodules using a list of ring elements"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated left/right submodule of the &homalg; cyclic left/right module <A>M</A>
##      with generators given by the entries of the list <A>gens</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Subobject,
        "constructor for homalg submodules",
        [ IsList, IsFinitelyPresentedModuleRep ],
        
  function( gens, M )
    local l, R, mat;
    
    if NrGenerators( M ) <> 1 then
        Error( "the given module is either not cyclic or not presented on a cyclic generator\n" );
    fi;
    
    l := Length( gens );
    
    if l = 0 then
        return FullSubobject( M );
    fi;
    
    if not ForAll( gens, IsRingElement ) then
        Error( "all entries of the list must be ring elements\n" );
    fi;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        mat := HomalgMatrix( gens, l, 1, R );
    else
        mat := HomalgMatrix( gens, 1, l, R );
    fi;
    
    return Subobject( mat, M );
    
end );

##
InstallMethod( Subobject,	## in case the methods below do not apply
        "constructor for homalg submodules",
        [ IsHomalgRelations, IsFinitelyPresentedModuleRep ],
        
  function( rel, M )
    
    Error( "the set of relations and the module should either be both left or both right\n" );
    
end );

##
InstallMethod( Subobject,
        "constructor for homalg submodules",
        [ IsHomalgRelations and IsHomalgRelationsOfRightModule, IsFinitelyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( rel, M )
    
    return Subobject( MatrixOfRelations( rel ), M );
    
end );

##
InstallMethod( Subobject,
        "constructor for homalg submodules",
        [ IsHomalgRelations and IsHomalgRelationsOfLeftModule, IsFinitelyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( rel, M )
    
    return Subobject( MatrixOfRelations( rel ), M );
    
end );

##  <#GAPDoc Label="LeftSubmodule">
##  <ManSection>
##    <Oper Arg="mat" Name="LeftSubmodule" Label="constructor for left submodules"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated left submodule with generators given by the
##      rows of the &homalg; matrix <A>mat</A>.
##      <Listing Type="Code"><![CDATA[
InstallMethod( LeftSubmodule,
        "constructor for homalg submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, NrColumns( gen ) * R );
    
end );
##  ]]></Listing>
##      <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegers( ) / 4;
##  <A homalg residue class ring>
##  gap> I := HomalgMatrix( "[ 2 ]", 1, 1, Z4 );
##  <A homalg residue class 1 by 1 matrix>
##  gap> I := LeftSubmodule( I );
##  <A principal torsion-free (left) ideal given by a cyclic generator>
##  gap> IsFree( I );
##  false
##  gap> I;
##  <A principal reflexive non-projective (left) ideal given by a cyclic generator\
##  >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( LeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgRing ],
        
  function( R )
    
    return FullSubobject( 1 * R );
    
end );

##
InstallMethod( LeftSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local R;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    R := HomalgRing( gen[1] );
    
    return LeftSubmodule( HomalgMatrix( gen, Length( gen ), 1, R ) );
    
end );

##
InstallMethod( LeftSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    if gen = [ ] then
        return FullSubobject( 1 * R );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, R );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return LeftSubmodule( HomalgMatrix( Gen, Length( Gen ), 1, R ) );
    
end );

##
InstallMethod( LeftSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return LeftSubmodule( SplitString( Gen, "," ), R );
    
end );

##  <#GAPDoc Label="RightSubmodule">
##  <ManSection>
##    <Oper Arg="mat" Name="RightSubmodule" Label="constructor for right submodules"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated right submodule with generators given by the
##      columns of the &homalg; matrix <A>mat</A>.
##      <Listing Type="Code"><![CDATA[
InstallMethod( RightSubmodule,
        "constructor for homalg submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, R * NrRows( gen ) );
    
end );
##  ]]></Listing>
##      <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegers( ) / 4;
##  <A homalg residue class ring>
##  gap> I := HomalgMatrix( "[ 2 ]", 1, 1, Z4 );
##  <A homalg residue class 1 by 1 matrix>
##  gap> I := RightSubmodule( I );
##  <A principal torsion-free (right) ideal given by a cyclic generator>
##  gap> IsFree( I );
##  false
##  gap> I;
##  <A principal reflexive non-projective (right) ideal given by a cyclic generato\
##  r>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( RightSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgRing ],
        
  function( R )
    
    return FullSubobject( R * 1 );
    
end );

##
InstallMethod( RightSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local R;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    R := HomalgRing( gen[1] );
    
    return RightSubmodule( HomalgMatrix( gen, 1, Length( gen ), R ) );
    
end );

##
InstallMethod( RightSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    if gen = [ ] then
        return FullSubobject( R * 1 );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, R );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return RightSubmodule( HomalgMatrix( Gen, 1, Length( Gen ), R ) );
    
end );

##
InstallMethod( RightSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return RightSubmodule( SplitString( Gen, "," ), R );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, ( NrColumns( gen ) * R )^0 );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgRing ],
        
  function( R )
    
    return GradedLeftSubmodule( HomalgIdentityMatrix( 1, R ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local R;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    R := HomalgRing( gen[1] );
    
    return GradedLeftSubmodule( HomalgMatrix( gen, Length( gen ), 1, R ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    if gen = [ ] then
        return GradedLeftSubmodule( R );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, R );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return GradedLeftSubmodule( HomalgMatrix( Gen, Length( Gen ), 1, R ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return GradedLeftSubmodule( SplitString( Gen, "," ), R );
    
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
        [ IsHomalgRing ],
        
  function( R )
    
    return GradedRightSubmodule( HomalgIdentityMatrix( 1, R ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local R;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    R := HomalgRing( gen[1] );
    
    return GradedRightSubmodule( HomalgMatrix( gen, 1, Length( gen ), R ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    if gen = [ ] then
        return GradedRightSubmodule( R );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, R );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return GradedRightSubmodule( HomalgMatrix( Gen, 1, Length( Gen ), R ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgRing ],
        
  function( gen, R )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return GradedRightSubmodule( SplitString( Gen, "," ), R );
    
end );

##
InstallMethod( LeftIdealOfMinors,
        "constructor for homalg ideals",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    
    return LeftSubmodule( Minors( d, M ) );
    
end );

##
InstallMethod( LeftIdealOfMaximalMinors,
        "constructor for homalg ideals",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return LeftSubmodule( MaximalMinors( M ) );
    
end );

##
InstallMethod( RightIdealOfMinors,
        "constructor for homalg ideals",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    
    return RightSubmodule( Minors( d, M ) );
    
end );

##
InstallMethod( RightIdealOfMaximalMinors,
        "constructor for homalg ideals",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return RightSubmodule( MaximalMinors( M ) );
    
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

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep and IsFree ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( J )
    local M, left, R, r, rk, l;
    
    M := UnderlyingObject( J );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    R := HomalgRing( M );
    
    Print( "<A " );
    
    if IsList( DegreesOfGenerators( M ) ) then
        Print( "graded " );
    fi;
    
    if left then
        if ConstructedAsAnIdeal( J ) then
            Print( "principal " );
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(left) " );
            else
                Print( "left " );
            fi;
            Print( "ideal" );
        else
            Print( "free left submodule" );
        fi;
    else
        if ConstructedAsAnIdeal( J ) then
            Print( "principal " );
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(right) " );
            else
                Print( "right " );
            fi;
            Print( "ideal" );
        else
            Print( "free right submodule" );
        fi;
    fi;
    
    r := NrGenerators( M );
    
    if HasRankOfModule( M ) then
        rk := RankOfModule( M );
        Print( " of rank ", rk, " given by " );
        if r = rk then
            if r = 1 then
                Print( "a free generator" );
            else
                Print( "free generators" );
            fi;
        else ## => r > 1
            Print( r, " non-free generators" );
            if HasNrRelations( M ) = true then
                l := NrRelations( M );
                Print( " satisfying " );
                if l = 1 then
                    Print( "a single relation" );
                else
                    Print( l, " relations" );
                fi;
            fi;
        fi;
    else
        if r = 1 then
            Print( " given by a cyclic generator"  );
        else
            Print( " given by ", r, " generators"  );
        fi;
        if HasNrRelations( M ) = true then
            l := NrRelations( M );
            Print( " satisfying " );
            if l = 1 then
                Print( "a single relation" );
            else
                Print( l, " relations" );
            fi;
        fi;
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep and IsZero ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( J )
    local M, left, R, r, rk;
    
    M := UnderlyingObject( J );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    R := HomalgRing( M );
    
    Print( "<The zero " );
    
    if left then
        Print( "(left) " );
    else
        Print( "(right) " );
    fi;
    
    if ConstructedAsAnIdeal( J ) then
        Print( "ideal" );
    else
        Print( "submodule" );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    local R, gen, l;
    
    R := HomalgRing( M );
    
    gen := MatrixOfSubobjectGenerators( M );
    
    Display( gen );
    
    if IsList( DegreesOfGenerators( SuperObject( M ) ) ) then
        if IsList( DegreesOfGenerators( M ) ) then
            Print( "\n(graded, generators degrees: ", DegreesOfGenerators( M ), ")\n" );
        fi;
    fi;
    
    Print( "\nA " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        l := NrRows( gen );
        if ConstructedAsAnIdeal( M ) then
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(left)" );
            else
                Print( "left" );
            fi;
            Print( " ideal generated by the " );
            if l = 1 then
                Print( "entry" );
            else
                Print( l, " entries" );
            fi;
        else
            Print( "left submodule generated by the " );
            if l = 1 then
                Print( "row" );
            else
                Print( l, " rows" );
            fi;
        fi;
        Print( " of the above matrix\n" );
    else
        l := NrColumns( gen );
        if ConstructedAsAnIdeal( M ) then
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(right)" );
            else
                Print( "right" );
            fi;
            Print( " ideal generated by the " );
            if l = 1 then
                Print( "entry" );
            else
                Print( l, " entries" );
            fi;
        else
            Print( "right submodule generated by the " );
            if l = 1 then
                Print( "column" );
            else
                Print( l, " columns" );
            fi;
        fi;
        Print( " of the above matrix\n" );
    fi;
    
end );

