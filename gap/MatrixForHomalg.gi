#############################################################################
##
##  MatrixForHomalg.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg matrices.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the category IsMatrixForHomalg:
DeclareRepresentation( "IsHomalgInternalMatrixRep",
        IsMatrixForHomalg,
        [ ] );

DeclareRepresentation( "IsHomalgExternalMatrixRep",
        IsMatrixForHomalg,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgMatricesFamily",
        NewFamily( "HomalgMatricesFamily" ) );

# two new types:
BindGlobal( "HomalgInternalMatrixType",
        NewType( HomalgMatricesFamily ,
                IsHomalgInternalMatrixRep ) );

BindGlobal( "HomalgExternalMatrixType",
        NewType( HomalgMatricesFamily ,
                IsHomalgExternalMatrixRep ) );

####################################
#
# logical implications methods:
#
####################################

##
InstallTrueMethod( IsZeroMatrix, IsMatrixForHomalg and IsEmptyMatrix );

##
InstallTrueMethod( IsFullRowRankMatrix, IsMatrixForHomalg and IsIdentityMatrix );

##
InstallTrueMethod( IsFullColumnRankMatrix, IsMatrixForHomalg and IsIdentityMatrix );

##
InstallTrueMethod( IsUpperTriangularMatrix, IsMatrixForHomalg and IsDiagonalMatrix );

##
InstallTrueMethod( IsLowerTriangularMatrix, IsMatrixForHomalg and IsDiagonalMatrix );

##
InstallTrueMethod( IsUpperTriangularMatrix, IsMatrixForHomalg and IsStrictUpperTriangularMatrix );

##
InstallTrueMethod( IsLowerTriangularMatrix, IsMatrixForHomalg and IsStrictLowerTriangularMatrix );

##
InstallTrueMethod( IsTriangularMatrix, IsMatrixForHomalg and IsUpperTriangularMatrix );

##
InstallTrueMethod( IsTriangularMatrix, IsMatrixForHomalg and IsLowerTriangularMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsMatrixForHomalg and IsUpperTriangularMatrix and IsLowerTriangularMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsMatrixForHomalg and IsZeroMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsMatrixForHomalg and IsIdentityMatrix );

##
InstallTrueMethod( IsZeroMatrix, IsMatrixForHomalg and IsStrictUpperTriangularMatrix and IsStrictLowerTriangularMatrix );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsEmptyMatrix,
        IsMatrixForHomalg and HasNrRows and HasNrColumns, 0,
        
  function( M )
    
    if NrRows( M ) = 0 or NrColumns( M ) = 0 then
        return true;
    else
        return false;
    fi;
    
end );

##
InstallImmediateMethod( IsEmptyMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsEmptyMatrix( PreEval( M ) ) then
        return IsEmptyMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMatrix,
        IsMatrixForHomalg and HasEvalCertainRows, 0,
        
  function( M )
    
    if HasIsZeroMatrix( EvalCertainRows( M )[1] ) and IsZeroMatrix( EvalCertainRows( M )[1] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMatrix,
        IsMatrixForHomalg and HasEvalCertainColumns, 0,
        
  function( M )
    
    if HasIsZeroMatrix( EvalCertainColumns( M )[1] ) and IsZeroMatrix( EvalCertainColumns( M )[1] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsZeroMatrix( PreEval( M ) ) then
        return IsZeroMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullRowRankMatrix,
        IsMatrixForHomalg and HasNrRows, 0,
        
  function( M )
    
    if NrRows( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullRowRankMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsFullRowRankMatrix( PreEval( M ) ) then
        return IsFullRowRankMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullColumnRankMatrix,
        IsMatrixForHomalg and HasNrColumns, 0,
        
  function( M )
    
    if NrColumns( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullColumnRankMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsFullColumnRankMatrix( PreEval( M ) ) then
        return IsFullColumnRankMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullRowRankMatrix,
        IsMatrixForHomalg and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsFullColumnRankMatrix( EvalInvolution( M ) ) then
        return IsFullColumnRankMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullColumnRankMatrix,
        IsMatrixForHomalg and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsFullRowRankMatrix( EvalInvolution( M ) ) then
        return IsFullRowRankMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsMatrixForHomalg and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsLowerTriangularMatrix( EvalInvolution( M ) ) then
        return IsLowerTriangularMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsMatrixForHomalg and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsUpperTriangularMatrix( EvalInvolution( M ) ) then
        return IsUpperTriangularMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsMatrixForHomalg and HasEvalCertainRows, 0,
        
  function( M )
    local C;
    
    C := EvalCertainRows( M );
    
    if HasIsUpperTriangularMatrix( C[1] ) and IsUpperTriangularMatrix( C[1] )
       and ( C[2] = NrRows( C[1] ) + [ - Length( C[2] ) .. 0 ]
             or C[2] = [ 1 .. Length( C[2] ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsMatrixForHomalg and HasEvalCertainColumns, 0,
        
  function( M )
    local C;
    
    C := EvalCertainColumns( M );
    
    if HasIsLowerTriangularMatrix( C[1] ) and IsLowerTriangularMatrix( C[1] )
       and ( C[2] = NrColumns( C[1] ) + [ - Length( C[2] ) .. 0 ]
             or C[2] = [ 1 .. Length( C[2] ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsMatrixForHomalg and HasEvalCertainRows, 0,
        
  function( M )
    local C;
    
    C := EvalCertainRows( M );
    
    if HasIsDiagonalMatrix( C[1] ) and IsDiagonalMatrix( C[1] )
       and C[2] = [ 1 .. Length( C[2] ) ] then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsMatrixForHomalg and HasEvalCertainColumns, 0,
        
  function( M )
    local C;
    
    C := EvalCertainColumns( M );
    
    if HasIsDiagonalMatrix( C[1] ) and IsDiagonalMatrix( C[1] )
       and C[2] = [ 1 .. Length( C[2] ) ] then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsDiagonalMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsDiagonalMatrix( PreEval( M ) ) then
        return IsDiagonalMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsUpperTriangularMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsUpperTriangularMatrix( PreEval( M ) ) then
        return IsUpperTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsLowerTriangularMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsLowerTriangularMatrix( PreEval( M ) ) then
        return IsLowerTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsStrictUpperTriangularMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsStrictUpperTriangularMatrix( PreEval( M ) ) then
        return IsStrictUpperTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsStrictLowerTriangularMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasIsStrictLowerTriangularMatrix( PreEval( M ) ) then
        return IsStrictLowerTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( NrRows,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasNrRows( PreEval( M ) ) then
        return NrRows( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( NrColumns,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasNrColumns( PreEval( M ) ) then
        return NrColumns( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsMatrixForHomalg and HasIsIdentityMatrix and HasNrRows, 0,
        
  function( M )
    
    return NrRows( M );
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsMatrixForHomalg and HasIsIdentityMatrix and HasNrColumns, 0,
        
  function( M )
    
    return NrColumns( M );
        
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsMatrixForHomalg and HasIsZeroMatrix, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsMatrixForHomalg and HasIsZeroMatrix, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsMatrixForHomalg and HasEvalInvolution, 0,
        
  function( M )
    
    if HasColumnRankOfMatrix( EvalInvolution( M ) ) then
        return ColumnRankOfMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsMatrixForHomalg and HasEvalInvolution, 0,
        
  function( M )
    
    if HasRowRankOfMatrix( EvalInvolution( M ) ) then
        return RowRankOfMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasRowRankOfMatrix( PreEval( M ) ) then
        return RowRankOfMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsMatrixForHomalg and HasPreEval, 0,
        
  function( M )
    
    if HasColumnRankOfMatrix( PreEval( M ) ) then
        return ColumnRankOfMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZeroMatrix,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( M )
    
    return M = MatrixForHomalg( "zero", NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );



####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( M )
    
    return M!.ring;
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalMatrixRep ],
        
  function( M1, M2 )
    
    return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) and Eval( M1 ) = Eval( M2 );
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix, IsMatrixForHomalg and IsZeroMatrix ],
        
  function( M1, M2 )
    
    return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
           and NrRows( M1 ) = NrRows( M2 ) and NrColumns( M1 ) = NrColumns( M2 );
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix, IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( M1, M2 )
    
    return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) and NrRows( M1 ) = NrRows( M2 );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( M )
    local R, C;
    
    R := HomalgRing( M );
    
    if IsHomalgInternalMatrixRep( M ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalInvolution( C, M );
    
    SetNrRows( C, NrColumns( M ) );
    SetNrColumns( C, NrRows( M ) );
    
    return C;
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( M )
    
    return MatrixForHomalg( "zero", NrColumns( M ), NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( M )
    
    return MatrixForHomalg( "identity", NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsMatrixForHomalg, IsList ],
        
  function( M, plist )
    local R, C;
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    if IsHomalgInternalMatrixRep( M ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalCertainRows( C, [ M, plist ] );
    
    SetNrRows( C, Length( plist ) );
    SetNrColumns( C, NrColumns( M ) );
    
    return C;
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsMatrixForHomalg, IsList ],
        
  function( M, plist )
    local R, C;
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    if IsHomalgInternalMatrixRep( M ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalCertainColumns( C, [ M, plist ] );
    
    SetNrRows( C, NrRows( M ) );
    SetNrColumns( C, Length( plist ) );
    
    return C;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, C;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) and IsHomalgInternalMatrixRep( B ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalUnionOfRows( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) + NrRows( B ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsEmptyMatrix, IsMatrixForHomalg ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsEmptyMatrix, IsMatrixForHomalg and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return MatrixForHomalg( "zero", NrRows( A ) + NrRows( B ), NrColumns( A ), HomalgRing( A ) );
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) and IsHomalgInternalMatrixRep( B ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalUnionOfColumns( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) + NrColumns( B ) );
    
    return C;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsEmptyMatrix, IsMatrixForHomalg ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsEmptyMatrix, IsMatrixForHomalg and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    return MatrixForHomalg( "zero", NrRows( A ), NrColumns( A ) + NrColumns( B ), HomalgRing( A ) );
    
end );

##
InstallMethod( DiagMat,
        "of two homalg matrices",
        [ IsHomogeneousList ],
        
  function( l )
    local R, C;
    
    if l = [] then
        Error( "recieved an empty list\n" );
    fi;
    
    if not ForAll( l, IsMatrixForHomalg ) then
        Error( "at least one of the matrices in the list is not a homalg matrix\n" );
    fi;
    
    R := HomalgRing( l[1] );
    
    if ForAll( l, IsHomalgInternalMatrixRep ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalDiagMat( C, l );
    
    SetNrRows( C, Sum( List( l, NrRows ) ) );
    SetNrColumns( C, Sum( List( l, NrColumns ) ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsRingElement, IsMatrixForHomalg ],
        
  function( a, A )
    local R, C;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalMulMat( C, [ a, A ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsZero, IsMatrixForHomalg ],
        
  function( a, A )
    local R;
    
    R := HomalgRing( A );
    
    return MatrixForHomalg( "zero", NrRows( A ), NrColumns( A ), R );
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsOne, IsMatrixForHomalg ],
        
  function( a, A )
    
    return A;
    
end );

##
InstallMethod( \*,
        "of homalg matrices",
        [ IsRingElement, IsMatrixForHomalg and IsZeroMatrix ],
        
  function( a, A )
    
    return A;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) and IsHomalgInternalMatrixRep( B ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalAddMat( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix, IsMatrixForHomalg ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg and IsZeroMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return A;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseSameMutability,
        "of homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( A )
    local R;
    
    R := HomalgRing( A );
    
    return MinusOne( R ) * A;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseSameMutability,
        "of homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( A )
    
    return A;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not substractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not substractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) and IsHomalgInternalMatrixRep( B ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalSubMat( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix, IsMatrixForHomalg ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return -B;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg and IsZeroMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local R, C;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) and IsHomalgInternalMatrixRep( B ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalCompose( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( B ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix, IsMatrixForHomalg ],
        
  function( A, B )
    local R;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    R := HomalgRing( A );
    
    return MatrixForHomalg( "zero", NrRows( A ), NrColumns( B ), R );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg and IsZeroMatrix ],
        
  function( A, B )
    local R;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    R := HomalgRing( B );
    
    return MatrixForHomalg( "zero", NrRows( A ), NrColumns( B ), R );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix, IsMatrixForHomalg ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( AddRhs,				### defines: AddRhs
        "of homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( A )
    local C;
    
    C := MatrixForHomalg( A );
    
    SetEvalAddRhs( C, true );
    
    SetRightHandSide( C, MatrixForHomalg( "identity", NrRows( A ), HomalgRing( A ) ) );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( AddRhs,				### defines: AddRhs
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the second matrix cannot become a right hand side of the first, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    C := MatrixForHomalg( A );
    
    SetEvalAddRhs( C, true );
    
    SetRightHandSide( C, B );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( AddBts,				### defines: AddBts
        "of homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( A )
    local C;
    
    C := MatrixForHomalg( A );
    
    SetEvalAddBts( C, true );
    
    SetBottomSide( C, MatrixForHomalg( "identity", NrColumns( A ), HomalgRing( A ) ) );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( AddBts,				### defines: AddBts
        "of two homalg matrices",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( A, B )
    local C;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the second matrix cannot become a bottom side of the first, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), " column(s)\n" );
    fi;
    
    C := MatrixForHomalg( A );
    
    SetEvalAddBts( C, true );
    
    SetBottomSide( C, B );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( GetSide,
        "of homalg matrices",
        [ IsString, IsMatrixForHomalg ],
        
  function( side, A )
    local R, C;
    
    R := HomalgRing( A );
    
    if IsHomalgInternalMatrixRep( A ) then
        C := MatrixForHomalg( "internal", R );
    else
        C := MatrixForHomalg( "external", R );
    fi;
    
    SetEvalGetSide( C, [ side, A ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( ZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix and HasNrRows ],
        
  function( C )
    
    return [ 1 .. NrRows( C ) ];
    
end );

##
InstallMethod( ZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix and HasNrColumns ],
        
  function( C )
    
    return [ 1 .. NrColumns( C ) ];
    
end );

##
InstallMethod( ZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( ZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( NonZeroRows,
        "for homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( C )
    
    return Filtered( [ 1 .. NrRows( C ) ], x -> not x in ZeroRows( C ) );
    
end );

##
InstallMethod( NonZeroColumns,
        "for homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( C )
    
    return Filtered( [ 1 .. NrColumns( C ) ], x -> not x in ZeroColumns( C ) );
    
end );

##
InstallMethod( NonZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( NonZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( NonZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix and HasNrRows ],
        
  function( C )
    
    return [ 1 .. NrRows( C ) ];
    
end );

##
InstallMethod( NonZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix and HasNrColumns ],
        
  function( C )
    
    return [ 1 .. NrColumns( C ) ];
    
end );

##
InstallMethod( RowRankOfMatrix,			 	## FIXME: make it an InstallImmediateMethod
        [ IsMatrixForHomalg and IsTriangularMatrix ],
        
  function( M )
    
    return Length( NonZeroRows( M ) );
        
end );

##
InstallMethod( ColumnRankOfMatrix,			## FIXME: make it an InstallImmediateMethod
        [ IsMatrixForHomalg and IsTriangularMatrix ],
        
  function( M )
    
    return Length( NonZeroColumns( M ) );
        
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( MatrixForHomalg,
  function( arg )
    local nargs, R, ar, matrix, M;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsMatrixForHomalg( arg[1] ) then
        
        R := HomalgRing( arg[1] );
        
        if IsHomalgInternalMatrixRep( arg[1] ) then
            M := MatrixForHomalg( "internal", R );
        else
            M := MatrixForHomalg( "external", R );
        fi;
        
        SetPreEval( M, arg[1] );
        
        return M;
        
    fi;
    
    R := arg[nargs];
    
    if not IsRingForHomalg( R ) then
        Error( "the last argument must be an IsRingForHomalg" );
    fi;
    
    matrix := rec( ring := R );
    
    ## an empty matrix:
    if IsString( arg[1] ) and Length( arg[1] ) > 2 then
        if LowercaseString( arg[1]{[1..3]} ) = "int" then
            
            ## Objectify:
            Objectify( HomalgInternalMatrixType, matrix );
            
            return matrix;
            
        elif LowercaseString( arg[1]{[1..3]} ) = "ext" then
            ## Objectify:
            Objectify( HomalgExternalMatrixType, matrix );
            
            return matrix;
            
        fi;
    fi;
    
    ## the identity matrix:
    if IsString( arg[1] ) and Length( arg[1] ) > 1 and  LowercaseString( arg[1]{[1..2]} ) = "id" then
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgInternalMatrixType,
                IsIdentityMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
            SetNrColumns( matrix, arg[2] );
        fi;
        
        return matrix;
        
    fi;
    
    ## the zero matrix:
    if IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "zero" then
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgInternalMatrixType,
                IsZeroMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
	    if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
                SetNrColumns( matrix, arg[3] );
            fi;
        fi;
        
        return matrix;
        
    fi;
        
    if IsList( arg[1] ) and Length( arg[1] ) <> 0 and not IsList( arg[1][1] ) then
        M := List( arg[1], a -> [a] ); ## NormalizeInput
    else
        M := arg[1];
    fi;
    
    if IsList( arg[1] ) then ## HomalgInternalMatrixType
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgInternalMatrixType,
                Eval, M );
        
        if Length( arg[1] ) = 0 then
            SetNrRows( matrix, 0 );
            SetNrColumns( matrix, 0 );
        elif arg[1][1] = [] then
            SetNrRows( matrix, Length( arg[1] ) );
            SetNrColumns( matrix, 0 );
        elif not IsList( arg[1][1] ) then
            SetNrRows( matrix, Length( arg[1] ) );
            SetNrColumns( matrix, 1 );
        elif IsMatrix( arg[1] ) then
            SetNrRows( matrix, Length( arg[1] ) );
            SetNrColumns( matrix, Length( arg[1][1] ) );
        fi;
    else ## HomalgExternalMatrixType
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, HomalgExternalMatrixType,
                Eval, M );
        
    fi;
    
    return matrix;
    
end );
  
####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( o )
    
    Print( "<A homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
    fi;
    
    if HasNrColumns( o ) then
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "zero matrix>" );
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( o )
    
    Print( "<A homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
    fi;
    
    if HasNrColumns( o ) then
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "identity matrix>" );
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsMatrixForHomalg ],
        
  function( o )
    
    Print( "<A homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
    fi;
    
    if HasNrColumns( o ) then
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "matrix>" );
    
end );

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( o )
    
    Print( Eval( o ), "\n" );
    
end);
