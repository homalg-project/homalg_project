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
    local e;
    
    e := PreEval( M );
    
    if HasIsEmptyMatrix( e ) then
        return IsEmptyMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsZero( e ) then
        return IsZero( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsZero( MI ) then
        return IsZero( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalLeftInverse, 0,
        
  function( M )
    local MI;
    
    MI := EvalLeftInverse( M );
    
    if HasIsZero( MI ) then
        return IsZero( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalRightInverse, 0,
        
  function( M )
    local MI;
    
    MI := EvalRightInverse( M );
    
    if HasIsZero( MI ) then
        return IsZero( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalInverse, 0,
        
  function( M )
    local MI;
    
    MI := EvalInverse( M );
    
    if HasIsZero( MI ) then
        return IsZero( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local e;
    
    e := EvalCertainRows( M )[1];
    
    if HasIsZero( e ) and IsZero( e ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local e;
    
    e := EvalCertainColumns( M )[1];
    
    if HasIsZero( e ) and IsZero( e ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfRows( M );
    
    if HasIsZero( e[1] ) and IsZero( e[1] ) and
       HasIsZero( e[2] ) and IsZero( e[2] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfColumns( M );
    
    if HasIsZero( e[1] ) and IsZero( e[1] ) and
       HasIsZero( e[2] ) and IsZero( e[2] ) then
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
    local e;
    
    e := PreEval( M );
    
    if HasIsIdentityMatrix( e ) then
        return IsIdentityMatrix( e );
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
    local e;
    
    e := PreEval( M );
    
    if HasIsPermutationMatrix( e ) then
        return IsPermutationMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSubidentityMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsSubidentityMatrix( e ) then
        return IsSubidentityMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSubidentityMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local mat, plist, pos, pos_non_zero;
    
    mat := EvalCertainRows( M );
    
    plist := mat[2];
    mat := mat[1];
    
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
    
    mat := EvalCertainColumns( M );
    
    plist := mat[2];
    mat := mat[1];
    
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
    local e;
    
    e := PreEval( M );
    
    if HasIsRightInvertibleMatrix( e ) then
        return IsRightInvertibleMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsLeftInvertibleMatrix( MI ) then
        return IsLeftInvertibleMatrix( MI );
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
    local e;
    
    e := PreEval( M );
    
    if HasIsLeftInvertibleMatrix( e ) then
        return IsLeftInvertibleMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsRightInvertibleMatrix( MI ) then
        return IsRightInvertibleMatrix( MI );
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
    local e;
    
    e := PreEval( M );
    
    if HasIsLeftRegularMatrix( e ) then
        return IsLeftRegularMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsRightRegularMatrix( MI ) then
        return IsRightRegularMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsRightRegularMatrix( e ) then
        return IsRightRegularMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsLeftRegularMatrix( MI ) then
        return IsLeftRegularMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsLowerTriangularMatrix( MI ) then
        return IsLowerTriangularMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local C, plist;
    
    C := EvalCertainRows( M );
    
    plist := C[2];
    C := C[1];
    
    if HasIsUpperTriangularMatrix( C ) and IsUpperTriangularMatrix( C ) and
       ( plist = NrRows( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsUpperTriangularMatrix( e ) then
        return IsUpperTriangularMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsUpperTriangularMatrix( MI ) then
        return IsUpperTriangularMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local C, plist;
    
    C := EvalCertainColumns( M );
    
    plist := C[2];
    C := C[1];
    
    if HasIsLowerTriangularMatrix( C ) and IsLowerTriangularMatrix( C ) and
       ( plist = NrColumns( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsLowerTriangularMatrix( e ) then
        return IsLowerTriangularMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsLowerStairCaseMatrix( MI ) then
        return IsLowerStairCaseMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local C, plist;
    
    C := EvalCertainRows( M );
    
    plist := C[2];
    C := C[1];
    
    if HasIsUpperStairCaseMatrix( C ) and IsUpperStairCaseMatrix( C ) and
       ( plist = NrRows( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsUpperStairCaseMatrix( e ) then
        return IsUpperStairCaseMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsUpperStairCaseMatrix( MI ) then
        return IsUpperStairCaseMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local C, plist;
    
    C := EvalCertainColumns( M );
    
    plist := C[2];
    C := C[1];
    
    if HasIsLowerStairCaseMatrix( C ) and IsLowerStairCaseMatrix( C ) and
       ( plist = NrColumns( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsLowerStairCaseMatrix( e ) then
        return IsLowerStairCaseMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local C;
    
    C := EvalCertainRows( M );
    
    if HasIsDiagonalMatrix( C[1] ) and IsDiagonalMatrix( C[1] ) and
       C[2] = [ 1 .. Length( C[2] ) ] then
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
    
    if HasIsDiagonalMatrix( C[1] ) and IsDiagonalMatrix( C[1] ) and
       C[2] = [ 1 .. Length( C[2] ) ] then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsDiagonalMatrix( e ) then
        return IsDiagonalMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsStrictUpperTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsStrictUpperTriangularMatrix( e ) then
        return IsStrictUpperTriangularMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsStrictLowerTriangularMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsStrictLowerTriangularMatrix( e ) then
        return IsStrictLowerTriangularMatrix( e );
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
    local e;
    
    e := PreEval( M );
    
    if HasNrRows( e ) then
        return NrRows( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( NrColumns,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasNrColumns( e ) then
        return NrColumns( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasRowRankOfMatrix( e ) then
        return RowRankOfMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasColumnRankOfMatrix( MI ) then
        return ColumnRankOfMatrix( MI );
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
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
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
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
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
        IsHomalgMatrix and HasEvalDiagMat, 0,
        
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
    local e;
    
    e := PreEval( M );
    
    if HasColumnRankOfMatrix( e ) then
        return ColumnRankOfMatrix( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasRowRankOfMatrix( MI ) then
        return RowRankOfMatrix( MI );
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
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
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
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
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
        IsHomalgMatrix and HasEvalDiagMat, 0,
        
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
    local e;
    
    e := PreEval( M );
    
    if HasPositionOfFirstNonZeroEntryPerRow( e ) then
        return PositionOfFirstNonZeroEntryPerRow( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local e, mat, pos;
    
    e := EvalCertainRows( M );
    
    mat := e[1];
    
    if HasPositionOfFirstNonZeroEntryPerRow( mat ) then
        
        pos := PositionOfFirstNonZeroEntryPerRow( mat );
        
        return pos{ e[2] };
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and HasEvalCertainColumns and HasNrRows, 0,
        
  function( M )
    local e, mat, plist, pos;
    
    e := EvalCertainColumns( M );
    
    mat := e[1];
    
    if HasPositionOfFirstNonZeroEntryPerRow( mat ) then
        
        pos := PositionOfFirstNonZeroEntryPerRow( mat );
        
        plist := e[2];
    
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
    local A;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then ## otherwise we would take CertainRows of a bigger matrix
        
        Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( CertainRows )", "\033[0m" );
        
        A := EvalCertainRows( M );
        
        return CertainRows( A[1], A[2]{plist} );
        
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
        
        A := EvalCertainColumns( M );
        
        plistA := A[2];
        A := A[1];
        
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
    local e, A, B, a, rowsA, rowsB, plistA, plistB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( UnionOfRows )", "\033[0m" );
    
    e := EvalUnionOfRows( M );
    
    A := e[1];
    B := e[2];
    
    a := NrRows( A );
    
    rowsA := [ 1 .. a ];
    rowsB := [ 1 .. NrRows( B ) ];
    
    plistA := Filtered( plist, x -> x in rowsA );		## CAUTION: don't use Intersection(2)
    plistB := Filtered( plist - a, x -> x in rowsB );		## CAUTION: don't use Intersection(2)
    
    return UnionOfRows( CertainRows( A, plistA ), CertainRows( B, plistB ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
        
  function( M, plist )
    local AB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( UnionOfColumns )", "\033[0m" );
    
    AB := EvalUnionOfColumns( M );
    
    return UnionOfColumns( CertainRows( AB[1], plist ), CertainRows( AB[2], plist ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local  AB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( Compose )", "\033[0m" );
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then
        
        AB := EvalCompose( M );
        
        return CertainRows( AB[1], plist ) * AB[2];
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
    local A;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then ## otherwise we would take CertainColumns of a bigger matrix
        
        Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( CertainColumns )", "\033[0m" );
        
        A := EvalCertainColumns( M );
        
        return CertainColumns( A[1], A[2]{plist} );
        
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
        
        
        A := EvalCertainRows( M );
        
        plistA := A[2];
        A := A[1];
        
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
    local e, A, B, a, columnsA, columnsB, plistA, plistB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( UnionOfColumns )", "\033[0m" );
    
    e := EvalUnionOfColumns( M );
    
    A := e[1];
    B := e[2];
    
    a := NrColumns( A );
    
    columnsA := [ 1 .. a ];
    columnsB := [ 1 .. NrColumns( B ) ];
    
    plistA := Filtered( plist, x -> x in columnsA );			## CAUTION: don't use Intersection(2)
    plistB := Filtered( plist - a, x -> x in columnsB );		## CAUTION: don't use Intersection(2)
    
    return UnionOfColumns( CertainColumns( A, plistA ), CertainColumns( B, plistB ) );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
        
  function( M, plist )
    local AB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( UnionOfRows )", "\033[0m" );
    
    AB := EvalUnionOfRows( M );
    
    return UnionOfRows( CertainColumns( AB[1], plist ), CertainColumns( AB[2], plist ) );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local AB;
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( Compose )", "\033[0m" );
        
        AB := EvalCompose( M );
        
        return AB[1] * CertainColumns( AB[2], plist );
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
    local AA, BB, C;
    
    AA := EvalCompose( A );
    BB := EvalCompose( B );
    
    C := AA[1];
    
    if IsIdenticalObj( C , BB[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "C * E + C * F", "\033[0m" );
        
        return C * ( AA[2] + BB[2] );
        
    fi;
    
    C := AA[2];
    
    if IsIdenticalObj( C , BB[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "E * C + F * C", "\033[0m" );
        
        return ( AA[1] + BB[1] ) * C;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat, IsHomalgMatrix ],
        
  function( A, B )
    local R, AA;
    
    R := HomalgRing( A );
    
    AA := EvalMulMat( A );
    
    if IsZero( AA[1] + One( R ) ) then	## don't use IsMinusOne (it is declared for IsHomalgRingElement & not IsRingElement)
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-A + B", "\033[0m" );
        
        return B - AA[2];
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalMulMat ],
        
  function( A, B )
    local R, BB;
    
    R := HomalgRing( B );
    
    BB := EvalMulMat( B );
    
    if IsZero( BB[1] + One( R ) ) then	## don't use IsMinusOne (it is declared for IsHomalgRingElement & not IsRingElement)
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "A + (-B)", "\033[0m" );
        
        return A - BB[2];
        
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
    local R, AA;
    
    R := HomalgRing( A );
    
    AA := EvalMulMat( A );
    
    if IsZero( AA[1] + One( R ) ) then	## don't use IsMinusOne (it is declared for IsHomalgRingElement & not IsRingElement)
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-(-IsHomalgMatrix)", "\033[0m" );
        
        return AA[2];
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
    local AA, BB, C;
    
    AA := EvalCompose( A );
    BB := EvalCompose( B );
    
    C := AA[1];
    
    if IsIdenticalObj( C , BB[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "C * E - C * F", "\033[0m" );
        
        return C * ( AA[2] - BB[2] );
        
    fi;
    
    C := AA[2];
    
    if IsIdenticalObj( C , BB[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "E * C - F * C", "\033[0m" );
        
        return ( AA[1] - BB[1] ) * C;
        
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
    local AA;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "UnionOfRows * IsHomalgMatrix", "\033[0m" );
    
    AA := EvalUnionOfRows( A );
    
    return UnionOfRows( AA[1] * B, AA[2] * B );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( A, B )
    local BB;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * UnionOfColumns", "\033[0m" );
    
    BB := EvalUnionOfColumns( B );
    
    return UnionOfColumns( A * BB[1], A * BB[2] );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsHomalgMatrix ],
        
  function( A, B )
    local AA, a1, B1, B2;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "UnionOfColumns * IsHomalgMatrix", "\033[0m" );
    
    AA := EvalUnionOfColumns( A );
    
    a1 := NrColumns( AA[1] );
    
    B1 := CertainRows( B, [ 1 .. a1 ] );
    B2 := CertainRows( B, [ a1 + 1 .. NrRows( B ) ] );
    
    return AA[1] * B1 +  AA[2] * B2;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( A, B )
    local BB, b1, A1, A2;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * UnionOfRows", "\033[0m" );
    
    BB := EvalUnionOfRows( B );
    
    b1 := NrRows( BB[1] );
    
    A1 := CertainColumns( A, [ 1 .. b1 ] );
    A2 := CertainColumns( A, [ b1 + 1 .. NrColumns( A ) ] );
    
    return A1 * BB[1] + A2 * BB[2];
    
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
    local AA, LI;
    
    AA := EvalCompose( A );
    
    LI := AA[2];
    
    if HasEvalLeftInverse( LI ) then	## give it a chance
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "( IsHomalgMatrix * LeftInverse ) * IsHomalgMatrix", "\033[0m" );
        
        return AA[1] * ( LI * B );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalCompose ],
        
  function( A, B )
    local BB, RI;
    
    BB := EvalCompose( B );
    
    RI := BB[1];
    
    if HasEvalRightInverse( RI ) then	## give it a chance
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * ( RightInverse * IsHomalgMatrix )", "\033[0m" );
        
        return ( A * RI ) * BB[2];
        
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

