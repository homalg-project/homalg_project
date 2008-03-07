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

# two new representations for the category IsHomalgMatrix:
DeclareRepresentation( "IsHomalgInternalMatrixRep",
        IsHomalgMatrix,
        [ ] );

DeclareRepresentation( "IsHomalgExternalMatrixRep",
        IsHomalgMatrix,
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
InstallTrueMethod( IsZeroMatrix, IsHomalgMatrix and IsEmptyMatrix );

##
InstallTrueMethod( IsFullRowRankMatrix, IsHomalgMatrix and IsIdentityMatrix );

##
InstallTrueMethod( IsFullColumnRankMatrix, IsHomalgMatrix and IsIdentityMatrix );

##
InstallTrueMethod( IsUpperTriangularMatrix, IsHomalgMatrix and IsDiagonalMatrix );

##
InstallTrueMethod( IsLowerTriangularMatrix, IsHomalgMatrix and IsDiagonalMatrix );

##
InstallTrueMethod( IsUpperTriangularMatrix, IsHomalgMatrix and IsStrictUpperTriangularMatrix );

##
InstallTrueMethod( IsLowerTriangularMatrix, IsHomalgMatrix and IsStrictLowerTriangularMatrix );

##
InstallTrueMethod( IsTriangularMatrix, IsHomalgMatrix and IsUpperTriangularMatrix );

##
InstallTrueMethod( IsTriangularMatrix, IsHomalgMatrix and IsLowerTriangularMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsHomalgMatrix and IsUpperTriangularMatrix and IsLowerTriangularMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsStrictUpperTriangularMatrix, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsStrictLowerTriangularMatrix, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsHomalgMatrix and IsIdentityMatrix );

##
InstallTrueMethod( IsZeroMatrix, IsHomalgMatrix and IsStrictUpperTriangularMatrix and IsStrictLowerTriangularMatrix );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsEmptyMatrix,
        IsHomalgMatrix and HasNrRows and HasNrColumns, 0,
        
  function( M )
    
    if NrRows( M ) = 0 or NrColumns( M ) = 0 then
        return true;
    else
        return false;
    fi;
    
end );

##
InstallImmediateMethod( IsEmptyMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsEmptyMatrix( PreEval( M ) ) then
        return IsEmptyMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    
    if HasIsZeroMatrix( EvalCertainRows( M )[1] ) and IsZeroMatrix( EvalCertainRows( M )[1] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMatrix,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    
    if HasIsZeroMatrix( EvalCertainColumns( M )[1] ) and IsZeroMatrix( EvalCertainColumns( M )[1] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsZeroMatrix( PreEval( M ) ) then
        return IsZeroMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullRowRankMatrix,
        IsHomalgMatrix and HasNrRows, 0,
        
  function( M )
    
    if NrRows( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullRowRankMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsFullRowRankMatrix( PreEval( M ) ) then
        return IsFullRowRankMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullColumnRankMatrix,
        IsHomalgMatrix and HasNrColumns, 0,
        
  function( M )
    
    if NrColumns( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullColumnRankMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsFullColumnRankMatrix( PreEval( M ) ) then
        return IsFullColumnRankMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullRowRankMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsFullColumnRankMatrix( EvalInvolution( M ) ) then
        return IsFullColumnRankMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFullColumnRankMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsFullRowRankMatrix( EvalInvolution( M ) ) then
        return IsFullRowRankMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsLowerTriangularMatrix( EvalInvolution( M ) ) then
        return IsLowerTriangularMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsUpperTriangularMatrix( EvalInvolution( M ) ) then
        return IsUpperTriangularMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
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
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
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
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
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
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
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
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsDiagonalMatrix( PreEval( M ) ) then
        return IsDiagonalMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsUpperTriangularMatrix( PreEval( M ) ) then
        return IsUpperTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsLowerTriangularMatrix( PreEval( M ) ) then
        return IsLowerTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsStrictUpperTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsStrictUpperTriangularMatrix( PreEval( M ) ) then
        return IsStrictUpperTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

InstallImmediateMethod( IsStrictLowerTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
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
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasNrRows( PreEval( M ) ) then
        return NrRows( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( NrColumns,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasNrColumns( PreEval( M ) ) then
        return NrColumns( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasIsIdentityMatrix and HasNrRows, 0,
        
  function( M )
    
    return NrRows( M );
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasIsIdentityMatrix and HasNrColumns, 0,
        
  function( M )
    
    return NrColumns( M );
        
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasIsZeroMatrix, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasIsZeroMatrix, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasColumnRankOfMatrix( EvalInvolution( M ) ) then
        return ColumnRankOfMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasRowRankOfMatrix( EvalInvolution( M ) ) then
        return RowRankOfMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasRowRankOfMatrix( PreEval( M ) ) then
        return RowRankOfMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
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
        [ IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix ],
        
  function( M )
    
    return M!.ring;
    
end );

##
InstallMethod( HomalgPointer,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return HomalgPointer( Eval( M ) );
    
end );

##
InstallMethod( HomalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return HomalgExternalCASystem( Eval( M ) );
    
end );

##
InstallMethod( HomalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return HomalgExternalCASystemVersion( Eval( M ) );
    
end );

##
InstallMethod( HomalgStream,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return HomalgStream( Eval( M ) );
    
end );

##
InstallMethod( HomalgExternalCASystemPID,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return HomalgExternalCASystemPID( Eval( M ) );
    
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
        [ IsHomalgExternalMatrixRep, IsHomalgExternalMatrixRep ],
        
  function( M1, M2 )
    local R, RP;
    
    if not IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) then
        return false;
    fi;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.Equal) and IsBound(RP!.True) then
        return RP!.Equal( M1, M2 ) = RP!.True;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( M1, M2 )
    
    return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
           and NrRows( M1 ) = NrRows( M2 ) and NrColumns( M1 ) = NrColumns( M2 );
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M1, M2 )
    
    return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) and NrRows( M1 ) = NrRows( M2 );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, C;
    
    R := HomalgRing( M );
    
    C := MatrixForHomalg( R );
    
    SetEvalInvolution( C, M );
    
    SetNrRows( C, NrColumns( M ) );
    SetNrColumns( C, NrRows( M ) );
    
    return C;
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    return MatrixForHomalg( "zero", NrColumns( M ), NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    return MatrixForHomalg( "identity", NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    local R, C;
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    C := MatrixForHomalg( R );
    
    SetEvalCertainRows( C, [ M, plist ] );
    
    SetNrRows( C, Length( plist ) );
    SetNrColumns( C, NrColumns( M ) );
    
    return C;
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    local R, C;
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    C := MatrixForHomalg( R );
    
    SetEvalCertainColumns( C, [ M, plist ] );
    
    SetNrRows( C, NrRows( M ) );
    SetNrColumns( C, Length( plist ) );
    
    return C;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalUnionOfRows( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) + NrRows( B ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    return MatrixForHomalg( "zero", NrRows( A ) + NrRows( B ), NrColumns( A ), HomalgRing( A ) );
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalUnionOfColumns( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) + NrColumns( B ) );
    
    return C;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
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
    
    if not ForAll( l, IsHomalgMatrix ) then
        Error( "at least one of the matrices in the list is not a homalg matrix\n" );
    fi;
    
    R := HomalgRing( l[1] );
    
    C := MatrixForHomalg( R );
    
    SetEvalDiagMat( C, l );
    
    SetNrRows( C, Sum( List( l, NrRows ) ) );
    SetNrColumns( C, Sum( List( l, NrColumns ) ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsRingElement, IsHomalgMatrix ],
        
  function( a, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalMulMat( C, [ a, A ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgExternalObject, IsHomalgMatrix ],
        
  function( a, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalMulMat( C, [ a, A ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsZero, IsHomalgMatrix ],
        
  function( a, A )
    local R;
    
    R := HomalgRing( A );
    
    return MatrixForHomalg( "zero", NrRows( A ), NrColumns( A ), R );
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsOne, IsHomalgMatrix ],
        
  function( a, A )
    
    return A;
    
end );

##
InstallMethod( \*,
        "of homalg matrices",
        [ IsRingElement, IsHomalgMatrix and IsZeroMatrix ],
        
  function( a, A )
    
    return A;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalAddMat( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
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
        [ IsHomalgMatrix ],
        
  function( A )
    local R;
    
    R := HomalgRing( A );
    
    return MinusOne( R ) * A;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseSameMutability,
        "of homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( A )
    
    return A;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not substractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not substractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalSubMat( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
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
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalCompose( C, [ A, B ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( B ) );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
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
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    return B;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsIdentityMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    return A;
    
end );

##
InstallMethod( AddRhs,				### defines: AddRhs
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix ],
        
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
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
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
        [ IsString, IsHomalgMatrix ],
        
  function( side, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := MatrixForHomalg( R );
    
    SetEvalGetSide( C, [ side, A ] );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    return C;
    
end );

##
InstallMethod( ZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix and HasNrRows ],
        
  function( C )
    
    return [ 1 .. NrRows( C ) ];
    
end );

##
InstallMethod( ZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix and HasNrColumns ],
        
  function( C )
    
    return [ 1 .. NrColumns( C ) ];
    
end );

##
InstallMethod( ZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( ZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( NonZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    
    return Filtered( [ 1 .. NrRows( C ) ], x -> not x in ZeroRows( C ) );
    
end );

##
InstallMethod( NonZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    
    return Filtered( [ 1 .. NrColumns( C ) ], x -> not x in ZeroColumns( C ) );
    
end );

##
InstallMethod( NonZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( NonZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( C )
    
    return [ ];
    
end );

##
InstallMethod( NonZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix and HasNrRows ],
        
  function( C )
    
    return [ 1 .. NrRows( C ) ];
    
end );

##
InstallMethod( NonZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix and HasNrColumns ],
        
  function( C )
    
    return [ 1 .. NrColumns( C ) ];
    
end );

##
InstallMethod( RowRankOfMatrix,			 	## FIXME: make it an InstallImmediateMethod
        [ IsHomalgMatrix and IsTriangularMatrix ],
        
  function( M )
    
    return Length( NonZeroRows( M ) );
        
end );

##
InstallMethod( ColumnRankOfMatrix,			## FIXME: make it an InstallImmediateMethod
        [ IsHomalgMatrix and IsTriangularMatrix ],
        
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
    local nargs, R, type, ar, matrix, M;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgMatrix( arg[1] ) then
        
        R := HomalgRing( arg[1] );
        
        M := MatrixForHomalg( R );
        
        SetPreEval( M, arg[1] );
        
        return M;
        
    fi;
    
    R := arg[nargs];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing" );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := HomalgInternalMatrixType;
    else
        type := HomalgExternalMatrixType;
    fi;
    
    matrix := rec( ring := R );
    
    ## an empty matrix:
    if nargs = 1 then ## only the ring is given
        
        ## Objectify:
        Objectify( type, matrix );
        
        return matrix;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 then ## it can get obscure ;)
        
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
                matrix, type,
                IsIdentityMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
            SetNrColumns( matrix, arg[2] );
        fi;
        
        return matrix;
        
    fi;
    
    ## an empty matrix filled zeros:
    if IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "init" then
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
	    if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
                SetNrColumns( matrix, arg[3] );
            fi;
        fi;
        
        return matrix;
        
    fi;
        
    ## the zero matrix:
    if IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "zero" then
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
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
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( o )
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "zero matrix>" );
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( o )
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "identity matrix>" );
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( o )
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "matrix>" );
    
end );

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( o )
    
    Display( Eval( o ) );
    
end);

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( o )
    local cas;
    
    cas := HomalgExternalCASystem( o );
    
    if Length( cas ) > 4 and LowercaseString( cas{[1..5]} ) = "maple" then
        Print( HomalgSendBlocking( [ "eval(", o, ")" ], "need_output" ), "\n" );
    else
        Print( HomalgSendBlocking( [ o ], "need_output" ), "\n" );
    fi;
    
end);
