#############################################################################
##
##  HomalgMap.gi                Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for homalg maps ( = module homomorphisms ).
##
#############################################################################

##  <#GAPDoc Label="Maps:intro">
##    A &homalg; map is a data structures for maps (module homomorphisms) between finitely generated modules.
##    Each map in &homalg; knows its source (&see; <Ref BookName="homalg" Attr="Source"/>) and its target
##    (&see; <Ref BookName="homalg" Attr="Range"/>). A map is represented by a &homalg; matrix relative to the
##    current set of generators of the source resp. target &homalg; module. As with modules
##    (&see; Chapter <Ref Chap="Modules"/>), maps in &homalg; are realized in an intrinsic manner:
##    If the presentations of the source or/and target module are altered after the map was constructed,
##    a new adapted representation matrix of the map is automatically computed whenever needed.
##    For this the internal transition matrices of the modules are used. &homalg; uses the so-called
##    <E>associative</E> convention for maps. This means that maps of left modules are applied
##    from the right, whereas maps of right modules from the left.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsMapOfFinitelyGeneratedModulesRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsMapOfFinitelyGeneratedModulesRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of maps between finitley generated &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref BookName="homalg" Filt="IsHomalgChainMap"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsStaticMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsMapOfFinitelyGeneratedModulesRep",
        IsHomalgMap and IsStaticMorphismOfFinitelyGeneratedObjectsRep,
        [ "source", "target", "matrices", "index_pairs_of_presentations" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgMaps",
        NewFamily( "TheFamilyOfHomalgMaps" ) );

# four new types:
BindGlobal( "TheTypeHomalgMapOfLeftModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgMapOfRightModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgSelfMapOfLeftModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgSelfMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSelfMapOfRightModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgSelfMap and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="HomalgRing:map">
##  <ManSection>
##    <Oper Arg="phi" Name="HomalgRing"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The &homalg; ring of the &homalg; map <A>phi</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <An internal ring>
##  gap> phi := HomalgIdentityMap( 2 * ZZ );
##  <The identity morphism of a left module>
##  gap> R := HomalgRing( phi );
##  <An internal ring>
##  gap> IsIdenticalObj( R, ZZ );
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgRing,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( phi )
    
    return HomalgRing( Source( phi ) );
    
end );

##
InstallMethod( homalgResetFilters,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( cm )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfMaps ) then
        HOMALG.PropertiesOfMaps :=
          [ IsZero,
            IsMorphism,
            IsGeneralizedMorphism,
            IsSplitMonomorphism,
            IsMonomorphism,
            IsGeneralizedMonomorphism,
            IsSplitEpimorphism,
            IsEpimorphism,
            IsGeneralizedEpimorphism,
            IsIsomorphism,
            IsGeneralizedIsomorphism ];
    fi;
    
    for property in HOMALG.PropertiesOfMaps do
        ResetFilterObj( cm, property );
    od;
    
end );

##
InstallMethod( DegreeOfMorphism,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( phi )
    
    return 0;
    
end );

## provided to avoid branching in the code and always returns fail
InstallMethod( PositionOfTheDefaultPresentation,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( M )
    
    return fail;
    
end );

##
InstallMethod( PairOfPositionsOfTheDefaultPresentations,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultPresentation( Source( phi ) );
    pos_t := PositionOfTheDefaultPresentation( Range( phi ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        return [ pos_s, pos_t ];
    else
        return [ pos_t, pos_s ];
    fi;
    
end );

##
InstallMethod( MatrixOfMap,		## FIXME: make this optimal by finding shortest ways
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsInt, IsInt ],
        
  function( phi, _pos_s, _pos_t )
    local pos_s, pos_t, index_pair, l, dist, min, pos, matrix;
    
    if _pos_s < 1 then
        pos_s := PositionOfTheDefaultPresentation( Source( phi ) );
    else
        pos_s := _pos_s;
    fi;
    
    if _pos_t < 1 then
        pos_t := PositionOfTheDefaultPresentation( Range( phi ) );
    else
        pos_t := _pos_t;
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        index_pair := [ pos_s, pos_t ];
    else
        index_pair := [ pos_t, pos_s ];
    fi;
    
    l := phi!.index_pairs_of_presentations;
    
    if not index_pair in l then
        
        dist := List( l, a -> AbsInt( index_pair[1] - a[1] ) + AbsInt( index_pair[2] - a[2] ) );
        
        min := Minimum( dist );
        
        pos := PositionProperty( dist, a -> a = min );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
            matrix :=
              TransitionMatrix( Source( phi ), pos_s, l[pos][1] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( Range( phi ), l[pos][2], pos_t );
        else
            matrix :=
              TransitionMatrix( Range( phi ), pos_t, l[pos][1] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( Source( phi ), l[pos][2], pos_s );
        fi;
        
        phi!.matrices.( String( index_pair ) ) := matrix;
        
        Add( l, index_pair );
        
    fi;
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        return phi!.reduced_matrices.( String( index_pair ) );
    else
        return phi!.matrices.( String( index_pair ) );
    fi;
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgSelfMap, IsPosInt ],
        
  function( phi, pos_s_t )
    
    return MatrixOfMap( phi, pos_s_t, pos_s_t );
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return MatrixOfMap( phi, 0, 0 );
    
end );

##
InstallMethod( \=,
        "for two comparable homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    if HasMorphismAid( phi1 ) then
        if not HasMorphismAid( phi2 ) or
           MorphismAid( phi1 ) <> MorphismAid( phi2 ) then
            return false;
        fi;
    elif HasMorphismAid( phi2 ) then
        if not HasMorphismAid( phi1 ) or
           MorphismAid( phi1 ) <> MorphismAid( phi2 ) then
            return false;
        fi;
    fi;
    
    ## don't use phi1 - phi2 since FunctorObj will then cause an infinite loop
    phi := HomalgMap( MatrixOfMap( phi1 ) - MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    ## this takes care of the relations of the target module
    return IsZero( phi );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( 0 * MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return MinusOne( HomalgRing( phi ) ) * phi;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    BasisOfModule( Source( phi ) );
    BasisOfModule( Range( phi ) );
    
    return phi;
    
end );

##
InstallMethod( DecideZero,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local rel, index_pair, matrix, reduced;
    
    rel := RelationsOfModule( Range( phi ) );
    
    index_pair := PairOfPositionsOfTheDefaultPresentations( phi );
    
    matrix := MatrixOfMap( phi );
    
    reduced := DecideZero( matrix, rel );
    
    if not HasIsZero( phi ) then
        SetIsZero( phi, IsZero( reduced ) );
    fi;
    
    if reduced = matrix then
        reduced := matrix;
    else
        phi!.matrices.(String( index_pair )) := reduced;
    fi;
    
    phi!.reduced_matrices.(String( index_pair )) := reduced;
    
    return phi;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    OnLessGenerators( Source( phi ) );
    OnLessGenerators( Range( phi ) );
    
    return phi;
    
end );

##
InstallMethod( UnionOfRelations,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return UnionOfRelations( MatrixOfMap( phi ), Range( phi ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local syz;
    
    syz := SyzygiesGenerators( MatrixOfMap( phi ), Range( phi ) );
    
    if NrRelations( syz ) = 0 then
        SetIsMonomorphism( phi, true );
    fi;
    
    if IsList( DegreesOfGenerators( Source( phi ) ) ) then
        syz!.DegreesOfGenerators := DegreesOfGenerators( Source( phi ) );
    fi;
    
    return syz;
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local syz;
    
    syz := ReducedSyzygiesGenerators( MatrixOfMap( phi ), Range( phi ) );
    
    if NrRelations( syz ) = 0 then
        SetIsMonomorphism( phi, true );
    fi;
    
    if IsList( DegreesOfGenerators( Source( phi ) ) ) then
        syz!.DegreesOfGenerators := DegreesOfGenerators( Source( phi ) );
    fi;
    
    return syz;
    
end );

##
InstallMethod( Preimage,
        "for a matrix and a homalg map",
        [ IsHomalgMatrix, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( m, phi )
    local M, rel, mat;
    
    M := Range( phi );
    
    rel := MatrixOfRelations( M );
    
    mat := MatrixOfMap( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        return RightDivide( m, mat, rel );
    else
        return LeftDivide( m, mat, rel );
    fi;
    
end );

##
InstallMethod( SuccessivePreimages,
        "for a matrix and a homalg selfmap",
        [ IsHomalgMatrix, IsHomalgSelfMap and IsMapOfFinitelyGeneratedModulesRep ],
        
  function( m, phi )
    local preimages, pre, n;
    
    preimages := [ m ];
    
    pre := Preimage( m, phi );
    
    while IsHomalgMatrix( pre ) do
        
        Add( preimages, pre );
        
        n := Length( preimages );
        
        pre := Preimage( preimages[n], phi );
        
    od;
    
    return preimages;
    
end );

##  <#GAPDoc Label="PreInverse">
##  <ManSection>
##    <Oper Arg="phi" Name="PreInverse"/>
##    <Returns>a &homalg; map, <C>false</C>, or <C>fail</C></Returns>
##    <Description>
##      Compute a pre-inverse of the morphism <A>phi</A> in case one exists.
##      For a pre-inverse to exist <A>phi</A> must be an epimorphism. For <E>commutative</E> rings
##      &homalg; has an algorithm installed which decides the existence and returns
##      a pre-inverse in case one exists. If a pre-inverse does not exist then <C>false</C>
##      is returned. The algorithm finds a particular solution of a two-side inhomogeneous linear system
##      over <M>R := </M><C>HomalgRing</C><M>( <A>phi</A> )</M>.
##      For <E>non</E>commutative rings a heuristic method is installed. If it
##      finds a pre-inverse it returns it, otherwise it returns <C>fail</C>
##      (&see; <Ref Label="Modules-limitation" Text="Principal limitation"/>).
##      The operation <C>PreInverse</C> is used to install a method for the property
##      <Ref BookName="homalg" Prop="IsSplitEpimorphism"/>. <P/>
##      <C>PreInverse</C> checks if it can decide the projectivity of <C>Range</C><M>( <A>phi</A> )</M>.
##      To decide the projectivity of a module <M>M</M> over a <E>commutative</E> ring you can use <Br/><Br/>
##      
##      <C>IsSplitEpimorphism</C>( <C>FreeHullEpi</C><M>( M )</M> ); <Br/><Br/>
##      
##      Of course you can use <C>IsProjective</C><M>( M )</M> which triggers other methods.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( PreInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local R, S, T, M, p, Ib, Ic, b, c, P, d, Id, PI, B, A, L, sigma;
    
    ## no need to search for phi!.PreInverse
    ## as this is not the highest priority method
    
    R := HomalgRing( phi );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        TryNextMethod( );
    fi;
    
    S := Source( phi );
    T := Range( phi );
    
    M := MatrixOfRelations( ReducedBasisOfModule( S ) );
    
    p := MatrixOfMap( phi );
    
    #=====# begin of the core procedure #=====#
    
    Ib := MatrixOfMap( TheIdentityMorphism( S ) );
    Ic := MatrixOfMap( TheIdentityMorphism( T ) );
    
    b := NrRows( Ib );
    c := NrRows( Ic );
    
    P := ReducedBasisOfModule( T );
    
    d := NrRelations( P );
    Id := HomalgIdentityMatrix( d, R );
    
    P := MatrixOfRelations( P );
    
    PI := Involution( P );
    
    B := EntriesOfHomalgMatrix( Ic );
    
    B := Concatenation( ListWithIdenticalEntries( b * d, Zero( R ) ), B );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        B := HomalgMatrix( B, 1, b * d + c * c, R );
        A := UnionOfColumns( KroneckerMat( PI, Ib ), KroneckerMat( Ic, p ) );
        L := DiagMat( [ KroneckerMat( Id, M ), KroneckerMat( Ic, P ) ] );
        sigma := RightDivide( B, A, L );
    else
        B := HomalgMatrix( B, b * d + c * c, 1, R );
        A := UnionOfRows( KroneckerMat( Ib, PI ), KroneckerMat( p, Ic ) );
        L := DiagMat( [ KroneckerMat( M, Id ), KroneckerMat( P, Ic ) ] );
        sigma := LeftDivide( A, B, L );
    fi;
    
    if IsBool( sigma ) then	## no split
        
        ## from a method below we already know that phi is an epimorphism
        if IsEpimorphism( phi ) then	## to be sure ;)
            ## so T is not projective since phi is not split
            SetIsProjective( T, false );
        fi;
        
        phi!.PreInverse := false;
        
        return phi!.PreInverse;
        
    fi;
    
    ## we already have every thing to build the (matrix of the) split sigma
    
    sigma := EntriesOfHomalgMatrix( sigma );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        sigma := HomalgMatrix( sigma, c, b, R );
    else
        sigma := HomalgMatrix( sigma, b, c, R );
    fi;
    
    sigma := HomalgMap( sigma, T, S );
    
    DecideZero( sigma );
    
    Assert( 1, IsMonomorphism( sigma ) );
    
    SetIsSplitEpimorphism( phi, true );
    SetIsSplitMonomorphism( sigma, true );
    
    ## a direct summand of a projective module is again projective
    if HasIsProjective( S ) and IsProjective( S ) then
        SetIsProjective( T, true );
    fi;
    
    phi!.PreInverse := sigma;
    
    return phi!.PreInverse;
    
end );

##
InstallMethod( PreInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local S, T, sigma;
    
    if IsBound(phi!.PreInverse) then
        return phi!.PreInverse;
    fi;
    
    S := Source( phi );
    T := Range( phi );
    
    if not IsEpimorphism( phi ) then
        
        return false;
        
    elif IsIsomorphism( phi ) then
        
        ## only in case the standard method for IsIsomorphism wasn't triggered:
        UpdateObjectsByMorphism( phi );
        
        phi!.PreInverse := phi ^ -1;
        
        return phi!.PreInverse;
        
    fi;
    
    DecideZero( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        sigma := LeftInverse( MatrixOfMap( phi ) );
    else
        sigma := RightInverse( MatrixOfMap( phi ) );
    fi;
    
    ## this must come before any Eval:
    if HasIsZero( sigma ) and IsZero( sigma ) then
        
        SetIsZero( T, true );
        
        phi!.PreInverse := TheZeroMorphism( T, S );
        
        return phi!.PreInverse;
        
    fi;
    
    ## Left/RightInverse are lazy evaluated!
    if IsBool( Eval( sigma ) ) then	## no split even on the level of matrices
        
        ## from above we already know that phi is an epimorphism,
        ## so T is not projective since phi is not split
        SetIsProjective( T, false );
        
        phi!.PreInverse := false;
        
        return phi!.PreInverse;
        
    fi;
    
    sigma := HomalgMap( sigma, Range( phi ), Source( phi ) );
    
    if IsMorphism( sigma ) then
        
        DecideZero( sigma );
        
        Assert( 1, IsMonomorphism( sigma ) );
        
        SetIsSplitEpimorphism( phi, true );
        SetIsSplitMonomorphism( sigma, true );
        
        ## a direct summand of a projective module is again projective
        if HasIsProjective( S ) and IsProjective( S ) then
            SetIsProjective( T, true );
        fi;
        
        phi!.PreInverse := sigma;
        
        return phi!.PreInverse;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PostInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local inv;
    
    if not IsMonomorphism( phi ) then
        return false;
    elif IsIsomorphism( phi ) then
        return phi ^ -1;
    fi;
    
    DecideZero( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        inv := RightInverse( MatrixOfMap( phi ) );
    else
        inv := LeftInverse( MatrixOfMap( phi ) );
    fi;
    
    ## this must come before any Eval:
    if HasIsZero( inv ) and IsZero( inv ) then
        return TheZeroMorphism( Range( phi ), Source( phi ) );
    fi;
    
    if IsBool( Eval( inv ) ) then
        return false;
    fi;
    
    inv := HomalgMap( inv, Range( phi ), Source( phi ) );
    
    if IsMorphism( inv ) then
        
        Assert( 1, IsEpimorphism( inv ) );
        SetIsEpimorphism( inv, true );
        
        DecideZero( inv );
        
        SetIsSplitMonomorphism( phi, true );
        SetIsSplitEpimorphism( inv, true );
        
        return inv;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgMap">
##  <ManSection>
##    <Func Arg="mat, M, N" Name="HomalgMap" Label="constructor for maps"/>
##    <Func Arg="mat[, string]" Name="HomalgMap" Label="constructor for maps between free modules"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      This constructor returns a map (homomorphism) of finitely presented modules. It is represented by the
##      &homalg; matrix <A>mat</A> relative to the current set of generators of the source &homalg; module <A>M</A>
##      and target module <A>N</A> (&see; <Ref Sect="Modules:Constructors"/>). Unless the source module is free
##      <E>and</E> given on free generators the returned map will cautiously be indicated using
##      parenthesis: <Q>homomorphism</Q>. To verify if the result is indeed a well defined map use
##      <Ref BookName="homalg" Prop="IsMorphism"/>. If the presentations of the source or/and
##      target module are altered after the map was constructed, a new adapted representation matrix of the map is
##      automatically computed whenever needed. For this the internal transition matrices of the modules are used.
##      If source and target are identical objects, and only then, the map is created as a selfmap (endomorphism).
##      &homalg; uses the so-called <E>associative</E> convention for maps. This means that maps of left modules are
##      applied from the right, whereas maps of right modules from the left.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A 2 x 3 matrix over an internal ring>
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );
##  <A 2 x 4 matrix over an internal ring>
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -2, -4, \
##  > 0, 1,  4,  7, \
##  > 1, 0, -2, -4  \
##  > ]", 3, 4, ZZ );;
##  <A 3 x 4 matrix over an internal ring>
##  gap> phi := HomalgMap( mat, M, N );
##  <A "homomorphism" of left modules>
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> Display( phi );
##  [ [   1,   0,  -2,  -4 ],
##    [   0,   1,   4,   7 ],
##    [   1,   0,  -2,  -4 ] ]
##  
##  the map is currently represented by the above 3 x 4 matrix
##  gap> ByASmallerPresentation( M );
##  <A rank 1 left module presented by 1 relation for 2 generators>
##  gap> Display( last );
##  Z/< 3 > + Z^(1 x 1)
##  gap> Display( phi );
##  [ [   2,   1,   0,  -1 ],
##    [   1,   0,  -2,  -4 ] ]
##  
##  the map is currently represented by the above 2 x 4 matrix
##  gap> ByASmallerPresentation( N );
##  <A rank 2 left module presented by 1 relation for 3 generators>
##  gap> Display( N );
##  Z/< 4 > + Z^(1 x 2)
##  gap> Display( phi );
##  [ [  -8,   0,   0 ],
##    [  -3,  -1,  -2 ] ]
##  
##  the map is currently represented by the above 2 x 3 matrix
##  gap> ByASmallerPresentation( phi );
##  <A non-zero homomorphism of left modules>
##  gap> Display( phi );
##  [ [   0,   0,   0 ],
##    [   1,  -1,  -2 ] ]
##  
##  the map is currently represented by the above 2 x 3 matrix
##  ]]></Example>
##  To construct a map with source being a not yet specified free module
##      <Example><![CDATA[
##  gap> N;
##  <A rank 2 left module presented by 1 relation for 3 generators>
##  gap> SetPositionOfTheDefaultSetOfGenerators( N, 1 );
##  gap> N;
##  <A rank 2 left module presented by 2 relations for 4 generators>
##  gap> psi := HomalgMap( mat, "free", N );
##  <A homomorphism of left modules>
##  gap> Source( psi );
##  <A free left module of rank 3 on free generators>
##  ]]></Example>
##  To construct a map between not yet specified free left modules
##      <Example><![CDATA[
##  gap> chi := HomalgMap( mat );	## or chi := HomalgMap( mat, "l" );
##  <A homomorphism of left modules>
##  gap> Source( chi );
##  <A free left module of rank 3 on free generators>
##  gap> Range( chi );
##  <A free left module of rank 4 on free generators>
##  ]]></Example>
##  To construct a map between not yet specified free right modules
##      <Example><![CDATA[
##  gap> kappa := HomalgMap( mat, "r" );
##  <A homomorphism of right modules>
##  gap> Source( kappa );
##  <A free right module of rank 4 on free generators>
##  gap> Range( kappa );
##  <A free right module of rank 3 on free generators>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgMap,
  function( arg )
    local nargs, source, pos_s, target, pos_t, R, type, matrix, left, matrices, reduced_matrices,
          mat, degrees_t, degrees_s, nr_rows, nr_columns, index_pair, morphism, option;
    
    nargs := Length( arg );
    
    if IsHomalgRelations( arg[1] ) then
        mat := MatrixOfRelations( arg[1] );
        
        ## take care of the degrees of generators of source and target module
        if IsList( DegreesOfGenerators( arg[1] ) ) then
            degrees_t := DegreesOfGenerators( arg[1] );
            if IsHomalgRelationsOfLeftModule( arg[1] ) then
                if IsZero( mat ) then
                    degrees_s := ListWithIdenticalEntries( NrRows( mat ), -1 );
                else
                    degrees_s := NonTrivialDegreePerRow( mat, degrees_t );
                fi;
            else
                if IsZero( mat ) then
                    degrees_s := ListWithIdenticalEntries( NrColumns( mat ), -1 );
                else
                    degrees_s := NonTrivialDegreePerColumn( mat, degrees_t );
                fi;
            fi;
        fi;
    fi;
    
    if nargs > 1 then
        if IsHomalgModule( arg[2] ) then
            source := arg[2];
            pos_s := PositionOfTheDefaultPresentation( source );
        elif arg[2] = "free" and nargs > 2 and IsHomalgModule( arg[3] )
          and ( IsHomalgMatrix( arg[1] ) or IsHomalgRelations( arg[1] ) ) then
            if IsHomalgMatrix( arg[1] ) then
                mat := arg[1];
            fi;
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( arg[3] ) then
                if IsBound( degrees_s )  then
                    source := HomalgFreeLeftModuleWithDegrees( HomalgRing( arg[3] ), degrees_s );
                else
                    nr_rows := NrRows( mat );
                    source := HomalgFreeLeftModule( nr_rows, HomalgRing( arg[3] ) );
                fi;
            else
                if IsBound( degrees_s )  then
                    source := HomalgFreeRightModuleWithDegrees( HomalgRing( arg[3] ), degrees_s );
                else
                    nr_columns := NrColumns( mat );
                    source := HomalgFreeRightModule( nr_columns, HomalgRing( arg[3] ) );
                fi;
            fi;
            pos_s := PositionOfTheDefaultPresentation( source );
        elif IsHomalgRing( arg[2] ) and not ( IsList( arg[1] ) and nargs = 2 ) then
            source := "ring";
        elif IsList( arg[2] ) and IsHomalgModule( arg[2][1] ) and IsPosInt( arg[2][2] ) then
            source := arg[2][1];
            pos_s := arg[2][2];
            if not IsBound( SetsOfRelations( source )!.( pos_s ) ) then
                Error( "the source module does not possess a ", arg[2][2], ". set of relations (this positive number is given as the second entry of the list provided as the second argument)\n" );
            fi;
        fi;
    fi;
    
    if not IsBound( source ) then
        
        if IsHomalgMatrix( arg[1] ) then
            ResetFilterObj( arg[1], IsMutableMatrix );
            matrix := arg[1];
        elif IsHomalgRelations( arg[1] ) then
            matrix := MatrixOfRelations( arg[1] );
            left := IsHomalgRelationsOfLeftModule( arg[1] );
        elif IsHomalgRing( arg[nargs] ) then
            matrix := HomalgMatrix( arg[1], arg[nargs] );
        else
            Error( "The second argument must be the source module or the last argument should be an IsHomalgRing\n" );
        fi;
        
        R := HomalgRing( matrix );
        
        if nargs > 1 and IsStringRep( arg[2] ) and Length( arg[2] ) > 0
           and  LowercaseString( arg[2]{[1..1]} ) = "r" then
            left := false;	## we explicitly asked for a morphism of right modules
        elif not IsBound( left ) then
            left := true;
        fi;
        
        if left then
            if IsBound( degrees_s ) then
                source := HomalgFreeLeftModuleWithDegrees( R, degrees_s );
                target := HomalgFreeLeftModuleWithDegrees( R, degrees_t );
            else
                source := HomalgFreeLeftModule( NrRows( matrix ), R );
                target := HomalgFreeLeftModule( NrColumns( matrix ), R );
            fi;
            type := TheTypeHomalgMapOfLeftModules;
        else
            if IsBound( degrees_s ) then
                source := HomalgFreeRightModuleWithDegrees( R, degrees_s );
                target := HomalgFreeRightModuleWithDegrees( R, degrees_t );
            else
                source := HomalgFreeRightModule( NrColumns( matrix ), R );
                target := HomalgFreeRightModule( NrRows( matrix ), R );
            fi;
            type := TheTypeHomalgMapOfRightModules;
        fi;
        
        matrices := rec( );
        
        morphism := rec( 
                         matrices := matrices,
                         reduced_matrices := rec( ),
                         free_resolutions := rec( ),
                         index_pairs_of_presentations := [ [ 1, 1 ] ]);
        
        matrices.( String( [ 1, 1 ] ) ) := matrix;
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                Source, source,
                Range, target );
        
        if ( HasNrRelations( source ) = true and NrRelations( source ) = 0 ) then
            SetIsMorphism( morphism, true );
        fi;
        
        if IsBound( degrees_s ) then
            SetDegreeOfMorphism( morphism, 0 );
        fi;
        
        if HasIsZero( source ) and IsZero( source ) then
            SetIsGeneralizedMonomorphism( morphism, true );	## we don't know yet if IsMorhphism( morphism ) = true
        fi;
        
        if HasIsZero( target ) and IsZero( target ) then
            SetIsGeneralizedEpimorphism( morphism, true );	## we don't know yet if IsMorhphism( morphism ) = true
        fi;
        
        return morphism;
        
    fi;
    
    if nargs > 2 then
        if IsHomalgModule( arg[3] ) then
            target := arg[3];
            pos_t := PositionOfTheDefaultPresentation( target );
        elif arg[3] = "free" and IsHomalgModule ( source )
          and ( IsHomalgMatrix( arg[1] ) or IsHomalgRelations( arg[1] ) ) then
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) then
                if IsHomalgMatrix( arg[1] ) then
                    nr_columns := NrColumns( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_columns := NrColumns( MatrixOfRelations( arg[1] ) );
                fi;
                target := HomalgFreeLeftModule( nr_columns, HomalgRing( arg[1] ) );
            else
                if IsHomalgMatrix( arg[1] ) then
                    nr_rows := NrRows( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_rows := NrRows( MatrixOfRelations( arg[1] ) );
                fi;
                target := HomalgFreeRightModule( nr_rows, HomalgRing( arg[1] ) );
            fi;
            pos_t := PositionOfTheDefaultPresentation( target );
        elif IsHomalgRing( arg[3] ) then
            if source = "ring" then
                source := HomalgFreeLeftModule( 1, arg[2] );
                if not IsIdenticalObj( arg[2], arg[3] ) then
                    Error( "the source and target modules must be defined over the same ring\n" );
                fi;
                target := source;	## we get an endomorphism
                pos_s := PositionOfTheDefaultPresentation( source );
                pos_t := pos_s;
            else
                target := HomalgFreeLeftModule( 1, arg[3] );
                pos_t := PositionOfTheDefaultPresentation( target );
            fi;
        elif IsList( arg[3] ) and IsHomalgModule( arg[3][1] ) and IsPosInt( arg[3][2] ) then
            target := arg[3][1];
            pos_t := arg[3][2];
            if not IsBound( SetsOfRelations( target )!.( pos_t ) ) then
                Error( "the target module does not possess a ", arg[3][2], ". set of relations (this positive number is given as the second entry of the list provided as the third argument)\n" );
            fi;
        fi;
    elif source = "ring" then
        source := HomalgFreeLeftModule( 1, arg[2] );
        target := source;	## we get an endomorphism
        pos_s := PositionOfTheDefaultPresentation( source );
        pos_t := pos_s;
    else
        pos_t := pos_s;
    fi;
    
    R := HomalgRing( source );
    
    if IsBound( target ) and not IsIdenticalObj( source, target ) then
        if not IsIdenticalObj( R, HomalgRing( target ) ) then
            Error( "the source and target modules must be defined over the same ring\n" );
        elif IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( target ) then
            type := TheTypeHomalgMapOfLeftModules;
        elif IsHomalgRightObjectOrMorphismOfRightObjects( source ) and IsHomalgRightObjectOrMorphismOfRightObjects( target ) then
            type := TheTypeHomalgMapOfRightModules;
        else
            Error( "the source and target modules of a morphism must either both be left or both be right modules\n" );
        fi;
    else
        target := source;
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) then
            type := TheTypeHomalgSelfMapOfLeftModules;
        else
            type := TheTypeHomalgSelfMapOfRightModules;
        fi;
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) then
        nr_rows := NrGenerators( source, pos_s );
        nr_columns := NrGenerators( target, pos_t );
        index_pair := [ pos_s, pos_t ];
    else
        nr_columns := NrGenerators( source, pos_s );
        nr_rows := NrGenerators( target, pos_t );
        index_pair := [ pos_t, pos_s ];
    fi;
    
    matrices := rec( );
    
    reduced_matrices := rec( );
    
    morphism := rec( 
                     matrices := matrices,
                     reduced_matrices := reduced_matrices,
                     free_resolutions := rec( ),
                     index_pairs_of_presentations := [ index_pair ]);
    
    if IsList( arg[1] ) and Length( arg[1] ) = 1 and IsString( arg[1][1] ) and Length( arg[1][1] ) > 0 then
        
        option := arg[1][1];
        
        if Length( option ) > 3 and LowercaseString( option{[1..4]} ) = "zero" then
            ## the zero map:
            
            matrix := HomalgZeroMatrix( nr_rows, nr_columns, R );
            
            matrices.( String( index_pair ) ) := matrix;
            
            reduced_matrices.( String( index_pair ) ) := matrix;
            
            ## Objectify:
            ObjectifyWithAttributes(
                    morphism, type,
                    Source, source,
                    Range, target,
                    IsZero, true );
            
            if HasIsZero( source ) and IsZero( source ) then
                SetIsSplitMonomorphism( morphism, true );
            fi;
            
            if HasIsZero( target ) and IsZero( target ) then
                SetIsSplitEpimorphism( morphism, true );
            fi;
            
        elif Length( option ) > 7 and  LowercaseString( option{[1..8]} ) = "identity" then
            ## the identity map:
            
            if nr_rows <> nr_columns then
                Error( "for a matrix of a morphism to be the identity matrix the number of generators of the source and target module must coincide\n" );
            fi;
            
            matrix := HomalgIdentityMatrix( nr_rows, R );
            
            matrices.( String( index_pair ) ) := matrix;
            
            if IsIdenticalObj( source, target ) then
                if pos_s = pos_t then
                    ## Objectify:
                    ObjectifyWithAttributes(
                            morphism, type,
                            Source, source,
                            Range, target,
                            IsIdentityMorphism, true );
                else
                    ## Objectify:
                    ObjectifyWithAttributes(
                            morphism, type,
                            Source, source,
                            Range, target,
                            IsAutomorphism, true );
                fi;
            else
                ## Objectify:
                ObjectifyWithAttributes(
                        morphism, type,
                        Source, source,
                        Range, target,
                        IsEpimorphism, true );
            fi;
            
        else
            Error( "wrong first argument: ", arg[1], "\n" );
        fi;
        
    else
        
        if IsHomalgMatrix( arg[1] ) then
            if not IsIdenticalObj( HomalgRing( arg[1] ), R ) then
                Error( "the matrix and the modules are not defined over identically the same ring\n" );
            fi;
            ResetFilterObj( arg[1], IsMutableMatrix );
            matrix := arg[1];
        elif IsHomalgRelations( arg[1] ) then
            if not IsIdenticalObj( HomalgRing( arg[1] ), R ) then
                Error( "the matrix and the modules are not defined over identically the same ring\n" );
            fi;
            matrix := MatrixOfRelations( arg[1] );
        elif IsList( arg[1] ) then
            matrix := HomalgMatrix( arg[1], R );
        else
            Error( "the first argument must be in { IsHomalgMatrix, IsHomalgRelations, IsMatrix, IsList } but received: ",  arg[1], "\n" );
        fi;
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( source )
           and ( NrGenerators( source, pos_s ) <> NrRows( matrix )
                 or NrGenerators( target, pos_t ) <> NrColumns( matrix ) ) then
            Error( "the dimensions of the matrix do not match the numbers of generators of the modules\n" );
        elif IsHomalgRightObjectOrMorphismOfRightObjects( source )
           and ( NrGenerators( source, pos_s ) <> NrColumns( matrix )
                 or NrGenerators( target, pos_t ) <> NrRows( matrix ) ) then
            Error( "the dimensions of the matrix do not match the numbers of generators of the modules\n" );
        fi;
        
        matrices.( String( index_pair ) ) := matrix;
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                Source, source,
                Range, target );
        
    fi;
    
    if ( HasNrRelations( source ) = true and NrRelations( source ) = 0 ) then
        SetIsMorphism( morphism, true );
    fi;
    
    if IsBound( degrees_s ) then
        SetDegreeOfMorphism( morphism, 0 );
    fi;
    
    if HasIsZero( source ) and IsZero( source ) then
        SetIsGeneralizedMonomorphism( morphism, true );	## we don't know yet if IsMorhphism( morphism ) = true
    fi;
    
    if HasIsZero( target ) and IsZero( target ) then
        SetIsGeneralizedEpimorphism( morphism, true );	## we don't know yet if IsMorhphism( morphism ) = true
    fi;
    
    return morphism;
    
end );
  
##  <#GAPDoc Label="HomalgZeroMap">
##  <ManSection>
##    <Func Arg="M, N" Name="HomalgZeroMap" Label="constructor for zero maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The constructor returns the zero map between the source &homalg; module <A>M</A>
##      and the target &homalg; module <A>N</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A 2 x 3 matrix over an internal ring>
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );
##  <A 2 x 4 matrix over an internal ring>
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> HomalgZeroMap( M, N );
##  <The zero morphism of left modules>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgZeroMap,
  function( arg )
    
    return CallFuncList( HomalgMap, Concatenation( [ [ "zero" ] ], arg ) );
    
end );

##  <#GAPDoc Label="HomalgIdentityMap">
##  <ManSection>
##    <Func Arg="M, N" Name="HomalgIdentityMap" Label="constructor for identity maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The constructor returns the identity map of the &homalg; module <A>M</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A 2 x 3 matrix over an internal ring>
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> HomalgIdentityMap( M );
##  <The identity morphism of a left module>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgIdentityMap,
  function( arg )
    
    return CallFuncList( HomalgMap, Concatenation( [ [ "identity" ] ], arg ) );
    
end );

##
InstallMethod( OnAFreeSource,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( MatrixOfMap( phi ), "free", Range( phi ) );
    
end );

## works without side effects
InstallMethod( RemoveMorphismAid,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
end );

## works without side effects
InstallMethod( GeneralizedMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, psi;
    
    if not IsHomalgMap( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the morphism aid map
    morphism_aid_map1 := OnAFreeSource( morphism_aid_map );
    
    ## prepare a copy of phi
    psi := HomalgMap( MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
    SetMorphismAid( psi, morphism_aid_map1 );
    
    ## some properties of the morphism phi imply
    ## properties for the generalized morphism psi
    SetPropertiesOfGeneralizedMorphism( psi, phi );
    
    return psi;
    
end );

## works without side effects
InstallMethod( AddToMorphismAid,
        "for homalg maps",
        [ IsHomalgMap, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, morphism_aid_map0;
    
    if not IsHomalgMap( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the new morphism aid map
    morphism_aid_map1 := OnAFreeSource( morphism_aid_map );
    
    if HasMorphismAid( phi ) then
        ## we don't need the source of the old morphism aid map
        morphism_aid_map0 := OnAFreeSource( MorphismAid( phi ) );
        morphism_aid_map1 := CoproductMorphism( morphism_aid_map0, morphism_aid_map1 );
    fi;
    
    return GeneralizedMorphism( phi, morphism_aid_map1 );
    
end );

##
InstallMethod( AssociatedMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local mat, S, T;
    
    if not HasMorphismAid( phi ) then
        return phi;
    fi;
    
    mat := MatrixOfMap( phi );
    
    S := Source( phi );
    
    T := Presentation( UnionOfRelations( MorphismAid( phi ) ) );
    
    return HomalgMap( mat, S, T );
    
end );

##
InstallMethod( \*,
        "for homalg maps",
        [ IsHomalgRing, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( R, phi )
    
    return BaseChange( R, phi );
    
end );

##
InstallMethod( \*,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsHomalgRing ],
        
  function( phi, R )
    
    return R * phi;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local psi;
    
    if HasMorphismAid( phi ) then
        TryNextMethod( );
    fi;
    
    if IsHomalgEndomorphism( phi ) then
        psi := HomalgMap( MatrixOfMap( phi ), ShallowCopy( Source( phi ) ) );
    else
        psi := HomalgMap( MatrixOfMap( phi ), ShallowCopy( Source( phi ) ), ShallowCopy( Range( phi ) ) );
    fi;
    
    MatchPropertiesAndAttributes( phi, psi, LIHOM.intrinsic_properties, LIHOM.intrinsic_attributes );
    
    return psi;
    
end );

##
InstallMethod( UpdateObjectsByMorphism,
        "for homalg maps",
        [ IsHomalgMap and IsIsomorphism ],
        
  function( phi )
    
    MatchPropertiesAndAttributes( Source( phi ), Range( phi ), LIMOD.intrinsic_properties, LIMOD.intrinsic_attributes );
    
end );

##
InstallMethod( AnIsomorphism,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, left, N, iso;
    
    rel := RelationsOfModule( M );
    
    ## important since each set of relations knows the module it represents
    rel := ShallowCopy( rel );
    
    N := Presentation( GeneratorsOfModule( M ), rel );
    
    ## define the obvious isomorphism between N an M
    iso := HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) );
    
    iso := HomalgMap( iso, N, M );
    
    SetIsIsomorphism( iso, true );
    
    ## copy the known properties and attributes of im to def
    UpdateObjectsByMorphism( iso );
    
    return iso;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( o )
    local s;
    
    s := ViewObjString( o );
    
    if ( HasIsIdentityMorphism( o ) and IsIdentityMorphism( o ) ) or ( HasIsZero( o ) and IsZero( o ) and not HasMorphismAid( o ) ) then
      Print( "<The", s, ">" );
    elif s[2] in "aeiouAEIOU" then
      Print( "<An", s, ">" );
    else
      Print( "<A", s, ">" );
    fi;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( o )
    local s;
    
    s := "";
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero map of homalg modules
        s := Concatenation( s, " non-zero" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            s := Concatenation( s, " homomorphism of" );
        elif HasMorphismAid( o ) then	## otherwise the notion of generalized morphism is meaningless
            if HasIsGeneralizedMorphism( o ) then
                if HasIsGeneralizedIsomorphism( o ) and IsGeneralizedIsomorphism( o ) then
                    s := Concatenation( s, " generalized isomorphism of" );
                elif HasIsGeneralizedMonomorphism( o ) and IsGeneralizedMonomorphism( o ) then
                    s := Concatenation( s, " generalized embedding of" );
                elif HasIsGeneralizedEpimorphism( o ) and IsGeneralizedEpimorphism( o ) then
                    s := Concatenation( s, " generalized epimorphism of" );
                elif IsGeneralizedMorphism( o ) then
                    s := Concatenation( s, " generalized homomorphism of" );
                else
                    s := Concatenation( s, " non-well defined (generalized) map of" );
                fi;
            else
                s := Concatenation( s, " \"generalized homomorphism\" of" );
            fi;
        else
            s := Concatenation( s, " non-well-defined map between" );
        fi;
    else
        if HasMorphismAid( o ) then	## otherwise the notion of generalized morphism is meaningless
            if HasIsGeneralizedMorphism( o ) then
                if HasIsGeneralizedIsomorphism( o ) and IsGeneralizedIsomorphism( o ) then
                    s := Concatenation( s, " generalized isomorphism of" );
                elif HasIsGeneralizedMonomorphism( o ) and IsGeneralizedMonomorphism( o ) then
                    s := Concatenation( s, " generalized embedding of" );
                elif HasIsGeneralizedEpimorphism( o ) and IsGeneralizedEpimorphism( o ) then
                    s := Concatenation( s, " generalized epimorphism of" );
                elif IsGeneralizedMorphism( o ) then
                    s := Concatenation( s, " generalized homomorphism of" );
                else
                    s := Concatenation( s, " non-well defined (generalized) map of" );
                fi;
            else
                s := Concatenation( s, " \"generalized homomorphism\" of" );
            fi;
        else
            s := Concatenation( s, " \"homomorphism\" of" );
        fi;
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap and IsMonomorphism ], 896,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " monomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap and IsEpimorphism ], 897,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " epimorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap and IsSplitMonomorphism ], 1998,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " split monomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap and IsSplitEpimorphism ], 1999,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " split epimorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap and IsIsomorphism ], 2000,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " isomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgMap and IsZero ], 2001,
        
  function( o )
    local s;
    
    s := "";
    
    if HasMorphismAid( o ) then
        s := Concatenation( s, " zero generalized" );
    else
        s := Concatenation( s, " zero" );
    fi;
    
    s := Concatenation( s, " morphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " left" );
    else
        s := Concatenation( s, " right" );
    fi;
    
    s := Concatenation( s, " modules" );
    
    return s;
    
end );

InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap ],
        
  function( o )
    local s;
    
    s := "";
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero map of homalg modules
        Print( " non-zero" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            s := Concatenation( s, " endomorphism of" );
        else
            s := Concatenation( s, " non-well-defined self-map of" );
        fi;
    else
        s := Concatenation( s, " \"endomorphism\" of" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsMonomorphism ],
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " monic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsEpimorphism ], 996,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " epic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsSplitMonomorphism ], 997,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " split monic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsSplitEpimorphism ], 2998,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " split epic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsAutomorphism ], 2999,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " automorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsIdentityMorphism ], 3000,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " identity morphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( ViewObjString,
        "for homalg maps",
        [ IsHomalgSelfMap and IsZero ], 3001,
        
  function( o )
    local s;
    
    s := "";
    
    s := Concatenation( s, " zero endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, " a left" );
    else
        s := Concatenation( s, " a right" );
    fi;
    
    s := Concatenation( s, " module" );
    
    return s;
    
end );

##
InstallMethod( Display,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( o )
  
    Display( o, "" );
    
end );


##
InstallMethod( Display,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsString ],
        
  function( o, extra_information )
    local T, mat;
    
    T := Range( o );
    
    mat := MatrixOfMap( o );
    
    Display( mat );
    
    if IsList( DegreesOfGenerators( T ) ) and not DegreesOfGenerators( T ) = [ ] then
        Print( "\n(target generators degrees: ", DegreesOfGenerators( T ), ")\n" );
    fi;
    
    if extra_information <> "" then
        Print( "\nthe ", extra_information, " map is currently represented by the above ", NrRows( mat ), " x ", NrColumns( mat ), " matrix\n" );
    else
        Print( "\nthe map is currently represented by the above ", NrRows( mat ), " x ", NrColumns( mat ), " matrix\n" );
    fi;
    
end );

