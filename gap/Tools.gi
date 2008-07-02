#############################################################################
##
##  Tools.gi                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg tools.
##
#############################################################################

####################################
#
# methods for operations (you MUST replace for an external CAS):
#
####################################

##
## operations for ring elements:
##

##
InstallMethod( Zero,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Zero) then
        if IsFunction( RP!.Zero ) then
            return RP!.Zero( R );
        else
            return RP!.Zero;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( One,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.One) then
        if IsFunction( RP!.One ) then
            return RP!.One( R );
        else
            return RP!.One;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( MinusOne,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.MinusOne) then
        if IsFunction( RP!.MinusOne ) then
            return RP!.MinusOne( R );
        else
            return RP!.MinusOne;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsZero,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsZero) then
        return RP!.IsZero( r );
    else
        return homalgPointer( r ) = homalgPointer( Zero( R ) ); ## FIXME
    fi;
    
end );

##
InstallMethod( IsOne,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsOne) then
        return RP!.IsOne( r );
    else
        return homalgPointer( r ) = homalgPointer( One( R ) ); ## FIXME
    fi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg rings elements",
        [ IsHomalgExternalRingElementRep ],
        
  function( r )
    local R, RP, minus_r;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Minus) and IsBound(RP!.Zero) then
        minus_r := RP!.Minus( Zero( R ), r );
        return HomalgExternalRingElement( minus_r, homalgExternalCASystem( R ), R );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \/,
        "for external homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep,
          IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( a, u )
    local R, RP;
    
    R := HomalgRing( a );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideByUnit) then
        return HomalgExternalRingElement( RP!.DivideByUnit( a, u ), u!.cas, R );
    fi;
    
    Error( "could not find a procedure called DivideByUnit in the homalgTable", RP, "\n" );
    
end );

##
## operations for matrices:
##

##
InstallMethod( IsZero,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    ## since DecideZero calls IsZero, the attribute IsReducedModuloRingRelations is used
    ## in DecideZero to avoid infinite loops
    
    if IsBound(RP!.IsZeroMatrix) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations!
        return RP!.IsZeroMatrix( DecideZero( M ) ); ## with this, \= can fall back to IsZero
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## From the documentation ?Zero: `ZeroSameMutability( <obj> )' is equivalent to `0 * <obj>'.
    
    return M = 0 * M; ## hence, by default, IsZero falls back to \= (see below)
    
end );

##
InstallMethod( Eval,				### defines: an initial matrix filled with zeros
        "for homalg matrices",
        [ IsHomalgMatrix and IsInitialMatrix and HasNrRows and HasNrColumns ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.ZeroMatrix ) then
        ResetFilterObj( C, IsInitialMatrix );
        return RP!.ZeroMatrix( C );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called ZeroMatrix in the homalgTable to evaluate an external initial matrix", RP, "\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    ResetFilterObj( C, IsInitialMatrix );
    
    return ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) );
    
end );

##
InstallMethod( Eval,				### defines: an initial matrix filled with zeros
        "for homalg matrices",
        [ IsHomalgMatrix and IsInitialIdentityMatrix and HasNrRows and HasNrColumns ],
        
  function( C )
    local R, RP, o, z, zz, id;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.IdentityMatrix ) then
        ResetFilterObj( C, IsInitialIdentityMatrix );
        return RP!.IdentityMatrix( C );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called IdentityMatrix in the homalgTable to evaluate an external initial identity matrix", RP, "\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    ResetFilterObj( C, IsInitialIdentityMatrix );
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return id;
    
end );

##
InstallMethod( Eval,				### defines: Involution
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    M :=  EvalInvolution( C );
    
    if IsBound(RP!.Involution) then
        return RP!.Involution( M );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called Involution in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return TransposedMat( Eval( M ) );
    
end );

##
InstallMethod( Eval,				### defines: CertainRows
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainRows ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalCertainRows( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainRows) then
        return RP!.CertainRows( M, plist );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called CertainRows in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){ plist };
    
end );

##
InstallMethod( Eval,				### defines: CertainColumns
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainColumns ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalCertainColumns( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainColumns) then
        return RP!.CertainColumns( M, plist );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called CertainColumns in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){ [ 1 .. NrRows( M ) ] }{plist};
    
end );

##
InstallMethod( Eval,				### defines: UnionOfRows
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( C )
    local R, RP, e, A, B, U;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalUnionOfRows( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.UnionOfRows) then
        return RP!.UnionOfRows( A, B );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called UnionOfRows in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := ShallowCopy( Eval( A ) );
    
    U{ [ NrRows( A ) + 1 .. NrRows( A ) + NrRows( B ) ] } := Eval( B );
    
    return U;
    
end );

##
InstallMethod( Eval,				### defines: UnionOfColumns
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( C )
    local R, RP, e, A, B, U;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalUnionOfColumns( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.UnionOfColumns) then
        return RP!.UnionOfColumns( A, B );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called UnionOfColumns in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := List( ShallowCopy( Eval( A ) ), ShallowCopy );
    
    U{ [ 1 .. NrRows( A ) ] }{ [ NrColumns( A ) + 1 .. NrColumns( A ) + NrColumns( B ) ] } := Eval( B );
    
    return U;
    
end );

##
InstallMethod( Eval,				### defines: DiagMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( C )
    local R, RP, e, z, m, n, diag, mat;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalDiagMat( C );
    
    if IsBound(RP!.DiagMat) then
        return RP!.DiagMat( e );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called DiagMat in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    z := Zero( R );
    
    m := Sum( List( e, NrRows ) );
    n := Sum( List( e, NrColumns ) );
    
    diag := List( [ 1 .. m ],  a -> List( [ 1 .. n ], b -> z ) );
    
    #=====# begin of the core procedure #=====#
    
    m := 0;
    n := 0;
    
    for mat in e do
        diag{ [ m + 1 .. m + NrRows( mat ) ] }{ [ n + 1 .. n + NrColumns( mat ) ] } := Eval( mat );
        m := m + NrRows( mat );
        n := n + NrColumns( mat );
    od;
    
    return diag;
    
end );

##
InstallMethod( Eval,				### defines: KroneckerMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalKroneckerMat ],
        
  function( C )
    local R, RP, A, B;
    
    R := HomalgRing( C );
    
    if HasIsCommutative( R ) and not IsCommutative( R ) then
        Info( InfoWarning, 1, "\033[01m\033[5;31;47mthe Kronecker product is only defined for commutative rings!\033[0m" );
    fi;
    
    RP := homalgTable( R );
    
    A :=  EvalKroneckerMat( C )[1];
    B :=  EvalKroneckerMat( C )[2];
    
    if IsBound(RP!.KroneckerMat) then
        return RP!.KroneckerMat( A, B );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called KroneckerMat in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return KroneckerProduct( Eval( A ), Eval( B ) ); ## this was easy :)
    
end );

##
InstallMethod( Eval,				### defines: MulMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( C )
    local R, RP, e, a, A;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalMulMat( C );
    
    a := e[1];
    A := e[2];
    
    if IsBound(RP!.MulMat) then
        
        e := RP!.MulMat( a, A );
        
        if HasRingRelations( R ) then
            e := HomalgMatrix( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called MulMat in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := a * Eval( A );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: AddMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalAddMat ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalAddMat( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.AddMat) then
        
        e := RP!.AddMat( A, B );
        
        if HasRingRelations( R ) then
            e := HomalgMatrix( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called AddMat in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) + Eval( B );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: SubMat
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalSubMat ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalSubMat( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.SubMat) then
        
        e := RP!.SubMat( A, B );
        
        if HasRingRelations( R ) then
            e := HomalgMatrix( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called SubMat in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) - Eval( B );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: Compose
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalCompose( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.Compose) then
        
        e := RP!.Compose( A, B );
        
        if HasRingRelations( R ) then
            e := HomalgMatrix( e, R );
            return Eval( DecideZero( e ) );
        fi;
        
        return e;
        
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called Compose in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) * Eval( B );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,				### defines: IdentityMap
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix and HasNrRows and HasNrColumns ], 10,
        
  function( C )
    local R, RP, o, z, zz, id;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.IdentityMatrix ) then
        return RP!.IdentityMatrix( C );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called IdentityMatrix in the homalgTable to evaluate an external identity matrix", RP, "\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return id;
    
end );

##
InstallMethod( Eval,				### defines: ZeroMap
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero and HasNrRows and HasNrColumns ], 20,
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if NrRows( C ) = 0 or NrColumns( C ) = 0 then
        Info( InfoWarning, 1, "\033[01m\033[5;31;47man empty matrix is about to get evaluated!\033[0m" );
    fi;
    
    if IsBound( RP!.ZeroMatrix ) then
        return RP!.ZeroMatrix( C );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called ZeroMatrix in the homalgTable to evaluate an external zero matrix", RP, "\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    return ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) );
    
end );

##
InstallMethod( NrRows,				### defines: NrRows
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.NrRows) then
        return RP!.NrRows( C );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called NrRows in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Length( Eval( C ) );
    
end );

##
InstallMethod( NrColumns,			### defines: NrColumns
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.NrColumns) then
        return RP!.NrColumns( C );
    fi;
    
    if IsHomalgExternalMatrixRep( C ) then
        Error( "could not find a procedure called NrColumns in the homalgTable to apply on a an external matrix", RP, "\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Length( Eval( C )[ 1 ] );
    
end );

####################################
#
# methods for operations (you probably want to replace for an external CAS):
#
####################################

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRing, IsRingElement ],
        
  function( R, r )
    
    return IsUnit( R!.ring, r );
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRing, IsRingElement and IsHomalgExternalRingElement ],
        
  function( R, r )
    local RP;
    
    if HasIsZero( r ) and IsZero( r ) then
        return false;
    elif HasIsOne( r ) and IsOne( r ) then
        return true;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsUnit) then
        return RP!.IsUnit( R, r );
    fi;
    
    if Eval( LeftInverse( HomalgMatrix( [ r ], 1, 1, R ) ) ) <> fail then
        return true;
    fi;
    
    return false;
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgExternalRingElementRep ],
        
  function( r )
    
    return IsUnit( HomalgRing( r ), r );
    
end );

##
InstallMethod( ZeroRows,			### defines: ZeroRows
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, M, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    M := DecideZero( C );
    
    if IsBound(RP!.ZeroRows) then
        return RP!.ZeroRows( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    z := HomalgZeroMatrix( 1, NrColumns( C ), R );
    
    return Filtered( [ 1 .. NrRows( C ) ], a -> CertainRows( M, [ a ] ) = z );
    
end );

##
InstallMethod( ZeroColumns,			### defines: ZeroColumns
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, M, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    M := DecideZero( C );
    
    if IsBound(RP!.ZeroColumns) then
        return RP!.ZeroColumns( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    z := HomalgZeroMatrix( NrRows( C ), 1, R );
    
    return Filtered( [ 1 .. NrColumns( C ) ], a ->  CertainColumns( M, [ a ] ) = z );
    
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
    
    RP := homalgTable( R );
    
    if IsBound(RP!.AreEqualMatrices) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations!
        return RP!.AreEqualMatrices( M1, M2 );
    elif IsBound(RP!.Equal) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations!
        return RP!.Equal( M1, M2 );
    elif IsBound(RP!.IsZeroMatrix) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations!
        return RP!.IsZeroMatrix( DecideZero( M1 - M2 ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsIdentityMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    if NrRows( M ) <> NrColumns( M ) then
        return false;
    elif NrRows( M ) = 0 then
        return true;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsIdentityMatrix) then
        return RP!.IsIdentityMatrix( DecideZero( M ) );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return M = HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( IsDiagonalMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, diag;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsDiagonalMatrix) then
        return RP!.IsDiagonalMatrix( DecideZero ( M ) );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    diag := DiagonalEntries( M );
    
    return M = HomalgDiagonalMatrix( diag, NrRows( M ), NrColumns( M ), R );
    
end );

##
InstallMethod( GetColumnIndependentUnitPositions,	### defines: GetColumnIndependentUnitPositions (GetIndependentUnitPositions)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, pos_list )
    local R, RP, rest, pos, i, j, k;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetColumnIndependentUnitPositions) then
        return RP!.GetColumnIndependentUnitPositions( M, pos_list );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rest := [ 1 .. NrColumns( M ) ];
    
    pos := [ ];
    
    for i in [ 1 .. NrRows( M ) ] do
        for k in Reversed( rest ) do
            if not [ i, k ] in pos_list and IsUnit( R, GetEntryOfHomalgMatrix( M, i, k ) ) then
                Add( pos, [ i, k ] );
                rest := Filtered( rest, a -> IsZero( GetEntryOfHomalgMatrix( M, i, a ) ) );
                break;
            fi;
        od;
    od;
    
    return pos;
    
end );

##
InstallMethod( GetRowIndependentUnitPositions,	### defines: GetRowIndependentUnitPositions (GetIndependentUnitPositions)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, pos_list )
    local R, RP, rest, pos, j, i, k;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetRowIndependentUnitPositions) then
        return RP!.GetRowIndependentUnitPositions( M, pos_list );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rest := [ 1 .. NrRows( M ) ];
    
    pos := [ ];
    
    for j in [ 1 .. NrColumns( M ) ] do
        for k in Reversed( rest ) do
            if not [ j, k ] in pos_list and IsUnit( R, GetEntryOfHomalgMatrix( M, k, j ) ) then
                Add( pos, [ j, k ] );
                rest := Filtered( rest, a -> IsZero( GetEntryOfHomalgMatrix( M, a, j ) ) );
                break;
            fi;
        od;
    od;
    
    return pos;
    
end );

##
InstallMethod( GetUnitPosition,			### defines: GetUnitPosition
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, pos_list )
    local R, RP, m, n, i, j;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetUnitPosition) then
        return RP!.GetUnitPosition( M, pos_list );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    m := NrRows( M );
    n := NrColumns( M );
    
    for i in [ 1 .. m ] do
        for j in [ 1 .. n ] do
            if not [ i, j ] in pos_list and not j in pos_list and IsUnit( R, GetEntryOfHomalgMatrix( M, i, j ) ) then
                return [ i, j ];
            fi;
        od;
    od;
    
    return fail;	## the Maple version returns NULL and we return fail
    
end );

##
InstallMethod( DivideEntryByUnit,		### defines: DivideRowByUnit
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt, IsRingElement ],
        
  function( M, i, j, u )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideEntryByUnit) then
        RP!.DivideEntryByUnit( M, i, j, u );
    else
        SetEntryOfHomalgMatrix( M, i, j, GetEntryOfHomalgMatrix( M, i, j ) / u );
    fi;
    
end );
    
##
InstallMethod( DivideRowByUnit,			### defines: DivideRowByUnit
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsRingElement, IsInt ],
        
  function( M, i, u, j )
    local R, RP, a;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideRowByUnit) then
        RP!.DivideRowByUnit( M, i, u, j );
    else
	
        #=====# begin of the core procedure #=====#
	
        if j > 0 then
            ## the two for's avoid creating non-dense lists:
            for a in [ 1 .. j - 1 ] do
                DivideEntryByUnit( M, i, a, u );
            od;
            for a in [ j + 1 .. NrColumns( M ) ] do
                DivideEntryByUnit( M, i, a, u );
            od;
            SetEntryOfHomalgMatrix( M, i, j, One( R ) );
        else
            for a in [ 1 .. NrColumns( M ) ] do
                DivideEntryByUnit( M, i, a, u );
            od;
        fi;
        
    fi;
    
    ## since all what we did had a side effect on Eval( M ) ignoring
    ## possible other Eval's, e.g. EvalCompose, we must return
    ## a new homalg matrix object only containing Eval( M )
    return HomalgMatrix( Eval( M ), NrRows( M ), NrColumns( M ), R );
    
end );

##
InstallMethod( DivideColumnByUnit,		### defines: DivideColumnByUnit
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsRingElement, IsInt ],
        
  function( M, j, u, i )
    local R, RP, a;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideColumnByUnit) then
        RP!.DivideColumnByUnit( M, j, u, i );
    else
        
        #=====# begin of the core procedure #=====#
        
        if i > 0 then
            ## the two for's avoid creating non-dense lists:
            for a in [ 1 .. i - 1 ] do
                DivideEntryByUnit( M, a, j, u );
            od;
            for a in [ i + 1 .. NrRows( M ) ] do
                DivideEntryByUnit( M, a, j, u );
            od;
            SetEntryOfHomalgMatrix( M, i, j, One( R ) );
        else
            for a in [ 1 .. NrRows( M ) ] do
                DivideEntryByUnit( M, a, j, u );
            od;
        fi;
        
    fi;
    
    ## since all what we did had a side effect on Eval( M ) ignoring
    ## possible other Eval's, e.g. EvalCompose, we must return
    ## a new homalg matrix object only containing Eval( M )
    return HomalgMatrix( Eval( M ), NrRows( M ), NrColumns( M ), R );
    
end );

##
InstallMethod( CopyRowToIdentityMatrix,		### defines: CopyRowToIdentityMatrix
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsList, IsPosInt ],
        
  function( M, i, L, j )
    local R, RP, v, vi, l, r;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CopyRowToIdentityMatrix) then
        RP!.CopyRowToIdentityMatrix( M, i, L, j );
    else
        
        #=====# begin of the core procedure #=====#
        
        if Length( L ) > 0 and IsHomalgMatrix( L[1] ) then
            v := L[1];
        fi;
        
        if Length( L ) > 1 and IsHomalgMatrix( L[2] ) then
            vi := L[2];
        fi;
        
        if IsBound( v ) and IsBound( vi ) then
            ## the two for's avoid creating non-dense lists:
            for l in [ 1 .. j - 1 ] do
                r := GetEntryOfHomalgMatrix( M, i, l );
                if not IsZero( r ) then
                    SetEntryOfHomalgMatrix( v, j, l, -r );
                    SetEntryOfHomalgMatrix( vi, j, l, r );
                fi;
            od;
            for l in [ j + 1 .. NrColumns( M ) ] do
                r := GetEntryOfHomalgMatrix( M, i, l );
                if not IsZero( r ) then
                    SetEntryOfHomalgMatrix( v, j, l, -r );
                    SetEntryOfHomalgMatrix( vi, j, l, r );
                fi;
            od;
        elif IsBound( v ) then
            ## the two for's avoid creating non-dense lists:
            for l in [ 1 .. j - 1 ] do
                r := GetEntryOfHomalgMatrix( M, i, l );
                SetEntryOfHomalgMatrix( v, j, l, -r );
            od;
            for l in [ j + 1 .. NrColumns( M ) ] do
                r := GetEntryOfHomalgMatrix( M, i, l );
                SetEntryOfHomalgMatrix( v, j, l, -r );
            od;
        elif IsBound( vi ) then
            ## the two for's avoid creating non-dense lists:
            for l in [ 1 .. j - 1 ] do
                r := GetEntryOfHomalgMatrix( M, i, l );
                SetEntryOfHomalgMatrix( vi, j, l, r );
            od;
            for l in [ j + 1 .. NrColumns( M ) ] do
                r := GetEntryOfHomalgMatrix( M, i, l );
                SetEntryOfHomalgMatrix( vi, j, l, r );
            od;
        fi;
        
    fi;
    
end );

##
InstallMethod( CopyColumnToIdentityMatrix,	### defines: CopyColumnToIdentityMatrix
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsList, IsPosInt ],
        
  function( M, j, L, i )
    local R, RP, u, ui, m, k, r;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CopyColumnToIdentityMatrix) then
        RP!.CopyColumnToIdentityMatrix( M, j, L, i );
    else
        
        #=====# begin of the core procedure #=====#
        
        if Length( L ) > 0 and IsHomalgMatrix( L[1] ) then
            u := L[1];
        fi;
        
        if Length( L ) > 1 and IsHomalgMatrix( L[2] ) then
            ui := L[2];
        fi;
        
        if IsBound( u ) and IsBound( ui ) then
            ## the two for's avoid creating non-dense lists:
            for k in [ 1 .. i - 1 ] do
                r := GetEntryOfHomalgMatrix( M, k, j );
                if not IsZero( r ) then
                    SetEntryOfHomalgMatrix( u, k, i, -r );
                    SetEntryOfHomalgMatrix( ui, k, i, r );
                fi;
            od;
            for k in [ i + 1 .. NrRows( M ) ] do
                r := GetEntryOfHomalgMatrix( M, k, j );
                if not IsZero( r ) then
                    SetEntryOfHomalgMatrix( u, k, i, -r );
                    SetEntryOfHomalgMatrix( ui, k, i, r );
                fi;
            od;
        elif IsBound( u ) then
            ## the two for's avoid creating non-dense lists:
            for k in [ 1 .. i - 1 ] do
                r := GetEntryOfHomalgMatrix( M, k, j );
                SetEntryOfHomalgMatrix( u, k, i, -r );
            od;
            for k in [ i + 1 .. NrRows( M ) ] do
                r := GetEntryOfHomalgMatrix( M, k, j );
                SetEntryOfHomalgMatrix( u, k, i, -r );
            od;
        elif IsBound( ui ) then
            ## the two for's avoid creating non-dense lists:
            for k in [ 1 .. i - 1 ] do
                r := GetEntryOfHomalgMatrix( M, k, j );
                SetEntryOfHomalgMatrix( ui, k, i, r );
            od;
            for k in [ i + 1 .. NrRows( M ) ] do
                r := GetEntryOfHomalgMatrix( M, k, j );
                SetEntryOfHomalgMatrix( ui, k, i, r );
            od;
        fi;
        
    fi;
    
end );

##
InstallMethod( SetColumnToZero,			### defines: SetColumnToZero
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt ],
        
  function( M, i, j )
    local R, RP, zero, k;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.SetColumnToZero) then
        RP!.SetColumnToZero( M, i, j );
    else
        
        #=====# begin of the core procedure #=====#
        
        zero := Zero( R );
        
        ## the two for's avoid creating non-dense lists:
        for k in [ 1 .. i - 1 ] do
            SetEntryOfHomalgMatrix( M, k, j, zero );
        od;
        
        for k in [ i + 1 .. NrRows( M ) ] do
            SetEntryOfHomalgMatrix( M, k, j, zero );
        od;
        
    fi;
    
    ## since all what we did had a side effect on Eval( M ) ignoring
    ## possible other Eval's, e.g. EvalCompose, we must return
    ## a new homalg matrix object only containing Eval( M )
    return HomalgMatrix( Eval( M ), NrRows( M ), NrColumns( M ), R );
    
end );

##
InstallMethod( GetCleanRowsPositions,		### defines: GetCleanRowsPositions
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, clean_columns )
    local R, RP, one, clean_rows, m, j, i;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetCleanRowsPositions) then
        return RP!.GetCleanRowsPositions( M, clean_columns );
    fi;
    
    one := One( R );
    
    #=====# begin of the core procedure #=====#
    
    clean_rows := [ ];
    
    m := NrRows( M );
    
    for j in clean_columns do
        for i in [ 1 .. m ] do
            if IsOne( GetEntryOfHomalgMatrix( M, i, j ) ) then
                Add( clean_rows, i );
                break;
            fi;
        od;
    od;
    
    return clean_rows;
    
end );

##
InstallMethod( ConvertRowToMatrix,		### defines: ConvertRowToMatrix
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt ],
        
  function( M, r, c )
    local R, RP, ext_obj, l, mat, j;
    
    if NrRows( M ) <> 1 then
        Error( "expecting a single row matrix as a first argument\n" );
    fi;
    
    if r = 1 then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ConvertRowToMatrix) then
        ext_obj := RP!.ConvertRowToMatrix( M, r, c );
        return HomalgMatrix( ext_obj, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## to use
    ## CreateHomalgMatrix( GetListOfHomalgMatrixAsString( M ), c, r, R )
    ## we would need a transpose afterwards,
    ## which differs from Involution in general:
    
    l := List( [ 1 .. c ],  j -> CertainColumns( M, [ (j-1) * r + 1 .. j * r ] ) );
    l := List( l, GetListOfHomalgMatrixAsString );
    l := List( l, a -> CreateHomalgMatrix( a, r, 1, R ) );
    
    mat := HomalgZeroMatrix( r, 0, R );
    
    for j in [ 1 .. c ] do
        mat := UnionOfColumns( mat, l[j] );
    od;
    
    return mat;
    
end );

##
InstallMethod( ConvertColumnToMatrix,		### defines: ConvertColumnToMatrix
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt ],
        
  function( M, r, c )
    local R, RP, ext_obj;
    
    if NrColumns( M ) <> 1 then
        Error( "expecting a single column matrix as a first argument\n" );
    fi;
    
    if c = 1 then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ConvertColumnToMatrix) then
        ext_obj := RP!.ConvertColumnToMatrix( M, r, c );
        return HomalgMatrix( ext_obj, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return CreateHomalgMatrix( GetListOfHomalgMatrixAsString( M ), r, c, R ); ## delicate
    
end );

##
InstallMethod( ConvertMatrixToRow,		### defines: ConvertMatrixToRow
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, ext_obj, r, c, l, mat, j;
    
    if NrRows( M ) = 1 then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ConvertMatrixToRow) then
        ext_obj := RP!.ConvertMatrixToRow( M );
        return HomalgMatrix( ext_obj, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    r := NrRows( M );
    c := NrColumns( M );
    
    ## CreateHomalgMatrix( GetListOfHomalgMatrixAsString( "Transpose"( M ) ), 1, r * c, R )
    ## would require a Transpose operation,
    ## which differs from Involution in general:
    
    l := List( [ 1 .. c ],  j -> CertainColumns( M, [ j ] ) );
    l := List( l, GetListOfHomalgMatrixAsString );
    l := List( l, a -> CreateHomalgMatrix( a, 1, r, R ) );
    
    mat := HomalgZeroMatrix( 1, 0, R );
    
    for j in [ 1 .. c ] do
        mat := UnionOfColumns( mat, l[j] );
    od;
    
    return mat;
    
end );

##
InstallMethod( ConvertMatrixToColumn,		### defines: ConvertMatrixToColumn
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, ext_obj;
    
    if NrColumns( M ) = 1 then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ConvertMatrixToColumn) then
        ext_obj := RP!.ConvertMatrixToColumn( M );
        return HomalgMatrix( ext_obj, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return CreateHomalgMatrix( GetListOfHomalgMatrixAsString( M ), NrColumns( M ) * NrRows( M ), 1, R ); ## delicate
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgMatrix and HasPreEval ],
        
  function( C )
    local R, RP, e;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  PreEval( C );
    
    if IsBound(RP!.PreEval) then
        return RP!.PreEval( e );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( e );
    
end );

####################################
#
# methods for operations (you probably don't urgently need replace for an external CAS):
#
####################################

##
InstallMethod( SUM,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep,
          IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r1, r2 )
    local R, RP, cas;
    
    R := HomalgRing( r1 );
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Sum) then
        cas := homalgExternalCASystem( R );
        return HomalgExternalRingElement( RP!.Sum( r1,  r2 ), cas, R ) ;
    elif IsBound(RP!.Minus) then
        cas := homalgExternalCASystem( R );
        return HomalgExternalRingElement( RP!.Minus( r1, RP!.Minus( Zero( R ), r2 ) ), cas, R ) ;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PROD,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep,
          IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r1, r2 )
    local R, RP, cas;
    
    R := HomalgRing( r1 );
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Product) then
        cas := homalgExternalCASystem( R );
        return HomalgExternalRingElement( RP!.Product( r1,  r2 ), cas, R ) ;
    fi;
    
    TryNextMethod( );
    
end );

