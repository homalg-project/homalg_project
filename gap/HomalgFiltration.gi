#############################################################################
##
##  HomalgFiltration.gi         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for a filtration.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgFiltration:
DeclareRepresentation( "IsFiltrationOfFinitelyPresentedModuleRep",
        IsHomalgFiltration,
        [ "filtration" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgFiltrations",
        NewFamily( "TheFamilyOfHomalgFiltrations" ) );

# four new types:
BindGlobal( "TheTypeHomalgDescendingFiltrationOfLeftModule",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedModuleRep and
                IsHomalgFiltrationOfLeftModule and
                IsDescendingFiltration ) );

BindGlobal( "TheTypeHomalgAscendingFiltrationOfLeftModule",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedModuleRep and
                IsHomalgFiltrationOfLeftModule and
                IsAscendingFiltration ) );

BindGlobal( "TheTypeHomalgDescendingFiltrationOfRightModule",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedModuleRep and
                IsHomalgFiltrationOfRightModule and
                IsDescendingFiltration ) );

BindGlobal( "TheTypeHomalgAscendingFiltrationOfRightModule",
        NewType(  TheFamilyOfHomalgFiltrations,
                IsFiltrationOfFinitelyPresentedModuleRep and
                IsHomalgFiltrationOfRightModule and 
                IsAscendingFiltration ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DegreesOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return filt!.degrees;
    
end );

##
InstallMethod( LowestDegree,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return DegreesOfFiltration( filt )[1];
    
end );

##
InstallMethod( HighestDegree,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    local degrees;
    
    degrees := DegreesOfFiltration( filt );
    
    return degrees[Length( degrees )];
    
end );

##
InstallMethod( CertainMorphism,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep, IsInt ],
        
  function( filt, p )
    
    return filt!.(String( p ));
    
end );

##
InstallMethod( CertainObject,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep, IsInt ],
        
  function( filt, p )
    
    return Source( CertainMorphism( filt, p ) );
    
end );

##
InstallMethod( ObjectsOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return List( DegreesOfFiltration( filt ), p -> CertainObject( filt, p ) );
    
end );

##
InstallMethod( MorphismsOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return List( DegreesOfFiltration( filt ), p -> CertainMorphism( filt, p ) );
    
end );

##
InstallMethod( LowestDegreeMorphism,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return CertainMorphism( filt, LowestDegree( filt ) );
    
end );

##
InstallMethod( HighestDegreeMorphism,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return CertainMorphism( filt, HighestDegree( filt ) );
    
end );

##
InstallMethod( HomalgRing,
        "for filtration of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return HomalgRing( LowestDegreeMorphism( filt ) );
    
end );

##
InstallMethod( UnderlyingModule,
        "for filtration of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return Range( LowestDegreeMorphism( filt ) );
    
end );

##
InstallMethod( MatrixOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep, IsInt ],
        
  function( filt, p_min )
    local stack;
    
    stack := List( Filtered( DegreesOfFiltration( filt ), p -> p >= p_min ) , d -> CertainMorphism( filt, d ) );
    
    stack := Iterated( stack, StackMaps );
    
    return MatrixOfMap( stack );
    
end );

##
InstallMethod( MatrixOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    
    return MatrixOfFiltration( filt, LowestDegree( filt ) );
    
end );

##
InstallMethod( IsomorphismOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( filt )
    local M, R, ByASmallerPresentation, degrees, l, nr_rels, nr_gens, Ids,
          iotas, etas, alphas, i, p, gen_emb, mor_aid, j, pi, Mp, Id_p, iota,
          d1, d0, eta0, epi, eta, emb, pr_P0, pr_Fp1, pr_Mp, Fp_adapted, q,
          gen_iso, alpha, compose, diagmat, transition, nr_rows, nr_cols,
          stack, augment, presentation, rows, cols, triangular;
    
    M := UnderlyingModule( filt );
    
    ## fix the current presentation for M
    LockModuleOnCertainPresentation( M );
        
    R := HomalgRing( M );
    
    ## deactivate an automatic ByASmallerPresentation,
    ## since this will destroy the following algorithm
    if IsBound( R!.ByASmallerPresentation ) then
        ByASmallerPresentation := true;
        Unbind( R!.ByASmallerPresentation );
    else
        ByASmallerPresentation := false;
    fi;
    
    degrees := DegreesOfFiltration( filt );
    
    degrees := Reversed( degrees );		## we have to start with the highest (sub)factor
    
    l := Length( degrees );
    
    nr_rels := [ ];
    nr_gens := [ ];
    Ids := rec( );
    iotas := rec( );
    etas := rec( );
    alphas := rec( );
    
    for i in [ 1 .. l ] do
        
        p := degrees[i];
        
        ## M_p -> M
        ## the generalized embedding of the p-th graded part M_p
        ## into the (filtered) module M
        gen_emb := CertainMorphism( filt, p );
        
        ## M_p -> F_p( M )
        ## the generalized isomorphism of the p-th graded part M_p
        ## onto the submodule  F_p( M )
        for j in [ 1 .. i - 1 ] do
            
            if HasMorphismAidMap( gen_emb ) then
                mor_aid := MorphismAidMap( gen_emb ) / iotas.(String( degrees[j] ));
            else
                mor_aid := 0;
            fi;
            
            gen_emb := gen_emb / iotas.(String( degrees[j] ));
            
            if IsHomalgMap( mor_aid ) then
                SetMorphismAidMap( gen_emb, mor_aid );
            fi;
        od;
        
        ## pi: F_p( M ) -> M_p
        ## the epimorphism F_p( M ) onto M_p
        pi  := gen_emb ^ -1;
        
        ## the p-th graded part M_p
        Mp := Range( pi );
        
        ## fix the current presentation for M_p
        LockModuleOnCertainPresentation( Mp );
        
        ## iota: F_{p+1}( M ) -> F_p( M )
        ## the embedding iota_p of F_{p+1}( M ) into F_p( M )
        iota := KernelEmb( pi );
        
        ## fix the current presentation for F_{p+1}( M )
        LockModuleOnCertainPresentation( Source( iota ) );
        
        ## store the successive embeddings
        iotas.(String( p )) := iota;
        
        ## d1: K_1 -> P_0
        ## the embedding of the first syzygies module K_1 = K_1( M_p )
        ## into the free hull P_0 of M_p
        d1 := SyzygiesModuleEmb( Mp );
        
        ## the identity map of P_0
        Id_p := TheIdentityMorphism( Range( d1 ) );
        
        ## store the successive embeddings
        Ids.(String( p )) := Id_p;
        
        ## the dimensions of the diagonal blocks
        Add( nr_rels, NrGenerators( Source( d1 ) ) );
        Add( nr_gens, NrGenerators( Range( d1 ) ) );
        
        ## d0: P_0 -> M_p
        ## the epimorphism from the free hull P_0 (of M_p) onto M_p
        d0 := FreeHullEpi( Mp );
        
        ## make a copy without the morphism aid map
        gen_emb := RemoveMorphismAidMap( gen_emb );
        
        ## eta0: P_0 -> F_p( M )
        ## the first lift of the identity map of M_p to a map between P_0 and F_p( M )
        eta0 := PreCompose( d0, gen_emb );
        
        ## epi: P_0 + F_{p+1}( M ) -> F_p( M )
        ## the epimorphism from the direct sum P_0 + F_{p+1}( M ) onto F_p( M )
        epi := StackMaps( -eta0, iota );
        
        LockModuleOnCertainPresentation( Source( epi ) );
        LockModuleOnCertainPresentation( Range( epi ) );
        
        ## eta: K_1 -> F_{p+1}( M )
        ## the 1-cocycle of the extension 0 -> F_{p+1} -> F_p -> M_p -> 0
        eta := CompleteImageSquare( d1, eta0, iota );
        
        Assert( 1, IsMorphism( eta ) );
        
        SetIsMorphism( eta, true );
        
        ## store the successive 1-cocycles
        if i < l then
            etas.(String( [ p, degrees{[i + 1 .. l]} ] )) := eta;
        fi;
        
        ## K_1 -> P_0 + F_{p+1}( M )
        ## the cokernel of (the embedding) K_1 -> P_0 + F_{p+1}( M ) is
        ## 1) isomorphic to F_p( M )
        ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p+1}( M ) > 0
        emb := AugmentMaps( d1, eta );
        
        ## P_0 + F_{p+1}( M ) -> P_0
        ## the projection on the first/second summand in the direct sum P_0 + F_{p+1}( M )
        pr_P0 := EpiOnLeftFactor( Range( emb ) );
        pr_Fp1 := EpiOnRightFactor( Range( emb ) );
        pr_Mp := PreCompose( pr_P0, d0 );
        
        ## the cokernel of (the embedding) K_1 -> P_0 + F_{p+1}( M ) is
        ## 1) isomorphic to F_p( M )
        ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p+1}( M ) > 0
        Fp_adapted := Cokernel( emb );
        
        ## lock the module on this presentation
        LockModuleOnCertainPresentation( Fp_adapted );
        
        for j in [ 2 .. i ] do
            
            q := degrees[j - 1];
            
            ## rewrite eta
            eta := etas.(String( [ q, degrees{[ i .. l ]} ] )) / epi;
            
            ## the 1-cocycle between M_{p-1} and M_p
            etas.(String([ q, p ])) := PreCompose( eta, pr_Mp );
            
            ## prepare the next step
            if i < l then
                etas.(String([ q, degrees{[ i + 1 .. l ]} ])) := PreCompose( eta, pr_Fp1 );
            fi;
            
        od;
        
        ## Cokernel( K_1 -> P_0 + F_{p+1}( M ) ) -> P_0 + F_{p+1}( M )
        ## the generalized isomorphism from the cokernel of K_1 -> P_0 + F_{p+1}( M )
        ## into the direct sum P_0 + F_{p+1}( M ), where the former, by construction,
        ## 1) is isomorphic to F_p( M ) and
        ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p+1}( M ) > 0
        gen_iso := CokernelNaturalGeneralizedEmbedding( emb );
        
        ## make a copy without the morphism aid map
        gen_iso := RemoveMorphismAidMap( gen_iso );
        
        ## the isomorphism between Cokernel( K_1 -> P_0 + F_{p+1}( M ) ) and F_p( M ),
        ## where the former is, by contruction, equipped with a presentation
        ## adapted to the filtration F_p( M ) > F_{p+1}( M ) > 0
        alpha := PreCompose( gen_iso, epi );
        
        Assert( 1, IsIsomorphism( alpha ) );
        
        SetIsIsomorphism( alpha, true );
        
        alphas.(String( p )) := alpha;
        
    od;
    
    if IsHomalgFiltrationOfLeftModule( filt ) then
        compose := function( a, b ) return b * a; end;
        nr_rows := nr_rels;
        nr_cols := nr_gens;
        stack := UnionOfRows;
        augment := UnionOfColumns;
        presentation := LeftPresentation;
    else
        compose := function( a, b ) return a * b; end;
        nr_rows := nr_gens;
        nr_cols := nr_rels;
        stack := UnionOfColumns;
        augment := UnionOfRows;
        presentation := RightPresentation;
    fi;
    
    diagmat := function( a, b ) return DiagMat( [ a, b ] ); end;
    
    transition := [ ];
    
    for i in [ 1 .. l ] do
        alpha := [ ];
        for j in [ 1 .. i - 1 ] do
            Add( alpha, MatrixOfMap( Ids.(String( degrees[j] )) ) );
        od;
        Add( alpha, MatrixOfMap( alphas.(String( degrees[i] )) ) );
        Add( transition, Iterated( alpha, diagmat ) );
    od;
    
    transition := Iterated( transition, compose );
    
    ## the following (commented out) line to compute the filtration-adapted
    ## transition matrix is in general not enough (hence wrong):
    ## transition := MatrixOfFiltration( filt );
    
    rows := [ ];
    
    if IsHomalgFiltrationOfLeftModule( filt ) then
        for i in [ 1 .. l ] do
            cols := [ ];
            for j in [ 1 .. l ] do
                if j < i then
                    ## zeros
                    Add( cols, HomalgZeroMatrix( nr_rows[i], nr_cols[j], R ) );
                elif j = i then
                    ## the diagonal block
                    Add( cols, MatrixOfMap( SyzygiesModuleEmb( CertainObject( filt, degrees[i] ) ) ) );
                else
                    ## the pieces of the 1-cocycle
                    Add( cols, MatrixOfMap( etas.(String( [ degrees[i], degrees[j] ] )) ) );
                fi;
            od;
            Add( rows, Iterated( cols, augment ) );
        od;
    else
        for i in [ 1 .. l ] do
            cols := [ ];
            for j in [ 1 .. l ] do
                if j < i then
                    ## zeros
                    Add( cols, HomalgZeroMatrix( nr_rows[j], nr_cols[i], R ) );		## we make the distinction between left and right modules for this line (i and j are flipped here)
                elif j = i then
                    ## the diagonal block
                    Add( cols, MatrixOfMap( SyzygiesModuleEmb( CertainObject( filt, degrees[i] ) ) ) );
                else
                    ## the pieces of the 1-cocycle
                    Add( cols, MatrixOfMap( etas.(String( [ degrees[i], degrees[j] ] )) ) );
                fi;
            od;
            Add( rows, Iterated( cols, augment ) );
        od;
    fi;
    
    triangular := Iterated( rows, stack );
    
    triangular := presentation( triangular );
    
    LockModuleOnCertainPresentation( triangular );
    
    ## the isomorphism between the filtered module and the underlying module
    triangular := HomalgMap( transition, triangular, M );
    
    if IsBound( filt!.Isomorphism ) then
        UpdateModulesByMap( filt!.Isomorphism );	## this was invoked once before, but maybe more is known by now
        triangular := PreCompose( triangular, filt!.Isomorphism );
    fi;
    
    Assert( 1, IsIsomorphism( triangular ) );
    
    SetIsIsomorphism( triangular, true );
    
    ## now it is safe to reactivate an automatic
    ## ByASmallerPresentation again
    ## (in case it was deactivated)
    if ByASmallerPresentation then
        R!.ByASmallerPresentation := true;
    fi;
    
    return triangular;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), BasisOfModule );
    
    BasisOfModule( UnderlyingModule( filt ) );
    
    return filt;
    
end );

##
InstallMethod( DecideZero,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( MorphismsOfFiltration( filt ), DecideZero );
    
    return filt;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), OnLessGenerators );
    
    OnLessGenerators( UnderlyingModule( filt ) );
    
    return filt;
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), ByASmallerPresentation );
    
    ByASmallerPresentation( UnderlyingModule( filt ) );
    
    DecideZero( filt );
    
    return filt;
    
end );

##
InstallMethod( UnlockModule,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    UnlockModule( UnderlyingModule( filt ) );
    
    return filt;
    
end );

##
InstallMethod( UnlockFiltration,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    UnlockModule( filt );
    
    Perform( ObjectsOfFiltration( filt ), UnlockModule );
    
    return filt;
    
end );

##
InstallMethod( AssociatedSecondSpectralSequence,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    if IsBound(filt!.SecondSpectralSequence) then
        return filt!.SecondSpectralSequence;
    fi;
    
    return fail;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgFiltration,
  function( arg )
    local nargs, descending, pre_filtration, degrees, l, filtration, i,
          gen_emb, monomorphism_aid, gen_map, left, type, properties, ar;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty arguments\n" );
    fi;
    
    if arg[nargs] = "descending" then
        descending := true;
    elif arg[nargs] = "ascending" then
        descending := false;
    else
        Error( "the last argument must be either \"descending\" or \"ascending\"\n" );
    fi;
    
    pre_filtration := arg[1];
    
    if IsRecord( pre_filtration ) and not IsBound( pre_filtration!.degrees ) and IsList( pre_filtration!.degrees ) and not IsEmpty( pre_filtration!.degrees ) then
        Error( "the first argument must be a record containing, as a component, a non-empty list of degrees\n" );
    fi;
    
    degrees := pre_filtration!.degrees;
    
    ConvertToRangeRep( degrees );
    
    l := Length( degrees );
    
    ## construct the filtration out of the pre_filtration
    filtration := rec( );
    
    filtration.degrees := degrees;
    
    if IsBound( pre_filtration.bidegrees ) then
        filtration.bidegrees := pre_filtration.bidegrees;
    fi;
    
    i := String( degrees[1] );
    
    if not IsBound( pre_filtration!.(String( i )) ) then
        Error( "cannot find a morphism at degree ", i, "\n" );
    fi;
    
    gen_emb := pre_filtration!.(String( i ));
    
    if  l = 1 then
        
        ## check assertion
        Assert( 1, IsIsomorphism( gen_emb ) );
        
        SetIsIsomorphism( gen_emb, true );
        
    else
        
        ## the bottom map must be a monomorphism
        Assert( 1, IsMonomorphism( gen_emb ) );
        
        SetIsMonomorphism( gen_emb, true );
        
    fi;
    
    filtration.(String( i )) := gen_emb;
    
    monomorphism_aid := gen_emb;
    
    for i in degrees{[ 2 .. l - 1 ]} do
        
        gen_map := pre_filtration!.(String( i ));
        
        gen_emb := GeneralizedMap( gen_map, monomorphism_aid );
        
        ## check assertion
        Assert( 1, IsGeneralizedMonomorphism( gen_emb ) );
        
        SetIsGeneralizedMonomorphism( gen_emb, true );
        
        filtration.(String( i )) := gen_emb;
        
        ## prepare the next step
        monomorphism_aid := StackMaps( monomorphism_aid, gen_map );
        
    od;
    
    if l > 1 then
        
        ## the last step
        i := degrees[l];
        
        gen_map := pre_filtration!.(String( i ));
        
        gen_emb := GeneralizedMap( gen_map, monomorphism_aid );
        
        ## the upper one but be a generalized isomorphism
        Assert( 1, IsGeneralizedIsomorphism( gen_emb ) );
        
        SetIsGeneralizedIsomorphism( gen_emb, true );
        
        filtration.(String( i )) := gen_emb;
        
    fi;
    
    ## finalize
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( gen_emb );
    
    if left then
        if descending then
            type := TheTypeHomalgDescendingFiltrationOfLeftModule;
        else
            type := TheTypeHomalgAscendingFiltrationOfLeftModule;
        fi;
    else
        if descending then
            type := TheTypeHomalgDescendingFiltrationOfRightModule;
        else
            type := TheTypeHomalgAscendingFiltrationOfRightModule;
        fi;
    fi;
    
    properties := arg{[ 2 .. nargs - 1 ]};
    
    ar := Concatenation( [ filtration, type ], properties );
    
    ## Objectify:
    CallFuncList( ObjectifyWithAttributes, ar );
    
    return filtration;
    
end );

##
InstallGlobalFunction( HomalgDescendingFiltration,
  function( arg )
    
    return CallFuncList( HomalgFiltration, Concatenation( arg, [ "descending" ] ) );
    
end );

##
InstallGlobalFunction( HomalgAscendingFiltration,
  function( arg )
    
    return CallFuncList( HomalgFiltration, Concatenation( arg, [ "ascending" ] ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg filtration",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( o )
    local degrees, l, plural, purity, the, p, s;
    
    degrees := DegreesOfFiltration( o );
    
    l := Length( degrees );
    
    plural := l > 1;
    
    purity := HasIsPurityFiltration( o ) and IsPurityFiltration( o );
    
    the := purity;
    
    if the then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    if IsDescendingFiltration( o ) then
        Print( " de" );
    else
        if the then
            Print( " a" );
        else
            Print( "n a" );
        fi;
    fi;
    
    Print( "scending " );
    
    if purity then
        Print( "purity " );
    fi;
    
    if IsDescendingFiltration( o ) then
        degrees := Reversed( degrees );		## we want to start with the highest (sub)factor
    fi;
    
    if plural then
        Print( "filtration with degrees ", degrees, " and graded parts:\n" );
    else
        Print( "trivial filtration with degree ", degrees, " and graded part:\n" );
    fi;
    
    if IsAscendingFiltration( o ) then
        degrees := Reversed( degrees );		## we want to start with the highest (sub)factor
    fi;
    
    for p in degrees do
        s := ListWithIdenticalEntries( 4 - Length( String( p ) ), ' ' );
        ConvertToStringRep( s );
        Print( s, p, ":\t" );
        ViewObj( CertainObject( o, p ) );
        Print( "\n" );
    od;
    
    Print( "of\n" );
    ViewObj( UnderlyingModule( o ) );
    Print( ">" );
    
end );

InstallMethod( Display,
        "for homalg filtration",
        [ IsFiltrationOfFinitelyPresentedModuleRep ],
        
  function( o )
    local degrees, l, d;
    
    degrees := DegreesOfFiltration( o );
    
    degrees := Reversed( degrees );		## we want to start with the highest (sub)factor
    
    l := Length( degrees );
    
    for d in degrees{[ 1 .. l - 1 ]} do
        Print( "Degree ", d, ":\n\n" );
        Display( CertainObject( o, d ) );
        Print( "----------\n" );
    od;
    
    Print( "Degree ", degrees[l], ":\n\n" );
    Display( CertainObject( o, degrees[l] ) );
    
end );
