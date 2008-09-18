#############################################################################
##
##  Basic.gi                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg basic procedures.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( BasisOfRows,			### defines: BasisOfRows (BasisOfModule (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, ring_rel, rel, Mrel, side, zz;
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or NrColumns( M ) = 0 then
        return BasisOfRowModule( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfLeftModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
    
    Mrel := UnionOfRows( M, rel );
    
    return BasisOfRowModule( Mrel );
    
end );

##
InstallMethod( BasisOfColumns,			### defines: BasisOfColumns (BasisOfModule (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, ring_rel, rel, Mrel, side, zz;
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or NrRows( M ) = 0 then
        return BasisOfColumnModule( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfRightModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
    
    Mrel := UnionOfColumns( M, rel );
    
    return BasisOfColumnModule( Mrel );
    
end );

##
InstallMethod( BasisOfRows,			### defines: BasisOfRows (BasisOfModule (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, ring_rel, rel, Mrel, id, zz, TT, bas;
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or NrColumns( M ) = 0 then
        return BasisOfRowsCoeff( M, T );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfLeftModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
    
    Mrel := UnionOfRows( M, rel );
    
    TT := HomalgVoidMatrix( R );
    
    bas := BasisOfRowsCoeff( Mrel, TT );
    
    SetPreEval( T, CertainColumns( TT, [ 1 .. NrRows( M ) ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return bas;
    
end );

##
InstallMethod( BasisOfColumns,			### defines: BasisOfColumns (BasisOfModule (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, ring_rel, rel, Mrel, id, zz, TT, bas;
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or NrRows( M ) = 0 then
        return BasisOfColumnsCoeff( M, T );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfRightModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
    
    Mrel := UnionOfColumns( M, rel );
    
    TT := HomalgVoidMatrix( R );
    
    bas := BasisOfColumnsCoeff( Mrel, TT );
    
    SetPreEval( T, CertainRows( TT, [ 1 .. NrColumns( M ) ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return bas;
    
end );

##
InstallMethod( DecideZero,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, ring_rel, rel, red;
    
    if HasIsReducedModuloRingRelations( M ) and IsReducedModuloRingRelations( M ) then
        return M;
    fi;
    
    ## the upper exit condition and setting SetIsReducedModuloRingRelations to true in the following
    ## avoids infinite loops when IsZero(Matrix) is called (as below), since the latter, in turn,
    ## calls DecideZero first!
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or IsEmptyMatrix( M ) then
        
        SetIsReducedModuloRingRelations( M, true );
        IsZero( M );
        
        return M;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    rel := MatrixOfRelations( ring_rel );
    
    if IsHomalgRelationsOfLeftModule( ring_rel ) then
        rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
        red := DecideZeroRows( M, rel );
    else
        rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
        red := DecideZeroColumns( M, rel );
    fi;
    
    SetIsReducedModuloRingRelations( red, true );
    IsZero( red );
    
    return red;
    
end );

##
InstallMethod( SyzygiesOfRows,			### defines: SyzygiesOfRows (SyzygiesGenerators (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, ring_rel, rel;
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or NrColumns( M ) = 0 then
        return SyzygiesGeneratorsOfRows( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfLeftModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
    
    return SyzygiesGeneratorsOfRows( M, rel );
    
end );

##
InstallMethod( SyzygiesOfColumns,		### defines: SyzygiesOfColumns (SyzygiesGenerators (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, ring_rel, rel;
    
    R := HomalgRing( M );
    
    if not HasRingRelations( R ) or NrRows( M ) = 0 then
        return SyzygiesGeneratorsOfColumns( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfRightModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
    
    return SyzygiesGeneratorsOfColumns( M, rel );
    
end );

##
InstallMethod( SyzygiesOfRows,			### defines: SyzygiesOfRows (SyzygiesGenerators (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, ring_rel, rel, S;
    
    R := HomalgRing( M1 );
    
    if not HasRingRelations( R ) or NrColumns( M1 ) = 0 then
        
        S := SyzygiesGeneratorsOfRows( M1, M2 );
        
        ## since SyzygiesGeneratorsOfRows of M1 modulo M2
        ## first computes the syzygies matrix of the stack of M1 and M2,
        ## and then keeps only those columns S corresponding to M1,
        ## zero rows can potentially exist in S (and we like to remove them);
        ## if the ring specific SyzygiesGeneratorsOfRows gets rid
        ## of the zero rows automatically, it should then set the
        ## attribute ZeroRows of its result to [ ] in order for the
        ## next line to be handled by immediate methods without
        ## further computations
        
        S := CertainRows( S, NonZeroRows( S ) );
        
        SetZeroRows( S, [ ] );
        
        return S;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfLeftModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrColumns( M1 ), rel ) );
    
    S := SyzygiesGeneratorsOfRows( M1, UnionOfRows( M2, rel ) );
    
    ## see the above comment
    S := CertainRows( S, NonZeroRows( S ) );
    
    SetZeroRows( S, [ ] );
    
    if IsZero( S ) then
        
        SetIsLeftRegularMatrix( M1, true );
        
    fi;
    
    return S;
    
end );

##
InstallMethod( SyzygiesOfColumns,		### defines: SyzygiesOfColumns (SyzygiesGenerators (high-level))
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, ring_rel, rel, S;
    
    R := HomalgRing( M1 );
    
    if not HasRingRelations( R ) or NrRows( M1 ) = 0 then
        
        S := SyzygiesGeneratorsOfColumns( M1, M2 );
        
        ## since SyzygiesGeneratorsOfColumns of M1 modulo M2
        ## first computes the syzygies matrix of the augmentation of M1 and M2,
        ## and then keeps only those rows S corresponding to M1,
        ## zero columns can potentially exist in S (and we like to remove them);
        ## if the ring specific SyzygiesGeneratorsOfColumns gets rid
        ## of the zero columns automatically, it should then set the
        ## attribute ZeroColumns of its result to [ ] in order for the
        ## next line to be handled by immediate methods without
        ## further computations
        
        S := CertainColumns( S, NonZeroColumns( S ) );
        
        SetZeroColumns( S, [ ] );
        
        return S;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    if IsHomalgRelationsOfRightModule( ring_rel ) then
        rel := MatrixOfRelations( ring_rel );
    else
        rel := Involution( MatrixOfRelations( ring_rel ) );
    fi;
    
    rel := DiagMat( ListWithIdenticalEntries( NrRows( M1 ), rel ) );
    
    S := SyzygiesGeneratorsOfColumns( M1, UnionOfColumns( M2, rel ) );
    
    ## see the above comment
    S := CertainColumns( S, NonZeroColumns( S ) );
    
    SetZeroColumns( S, [ ] );
    
    if IsZero( S ) then
        
        SetIsRightRegularMatrix( M1, true );
        
    fi;
    
    return S;
    
end );

##
InstallMethod( SyzygiesBasisOfRows,		### defines: SyzygiesBasisOfRows (SyzygiesBasis)
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local S;
    
    S := SyzygiesOfRows( M );
    
    return BasisOfRows( S );
    
end );

##
InstallMethod( SyzygiesBasisOfColumns,		### defines: SyzygiesBasisOfColumns (SyzygiesBasis)
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local S;
    
    S := SyzygiesOfColumns( M );
    
    return BasisOfColumns( S );
    
end );

##
InstallMethod( SyzygiesBasisOfRows,		### defines: SyzygiesBasisOfRows (SyzygiesBasis)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local S;
    
    S := SyzygiesOfRows( M1, M2 );
    
    return BasisOfRows( S );
    
end );

##
InstallMethod( SyzygiesBasisOfColumns,		### defines: SyzygiesBasisOfColumns (SyzygiesBasis)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local S;
    
    S := SyzygiesOfColumns( M1, M2 );
    
    return BasisOfColumns( S );
    
end );

#=======================================================================
# Right divide:
# Solve the inhomogeneous linear system: B = XA
# i.e.
# perform the right division if possible B * A^(-1)
# Generalizes Leftinverse: AI * A = Id <=> AI = Id * A^(-1)
#_______________________________________________________________________
InstallMethod( RightDivide,			### defines: RightDivide (RightDivideF)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( B, A )				## CAUTION: Do not use lazy evaluation here!!!
    local R, CA, IA, CB, NF;
    
    R := HomalgRing( B );
    
    ## CA * A = IA
    CA := HomalgVoidMatrix( R );
    IA := BasisOfRows( A, CA );
    
    ## check assertion
    Assert( 3, CA * A = IA );
    
    ## NF = B + CB * IA
    CB := HomalgVoidMatrix( R );
    NF := DecideZeroRowsEffectively( B, IA, CB );
    
    ## check assertion
    Assert( 3, NF = B + CB * IA );
    
    ## NF <> 0
    if not IsZero( NF ) then
        #Error( "The second argument is not a right factor of the first, i.e. the rows of the second argument are not a generating set!\n" );
        return fail;
    fi;
    
    ## CD = -CB * CA => CD * A = B
    return -CB * CA;				## -CB * CA = (-CB) * CA and COLEM should take over since CB := -matrix
    
end );

#=======================================================================
# Left divide:
# Solve the inhomogeneous linear system: AX = B
# i.e.
# perform the left division if possible A^(-1) * B
# Generalizes Rightinverse: A * AI = Id <=> AI = A^(-1) * Id
#_______________________________________________________________________
InstallMethod( LeftDivide,			### defines: LeftDivide (LeftDivideF)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )				## CAUTION: Do not use lazy evaluation here!!!
    local R, CA, IA, CB, NF;
    
    R := HomalgRing( B );
    
    ## A * CA = IA
    CA := HomalgVoidMatrix( R );
    IA := BasisOfColumns( A, CA );
    
    ## check assertion
    Assert( 3, A * CA = IA );
    
    ## NF = B + IA * CB
    CB := HomalgVoidMatrix( R );
    NF := DecideZeroColumnsEffectively( B, IA, CB );
    
    ## check assertion
    Assert( 3, NF = B + IA * CB );
    
    ## NF <> 0
    if not IsZero( NF ) then
        #Error( "The first argument is not a left factor of the second, i.e. the columns of the first argument are not a generating set!\n" );
        return fail;
    fi;
    
    ## CD = CA * -CB => A * CD = B
    return CA * -CB;				## CA * -CB = CA * (-CB) and COLEM should take over since CB := -matrix
    
end );

#=======================================================================
# Right divide modulo:	( cf. [BR, Subsection 3.1.1] )
# Solve the inhomogeneous linear system: B = XA mod L
# i.e.
# solve the inhomogeneous linear system: B = XA + YL
# i.e.
# perform the right division if possible B * A^(-1) mod L
# Leftinverse is a special case: Id = AI * A mod L <=> AI = Id * A^(-1) mod L
#_______________________________________________________________________
InstallMethod( RightDivide,			### defines: RightDivide (RightDivide)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRelationsOfLeftModule ],
        
  function( B, A, L )				## CAUTION: Do not use lazy evaluation here!!!
    local R, BL, ZA, AL, CA, IAL, ZB, CB, NF, a;
    
    R := HomalgRing( B );
    
    BL := BasisOfModule( L );
    
    ## first reduce A modulo L
    ZA := DecideZero( A, BL );
    
    AL := UnionOfRows( ZA, MatrixOfRelations( BL ) );
    
    ## CA * AL = IAL
    CA := HomalgVoidMatrix( R );
    IAL := BasisOfRows( AL, CA );
    
    ## check assertion
    Assert( 3, CA * AL = IAL );
    
    ## also reduce B modulo L
    ZB := DecideZero( B, BL );
    
    ## NF = B + CB * IAL
    CB := HomalgVoidMatrix( R );
    NF := DecideZeroRowsEffectively( ZB, IAL, CB );
    
    ## check assertion
    Assert( 3, NF = ZB + CB * IAL );
    
    ## NF <> 0
    if not IsZero( NF ) then
        return fail;
    fi;
    
    a := NrRows( A );
    
    ## CD = -CB * CA => CD * A = B
    return -CB * CertainColumns( CA, [ 1 .. a ] );	## -CB * CA = (-CB) * CA and COLEM should take over since CB := -matrix
    
end );

#=======================================================================
# Left divide modulo:	( cf. [BR, Subsection 3.1.1] )
# Solve the inhomogeneous linear system: AX = B mod L
# i.e.
# solve the inhomogeneous linear system: B = AX + LY
# i.e.
# perform the right division if possible A^(-1) * B mod L
# Rightinverse is a special case: Id = A * AI mod L <=> AI = A^(-1) * Id mod L
#_______________________________________________________________________
InstallMethod( LeftDivide,			### defines: LeftDivide (LeftDivide)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRelationsOfRightModule ],
        
  function( A, B, L )				## CAUTION: Do not use lazy evaluation here!!!
    local R, BL, ZA, AL, CA, IAL, ZB, CB, NF, a;
    
    R := HomalgRing( B );
    
    BL := BasisOfModule( L );
    
    ## first reduce A modulo L
    ZA := DecideZero( A, BL );
    
    AL := UnionOfColumns( ZA, MatrixOfRelations( BL ) );
    
    ## AL * CA = IAL
    CA := HomalgVoidMatrix( R );
    IAL := BasisOfColumns( AL, CA );
    
    ## check assertion
    Assert( 3, AL * CA = IAL );
    
    ## also reduce B modulo L
    ZB := DecideZero( B, BL );
    
    ## NF = B + IAL * CB
    CB := HomalgVoidMatrix( R );
    NF := DecideZeroColumnsEffectively( ZB, IAL, CB );
    
    ## check assertion
    Assert( 3, NF = ZB + IAL * CB );
    
    ## NF <> 0
    if not IsZero( NF ) then
        return fail;
    fi;
    
    a := NrColumns( A );
    
    ## CD = CA * -CB => A * CD = B
    return CertainRows( CA, [ 1 .. a ] ) * -CB;		## CA * -CB = CA * (-CB) and COLEM should take over since CB := -matrix
    
end );

##---------------------
##
## the lazy evaluation:
##
##---------------------

##
InstallMethod( Eval,				### defines: LeftInverse (LeftinverseF)
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalLeftInverse ],
        
  function( LI )
    local R, RI, Id, left_inv;
    
    R := HomalgRing( LI );
    
    RI := EvalLeftInverse( LI );
    
    Id := HomalgIdentityMatrix( NrColumns( RI ), R );
    
    left_inv := RightDivide( Id, RI );		## ( cf. [BR, Subsection 3.1.3] )
    
    if left_inv = fail then
        return fail;
    fi;
    
    ## CAUTION: for the following SetXXX RightDivide is assumed not to be lazy evaluated!!!
    
    SetIsLeftInvertibleMatrix( RI, true );
    
    if HasIsInvertibleMatrix( RI ) and IsInvertibleMatrix( RI ) then
        SetIsInvertibleMatrix( LI, true );
    else
        SetIsRightInvertibleMatrix( LI, true );
    fi;
    
    return Eval( left_inv );
    
end );

##
InstallMethod( Eval,				### defines: RightInverse (RightinverseF)
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalRightInverse ],
        
  function( RI )
    local R, LI, Id, right_inv;
    
    R := HomalgRing( RI );
    
    LI := EvalRightInverse( RI );
    
    Id := HomalgIdentityMatrix( NrRows( LI ), R );
    
    right_inv := LeftDivide( LI, Id );		## ( cf. [BR, Subsection 3.1.3] )
    
    if right_inv = fail then
        return fail;
    fi;
    
    ## CAUTION: for the following SetXXX LeftDivide is assumed not to be lazy evaluated!!!
    
    SetIsRightInvertibleMatrix( LI, true );
    
    if HasIsInvertibleMatrix( LI ) and IsInvertibleMatrix( LI ) then
        SetIsInvertibleMatrix( RI, true );
    else
        SetIsLeftInvertibleMatrix( RI, true );
    fi;
    
    return Eval( right_inv );
    
end );

##
InstallGlobalFunction( BestBasis,		### defines: BestBasis
  function( arg )
    local M, R, RP, nargs, m, n, B, U, V;
    
    if not IsHomalgMatrix( arg[1] ) then
        Error( "expecting a homalg matrix as a first argument, but received ", arg[1], "\n" );
    fi;
    
    M := arg[1];
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.BestBasis) then
        
        return CallFuncList( RP!.BestBasis, arg );
        
    elif IsBound(RP!.TriangularBasisOfRows) then
        
        nargs := Length( arg );
        
        m := NrRows( M );
        n := NrColumns( M );
        
        if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
            B := TriangularBasisOfRows( M, arg[2] );
        else
            B := TriangularBasisOfRows( M );
        fi;
        
        if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
            B := TriangularBasisOfColumns( B, arg[3] );
        else
            B := TriangularBasisOfColumns( B );
        fi;
        
        if m - NrRows( B ) = 0 and n - NrColumns( B ) = 0 then
            return B;
        elif m - NrRows( B ) = 0 and n - NrColumns( B ) > 0 then
            return UnionOfColumns( B, HomalgZeroMatrix( m, n - NrColumns( B ), R ) );
        elif m - NrRows( B ) > 0 and n - NrColumns( B ) = 0 then
            return UnionOfRows( B, HomalgZeroMatrix( m - NrRows( B ), n, R ) );
        else
            return DiagMat( [ B, HomalgZeroMatrix( m - NrRows( B ), n - NrColumns( B ), R ) ] );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallGlobalFunction( ReducedBasisOfModule,	### defines: ReducedBasisOfModule (ReducedBasisOfModule) (incomplete)
  function( arg )
    local nargs, M, COMPUTE_BASIS, STORE_SYZYGIES, ar, S, unit_pos;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsFinitelyPresentedModuleRep( arg[1] ) then
        return CallFuncList( ReducedBasisOfModule,
                       Concatenation( [ RelationsOfModule( arg[1] ) ], arg{[2..nargs]} ) );
    fi;
    
    if not ( nargs > 0 and IsRelationsOfFinitelyPresentedModuleRep( arg[1] ) ) then
        Error( "the first argument must be a module or a set of relations\n" );
    fi;
    
    ## M is a set of relations of a module
    M := arg[1];
    
    COMPUTE_BASIS := false;
    STORE_SYZYGIES := false;
    
    for ar in arg{[ 2 .. nargs ]} do
        if ar = "COMPUTE_BASIS" then
            COMPUTE_BASIS := true;
        elif ar = "STORE_SYZYGIES" then
            STORE_SYZYGIES := true;
        fi;
    od;
    
    if NrRelations( M ) = 0 then
        if STORE_SYZYGIES then
            M!.SyzygiesGenerators := SyzygiesGenerators( M );
        fi;
        return M;
    fi;
    
    if COMPUTE_BASIS and IsBound( M!.ReducedBasisOfModule ) then
        if STORE_SYZYGIES and not IsBound( M!.ReducedBasisOfModule!.SyzygiesGenerators ) then
            M!.ReducedBasisOfModule!.SyzygiesGenerators := SyzygiesGenerators( M );
        fi;
        return M!.ReducedBasisOfModule;
    elif not COMPUTE_BASIS and IsBound( M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS) then
        if STORE_SYZYGIES and not IsBound( M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS!.SyzygiesGenerators ) then
            M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS!.SyzygiesGenerators := SyzygiesGenerators( M );
        fi;
        return M!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS;
    fi;
    
    if COMPUTE_BASIS then
        M := BasisOfModule( M );
    fi;
    
    ## get rid of the rows containing the ring relations
    if HasRingRelations( HomalgRing( M ) ) then
        M := GetRidOfObsoleteRelations( M );
    fi;
    
    ## iterate the syzygy trick
    while true do
        S := SyzygiesGenerators( M );
        unit_pos := GetIndependentUnitPositions( S );
        unit_pos := List( unit_pos, a -> a[2] );	## due to the convention followed in GetRow/ColumnIndependentUnitPositions we are always interested in a[2]
        if NrRelations( S ) = 0 or unit_pos = [ ] then
            break;
        fi;
        M := CertainRelations( M, Filtered( [ 1 .. NrRelations( M ) ], j -> not j in unit_pos ) );
    od;
    
    if COMPUTE_BASIS then
        arg[1]!.ReducedBasisOfModule := M;
    else
        arg[1]!.ReducedBasisOfModule_DID_NOT_COMPUTE_BASIS := M;
    fi;
    
    if STORE_SYZYGIES then
        M!.SyzygiesGenerators := S;
    fi;
    
    return M;
    
end );

##
InstallGlobalFunction( SimplerEquivalentMatrix,	### defines: SimplerEquivalentMatrix (BetterGenerators) (incomplete)
  function( arg )
    local M, R, RP, nargs, compute_U, compute_V, compute_UI, compute_VI,
          U, V, UI, VI, nar_U, nar_V, nar_UI, nar_VI, MM, m, n, finished,
          barg, one, clean_rows, unclean_rows, clean_columns, unclean_columns,
          eliminate_units, b, a, v, u, l;
    
    if not IsHomalgMatrix( arg[1] ) then
        Error( "expecting a homalg matrix as a first argument, but received ", arg[1], "\n" );
    fi;
    
    M := arg[1];
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
  
    if IsBound(RP!.SimplerEquivalentMatrix) then
        return RP!.SimplerEquivalentMatrix( arg );
    fi;
    
    nargs := Length( arg );
    
    if nargs = 1 then
        ## SimplerEquivalentMatrix(M)
        compute_U := false;
        compute_V := false;
        compute_UI := false;
        compute_VI := false;
    elif nargs = 2 and IsHomalgMatrix( arg[2] ) then
        ## SimplerEquivalentMatrix(M,V)
        compute_U := false;
        compute_V := true;
        compute_UI := false;
        compute_VI := false;
        nar_V := 2;
    elif nargs = 3 and IsHomalgMatrix( arg[2] ) and IsString( arg[3] ) then
        ## SimplerEquivalentMatrix(M,VI,"")
        compute_U := false;
        compute_V := false;
        compute_UI := false;
        compute_VI := true;
        nar_VI := 2;
    elif nargs = 6 and IsHomalgMatrix( arg[2] ) and IsHomalgMatrix( arg[3] )
      and IsString( arg[4] ) and IsString( arg[5] ) and IsString( arg[6] ) then
        ## SimplerEquivalentMatrix(M,U,UI,"","","")
        compute_U := true;
        compute_V := false;
        compute_UI := true;
        compute_VI := false;
        nar_U := 2;
        nar_UI := 3;
    elif nargs = 5 and IsHomalgMatrix( arg[2] ) and IsHomalgMatrix( arg[3] )
      and IsString( arg[4] ) and IsString( arg[5] ) then
        ## SimplerEquivalentMatrix(M,V,VI,"","")
        compute_U := false;
        compute_V := true;
        compute_UI := false;
        compute_VI := true;
        nar_V := 2;
        nar_VI := 3;
    elif nargs = 4 and IsHomalgMatrix( arg[2] ) and IsHomalgMatrix( arg[3] )
      and IsString( arg[5] ) then
        ## SimplerEquivalentMatrix(M,UI,VI,"")
        compute_U := false;
        compute_V := false;
        compute_UI := true;
        compute_VI := true;
        nar_UI := 2;
        nar_VI := 3;
    elif nargs = 5 and IsHomalgMatrix( arg[2] ) and IsHomalgMatrix( arg[3] )
      and IsHomalgMatrix( arg[4] ) and IsHomalgMatrix( arg[5] ) then
        ## SimplerEquivalentMatrix(M,U,V,UI,VI)
        compute_U := true;
        compute_V := true;
        compute_UI := true;
        compute_VI := true;
        nar_U := 2;
        nar_V := 3;
        nar_UI := 4;
        nar_VI := 5;
    elif IsHomalgMatrix( arg[2] ) and IsHomalgMatrix( arg[3] ) then
        ## SimplerEquivalentMatrix(M,U,V)
        compute_U := true;
        compute_V := true;
        compute_UI := false;
        compute_VI := false;
        nar_U := 2;
        nar_V := 3;
    else
        Error( "Wrong input!\n" );
    fi;
    
    m := NrRows( M );
    n := NrColumns( M );
    
    finished := false;
    
    if compute_U or compute_UI then
        U := HomalgVoidMatrix( R );
    fi;
        
    if compute_V or compute_VI then
        V := HomalgVoidMatrix( R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if IsZero( M ) then
        
        if compute_U then
            U := HomalgIdentityMatrix( m, R );
        fi;
        
        if compute_V then
            V := HomalgIdentityMatrix( n, R );
        fi;
        
        if compute_UI then
            UI := HomalgIdentityMatrix( m, R );
        fi;
        
        if compute_VI then
            VI := HomalgIdentityMatrix( n, R );
        fi;
        
        finished := true;
        
    fi;
    
    if not finished
       and ( IsBound( RP!.BestBasis )
             or IsBound( RP!.TriangularBasisOfRows )
             or IsBound( RP!.TriangularBasisOfColumns ) ) then
        
        if not ( compute_U or compute_UI or compute_V or compute_VI ) then
            barg := [ M ];
        elif ( compute_U or compute_UI ) and not ( compute_V or compute_VI ) then
            barg := [ M, U ];
        elif ( compute_V or compute_VI ) and not ( compute_U or compute_UI ) then
            barg := [ M, "", V ];
        else
            barg := [ M, U, V ];
        fi;
        
        M := CallFuncList( BestBasis, barg );
        
        ## FIXME:
        #if ( compute_V or compute_VI ) then
        #    if IsList( V ) and V <> [] and IsString( V[1] ) then
        #        if LowercaseString( V[1]{[1..3]} ) = "inv" then
        #            VI := V[2];
        #            if compute_V then
        #                V := LeftInverse( VI, arg[1], "NO_CHECK");
        #            fi;
        #        else
        #            Error( "Cannot interpret the first string in V ", V[1], "\n" );
        #        fi;
        #    fi;
        #fi;
        
        if compute_UI then
            if IsString( U ) then
                UI := U;
            else
                UI := RightInverse( U );
            fi;
        fi;
        
        if compute_VI and not IsBound( VI ) then
            VI := LeftInverse( V ); ## this is indeed a LeftInverse
        fi;
        
        ## don't compute a "basis" here, since it is not clear if to do it for rows or for columns!
        ## this differs from the Maple code, where we only worked with left modules
        
    elif not finished then
        
        MM := ShallowCopy( M );
        
        if IsIdenticalObj( MM, M ) then
            Error( "unable to get a real copy of the matrix\n" );
        fi;
        
        M := MM;
        
        m := NrRows( M );
        n := NrColumns( M );
        
        if compute_U then
            U := HomalgIdentityMatrix( m, R );
        fi;
        if compute_UI then
            UI := HomalgIdentityMatrix( m, R );
        fi;
        
        if compute_V then
            V := HomalgIdentityMatrix( n, R );
        fi;
        if compute_VI then
            VI := HomalgIdentityMatrix( n, R );
        fi;
        
        one := One( R );
        
        clean_rows := [ ];
        unclean_rows := [ 1 .. m ];
        clean_columns := [ ];
        unclean_columns := [ 1 .. n ];
        
        eliminate_units := function( arg )
            local pos, i, j, r, q, v, vi, u, ui;
            
            if Length( arg ) > 0 then
                pos := arg[1];
            else
                pos := GetUnitPosition( M, clean_columns );
            fi;
            
            if pos = fail then
                clean_rows := GetCleanRowsPositions( M, clean_columns );
                unclean_rows := Filtered( [ 1 .. m ], a -> not a in clean_rows );
                
                return clean_columns;
            else
                b := false;
            fi;
            
            while true do
                i := pos[1];
                j := pos[2];
                
                Add( clean_columns, j );
                Remove( unclean_columns, Position( unclean_columns, j ) );
                
                ## divide the i-th row by the unit M[i][j]
                
                r := GetEntryOfHomalgMatrix( M, i, j ); 
                if not IsOne( r ) then
                    
                    M := DivideRowByUnit( M, i, r, j );
                    
                    if compute_U then
                        U := DivideRowByUnit( U, i, r, 0 );
                    fi;
                    
                    if compute_UI then
                        q := one / r;
                        UI := DivideColumnByUnit( UI, i, q, 0 );
                    fi;
                fi;
                
                ## cleanup the i-th row
                
                v := HomalgInitialIdentityMatrix( n, R );
                
                if compute_VI then
                    vi := HomalgInitialIdentityMatrix( n, R );
                else
                    vi := "";
                fi;
                
                CopyRowToIdentityMatrix( M, i, [ v, vi ], j );
                
                if compute_V then
                    V := V * v;
                fi;
                
                if compute_VI then
                    VI := vi * VI;
                fi;
                
                M := M * v;
                
                ## cleanup the j-th column
                
                if compute_U then
                    u := HomalgInitialIdentityMatrix( NrRows( U ), R );
                else
                    u := "";
                fi;
                
                if compute_UI then
                    ui := HomalgInitialIdentityMatrix( NrRows( U ), R );
                else
                    ui := "";
                fi;
                
                if compute_U or compute_UI then
                    CopyColumnToIdentityMatrix( M, j, [ u, ui ], i );
                fi;
                
                if compute_U then
                    U := u * U;
                fi;
                
                if compute_UI then
                    UI := UI * ui;
                fi;
                
                # an M := u * M would simply cause:
                M := SetColumnToZero( M, i, j );
                
                pos := GetUnitPosition( M, clean_columns );
                
                if pos = fail then
                    break;
                fi;
            od;
            
            clean_rows := GetCleanRowsPositions( M, clean_columns );
            unclean_rows := Filtered( [ 1 .. m ], a -> not a in clean_rows );
            
            return clean_columns;
        end;
        
        while true do
            
            ## don't compute a "basis" here, since it is not clear if to do it for rows or for columns!
            ## this differs from the Maple code, where we only worked with left modules
            
            m := NrRows( M );
            n := NrColumns( M );
            
            b := true;
            
            eliminate_units();
            
            ## FIXME: add heuristics
            
            if b then
                break;
            fi;
        od;
    fi;
    
    if compute_U then
        SetPreEval( arg[nar_U], U );
        ResetFilterObj( arg[nar_U], IsVoidMatrix );
    fi;
    
    if compute_V then
        SetPreEval( arg[nar_V], V );
        ResetFilterObj( arg[nar_V], IsVoidMatrix );
    fi;
    
    if compute_UI then
        if not IsBound( UI ) then
            UI := HomalgIdentityMatrix( NrRows( M ), R );
        fi;
        SetPreEval( arg[nar_UI], UI );
        ResetFilterObj( arg[nar_UI], IsVoidMatrix );
    fi;
    
    if compute_VI then
        if not IsBound( VI ) then
            VI := HomalgIdentityMatrix( NrColumns( M ), R );
        fi;
        SetPreEval( arg[nar_VI], VI );
        ResetFilterObj( arg[nar_VI], IsVoidMatrix );
    fi;
    
    return M;
    
end );
