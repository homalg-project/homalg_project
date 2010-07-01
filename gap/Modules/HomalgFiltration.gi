#############################################################################
##
##  HomalgFiltration.gi         homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for a filtration.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedObjectRep, IsInt ],
        
  function( filt, p_min )
    local stack;
    
    stack := List( Filtered( DegreesOfFiltration( filt ), p -> p >= p_min ) , d -> CertainMorphism( filt, d ) );
    
    stack := Iterated( stack, CoproductMorphism );
    
    return MatrixOfMap( stack );
    
end );

##
InstallMethod( MatrixOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return MatrixOfFiltration( filt, LowestDegree( filt ) );
    
end );

##
InstallMethod( IsomorphismOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    local M, R, ByASmallerPresentation, degrees, l, nr_rels, nr_gens, Ids,
          etas, alphas, i, p, gen_emb, iotas, mor_aid, pi, Mp, Id_p, iota,
          d1, d0, eta0, epi, eta, emb, pr_P0, pr_Fp_1, pr_Mp, Fp_adapted, j,
          q, chi, alpha, compose, diagmat, transition, nr_rows, nr_cols,
          stack, augment, presentation, rows, cols, triangular;
    
    M := UnderlyingObject( filt );
    
    ## fix the current presentation for M
    LockObjectOnCertainPresentation( M );
        
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
        if IsBound( iota ) then
            
            if IsBound( iotas ) then
                iotas := PreCompose( iota, iotas );
            else
                iotas := iota;
            fi;
            
            if HasMorphismAid( gen_emb ) then
                mor_aid := MorphismAid( gen_emb ) / iotas;	## lift
            else
                mor_aid := 0;
            fi;
            
            gen_emb := gen_emb / iotas;		## generalized lift
            
            if IsHomalgMap( mor_aid ) then
                SetMorphismAid( gen_emb, mor_aid );
            fi;
            
        fi;
        
        ## pi: F_p( M ) -> M_p
        ## the epimorphism F_p( M ) onto M_p
        pi  := gen_emb ^ -1;
        
        ## the p-th graded part M_p
        Mp := Range( pi );
        
        ## fix the current presentation for M_p
        LockObjectOnCertainPresentation( Mp );
        
        ## iota: F_{p-1}( M ) -> F_p( M )
        ## the embedding iota_p of F_{p-1}( M ) into F_p( M )
        iota := KernelEmb( pi );
        
        ## fix the current presentation for F_{p-1}( M )
        LockObjectOnCertainPresentation( Source( iota ) );
        
        ## d1: K_1 -> P_0
        ## the embedding of the first syzygies module K_1 = K_1( M_p )
        ## into the free hull P_0 of M_p
        d1 := SyzygiesObjectEmb( Mp );
        
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
        gen_emb := RemoveMorphismAid( gen_emb );
        
        ## eta0: P_0 -> F_p( M )
        ## the first lift of the identity map of M_p to a map between P_0 and F_p( M )
        eta0 := PreCompose( d0, gen_emb );
        
        ## epi: P_0 + F_{p-1}( M ) -> F_p( M )
        ## the epimorphism from the direct sum P_0 + F_{p-1}( M ) onto F_p( M )
        epi := CoproductMorphism( -eta0, iota );
        
        LockObjectOnCertainPresentation( Source( epi ) );
        LockObjectOnCertainPresentation( Range( epi ) );
        
        ## eta: K_1 -> F_{p-1}( M )
        ## the 1-cocycle of the extension 0 -> F_{p-1} -> F_p -> M_p -> 0
        eta := CompleteImageSquare( d1, eta0, iota );
        
        Assert( 1, IsMorphism( eta ) );
        
        SetIsMorphism( eta, true );
        
        ## store the successive 1-cocycles
        if i < l then
            etas.(String( [ p, degrees{[i + 1 .. l]} ] )) := eta;
        fi;
        
        ## K_1 -> P_0 + F_{p-1}( M )
        ## the cokernel of (the embedding) K_1 -> P_0 + F_{p-1}( M ) is
        ## 1) isomorphic to F_p( M )
        ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
        emb := ProductMorphism( d1, eta );
        
        ## P_0 + F_{p-1}( M ) -> P_0,
        ## the projection on the first summand in the direct sum P_0 + F_{p-1}( M )
        pr_P0 := EpiOnLeftFactor( Range( emb ) );
        
        ## P_0 + F_{p-1}( M ) -> M_p,
        ## the composition P_0 + F_{p-1}( M ) -> F_{p-1}( M ) -> M_p
        pr_Mp := PreCompose( pr_P0, d0 );
        
        ## P_0 + F_{p-1}( M ) -> F_{p-1}( M ),
        ## the projection on the second summand in the direct sum P_0 + F_{p-1}( M )
        pr_Fp_1 := EpiOnRightFactor( Range( emb ) );
        
        ## the cokernel of (the embedding) K_1 -> P_0 + F_{p-1}( M ) is
        ## 1) isomorphic to F_p( M )
        ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
        Fp_adapted := Cokernel( emb );
        
        ## lock the module on this presentation
        LockObjectOnCertainPresentation( Fp_adapted );
        
        for j in [ 1 .. i - 1 ] do
            
            q := degrees[j];
            
            ## rewrite eta
            eta := etas.(String( [ q, degrees{[ i .. l ]} ] )) / epi;	## generalized lift
            
            ## the "generalized 1-cocycle" block between M_q and M_p
            etas.(String([ q, p ])) := PreCompose( eta, pr_Mp );
            
            ## prepare the next step
            if i < l then
                etas.(String([ q, degrees{[ i + 1 .. l ]} ])) := PreCompose( eta, pr_Fp_1 );
            fi;
            
        od;
        
        ## P_0 + F_{p-1}( M ) -> Cokernel( K_1 -> P_0 + F_{p-1}( M ) )
        ## the natural epimorphism from the direct sum P_0 + F_{p-1}( M )
        ## onto the cokernel of K_1 -> P_0 + F_{p-1}( M ), where the latter, by construction,
        ## 1) is isomorphic to F_p( M ) and
        ## 2) has a presentation adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
        chi := CokernelEpi( emb );
        
        ## the isomorphism between Cokernel( K_1 -> P_0 + F_{p-1}( M ) ) and F_p( M ),
        ## where the former is, by contruction, equipped with a presentation
        ## adapted to the filtration F_p( M ) > F_{p-1}( M ) > 0
        alpha := PreDivide( chi, epi );
        
        Assert( 1, IsIsomorphism( alpha ) );
        
        SetIsIsomorphism( alpha, true );
        
        alphas.(String( p )) := alpha;
        
    od;
    
    if IsHomalgFiltrationOfLeftObject( filt ) then
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
    
    if IsHomalgFiltrationOfLeftObject( filt ) then
        for i in [ 1 .. l ] do
            cols := [ ];
            for j in [ 1 .. l ] do
                if j < i then
                    ## zeros
                    Add( cols, HomalgZeroMatrix( nr_rows[i], nr_cols[j], R ) );
                elif j = i then
                    ## the diagonal block
                    Add( cols, MatrixOfMap( PresentationMap( CertainObject( filt, degrees[i] ) ) ) );
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
                    Add( cols, MatrixOfMap( PresentationMap( CertainObject( filt, degrees[i] ) ) ) );
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
    
    LockObjectOnCertainPresentation( triangular );
    
    ## the isomorphism between the filtered module and the underlying module
    triangular := HomalgMap( transition, triangular, M );
    
    if IsBound( filt!.Isomorphism ) then
        UpdateObjectsByMorphism( filt!.Isomorphism );	## this was invoked once before, but maybe more is known by now
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
    
    BasisOfModule( UnderlyingObject( filt ) );
    
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
    
    OnLessGenerators( UnderlyingObject( filt ) );
    
    return filt;
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), ByASmallerPresentation );
    
    ByASmallerPresentation( UnderlyingObject( filt ) );
    
    DecideZero( filt );
    
    return filt;
    
end );

