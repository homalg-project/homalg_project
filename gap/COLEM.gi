#############################################################################
##
##  COLEM.gi                    COLEM subpackage             Mohamed Barakat
##
##         COLEM = Clever Operations for Lazy Evaluated Matrices
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the COLEM subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( COLEM,
        rec(
            color := "\033[4;30;46m",
            level := 10,
            single_operations := 10,
            )
        );

####################################
#
# logical implications methods:
#
####################################

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
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsZero( PreEval( M ) ) then
        return IsZero( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsZero( EvalInvolution( M ) ) then
        return IsZero( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalLeftInverse, 0,
        
  function( M )
    
    if HasIsZero( EvalLeftInverse( M ) ) then
        return IsZero( EvalLeftInverse( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalRightInverse, 0,
        
  function( M )
    
    if HasIsZero( EvalRightInverse( M ) ) then
        return IsZero( EvalRightInverse( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalInverse, 0,
        
  function( M )
    
    if HasIsZero( EvalInverse( M ) ) then
        return IsZero( EvalInverse( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    
    if HasIsZero( EvalCertainRows( M )[1] ) and IsZero( EvalCertainRows( M )[1] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    
    if HasIsZero( EvalCertainColumns( M )[1] ) and IsZero( EvalCertainColumns( M )[1] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    
    if HasIsZero( EvalUnionOfRows( M )[1] ) and IsZero( EvalUnionOfRows( M )[1] )
       and HasIsZero( EvalUnionOfRows( M )[2] ) and IsZero( EvalUnionOfRows( M )[2] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    
    if HasIsZero( EvalUnionOfColumns( M )[1] ) and IsZero( EvalUnionOfColumns( M )[1] )
       and HasIsZero( EvalUnionOfColumns( M )[2] ) and IsZero( EvalUnionOfColumns( M )[2] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerRow( M );
    
    return Set( pos ) in [ [ ], [ 0 ] ];
    
end );

##
InstallImmediateMethod( IsIdentityMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsIdentityMatrix( PreEval( M ) ) then
        return IsIdentityMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsIdentityMatrix,
        IsHomalgMatrix and IsPermutationMatrix and HasPositionOfFirstNonZeroEntryPerRow and HasNrRows, 0,
        
  function( M )
    
    return PositionOfFirstNonZeroEntryPerRow( M ) = [ 1 .. NrRows( M ) ];
    
end );

##
InstallImmediateMethod( IsPermutationMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsPermutationMatrix( PreEval( M ) ) then
        return IsPermutationMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSubidentityMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsSubidentityMatrix( PreEval( M ) ) then
        return IsSubidentityMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSubidentityMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local mat, plist, pos, pos_non_zero;
    
    mat := EvalCertainRows( M )[1];
    plist := EvalCertainRows( M )[2];
    
    if HasIsSubidentityMatrix( mat ) and IsSubidentityMatrix( mat ) then
        
        if HasNrRows( mat ) and HasNrColumns( mat )
           and NrRows( mat ) <= NrColumns( mat ) then
            
            return IsDuplicateFree( plist );
            
        fi;
        
        if HasPositionOfFirstNonZeroEntryPerRow( mat ) and HasNrColumns( mat ) then
            
            pos := PositionOfFirstNonZeroEntryPerRow( mat );
            
            pos := pos{ plist };
            
            pos_non_zero := Filtered( pos, i -> i <> 0 );
            
            if not IsDuplicateFree( pos_non_zero ) then
                return false;
            fi;
            
            if not 0 in pos					## NrRows( M ) <= NrColumns( M )
               or  Length( pos_non_zero ) = NrColumns( mat )	## NrColumns( M ) <= NrRows( M )
               then
                return true;
            fi;
            
            return false;
            
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSubidentityMatrix,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local mat, plist, pos, plist_non_zero;
    
    mat := EvalCertainColumns( M )[1];
    plist := EvalCertainColumns( M )[2];
    
    if HasIsSubidentityMatrix( mat ) and IsSubidentityMatrix( mat ) then
        
        if HasNrColumns( mat ) and HasNrRows( mat )
           and NrColumns( mat ) <= NrRows( mat ) then
            
            return IsDuplicateFree( plist );
            
        fi;
        
        if HasPositionOfFirstNonZeroEntryPerRow( mat ) and HasNrRows( mat ) then
            
            pos := PositionOfFirstNonZeroEntryPerRow( mat );
            
            plist := List( plist, function( i ) if i in pos then return i; else return 0; fi; end );
            
            plist_non_zero := Filtered( plist, i -> i <> 0 );
            
            if not IsDuplicateFree( plist_non_zero ) then
                return false;
            fi;
            
            if not 0 in plist 					## NrColumns( M ) <= NrRows( M )
               or Length( plist_non_zero ) = NrRows( mat )	## NrRows( M ) <= NrColumns( M )
               then
                return true;
            fi;
            
            return false;
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsRightInvertibleMatrix( PreEval( M ) ) then
        return IsRightInvertibleMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsLeftInvertibleMatrix( EvalInvolution( M ) ) then
        return IsLeftInvertibleMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfColumns( M );
    
    if ( HasIsRightInvertibleMatrix( e[1] ) and IsRightInvertibleMatrix( e[1] ) ) or
       ( HasIsRightInvertibleMatrix( e[2] ) and IsRightInvertibleMatrix( e[2] ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsLeftInvertibleMatrix( PreEval( M ) ) then
        return IsLeftInvertibleMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsRightInvertibleMatrix( EvalInvolution( M ) ) then
        return IsRightInvertibleMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfRows( M );
    
    if ( HasIsLeftInvertibleMatrix( e[1] ) and IsLeftInvertibleMatrix( e[1] ) ) or
       ( HasIsLeftInvertibleMatrix( e[2] ) and IsLeftInvertibleMatrix( e[2] ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsLeftRegularMatrix( PreEval( M ) ) then
        return IsLeftRegularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsRightRegularMatrix( EvalInvolution( M ) ) then
        return IsRightRegularMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsRightRegularMatrix( PreEval( M ) ) then
        return IsRightRegularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsLeftRegularMatrix( EvalInvolution( M ) ) then
        return IsLeftRegularMatrix( EvalInvolution( M ) );
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
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsUpperTriangularMatrix( PreEval( M ) ) then
        return IsUpperTriangularMatrix( PreEval( M ) );
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
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsLowerTriangularMatrix( PreEval( M ) ) then
        return IsLowerTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsLowerStairCaseMatrix( EvalInvolution( M ) ) then
        return IsLowerStairCaseMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local C;
    
    C := EvalCertainRows( M );
    
    if HasIsUpperStairCaseMatrix( C[1] ) and IsUpperStairCaseMatrix( C[1] )
       and ( C[2] = NrRows( C[1] ) + [ - Length( C[2] ) .. 0 ]
             or C[2] = [ 1 .. Length( C[2] ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsUpperStairCaseMatrix( PreEval( M ) ) then
        return IsUpperStairCaseMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    
    if HasIsUpperStairCaseMatrix( EvalInvolution( M ) ) then
        return IsUpperStairCaseMatrix( EvalInvolution( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local C;
    
    C := EvalCertainColumns( M );
    
    if HasIsLowerStairCaseMatrix( C[1] ) and IsLowerStairCaseMatrix( C[1] )
       and ( C[2] = NrColumns( C[1] ) + [ - Length( C[2] ) .. 0 ]
             or C[2] = [ 1 .. Length( C[2] ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsLowerStairCaseMatrix( PreEval( M ) ) then
        return IsLowerStairCaseMatrix( PreEval( M ) );
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

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsDiagonalMatrix( PreEval( M ) ) then
        return IsDiagonalMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsStrictUpperTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasIsStrictUpperTriangularMatrix( PreEval( M ) ) then
        return IsStrictUpperTriangularMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
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
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasRowRankOfMatrix( PreEval( M ) ) then
        return RowRankOfMatrix( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
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
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasIsLeftRegularMatrix and HasNrRows, 0,
        
  function( M )
    
    if IsLeftRegularMatrix( M ) then
        return NrRows( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and EvalUnionOfColumns, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfColumns( M );
    
    if HasRowRankOfMatrix( e[1] ) and HasRowRankOfMatrix( e[2] ) then
        if RowRankOfMatrix( e[1] ) = 0 then
            return RowRankOfMatrix( e[2] );
        elif RowRankOfMatrix( e[2] ) = 0 then
            return RowRankOfMatrix( e[1] );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and EvalUnionOfRows, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfRows( M );
    
    if HasRowRankOfMatrix( e[1] ) and HasRowRankOfMatrix( e[2] ) then
        if RowRankOfMatrix( e[1] ) = 0 then
            return RowRankOfMatrix( e[2] );
        elif RowRankOfMatrix( e[2] ) = 0 then
            return RowRankOfMatrix( e[1] );
        fi;
    fi;
    
    if HasRowRankOfMatrix( e[1] ) and RowRankOfMatrix( e[1] ) = NrColumns( e[1] ) then
        return NrColumns( e[1] );
    elif HasRowRankOfMatrix( e[2] ) and RowRankOfMatrix( e[2] ) = NrColumns( e[2] ) then
        return NrColumns( e[2] );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and EvalDiagMat, 0,
        
  function( M )
    local e;
    
    e := EvalDiagMat( M );
    
    if ForAll( e, HasRowRankOfMatrix ) then
        return Sum( List( e, RowRankOfMatrix ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasColumnRankOfMatrix, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then ## FIXME: make me more general!
        return ColumnRankOfMatrix( M );
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
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasIsRightRegularMatrix and HasNrColumns, 0,
        
  function( M )
    
    if IsRightRegularMatrix( M ) then
        return NrColumns( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and EvalUnionOfRows, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfRows( M );
    
    if HasColumnRankOfMatrix( e[1] ) and HasColumnRankOfMatrix( e[2] ) then
        if ColumnRankOfMatrix( e[1] ) = 0 then
            return ColumnRankOfMatrix( e[2] );
        elif ColumnRankOfMatrix( e[2] ) = 0 then
            return ColumnRankOfMatrix( e[1] );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and EvalUnionOfColumns, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfColumns( M );
    
    if HasColumnRankOfMatrix( e[1] ) and HasColumnRankOfMatrix( e[2] ) then
        if ColumnRankOfMatrix( e[1] ) = 0 then
            return ColumnRankOfMatrix( e[2] );
        elif ColumnRankOfMatrix( e[2] ) = 0 then
            return ColumnRankOfMatrix( e[1] );
        fi;
    fi;
    
    if HasColumnRankOfMatrix( e[1] ) and ColumnRankOfMatrix( e[1] ) = NrRows( e[1] ) then
        return NrRows( e[1] );
    elif HasColumnRankOfMatrix( e[2] ) and ColumnRankOfMatrix( e[2] ) = NrRows( e[2] ) then
        return NrRows( e[2] );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and EvalDiagMat, 0,
        
  function( M )
    local e;
    
    e := EvalDiagMat( M );
    
    if ForAll( e, HasColumnRankOfMatrix ) then
        return Sum( List( e, ColumnRankOfMatrix ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasRowRankOfMatrix, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then ## FIXME: make me more general!
        return RowRankOfMatrix( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    
    if HasPositionOfFirstNonZeroEntryPerRow( PreEval( M ) ) then
        return PositionOfFirstNonZeroEntryPerRow( PreEval( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local mat, pos;
    
    mat := EvalCertainRows( M )[1];
    
    if HasPositionOfFirstNonZeroEntryPerRow( mat ) then
        
        pos := PositionOfFirstNonZeroEntryPerRow( mat );
        
        return pos{ EvalCertainRows( M )[2] };
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and HasEvalCertainColumns and HasNrRows, 0,
        
  function( M )
    local mat, pos, plist;
    
    mat := EvalCertainColumns( M )[1];
    
    if HasPositionOfFirstNonZeroEntryPerRow( mat ) then
        
        pos := PositionOfFirstNonZeroEntryPerRow( mat );
        
        plist := EvalCertainColumns( M )[2];
        
        return List( [ 1 .. NrRows( M ) ], function( i ) if pos[i] in plist then return Position( plist, pos[i] ); else return 0; fi; end );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow and HasNrRows, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerRow( M );
    
    return Filtered( [ 1 .. NrRows( M ) ], i -> pos[i] = 0 );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow and IsSubidentityMatrix and HasNrColumns, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerRow( M );
    
    return Filtered( [ 1 .. NrColumns( M ) ], i -> not i in pos );
    
end );

####################################
#
# methods for operations:
#
####################################

#-----------------------------------
# Involution
#-----------------------------------

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "Involution( PreEval )", "\033[0m" );
    
    return Involution( PreEval( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "Involution( Involution )", "\033[0m" );
    
    return EvalInvolution( M );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "Involution( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    e := List( e, Involution );
    
    return DiagMat( e );
    
end );

#-----------------------------------
# CertainRows
#-----------------------------------

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsList ],
        
  function( M, plist )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: CertainRows( PreEval )", "\033[0m" );
    
    return CertainRows( PreEval( M ), plist );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainRows, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then ## otherwise we would take CertainRows of a bigger matrix
        
        Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( CertainRows )", "\033[0m" );
        
        A := EvalCertainRows( M )[1];
        plistA := EvalCertainRows( M )[2];
        
        return CertainRows( A, plistA{plist} );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainColumns, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then ## otherwise we would take CertainRows of a bigger matrix
        
        A := EvalCertainColumns( M )[1];
        plistA := EvalCertainColumns( M )[2];
        
        if Length( plist ) * NrColumns( A ) < Length( plistA ) * NrRows( A ) then
            
            Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( CertainColumns )", "\033[0m" );
            
            return CertainColumns( CertainRows( A, plist ), plistA );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
        
  function( M, plist )
    local A, B, rowsA, rowsB, plistA, plistB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( UnionOfRows )", "\033[0m" );
    
    A := EvalUnionOfRows( M )[1];
    B := EvalUnionOfRows( M )[2];
    
    rowsA := [ 1 .. NrRows( A ) ];
    rowsB := [ 1 .. NrRows( B ) ];
    
    plistA := Filtered( plist, x -> x in rowsA );		## CAUTION: don't use Intersection(2)
    plistB := Filtered( plist - NrRows( A ), x -> x in rowsB );	## CAUTION: don't use Intersection(2)
    
    return UnionOfRows( CertainRows( A, plistA ), CertainRows( B, plistB ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
        
  function( M, plist )
    local A, B;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( UnionOfColumns )", "\033[0m" );
    
    A := EvalUnionOfColumns( M )[1];
    B := EvalUnionOfColumns( M )[2];
    
    return UnionOfColumns( CertainRows( A, plist ), CertainRows( B, plist ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local A, B;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( Compose )", "\033[0m" );
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then
        A := EvalCompose( M )[1];
        B := EvalCompose( M )[2];
        
        return CertainRows( A, plist ) * B;
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# CertainColumns
#-----------------------------------

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsList ],
        
  function( M, plist )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: CertainColumns( PreEval )", "\033[0m" );
    
    return CertainColumns( PreEval( M ), plist );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainColumns, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then ## otherwise we would take CertainColumns of a bigger matrix
        
        Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( CertainColumns )", "\033[0m" );
    
        A := EvalCertainColumns( M )[1];
        plistA := EvalCertainColumns( M )[2];
        
        return CertainColumns( A, plistA{plist} );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainRows, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then ## otherwise we would take CertainColumns of a bigger matrix
        
        A := EvalCertainRows( M )[1];
        plistA := EvalCertainRows( M )[2];
        
        if Length( plist ) * NrRows( A ) < Length( plistA ) * NrColumns( A ) then
            
            Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( CertainRows )", "\033[0m" );
            
            return CertainRows( CertainColumns( A, plist ), plistA );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
        
  function( M, plist )
    local A, B, columnsA, columnsB, plistA, plistB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( UnionOfColumns )", "\033[0m" );
    
    A := EvalUnionOfColumns( M )[1];
    B := EvalUnionOfColumns( M )[2];
    
    columnsA := [ 1 .. NrColumns( A ) ];
    columnsB := [ 1 .. NrColumns( B ) ];
    
    plistA := Filtered( plist, x -> x in columnsA );			## CAUTION: don't use Intersection(2)
    plistB := Filtered( plist - NrColumns( A ), x -> x in columnsB );	## CAUTION: don't use Intersection(2)
    
    return UnionOfColumns( CertainColumns( A, plistA ), CertainColumns( B, plistB ) );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
        
  function( M, plist )
    local A, B;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( UnionOfRows )", "\033[0m" );
    
    A := EvalUnionOfRows( M )[1];
    B := EvalUnionOfRows( M )[2];
    
    return UnionOfRows( CertainColumns( A, plist ), CertainColumns( B, plist ) );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local A, B;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( Compose )", "\033[0m" );
        
        A := EvalCompose( M )[1];
        B := EvalCompose( M )[2];
        
        return A * CertainColumns( B, plist );
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# UnionOfRows
#-----------------------------------

##
InstallMethod( UnionOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: UnionOfRows( PreEval, IsHomalgMatrix )", "\033[0m" );
    
    return UnionOfRows( PreEval( A ), B );
    
end );

##
InstallMethod( UnionOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: UnionOfRows( IsHomalgMatrix, PreEval )", "\033[0m" );
    
    return UnionOfRows( A, PreEval( B ) );
    
end );

#-----------------------------------
# UnionOfColumns
#-----------------------------------

##
InstallMethod( UnionOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: UnionOfColumns( PreEval, IsHomalgMatrix )", "\033[0m" );
    
    return UnionOfColumns( PreEval( A ), B );
    
end );

##
InstallMethod( UnionOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: UnionOfColumns( IsHomalgMatrix, PreEval )", "\033[0m" );
    
    return UnionOfColumns( A, PreEval( B ) );
    
end );

#-----------------------------------
# DiagMat
#-----------------------------------

##
InstallMethod( DiagMat,
        "of homalg matrices",
        [ IsHomogeneousList ], 1,
        
  function( l )
    local pos, R, r, c, len, L, k, diag;
    
    pos := PositionProperty( l, HasIsEmptyMatrix and IsEmptyMatrix );
    
    if pos <> fail then
        
        R := HomalgRing( l[1] );
        
        r := NrRows( l[pos] );
        c := NrColumns( l[pos] );
        
        len := Length( l );	## we can assume l >= 2, since other methods would then apply
        
        if pos = 1 then
            L := l{[ 2 .. len ]};
            if r = 0 then
                k := Sum( List( L, NrRows ) );
                diag := UnionOfColumns( HomalgZeroMatrix( k, c, R ), DiagMat( L ) );
            else
                k := Sum( List( L, NrColumns ) );
                diag := UnionOfRows( HomalgZeroMatrix( r, k, R ), DiagMat( L ) );
            fi;
        elif pos = len then
            L := l{[ 1 .. len - 1 ]};
            if r = 0 then
                k := Sum( List( L, NrRows ) );
                diag := UnionOfColumns( DiagMat( L ), HomalgZeroMatrix( k, c, R ) );
            else
                k := Sum( List( L, NrColumns ) );
                diag := UnionOfRows( DiagMat( L ), HomalgZeroMatrix( r, k, R ) );
            fi;
        else
            L := l{[ 1 .. pos ]};
            diag := DiagMat( [ DiagMat( L ), DiagMat( l{[ pos + 1 .. len ]} ) ] );
        fi;
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "DiagMat( [ ..., empty matrix, ... ] )", "\033[0m" );
        
        return diag;
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# AddMat
#-----------------------------------

##
InstallMethod( \+,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval + IsHomalgMatrix", "\033[0m" );
    
    return PreEval( A ) + B;
    
end );

##
InstallMethod( \+,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsHomalgMatrix + PreEval", "\033[0m" );
    
    return A + PreEval( B );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsHomalgMatrix and HasEvalCompose ],
        
  function( A, B )
    local C;
    
    C := EvalCompose( A )[1];
    
    if IsIdenticalObj( C , EvalCompose( B )[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "C * E + C * F", "\033[0m" );
        
        return C * ( EvalCompose( A )[2] + EvalCompose( B )[2] );
        
    fi;
    
    C := EvalCompose( A )[2];
    
    if IsIdenticalObj( C , EvalCompose( B )[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "E * C + F * C", "\033[0m" );
        
        return ( EvalCompose( A )[1] + EvalCompose( B )[1] ) * C;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat, IsHomalgMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    if IsZero( EvalMulMat( A )[1] + One( R ) ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-A + B", "\033[0m" );
        
        return B - EvalMulMat( A )[2];
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalMulMat ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( B );
    
    if IsZero( EvalMulMat( B )[1] + One( R ) ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "A + (-B)", "\033[0m" );
        
        return A - EvalMulMat( B )[2];
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# MulMat
#-----------------------------------

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement, IsHomalgMatrix and HasPreEval ],
        
  function( a, A )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsRingElement * PreEval", "\033[0m" );
    
    return a * PreEval( A );
    
end );

#-----------------------------------
# AdditiveInverseMutable
#-----------------------------------

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( A )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: -PreEval", "\033[0m" );
    
    return -PreEval( A );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( A )
    local R;
    
    R := HomalgRing( A );
    
    if IsZero( EvalMulMat( A )[1] + One( R ) ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-(-IsHomalgMatrix)", "\033[0m" );
        
        return EvalMulMat( A )[2];
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# SubMat
#-----------------------------------

##
InstallMethod( \-,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval - IsHomalgMatrix", "\033[0m" );
    
    return PreEval( A ) - B;
    
end );

##
InstallMethod( \-,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsHomalgMatrix - PreEval", "\033[0m" );
    
    return A - PreEval( B );
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsHomalgMatrix and HasEvalCompose ],
        
  function( A, B )
    local C;
    
    C := EvalCompose( A )[1];
    
    if IsIdenticalObj( C , EvalCompose( B )[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "C * E - C * F", "\033[0m" );
        
        return C * ( EvalCompose( A )[2] - EvalCompose( B )[2] );
        
    fi;
    
    C := EvalCompose( A )[2];
    
    if IsIdenticalObj( C , EvalCompose( B )[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "E * C - F * C", "\033[0m" );
        
        return ( EvalCompose( A )[1] - EvalCompose( B )[1] ) * C;
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# Compose
#-----------------------------------

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval * IsHomalgMatrix", "\033[0m" );
    
    return PreEval( A ) * B;
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsHomalgMatrix * PreEval", "\033[0m" );
    
    return A * PreEval( B );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsHomalgMatrix ],
        
  function( A, B )
    local A1, A2;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "UnionOfRows * IsHomalgMatrix", "\033[0m" );
    
    A1 := EvalUnionOfRows( A )[1];
    A2 := EvalUnionOfRows( A )[2];
    
    return UnionOfRows( A1 * B, A2* B );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( A, B )
    local B1, B2;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * UnionOfColumns", "\033[0m" );
    
    B1 := EvalUnionOfColumns( B )[1];
    B2 := EvalUnionOfColumns( B )[2];
    
    return UnionOfColumns( A * B1, A * B2 );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsHomalgMatrix ],
        
  function( A, B )
    local A1, A2, B1, B2;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "UnionOfColumns * IsHomalgMatrix", "\033[0m" );
    
    A1 := EvalUnionOfColumns( A )[1];
    A2 := EvalUnionOfColumns( A )[2];
    
    B1 := CertainRows( B, [ 1 .. NrColumns( A1 ) ] );
    B2 := CertainRows( B, [ NrColumns( A1 ) + 1 .. NrRows( B ) ] );
    
    return A1 * B1 +  A2 * B2;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( A, B )
    local B1, B2, A1, A2;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * UnionOfRows", "\033[0m" );
    
    B1 := EvalUnionOfRows( B )[1];
    B2 := EvalUnionOfRows( B )[2];
    
    A1 := CertainColumns( A, [ 1 .. NrRows( B1 ) ] );
    A2 := CertainColumns( A, [ NrRows( B1 ) + 1 .. NrColumns( A ) ] );
    
    return A1 * B1 + A2 * B2;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsSubidentityMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <= NrColumns( A ) and HasPositionOfFirstNonZeroEntryPerRow( A ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsSubidentityMatrix * IsHomalgMatrix", "\033[0m" );
        
        return CertainRows( B, PositionOfFirstNonZeroEntryPerRow( A ) );
        
    fi;
        
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsSubidentityMatrix ],
        
  function( A, B )
    local pos, plist;
    
    if NrColumns( B ) <= NrRows( B ) and HasPositionOfFirstNonZeroEntryPerRow( B ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * IsSubidentityMatrix", "\033[0m" );
        
        pos := PositionOfFirstNonZeroEntryPerRow( B );
        
        plist := List( [ 1 .. NrColumns( B ) ], i -> Position( pos, i ) );
        
        return CertainColumns( A, plist );
        
    fi;
        
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalLeftInverse, IsHomalgMatrix ],
        
  function( A, B )
    
    if IsIdenticalObj( EvalLeftInverse( A ), B ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "(its LeftInverse) * IsHomalgMatrix", "\033[0m" );
        
        return HomalgIdentityMatrix( NrColumns( B ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalRightInverse ],
        
  function( A, B )
    
    if IsIdenticalObj( A, EvalRightInverse( B ) ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * (its RightInverse)", "\033[0m" );
        
        return HomalgIdentityMatrix( NrRows( A ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalLeftInverse, IsHomalgMatrix and HasEvalCertainColumns ],
        
  function( A, B )
    local C, D;
    
    C := EvalLeftInverse( A );
    D := EvalCertainColumns( B );
    
    if HasEvalCertainColumns( C ) then
        
        C := EvalCertainColumns( C );
        
        if IsIdenticalObj( C[1], D[1] ) and C[2] = D[2] then
            
            Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "(its LeftInverse) * CertainColumns( IsHomalgMatrix )", "\033[0m" );
            
            return HomalgIdentityMatrix( NrColumns( B ), HomalgRing( A ) );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainRows, IsHomalgMatrix and HasEvalRightInverse ],
        
  function( A, B )
    local C, D;
    
    C := EvalCertainRows( A );
    D := EvalRightInverse( B );
    
    
    if HasEvalCertainRows( D ) then
        
        D := EvalCertainRows( D );
        
        if IsIdenticalObj( C[1], D[1] ) and C[2] = D[2] then
        
            Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( IsHomalgMatrix ) * (its RightInverse)", "\033[0m" );
            
            return HomalgIdentityMatrix( NrRows( A ), HomalgRing( A ) );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsHomalgMatrix ],
        
  function( A, B )
    local LI;
    
    LI := EvalCompose( A )[2];
    
    if HasEvalLeftInverse( LI ) then	## give it a chance
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "( IsHomalgMatrix * LeftInverse ) * IsHomalgMatrix", "\033[0m" );
        
        return EvalCompose( A )[1] * ( LI * B ); 
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalCompose ],
        
  function( A, B )
    local RI;
    
    RI := EvalCompose( B )[1];
    
    if HasEvalRightInverse( RI ) then	## give it a chance
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * ( RightInverse * IsHomalgMatrix )", "\033[0m" );
        
        return ( A * RI ) * EvalCompose( B )[2]; 
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# LeftInverse
#-----------------------------------

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: LeftInverse( PreEval )", "\033[0m" );
    
    return LeftInverse( PreEval( M ) );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalRightInverse ], 1,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "LeftInverse( RightInverse )", "\033[0m" );
    
    return EvalRightInverse( M );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInverse ], 2,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "LeftInverse( Inverse )", "\033[0m" );
    
    return EvalInverse( M );
    
end );

#-----------------------------------
# RightInverse
#-----------------------------------

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: RightInverse( PreEval )", "\033[0m" );
    
    return RightInverse( PreEval( M ) );
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalLeftInverse ], 1,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "RightInverse( LeftInverse )", "\033[0m" );
    
    return EvalLeftInverse( M );
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInverse ], 2,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "RightInverse( Inverse )", "\033[0m" );
    
    return EvalInverse( M );
    
end );

#-----------------------------------
# BasisOfRowModule
#-----------------------------------

##
InstallMethod( BasisOfRowModule,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: BasisOfRowModule( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    return DiagMat( List( e, BasisOfRowModule ) );
    
end );

#-----------------------------------
# BasisOfColumnModule
#-----------------------------------

##
InstallMethod( BasisOfColumnModule,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: BasisOfColumnModule( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    return DiagMat( List( e, BasisOfColumnModule ) );
    
end );

