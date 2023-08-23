# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

##         COLEM = Clever Operations for Lazy Evaluated Matrices

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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
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
    local e, A, B;
    
    e := EvalUnionOfRows( M );
    
    if ForAny( e, A -> HasIsZero( A ) and not IsZero( A ) ) then
        return false;
    fi;
    
    if ForAll( e, A -> HasIsZero( A ) and IsZero( A ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, A, B;
    
    e := EvalUnionOfColumns( M );
    
    if ForAny( e, A -> HasIsZero( A ) and not IsZero( A ) ) then
        return false;
    fi;
    
    if ForAll( e, A -> HasIsZero( A ) and IsZero( A ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalDiagMat, 0,
        
  function( M )
    local e;
    
    e := EvalDiagMat( M );
    
    if ForAll( e, B -> HasIsZero( B ) and IsZero( B ) ) then
        return true;
    elif ForAny( e, B -> HasIsZero( B ) and not IsZero( B ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalMulMatRight, 0,
        
  function( M )
    local e, A, a, R;
    
    e := EvalMulMatRight( M );
    
    A := e[1];
    a := e[2];
    
    if HasIsZero( a ) and IsZero( a ) then
        return true;
    elif HasIsZero( A ) then
        if IsZero( A ) then
            return true;
        elif IsHomalgRingElement( a ) and HasIsRegular( a ) and IsRegular( a ) then
            ## A is not zero
            return false;
        else
            R := HomalgRing( A );
            if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
                ## A is not zero
                return IsZero( a );
            elif IsHomalgRingElement( a ) and IsBound( a!.IsUnit ) and a!.IsUnit then
                ## A is not zero
                return false;
            fi;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalMulMat, 0,
        
  function( M )
    local e, a, A, R;
    
    e := EvalMulMat( M );
    
    a := e[1];
    A := e[2];
    
    if HasIsZero( a ) and IsZero( a ) then
        return true;
    elif HasIsZero( A ) then
        if IsZero( A ) then
            return true;
        elif IsHomalgRingElement( a ) and HasIsRegular( a ) and IsRegular( a ) then
            ## A is not zero
            return false;
        else
            R := HomalgRing( A );
            if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
                ## A is not zero
                return IsZero( a );
            elif IsHomalgRingElement( a ) and IsBound( a!.IsUnit ) and a!.IsUnit then
                ## A is not zero
                return false;
            fi;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsOne( e ) then
        return IsOne( e );
    fi;
    
    TryNextMethod( );
    
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
        
        if HasNumberRows( mat ) and HasNumberColumns( mat )
           and NumberRows( mat ) <= NumberColumns( mat ) then
            
            return IsDuplicateFree( plist );
            
        fi;
        
        if HasPositionOfFirstNonZeroEntryPerRow( mat ) and HasNumberColumns( mat ) then
            
            pos := PositionOfFirstNonZeroEntryPerRow( mat );
            
            pos := pos{ plist };
            
            pos_non_zero := Filtered( pos, i -> i <> 0 );
            
            if not IsDuplicateFree( pos_non_zero ) then
                return false;
            fi;
            
            if not 0 in pos                                  ## NumberRows( M ) <= NumberColumns( M )
               or  Length( pos_non_zero ) = NumberColumns( mat ) ## NumberColumns( M ) <= NumberRows( M )
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
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local mat, plist, pos, plist_non_zero;
    
    mat := EvalCertainRows( M );
    
    plist := mat[2];
    mat := mat[1];
    
    if HasIsSubidentityMatrix( mat ) and IsSubidentityMatrix( mat ) then
        
        if HasNumberRows( mat ) and HasNumberColumns( mat )
           and NumberRows( mat ) <= NumberColumns( mat ) then
            
            return IsDuplicateFree( plist );
            
        fi;
        
        if HasPositionOfFirstNonZeroEntryPerColumn( mat ) and HasNumberColumns( mat ) then
            
            pos := PositionOfFirstNonZeroEntryPerColumn( mat );
            
            plist := List( plist, function( i ) if i in pos then return i; else return 0; fi; end );
            
            plist_non_zero := Filtered( plist, i -> i <> 0 );
            
            if not IsDuplicateFree( plist_non_zero ) then
                return false;
            fi;
            
            if not 0 in plist                                 ## NumberRows( M ) <= NumberColumns( M )
               or Length( plist_non_zero ) = NumberColumns( mat ) ## NumberColumns( M ) <= NumberRows( M )
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
    local mat, plist, pos, pos_non_zero;
    
    mat := EvalCertainColumns( M );
    
    plist := mat[2];
    mat := mat[1];
    
    if HasIsSubidentityMatrix( mat ) and IsSubidentityMatrix( mat ) then
        
        if HasNumberColumns( mat ) and HasNumberRows( mat )
           and NumberColumns( mat ) <= NumberRows( mat ) then
            
            return IsDuplicateFree( plist );
            
        fi;
        
        if HasPositionOfFirstNonZeroEntryPerColumn( mat ) and HasNumberRows( mat ) then
            
            pos := PositionOfFirstNonZeroEntryPerColumn( mat );
            
            pos := pos{ plist };
            
            pos_non_zero := Filtered( pos, i -> i <> 0 );
            
            if not IsDuplicateFree( pos_non_zero ) then
                return false;
            fi;
            
            if not 0 in pos                               ## NumberColumns( M ) <= NumberRows( M )
               or  Length( pos_non_zero ) = NumberRows( mat ) ## NumberRows( M ) <= NumberColumns( M )
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
        
        if HasNumberColumns( mat ) and HasNumberRows( mat )
           and NumberColumns( mat ) <= NumberRows( mat ) then
            
            return IsDuplicateFree( plist );
            
        fi;
        
        if HasPositionOfFirstNonZeroEntryPerRow( mat ) and HasNumberRows( mat ) then
            
            pos := PositionOfFirstNonZeroEntryPerRow( mat );
            
            plist := List( plist, function( i ) if i in pos then return i; else return 0; fi; end );
            
            plist_non_zero := Filtered( plist, i -> i <> 0 );
            
            if not IsDuplicateFree( plist_non_zero ) then
                return false;
            fi;
            
            if not 0 in plist                              ## NumberColumns( M ) <= NumberRows( M )
               or Length( plist_non_zero ) = NumberRows( mat ) ## NumberRows( M ) <= NumberColumns( M )
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
    
    if ForAny( e, A -> HasIsRightInvertibleMatrix( A ) and IsRightInvertibleMatrix( A ) ) then
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
    
    if ForAny( e, A -> HasIsLeftInvertibleMatrix( A ) and IsLeftInvertibleMatrix( A ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsLeftRegular( e ) then
        return IsLeftRegular( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsRightRegular( MI ) then
        return IsRightRegular( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegular,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasIsRightRegular( e ) then
        return IsRightRegular( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegular,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasIsLeftRegular( MI ) then
        return IsLeftRegular( MI );
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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
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
       ( plist = NumberRows( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
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
       ( plist = NumberColumns( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
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
       ( plist = NumberRows( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
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
       ( plist = NumberColumns( C ) + [ -Length( plist ) .. 0 ] or plist = [ 1 .. Length( plist ) ] ) then
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
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e, A;
    
    e := EvalUnionOfRows( M );
    
    A := e[1];
    
    if HasIsDiagonalMatrix( A ) and IsDiagonalMatrix( A )
       and ForAll( e{[ 2 .. Length( e ) ]}, B -> HasIsZero( B ) and IsZero( B ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, A;
    
    e := EvalUnionOfColumns( M );
    
    A := e[1];
    
    if HasIsDiagonalMatrix( A ) and IsDiagonalMatrix( A )
       and ForAll( e{[ 2 .. Length( e ) ]}, B -> HasIsZero( B ) and IsZero( B ) ) then
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
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasEvalDiagMat, 0,
        
  function( M )
    local e;
    
    e := EvalDiagMat( M );
    
    if ForAll( e, HasIsDiagonalMatrix ) then
        return ForAll( List( e, IsDiagonalMatrix ), a -> a = true );
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
InstallImmediateMethod( NumberRows,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasNumberRows( e ) then
        return NumberRows( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( NumberColumns,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasNumberColumns( e ) then
        return NumberColumns( e );
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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
    if HasColumnRankOfMatrix( MI ) then
        return ColumnRankOfMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, r;
    
    e := EvalUnionOfColumns( M );
    
    if ForAll( e, HasRowRankOfMatrix ) then
        r := List( e, RowRankOfMatrix );
        if Maximum( r ) = Sum( r ) then
            return Maximum( r );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e, r, A;
    
    e := EvalUnionOfRows( M );
    
    if ForAll( e, HasRowRankOfMatrix ) then
        r := List( e, RowRankOfMatrix );
        if Maximum( r ) = Sum( r ) then
            return Maximum( r );
        fi;
    fi;
    
    for A in e do
        if HasRowRankOfMatrix( A ) and RowRankOfMatrix( A ) = NumberColumns( A ) then
            return NumberColumns( A );
        fi;
    od;
    
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
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
    if HasRowRankOfMatrix( MI ) then
        return RowRankOfMatrix( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e, r;
    
    e := EvalUnionOfRows( M );
    
    if ForAll( e, HasColumnRankOfMatrix ) then
        r := List( e, ColumnRankOfMatrix );
        if Maximum( r ) = Sum( r ) then
            return Maximum( r );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, r, A;
    
    e := EvalUnionOfColumns( M );
    
    if ForAll( e, HasColumnRankOfMatrix ) then
        r := List( e, ColumnRankOfMatrix );
        if Maximum( r ) = Sum( r ) then
            return Maximum( r );
        fi;
    fi;
    
    for A in e do
        if HasColumnRankOfMatrix( A ) and ColumnRankOfMatrix( A ) = NumberRows( A ) then
            return NumberRows( A );
        fi;
    od;
    
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
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfRows( M );
    
    if ForAll( e, HasPositionOfFirstNonZeroEntryPerRow ) then
        return Concatenation( List( e, PositionOfFirstNonZeroEntryPerRow ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, c, p, result, i;
    
    e := EvalUnionOfColumns( M );
    
    if ForAll( e, HasPositionOfFirstNonZeroEntryPerRow ) then
        
        c := 0;
        
        p := List( e, PositionOfFirstNonZeroEntryPerRow );

        p := List( p, a -> List( a, function(x) if x = 0 then return infinity; else return x; fi; end ) );
        
        result := ListWithIdenticalEntries( Length( p[1] ), infinity );
        
        for i in [ 1 .. Length( e ) ] do
        
            result := ListN( result, p[i], function( a, b ) return Minimum( a, b + c ); end );
        
            c := c + NumberColumns( e[i] );
        
        od;
        
        return List( result, function( a ) if a = infinity then return 0; else return a; fi; end );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerColumn,
        IsHomalgMatrix and HasPreEval, 0,
        
  function( M )
    local e;
    
    e := PreEval( M );
    
    if HasPositionOfFirstNonZeroEntryPerColumn( e ) then
        return PositionOfFirstNonZeroEntryPerColumn( e );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerColumn,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local e, mat, pos;
    
    e := EvalCertainColumns( M );
    
    mat := e[1];
    
    if HasPositionOfFirstNonZeroEntryPerColumn( mat ) then
        
        pos := PositionOfFirstNonZeroEntryPerColumn( mat );
        
        return pos{ e[2] };
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerColumn,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e;
    
    e := EvalUnionOfColumns( M );
    
    if ForAll( e, HasPositionOfFirstNonZeroEntryPerColumn ) then
        return Concatenation( List( e, PositionOfFirstNonZeroEntryPerColumn ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerColumn,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e, r, p, result, i;
    
    e := EvalUnionOfRows( M );
    
    if ForAll( e, HasPositionOfFirstNonZeroEntryPerColumn ) then
        
        r := 0;
        
        p := List( e, PositionOfFirstNonZeroEntryPerColumn );

        p := List( p, a -> List( a, function(x) if x = 0 then return infinity; else return x; fi; end ) );
        
        result := ListWithIdenticalEntries( Length( p[1] ), infinity );
        
        for i in [ 1 .. Length( e ) ] do
        
            result := ListN( result, p[i], function( a, b ) return Minimum( a, b + r ); end );
        
            r := r + NumberRows( e[i] );
        
        od;
        
        return List( result, function( a ) if a = infinity then return 0; else return a; fi; end );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasZeroColumns( MI ) then
        return ZeroColumns( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
    if HasZeroColumns( MI ) then
        return ZeroColumns( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasZeroRows( MI ) then
        return ZeroRows( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasEvalTransposedMatrix, 0,
        
  function( M )
    local MI;
    
    MI := EvalTransposedMatrix( M );
    
    if HasZeroRows( MI ) then
        return ZeroRows( MI );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################
    
##
InstallMethod( IsZero,
        "COLEM: for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsZero( UnionOfRows )", "\033[0m" );
    
    e := EvalUnionOfRows( M );
    
    return ForAll( e, IsZero );
    
end );

##
InstallMethod( IsZero,
        "COLEM: for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsZero( UnionOfColumns )", "\033[0m" );
    
    e := EvalUnionOfColumns( M );
    
    return ForAll( e, IsZero );
    
end );

##
InstallMethod( IsZero,
        "COLEM: for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsZero( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    return ForAll( e, IsZero );
    
end );

##
InstallMethod( IsZero,
        "COLEM: for homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMatRight ],
        
  function( M )
    local e, A, a;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsZero( A * a )", "\033[0m" );
    
    e := EvalMulMatRight( M );
    
    A := e[1];
    a := e[2];
    
    if IsZero( a ) then
        return true;
    elif IsZero( A ) then
        return true;
    elif HasIsMinusOne( a ) and IsMinusOne( a ) then
        ## A is not zero
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsZero,
        "COLEM: for homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( M )
    local e, a, A;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsZero( a * A )", "\033[0m" );
    
    e := EvalMulMat( M );
    
    a := e[1];
    A := e[2];
    
    if IsZero( a ) then
        return true;
    elif IsZero( A ) then
        return true;
    elif HasIsMinusOne( a ) and IsMinusOne( a ) then
        ## A is not zero
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

#-----------------------------------
# ZeroRows
#-----------------------------------

##
InstallMethod( ZeroRows,
        "COLEM: for homalg matrices (HasEvalInvolution)",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "ZeroRows( Involution( M ) ) = ZeroColumns( M )", "\033[0m" );
    
    return ZeroColumns( EvalInvolution( M ) );
    
end );

##
InstallMethod( ZeroRows,
        "COLEM: for homalg matrices (HasEvalTransposedMatrix)",
        [ IsHomalgMatrix and HasEvalTransposedMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "ZeroRows( TransposedMatrix( M ) ) = ZeroColumns( M )", "\033[0m" );
    
    return ZeroColumns( EvalTransposedMatrix( M ) );
    
end );

#-----------------------------------
# ZeroColumns
#-----------------------------------

##
InstallMethod( ZeroColumns,
        "COLEM: for homalg matrices (HasEvalInvolution)",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "ZeroColumns( Involution( M ) ) = ZeroRows( M )", "\033[0m" );
    
    return ZeroRows( EvalInvolution( M ) );
    
end );

##
InstallMethod( ZeroColumns,
        "COLEM: for homalg matrices (HasEvalTransposedMatrix)",
        [ IsHomalgMatrix and HasEvalTransposedMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "ZeroColumns( TransposedMatrix( M ) ) = ZeroRows( M )", "\033[0m" );
    
    return ZeroRows( EvalTransposedMatrix( M ) );
    
end );

#-----------------------------------
# IndicatorMatrixOfNonZeroEntries
#-----------------------------------

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "COLEM: for homalg matrices (HasEvalCertainRows)",
        [ IsHomalgMatrix and HasEvalCertainRows ],
        
  function( mat )
    local eval;
    
    eval := EvalCertainRows( mat );
    
    if not HasIndicatorMatrixOfNonZeroEntries( eval ) then
        
        TryNextMethod( );
        
    else
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IndicatorMatrixOfNonZeroEntries(CertainRows)", "\033[0m" );
        
        return IndicatorMatrixOfNonZeroEntries( eval[1] ){ eval[2] };
        
    fi;
    
end );

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "COLEM: for homalg matrices (HasEvalCertainColumns)",
        [ IsHomalgMatrix and HasEvalCertainColumns ],
        
  function( mat )
    local eval;
    
    eval := EvalCertainColumns( mat );
    
    if not HasIndicatorMatrixOfNonZeroEntries( eval ) then
        
        TryNextMethod( );
        
    else
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IndicatorMatrixOfNonZeroEntries(CertainColumns)", "\033[0m" );
        
        return List( IndicatorMatrixOfNonZeroEntries( eval[1] ), a -> a{ eval[2] } );
        
    fi;
    
end );

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "COLEM: for homalg matrices (HasEvalUnionOfRows)",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( mat )
    local eval;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IndicatorMatrixOfNonZeroEntries(UnionOfRows)", "\033[0m" );
    
    eval := EvalUnionOfRows( mat );
    
    return Concatenation( List( eval, IndicatorMatrixOfNonZeroEntries ) );;
    
end );

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "COLEM: for homalg matrices (HasEvalUnionOfColumns)",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( mat )
    local e, n;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IndicatorMatrixOfNonZeroEntries(UnionOfColumns)", "\033[0m" );
    
    e := EvalUnionOfColumns( mat );
    
    n := List( e, IndicatorMatrixOfNonZeroEntries );
    
    return List( [ 1 .. Length( n[1] ) ], a -> Concatenation( List( n, b -> b[a] ) ) );
    
end );

#-----------------------------------
# PositionOfFirstNonZeroEntryPerRow
#-----------------------------------

##
InstallMethod( PositionOfFirstNonZeroEntryPerRow,
        "COLEM: for homalg matrices (HasEvalCertainRows)",
        [ IsHomalgMatrix and HasEvalCertainRows ],
        
  function( M )
    local e, mat, pos;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "PositionOfFirstNonZeroEntryPerRow( CertainRows )", "\033[0m" );
    
    e := EvalCertainRows( M );
    
    mat := e[1];
    
    pos := PositionOfFirstNonZeroEntryPerRow( mat );
    
    return pos{ e[2] };
    
end );

##
InstallMethod( PositionOfFirstNonZeroEntryPerRow,
        "COLEM: for homalg matrices (HasEvalUnionOfRows)",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "PositionOfFirstNonZeroEntryPerRow( UnionOfRows )", "\033[0m" );
    
    e := EvalUnionOfRows( M );
    
    return Concatenation( List( e, PositionOfFirstNonZeroEntryPerRow ) );
    
end );

##
InstallMethod( PositionOfFirstNonZeroEntryPerRow,
        "COLEM: for homalg matrices (HasEvalUnionOfColumns)",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( M )
    local e, c, p, result, i;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "PositionOfFirstNonZeroEntryPerRow( UnionOfColumns )", "\033[0m" );
    
    e := EvalUnionOfColumns( M );
    
    c := 0;
        
    p := List( e, PositionOfFirstNonZeroEntryPerRow );

    p := List( p, a -> List( a, function(x) if x = 0 then return infinity; else return x; fi; end ) );
        
    result := ListWithIdenticalEntries( Length( p[1] ), infinity );
        
    for i in [ 1 .. Length( e ) ] do
        
        result := ListN( result, p[i], function( a, b ) return Minimum( a, b + c ); end );
       
        c := c + NumberColumns( e[i] );
      
    od;
        
    return List( result, function( a ) if a = infinity then return 0; else return a; fi; end );
        
end );

#-----------------------------------
# PositionOfFirstNonZeroEntryPerColumn
#-----------------------------------

##
InstallMethod( PositionOfFirstNonZeroEntryPerColumn,
        "COLEM: for homalg matrices (HasEvalCertainColumns)",
        [ IsHomalgMatrix and HasEvalCertainColumns ],
        
  function( M )
    local e, mat, pos;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "PositionOfFirstNonZeroEntryPerColumn( CertainColumns )", "\033[0m" );
    
    e := EvalCertainColumns( M );
    
    mat := e[1];
    
    pos := PositionOfFirstNonZeroEntryPerColumn( mat );
    
    return pos{ e[2] };
    
end );

##
InstallMethod( PositionOfFirstNonZeroEntryPerColumn,
        "COLEM: for homalg matrices (HasEvalUnionOfColumns)",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "PositionOfFirstNonZeroEntryPerColumn( UnionOfColumns )", "\033[0m" );
    
    e := EvalUnionOfColumns( M );
    
    return Concatenation( List( e, PositionOfFirstNonZeroEntryPerColumn ) );
    
end );

##
InstallMethod( PositionOfFirstNonZeroEntryPerColumn,
        "COLEM: for homalg matrices (HasEvalUnionOfRows)",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( M )
    local e, r, p, result, i;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "PositionOfFirstNonZeroEntryPerColumn( UnionOfRows )", "\033[0m" );
    
    e := EvalUnionOfRows( M );
    
    r := 0;
        
    p := List( e, PositionOfFirstNonZeroEntryPerColumn );

    p := List( p, a -> List( a, function(x) if x = 0 then return infinity; else return x; fi; end ) );
    
    result := ListWithIdenticalEntries( Length( p[1] ), infinity );
    
    for i in [ 1 .. Length( e ) ] do
    
        result := ListN( result, p[i], function( a, b ) return Minimum( a, b + r ); end );
    
        r := r + NumberRows( e[i] );
    
    od;
    
    return List( result, function( a ) if a = infinity then return 0; else return a; fi; end );
    
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
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "Involution( PreEval )", "\033[0m" );
    
    return Involution( PreEval( M ) );
    
end );

##
InstallMethod( Involution,
        "COLEM: for homalg matrices (HasEvalInvolution)",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "Involution( Involution )", "\033[0m" );
    
    return EvalInvolution( M );
    
end );

##
InstallMethod( Involution,
        "COLEM: for homalg matrices (HasEvalDiagMat)",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "Involution( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    e := List( e, Involution );
    
    return DiagMat( e );
    
end );

#-----------------------------------
# TransposedMatrix
#-----------------------------------

##
InstallMethod( TransposedMatrix,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "TransposedMatrix( PreEval )", "\033[0m" );
    
    return TransposedMatrix( PreEval( M ) );
    
end );

##
InstallMethod( TransposedMatrix,
        "COLEM: for homalg matrices (HasEvalTransposedMatrix)",
        [ IsHomalgMatrix and HasEvalTransposedMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "TransposedMatrix( TransposedMatrix )", "\033[0m" );
    
    return EvalTransposedMatrix( M );
    
end );

##
InstallMethod( TransposedMatrix,
        "COLEM: for homalg matrices (HasEvalDiagMat)",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "TransposedMatrix( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    e := List( e, TransposedMatrix );
    
    return DiagMat( e );
    
end );

#-----------------------------------
# CertainRows
#-----------------------------------

##
InstallMethod( CertainRows,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval, IsList ],
        
  function( M, plist )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: CertainRows( PreEval )", "\033[0m" );
    
    return CertainRows( PreEval( M ), plist );
    
end );

##
InstallMethod( CertainRows,
        "COLEM: for homalg matrices (HasEvalCertainRows)",
        [ IsHomalgMatrix and HasEvalCertainRows, IsList ],
        
  function( M, plist )
    local A;
    
    if not HasEval( M ) ## otherwise we would take CertainRows of a bigger matrix
       and COLEM.level >= COLEM.single_operations then
        
        Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( CertainRows )", "\033[0m" );
        
        A := EvalCertainRows( M );
        
        return CertainRows( A[1], A[2]{plist} );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainRows,
        "COLEM: for homalg matrices (HasEvalCertainColumns)",
        [ IsHomalgMatrix and HasEvalCertainColumns, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    ## this rule CertainRows( CertainColumns( M, [ ... ] ), [ i ] ) = CertainColumns( CertainRows( M, [ i ] ), [ ... ] )
    ## might be potentially expensive once we end up computing the rhs for the entire range of rows of M
    ## instead of computing CertainColumns( M, [ ... ] ) once and for all
    
    if not HasEval( M ) ## otherwise we would take CertainRows of a bigger matrix
       and COLEM.level >= 2 * COLEM.single_operations then ## this line disables this method by default
        
        A := EvalCertainColumns( M );
        
        plistA := A[2];
        A := A[1];
        
        if Length( plist ) * NumberColumns( A ) < Length( plistA ) * NumberRows( A ) then
            
            Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( CertainColumns )", "\033[0m" );
            
            return CertainColumns( CertainRows( A, plist ), plistA );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

## wrong
#InstallMethod( CertainRows,
#        "COLEM: for homalg matrices (HasEvalUnionOfRows)",
#        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
#        
#  function( M, plist )
#    local e, A, B, a, rowsA, rowsB, plistA, plistB;
#    
#    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( UnionOfRows )", "\033[0m" );
#    
#    e := EvalUnionOfRows( M );
#    
#    A := e[1];
#    B := e[2];
#    
#    a := NumberRows( A );
#    
#    rowsA := [ 1 .. a ];
#    rowsB := [ 1 .. NumberRows( B ) ];
#    
#    plistA := Filtered( plist, x -> x in rowsA );     ## CAUTION: don't use Intersection(2)
#    plistB := Filtered( plist - a, x -> x in rowsB ); ## CAUTION: don't use Intersection(2)
#    
#    return UnionOfRows( CertainRows( A, plistA ), CertainRows( B, plistB ) );
#    
#end );

##
InstallMethod( CertainRows,
        "COLEM: for homalg matrices (HasEvalUnionOfColumns)",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
        
  function( M, plist )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( UnionOfColumns )", "\033[0m" );
    
    e := EvalUnionOfColumns( M );
    
    return UnionOfColumns( List( e, a -> CertainRows( a, plist ) ) );
    
end );

##
InstallMethod( CertainRows,
        "COLEM: for homalg matrices (HasEvalCompose)",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local AB;
    
    ## this rule CertainRows( A * B, [ i ] ) = CertainRows( A, [ i ] ) * B
    ## might be potentially expensive once we end up computing the rhs of
    ## for the entire range of rows of A
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( Compose )", "\033[0m" );
        
        AB := EvalCompose( M );
        
        return CertainRows( AB[1], plist ) * AB[2];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainRows,
        "COLEM: for homalg matrices (IsEmpty)",
        [ IsHomalgMatrix, IsList and IsEmpty ], 1001,
        
  function( M, plist )
    
    ## forgetting M may save memory
    return HomalgZeroMatrix( 0, NumberColumns( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# CertainColumns
#-----------------------------------

##
InstallMethod( CertainColumns,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval, IsList ],
        
  function( M, plist )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: CertainColumns( PreEval )", "\033[0m" );
    
    return CertainColumns( PreEval( M ), plist );
    
end );

##
InstallMethod( CertainColumns,
        "COLEM: for homalg matrices (HasEvalCertainColumns)",
        [ IsHomalgMatrix and HasEvalCertainColumns, IsList ],
        
  function( M, plist )
    local A;
    
    if not HasEval( M ) ## otherwise we would take CertainColumns of a bigger matrix
       and COLEM.level >= COLEM.single_operations then
        
        Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( CertainColumns )", "\033[0m" );
        
        A := EvalCertainColumns( M );
        
        return CertainColumns( A[1], A[2]{plist} );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainColumns,
        "COLEM: for homalg matrices (HasEvalCertainRows)",
        [ IsHomalgMatrix and HasEvalCertainRows, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    ## this rule CertainColumns( CertainRows( M, [ ... ] ), [ i ] ) = CertainRows( CertainColumns( M, [ i ] ), [ ... ] )
    ## might be potentially expensive once we end up computing the rhs for the entire range of rows of M
    ## instead of computing CertainRows( M, [ ... ] ) once and for all
    
    if not HasEval( M ) ## otherwise we would take CertainColumns of a bigger matrix
       and COLEM.level >= 2 * COLEM.single_operations then ## this line disables this method by default
        
        A := EvalCertainRows( M );
        
        plistA := A[2];
        A := A[1];
        
        if Length( plist ) * NumberRows( A ) < Length( plistA ) * NumberColumns( A ) then
            
            Info( InfoCOLEM, 4, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( CertainRows )", "\033[0m" );
            
            return CertainRows( CertainColumns( A, plist ), plistA );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

## wrong
#InstallMethod( CertainColumns,
#        "COLEM: for homalg matrices (HasEvalUnionOfColumns)",
#        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
#        
#  function( M, plist )
#    local e, A, B, a, columnsA, columnsB, plistA, plistB;
#    
#    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( UnionOfColumns )", "\033[0m" );
#    
#    e := EvalUnionOfColumns( M );
#    
#    A := e[1];
#    B := e[2];
#    
#    a := NumberColumns( A );
#    
#    columnsA := [ 1 .. a ];
#    columnsB := [ 1 .. NumberColumns( B ) ];
#    
#    plistA := Filtered( plist, x -> x in columnsA );     ## CAUTION: don't use Intersection(2)
#    plistB := Filtered( plist - a, x -> x in columnsB ); ## CAUTION: don't use Intersection(2)
#    
#    return UnionOfColumns( CertainColumns( A, plistA ), CertainColumns( B, plistB ) );
#    
#end );

##
InstallMethod( CertainColumns,
        "COLEM: for homalg matrices (HasEvalUnionOfRows)",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
        
  function( M, plist )
    local e;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( UnionOfRows )", "\033[0m" );
    
    e := EvalUnionOfRows( M );
    
    return UnionOfRows( List( e, a -> CertainColumns( a, plist ) ) );
    
end );

##
InstallMethod( CertainColumns,
        "COLEM: for homalg matrices (HasEvalCompose)",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local AB;
    
    ## this rule CertainColumns( A * B, [ i ] ) = A CertainColumns( B, [ i ] )
    ## might be potentially expensive once we end up computing the rhs of
    ## for the entire range of columns of B
    
    if not HasEval( M ) and COLEM.level >= COLEM.single_operations then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainColumns( Compose )", "\033[0m" );
        
        AB := EvalCompose( M );
        
        return AB[1] * CertainColumns( AB[2], plist );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CertainColumns,
        "COLEM: for homalg matrices (IsEmpty)",
        [ IsHomalgMatrix, IsList and IsEmpty ], 1001,
        
  function( M, plist )
    
    ## forgetting M may save memory
    return HomalgZeroMatrix( NumberRows( M ), 0, HomalgRing( M ) );
    
end );

#-----------------------------------
# DiagMat
#-----------------------------------

##
InstallMethod( DiagMat,
        "COLEM: of a homalg ring and a list of homalg matrices",
        [ IsHomalgRing, IsHomogeneousList ], 1,
        
  function( R, l )
    local pos, r, c, len, L, k, diag;
    
    pos := PositionProperty( l, HasIsEmptyMatrix and IsEmptyMatrix );
    
    if pos <> fail then
        
        r := NumberRows( l[pos] );
        c := NumberColumns( l[pos] );
        
        len := Length( l ); ## we can assume l >= 2, since other methods would then apply
        
        if pos = 1 then
            L := l{[ 2 .. len ]};
            if r = 0 then
                k := Sum( List( L, NumberRows ) );
                diag := UnionOfColumns( HomalgZeroMatrix( k, c, R ), DiagMat( R, L ) );
            else
                k := Sum( List( L, NumberColumns ) );
                diag := UnionOfRows( HomalgZeroMatrix( r, k, R ), DiagMat( R, L ) );
            fi;
        elif pos = len then
            L := l{[ 1 .. len - 1 ]};
            if r = 0 then
                k := Sum( List( L, NumberRows ) );
                diag := UnionOfColumns( DiagMat( R, L ), HomalgZeroMatrix( k, c, R ) );
            else
                k := Sum( List( L, NumberColumns ) );
                diag := UnionOfRows( DiagMat( R, L ), HomalgZeroMatrix( r, k, R ) );
            fi;
        else
            L := l{[ 1 .. pos ]};
            diag := DiagMat( R, [ DiagMat( L ), DiagMat( l{[ pos + 1 .. len ]} ) ] );
        fi;
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "DiagMat( [ ..., empty matrix, ... ] )", "\033[0m" );
        
        return diag;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "COLEM: of a homalg ring and a list of homalg matrices",
        [ IsHomalgRing, IsHomogeneousList ], 1,
        
  function( R, l )
    
    if PositionProperty( l, m -> HasEvalDiagMat( m ) and not HasEval( m ) ) = fail then
        TryNextMethod( );
    fi;
    
    l := List( l, function( m ) if HasEvalDiagMat( m ) and not HasEval( m ) then return EvalDiagMat( m ); fi; return [ m ]; end  );
    
    l := Concatenation( l );
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "DiagMat( [ ..., DiagMat, ... ] )", "\033[0m" );
    
    return DiagMat( R, l );
    
end );

#-----------------------------------
# AddMat
#-----------------------------------

##
InstallMethod( \+,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval + IsHomalgMatrix", "\033[0m" );
    
    return PreEval( A ) + B;
    
end );

##
InstallMethod( \+,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsHomalgMatrix + PreEval", "\033[0m" );
    
    return A + PreEval( B );
    
end );

##
InstallMethod( \+,
        "COLEM: for two homalg matrices (HasEvalCompose)",
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
        "COLEM: for two homalg matrices (HasEvalMulMatRight)",
        [ IsHomalgMatrix and HasEvalMulMatRight, IsHomalgMatrix ],
        
  function( A, B )
    local R, AA;
    
    R := HomalgRing( A );
    
    AA := EvalMulMatRight( A );
    
    if IsMinusOne( AA[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-A + B", "\033[0m" );
        
        return B - AA[1];
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "COLEM: for two homalg matrices (HasEvalMulMat)",
        [ IsHomalgMatrix and HasEvalMulMat, IsHomalgMatrix ],
        
  function( A, B )
    local R, AA;
    
    R := HomalgRing( A );
    
    AA := EvalMulMat( A );
    
    if IsMinusOne( AA[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-A + B", "\033[0m" );
        
        return B - AA[2];
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "COLEM: for two homalg matrices (HasEvalMulMatRight)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalMulMatRight ],
        
  function( A, B )
    local R, BB;
    
    R := HomalgRing( B );
    
    BB := EvalMulMatRight( B );
    
    if IsMinusOne( BB[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "A + (-B)", "\033[0m" );
        
        return A - BB[1];
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "COLEM: for two homalg matrices (HasEvalMulMat)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalMulMat ],
        
  function( A, B )
    local R, BB;
    
    R := HomalgRing( B );
    
    BB := EvalMulMat( B );
    
    if IsMinusOne( BB[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "A + (-B)", "\033[0m" );
        
        return A - BB[2];
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# MulMatRight
#-----------------------------------

##
InstallMethod( \*,
        "COLEM: for homalg matrices with ring elements (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval, IsRingElement ],
        
  function( a, A )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval * IsRingElement", "\033[0m" );
    
    return PreEval( A ) * a;
    
end );

#-----------------------------------
# MulMat
#-----------------------------------

##
InstallMethod( \*,
        "COLEM: for homalg matrices with ring elements (HasPreEval)",
        [ IsRingElement, IsHomalgMatrix and HasPreEval ],
        
  function( a, A )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsRingElement * PreEval", "\033[0m" );
    
    return a * PreEval( A );
    
end );

##
InstallMethod( \*,
        "COLEM: for homalg matrices with ring elements (HasEvalMulMat)",
        [ IsRingElement, IsHomalgMatrix and HasEvalMulMat ],
        
  function( a, A )
    local e;
    
    e := EvalMulMat( A );
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "a * ( b * IsHomalgMatrix )", "\033[0m" );
    
    return ( a * e[1] ) * e[2];
    
end );

#-----------------------------------
# AdditiveInverseMutable
#-----------------------------------

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( A )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: -PreEval", "\033[0m" );
    
    return -PreEval( A );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "COLEM: for homalg matrices (HasEvalMulMatRight)",
        [ IsHomalgMatrix and HasEvalMulMatRight ],
        
  function( A )
    local R, AA;
    
    R := HomalgRing( A );
    
    AA := EvalMulMatRight( A );
    
    if IsMinusOne( AA[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "-(-IsHomalgMatrix)", "\033[0m" );
        
        return AA[1];
    fi;
    
    TryNextMethod( );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "COLEM: for homalg matrices (HasEvalMulMat)",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( A )
    local R, AA;
    
    R := HomalgRing( A );
    
    AA := EvalMulMat( A );
    
    if IsMinusOne( AA[1] ) then
        
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
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval - IsHomalgMatrix", "\033[0m" );
    
    return PreEval( A ) - B;
    
end );

##
InstallMethod( \-,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ],
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsHomalgMatrix - PreEval", "\033[0m" );
    
    return A - PreEval( B );
    
end );

##
InstallMethod( \-,
        "COLEM: for two homalg matrices (HasEvalCompose)",
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
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval, IsHomalgMatrix ], 15001,
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: PreEval * IsHomalgMatrix", "\033[0m" );
    
    return PreEval( A ) * B;
    
end );

##
InstallMethod( \*,
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasPreEval ], 15001,
        
  function( A, B )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: IsHomalgMatrix * PreEval", "\033[0m" );
    
    return A * PreEval( B );
    
end );

##
InstallMethod( \*,
        "COLEM: for homalg matrices (HasEvalMulMat)",
        [ IsHomalgMatrix and HasEvalMulMat, IsHomalgMatrix ], 15001,
        
  function( A, B )
    local e, c, R;
    
    e := EvalMulMat( A );
    
    c := e[1];
    
    R := HomalgRing( A );
    
    if not ( IsRat( c ) or ( HasIsCommutative( R ) and IsCommutative( R ) ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "( c * IsHomalgMatrix ) * IsHomalgMatrix", "\033[0m" );
    
    return c * ( e[2] * B );
    
end );

##
InstallMethod( \*,
        "COLEM: for homalg matrices (HasEvalMulMat)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalMulMat ], 15001,
        
  function( A, B )
    local e, c, R;
    
    e := EvalMulMat( B );
    
    c := e[1];
    
    R := HomalgRing( A );
    
    if not ( IsRat( c ) or ( HasIsCommutative( R ) and IsCommutative( R ) ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * ( c * IsHomalgMatrix )", "\033[0m" );
    
    return c * ( A * e[2] );
    
end );

## this rule speeds up the computation of BasisOfExternalHom in FunctorCategories considerably
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalUnionOfColumns)",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsHomalgMatrix ], 15001,
        
  function( A, B )
    local e, pos, l, c, result, i, k;
    
    e := EvalUnionOfColumns( A );
    
    pos := PositionsProperty( e, mat -> not ( HasIsZero( mat ) and IsZero( mat ) ) );
    
    l := Length( pos );
    
    if l > 2 or ( l = 2 and ForAll( e{pos}, mat -> not ( HasIsOne( mat ) and IsOne( mat ) ) ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "UnionOfColumns( IsZero .. mat, IsOne .. IsZero ) * IsHomalgMatrix", "\033[0m" );
    
    c := List( e, NumberColumns );
    
    result := e[1] * CertainRows( B, [ 1 .. c[1] ] );
    
    k := c[1];
    
    for i in [ 2 .. Length( c ) ] do
        
        result := result + e[i] * CertainRows( B, [ k + 1 .. k + c[i] ] );
        
        k := k + c[i];
        
    od;
    
    return result;
    
end );

## this rule speeds up the computation of BasisOfExternalHom in FunctorCategories considerably
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalUnionOfRows)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfRows ], 15001,
        
  function( A, B )
    local e, pos, l, r, result, i, k;
    
    e := EvalUnionOfRows( B );
    
    pos := PositionsProperty( e, mat -> not ( HasIsZero( mat ) and IsZero( mat ) ) );
    
    l := Length( pos );
    
    if l > 2 or ( l = 2 and ForAll( e{pos}, mat -> not ( HasIsOne( mat ) and IsOne( mat ) ) ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * UnionOfRows( IsZero .. mat, IsOne .. IsZero )", "\033[0m" );
    
    r := List( e, NumberRows );
    
    result := CertainColumns( A, [ 1 .. r[1] ] ) * e[1];
    
    k := r[1];
    
    for i in [ 2 .. Length( r ) ] do
        
        result := result + CertainColumns( A, [ k + 1 .. k + r[i] ] ) * e[i];
        
        k := k + r[i];
        
    od;
    
    return result;
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalUnionOfRows)",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsHomalgMatrix ], 15001,
        
  function( A, B )
    local a;
    
    if HasEval( A ) then
        TryNextMethod( );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "UnionOfRows * IsHomalgMatrix", "\033[0m" );
    
    a := EvalUnionOfRows( A );
    
    return UnionOfRows( List( a, x -> x * B ) );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalUnionOfColumns)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfColumns ], 15001,
        
  function( A, B )
    local b;
    
    if HasEval( B ) then
        TryNextMethod( );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * UnionOfColumns", "\033[0m" );
    
    b := EvalUnionOfColumns( B );
    
    return UnionOfColumns( List( b, x -> A * x ) );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (IsSubidentityMatrix)",
        [ IsHomalgMatrix and IsSubidentityMatrix, IsHomalgMatrix ], 15001,
        
  function( A, B )
    
    if NumberRows( A ) <= NumberColumns( A ) and HasPositionOfFirstNonZeroEntryPerRow( A ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsSubidentityMatrix * IsHomalgMatrix", "\033[0m" );
        
        return CertainRows( B, PositionOfFirstNonZeroEntryPerRow( A ) );
        
    fi;
        
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (IsSubidentityMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsSubidentityMatrix ], 15001,
        
  function( A, B )
    local pos, plist;
    
    if NumberColumns( B ) <= NumberRows( B ) and HasPositionOfFirstNonZeroEntryPerRow( B ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * IsSubidentityMatrix", "\033[0m" );
        
        pos := PositionOfFirstNonZeroEntryPerRow( B );
        
        plist := List( [ 1 .. NumberColumns( B ) ], i -> Position( pos, i ) );
        
        return CertainColumns( A, plist );
        
    fi;
        
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalLeftInverse)",
        [ IsHomalgMatrix and HasEvalLeftInverse, IsHomalgMatrix ], 15001,
        
  function( A, B )
    
    if IsIdenticalObj( EvalLeftInverse( A ), B ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "(its LeftInverse) * IsHomalgMatrix", "\033[0m" );
        
        return HomalgIdentityMatrix( NumberColumns( B ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalRightInverse)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalRightInverse ], 15001,
        
  function( A, B )
    
    if IsIdenticalObj( A, EvalRightInverse( B ) ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "IsHomalgMatrix * (its RightInverse)", "\033[0m" );
        
        return HomalgIdentityMatrix( NumberRows( A ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalLeftInverse)",
        [ IsHomalgMatrix and HasEvalLeftInverse, IsHomalgMatrix and HasEvalCertainColumns ], 15001,
        
  function( A, B )
    local C, D;
    
    C := EvalLeftInverse( A );
    D := EvalCertainColumns( B );
    
    if HasEvalCertainColumns( C ) then
        
        C := EvalCertainColumns( C );
        
        if IsIdenticalObj( C[1], D[1] ) and C[2] = D[2] then
            
            Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "(its LeftInverse) * CertainColumns( IsHomalgMatrix )", "\033[0m" );
            
            return HomalgIdentityMatrix( NumberColumns( B ), HomalgRing( A ) );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalCertainRows)",
        [ IsHomalgMatrix and HasEvalCertainRows, IsHomalgMatrix and HasEvalRightInverse ], 15001,
        
  function( A, B )
    local C, D;
    
    C := EvalCertainRows( A );
    D := EvalRightInverse( B );
    
    
    if HasEvalCertainRows( D ) then
        
        D := EvalCertainRows( D );
        
        if IsIdenticalObj( C[1], D[1] ) and C[2] = D[2] then
        
            Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "CertainRows( IsHomalgMatrix ) * (its RightInverse)", "\033[0m" );
            
            return HomalgIdentityMatrix( NumberRows( A ), HomalgRing( A ) );
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalCompose)",
        [ IsHomalgMatrix and HasEvalCompose, IsHomalgMatrix ], 15001,
        
  function( A, B )
    local AA, LI;
    
    AA := EvalCompose( A );
    
    LI := AA[2];
    
    if HasEvalLeftInverse( LI ) then ## give it a chance
        
        Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "( IsHomalgMatrix * LeftInverse ) * IsHomalgMatrix", "\033[0m" );
        
        return AA[1] * ( LI * B );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "COLEM: for two homalg matrices (HasEvalCompose)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalCompose ], 15001,
        
  function( A, B )
    local BB, RI;
    
    BB := EvalCompose( B );
    
    RI := BB[1];
    
    if HasEvalRightInverse( RI ) then ## give it a chance
        
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
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: LeftInverse( PreEval )", "\033[0m" );
    
    return LeftInverse( PreEval( M ) );
    
end );

##
InstallMethod( LeftInverse,
        "COLEM: for homalg matrices (HasEvalRightInverse)",
        [ IsHomalgMatrix and HasEvalRightInverse ], 1,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "LeftInverse( RightInverse )", "\033[0m" );
    
    return EvalRightInverse( M );
    
end );

##
InstallMethod( LeftInverse,
        "COLEM: for homalg matrices (HasEvalInverse)",
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
        "COLEM: for homalg matrices (HasPreEval)",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( M )
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: RightInverse( PreEval )", "\033[0m" );
    
    return RightInverse( PreEval( M ) );
    
end );

##
InstallMethod( RightInverse,
        "COLEM: for homalg matrices (HasEvalLeftInverse)",
        [ IsHomalgMatrix and HasEvalLeftInverse ], 1,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "\033[01mCOLEM\033[0m ", COLEM.color, "RightInverse( LeftInverse )", "\033[0m" );
    
    return EvalLeftInverse( M );
    
end );

##
InstallMethod( RightInverse,
        "COLEM: for homalg matrices (HasEvalInverse)",
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
        "COLEM: for homalg matrices (HasEvalDiagMat)",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local D;
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: BasisOfRowModule( DiagMat )", "\033[0m" );
    
    D := DiagMat( List( EvalDiagMat( M ), BasisOfRowModule ) );
    
    ## CAUTION: might cause problems
    SetIsBasisOfRowsMatrix( D, true );
    
    return D;
    
end );

#-----------------------------------
# BasisOfColumnModule
#-----------------------------------

##
InstallMethod( BasisOfColumnModule,
        "COLEM: for homalg matrices (HasEvalDiagMat)",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local D;
    
    Info( InfoCOLEM, 3, COLEM.color, "colem: BasisOfColumnModule( DiagMat )", "\033[0m" );
    
    D := DiagMat( List( EvalDiagMat( M ), BasisOfColumnModule ) );
    
    ## CAUTION: might cause problems
    SetIsBasisOfColumnsMatrix( D, true );
    
    return D;
    
end );

