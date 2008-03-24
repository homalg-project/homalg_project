#############################################################################
##
##  HomalgMatrix.gi             homalg package               Mohamed Barakat
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
BindGlobal( "HomalgMatrixFamily",
        NewFamily( "HomalgMatrixFamily" ) );

# two new types:
BindGlobal( "HomalgInternalMatrixType",
        NewType( HomalgMatrixFamily ,
                IsHomalgInternalMatrixRep ) );

BindGlobal( "HomalgExternalMatrixType",
        NewType( HomalgMatrixFamily ,
                IsHomalgExternalMatrixRep ) );

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
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    ## since DecideZero calls IsZeroMatrix, the attribute IsReducedModuloRingRelations is used
    ## in DecideZero to avoid infinite loops
    
    if IsBound(RP!.IsZeroMatrix) then
        return RP!.IsZeroMatrix( DecideZero( M ) ); ## with this, \= can fall back to IsZeroMatrix
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## From the documentation ?Zero: `ZeroSameMutability( <obj> )' is equivalent to `0 * <obj>'.
    
    return M = 0 * M; ## hence, by default, IsZeroMatrix falls back to \= (see below)
    
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
    
    return HomalgPointer( Eval( M ) ); ## here we must evaluate
    
end );

##
InstallMethod( HomalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return HomalgExternalCASystem( R ); ## avoid evaluating the matrix
    else
        return HomalgExternalCASystem( Eval( M ) );
    fi;
    
end );

##
InstallMethod( HomalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return HomalgExternalCASystemVersion( R ); ## avoid evaluating the matrix
    else
        return HomalgExternalCASystemVersion( Eval( M ) );
    fi;
    
end );

##
InstallMethod( HomalgStream,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return HomalgStream( R ); ## avoid evaluating the matrix
    else
        return HomalgStream( Eval( M ) );
    fi;
    
end );

##
InstallMethod( HomalgExternalCASystemPID,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return HomalgExternalCASystemPID( R ); ## avoid evaluating the matrix
    else
        return HomalgExternalCASystemPID( Eval( M ) );
    fi;
    
end );

##
InstallMethod( AreComparableMatrices,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    if HasNrRows( M1 ) or HasNrRows( M2 ) then ## trigger as few as possible operations
        return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
               and NrRows( M1 ) = NrRows( M2 ) and NrColumns( M1 ) = NrColumns( M2 );
    else ## no other choice
        return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
               and NrColumns( M1 ) = NrColumns( M2 ) and NrRows( M1 ) = NrRows( M2 );
    fi;
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    return DecideZero( M1 ) = DecideZero( M2 );
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgInternalMatrixRep and IsReducedModuloRingRelations,
          IsHomalgInternalMatrixRep and IsReducedModuloRingRelations ],
        
  function( M1, M2 )
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    return Eval( M1 ) = Eval( M2 );
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgExternalMatrixRep and IsReducedModuloRingRelations,
          IsHomalgExternalMatrixRep and IsReducedModuloRingRelations ],
        
  function( M1, M2 )
    local R, RP;
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.AreEqualMatrices) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations!
        return RP!.AreEqualMatrices( M1, M2 );
    elif IsBound(RP!.Equal) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations!
        return RP!.Equal( M1, M2 );
    elif IsBound(RP!.IsZeroMatrix) then
        ## offhand, the following way does not allow garbage collection in the external system
        return RP!.IsZeroMatrix( DecideZero( M1 - M2 ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return HomalgMatrix( "zero", NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, C;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrColumns( M ) );
    SetNrColumns( C, NrRows( M ) );
    
    SetEvalInvolution( C, M );
    
    return C;
    
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, Length( plist ) );
    SetNrColumns( C, NrColumns( M ) );
    
    SetEvalCertainRows( C, [ M, plist ] );
    
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
    
    C := HomalgMatrix( R );
    
    SetNrColumns( C, Length( plist ) );
    SetNrRows( C, NrRows( M ) );
    
    SetEvalCertainColumns( C, [ M, plist ] );
    
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) + NrRows( B ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalUnionOfRows( C, [ A, B ] );
    
    return C;
    
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) + NrColumns( B ) );
    
    SetEvalUnionOfColumns( C, [ A, B ] );
    
    return C;
    
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, Sum( List( l, NrRows ) ) );
    SetNrColumns( C, Sum( List( l, NrColumns ) ) );
    
    SetEvalDiagMat( C, l );
    
    return C;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsRingElement, IsHomalgMatrix ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalMulMat( C, [ a, A ] );
    
    return C;
    
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalAddMat( C, [ A, B ] );
    
    return C;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := MinusOne( R ) * A;
    
    if HasIsZeroMatrix( A ) then
        SetIsZeroMatrix( C, IsZeroMatrix( A ) );
    fi;
    
    return C;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalSubMat( C, [ A, B ] );
    
    return C;
    
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
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( B ) );
    
    SetEvalCompose( C, [ A, B ] );
    
    return C;
    
end );

##
InstallMethod( NonZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local zero_rows;
    
    zero_rows := ZeroRows( C );
    
    return Filtered( [ 1 .. NrRows( C ) ], x -> not x in zero_rows );
    
end );

##
InstallMethod( NonZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local zero_columns;
    
    zero_columns := ZeroColumns( C );
    
    return Filtered( [ 1 .. NrColumns( C ) ], x -> not x in zero_columns );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, C;
    
    if NrRows( M ) < NrColumns( M ) then
        Error( "the number of rows ", NrRows( M ), "is smaller than the number of columns ", NrColumns( M ), "\n" );
    fi;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrColumns( M ) );
    SetNrColumns( C, NrRows( M ) );
    
    SetEvalLeftInverse( C, M );
    SetEvalRightInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    if NrColumns( M ) = 0 then
        return HomalgMatrix( "zero", 0, NrRows( M ), HomalgRing( M ) );
    else
        Error( "a zero matrix with positive number of columns has no left inverse!" );
    fi;
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, C;
    
    if NrColumns( M ) < NrRows( M ) then
        Error( "the number of columns ", NrColumns( M ), "is smaller than the number of rows ", NrRows( M ), "\n" );
    fi;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrColumns( C, NrRows( M ) );
    SetNrRows( C, NrColumns( M ) );
    
    SetEvalRightInverse( C, M );
    SetEvalLeftInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    if NrRows( M ) = 0 then
        return HomalgMatrix( "zero", NrColumns( M ), 0, HomalgRing( M ) );
    else
        Error( "a zero matrix with positive number of rows has no left inverse!" );
    fi;
    
end );

##
InstallMethod( AddRhs,				### defines: AddRhs
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( A )
    local C;
    
    C := HomalgMatrix( A );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalAddRhs( C, true );
    
    SetRightHandSide( C, HomalgMatrix( "identity", NrRows( A ), HomalgRing( A ) ) );
    
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
    
    C := HomalgMatrix( A );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalAddRhs( C, true );
    
    SetRightHandSide( C, B );
    
    return C;
    
end );

##
InstallMethod( AddBts,				### defines: AddBts
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( A )
    local C;
    
    C := HomalgMatrix( A );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalAddBts( C, true );
    
    SetBottomSide( C, HomalgMatrix( "identity", NrColumns( A ), HomalgRing( A ) ) );
    
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
    
    C := HomalgMatrix( A );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalAddBts( C, true );
    
    SetBottomSide( C, B );
    
    return C;
    
end );

##
InstallMethod( GetSide,
        "of homalg matrices",
        [ IsString, IsHomalgMatrix ],
        
  function( side, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalGetSide( C, [ side, A ] );
    
    return C;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgMatrix,
  function( arg )
    local nargs, R, type, ar, matrix, M;
    
    nargs := Length( arg );
    
    ## "copy" the matrix:
    if nargs > 0 and IsHomalgMatrix( arg[1] ) then
        
        R := HomalgRing( arg[1] );
        
        M := HomalgMatrix( R );
        
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
    
    if nargs = 1 then ## only the ring is given
    ## an empty matrix
        
        ## Objectify:
        Objectify( type, matrix );
        
        return matrix;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 2 then
    ## it can get obscure ;)
        
        if LowercaseString( arg[1]{[1..3]} ) = "int" then
            
            ## Objectify:
            Objectify( HomalgInternalMatrixType, matrix );
            
            return matrix;
            
        elif LowercaseString( arg[1]{[1..3]} ) = "ext" then
            
            ## Objectify:
            Objectify( HomalgExternalMatrixType, matrix );
            
            return matrix;
            
        fi;
        
    fi; ## CAUTION: don't make an elif here!!!
    
    if IsString( arg[1] ) and Length( arg[1] ) > 1 and  LowercaseString( arg[1]{[1..2]} ) = "id" then
    ## the identity matrix:
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsIdentityMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
            SetNrColumns( matrix, arg[2] );
        fi;
        
        return matrix;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "init" then
    ## an initial matrix having the flag IsInitialMatrix
    ## and filled with zeros BUT NOT marked as an IsZeroMatrix:
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            SetNrColumns( matrix, arg[3] );
        fi;
        
        return matrix;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "void" then
    ## a void matrix filled with nothing having the flag IsVoidMatrix:
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsVoidMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            SetNrColumns( matrix, arg[3] );
        fi;
            
        return matrix;
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "zero" then
    ## the zero matrix:
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsZeroMatrix, true );
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            SetNrRows( matrix, arg[2] );
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            SetNrColumns( matrix, arg[3] );
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

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix and IsPermutationMatrix ],
        
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
    
    Print( "permutation matrix>" );
    
end );

##
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

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( o )
    
    if HasEval( o ) then
        Print( "<A" );
    else
        Print( "<An unevaluated" );
    fi;
    
    Print( " homalg " );
    
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

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( o )
    local first_attribute;
    
    first_attribute := true;
    
    if IsVoidMatrix( o ) then
        Print( "<A void" );
    elif IsInitialMatrix( o ) then
        Print( "<An initial" );
    elif not HasEval( o ) then
        Print( "<An unevaluated" );
    else
        Print( "<A" );
        first_attribute := false;
    fi;
    
    if not ( HasIsSubidentityMatrix( o ) and IsSubidentityMatrix( o ) )
       and HasIsZeroMatrix( o ) then ## if this method applies and HasIsZeroMatrix is set we already know that o is a non-zero homalg matrix
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    if not ( HasNrRows( o ) and NrRows( o ) = 1 and HasNrColumns( o ) and NrColumns( o ) = 1 ) then
        if HasIsDiagonalMatrix( o ) and IsDiagonalMatrix( o ) then
            Print( " diagonal" );
        elif HasIsStrictUpperTriangularMatrix( o ) and IsStrictUpperTriangularMatrix( o ) then
            Print( " strict upper triangular" );
        elif HasIsStrictLowerTriangularMatrix( o ) and IsStrictLowerTriangularMatrix( o ) then
            Print( " strict lower triangular" );
        elif HasIsUpperTriangularMatrix( o ) and IsUpperTriangularMatrix( o ) then
            if not first_attribute then
                Print( "n upper triangular" );
            else
                Print( " upper triangular" );
            fi;
        elif HasIsLowerTriangularMatrix( o ) and IsLowerTriangularMatrix( o ) then
            Print( " lower triangular" );
        elif HasIsTriangularMatrix( o ) and IsTriangularMatrix( o ) then
            Print( " triangular" );
        elif not first_attribute then
            first_attribute := fail;
        fi;
        
        if first_attribute <> fail then
            first_attribute := true;
        else
            first_attribute := false;
        fi;
        
        if HasIsInvertibleMatrix( o ) and IsInvertibleMatrix( o ) then
            if not first_attribute then
                Print( "n invertible" );
            else
                Print( " invertible" );
            fi;
        else
            if HasIsRightInvertibleMatrix( o ) and IsRightInvertibleMatrix( o ) then
                Print( " right invertible" );
            elif HasIsFullRowRankMatrix( o ) and IsFullRowRankMatrix( o ) then
                Print( " full row rank" );
            fi;
            
            if HasIsLeftInvertibleMatrix( o ) and IsLeftInvertibleMatrix( o ) then
                Print( " left invertible" );
            elif HasIsFullColumnRankMatrix( o ) and IsFullColumnRankMatrix( o ) then
                Print( " full column rank" );
            fi;
        fi;
    fi;
    
    if HasIsSubidentityMatrix( o ) and IsSubidentityMatrix( o ) then
        Print( " sub-identity" );
    fi;
    
    Print( " homalg " );
    
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

##
InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( o )
    
    Display( Eval( o ) );
    
end);

