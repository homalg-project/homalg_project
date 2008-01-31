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
# methods for operations:
#
####################################

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and IsZeroMatrix ],
        
  function( C )
    local z;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    return ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and IsIdentityMatrix ],
        
  function( C )
    local o, z, zz, id;
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return id;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalInvolution ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    M :=  EvalInvolution( C );
    
    if IsBound(RP!.Involution) then
        return RP!.Involution( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return TransposedMat( Eval( M ) );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalCertainRows ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalCertainRows( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainRows) then
        return RP!.CertainRows( M, plist );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){ plist };
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalCertainColumns ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalCertainColumns( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainColumns) then
        return RP!.CertainColumns( M, plist );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){ [ 1 .. NrRows( M ) ] }{plist};
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalUnionOfRows ],
        
  function( C )
    local R, RP, e, A, B, U;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalUnionOfRows( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.UnionOfRows) then
        return RP!.UnionOfRows( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := ShallowCopy( Eval( A ) );
    
    U{ [ NrRows( A ) + 1 .. NrRows( A ) + NrRows( B ) ] } := Eval( B );
    
    return U;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalUnionOfColumns ],
        
  function( C )
    local R, RP, e, A, B, U;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalUnionOfColumns( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.UnionOfColumns) then
        return RP!.UnionOfColumns( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := List( ShallowCopy( Eval( A ) ), ShallowCopy );
    
    U{ [ 1 .. NrRows( A ) ] }{ [ NrColumns( A ) + 1 .. NrColumns( A ) + NrColumns( B ) ] } := Eval( B );
    
    return U;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalDiagMat ],
        
  function( C )
    local R, RP, e, z, m, n, diag, mat;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalDiagMat( C );
    
    if IsBound(RP!.DiagMat) then
        return RP!.DiagMat( e );
    fi;
    
    z := Zero( HomalgRing( e[1] ) );
    
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
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalMulMat ],
        
  function( C )
    local R, RP, e, a, A;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalMulMat( C );
    
    a := e[1];
    A := e[2];
    
    if IsBound(RP!.MulMat) then
        return RP!.MulMat( a, A );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := a * Eval( A );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalAddMat ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalAddMat( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.AddMat) then
        return RP!.AddMat( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) + Eval( B );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalSubMat ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalSubMat( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.SubMat) then
        return RP!.SubMat( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) - Eval( B );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalCompose ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalCompose( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.Compose) then
        return RP!.Compose( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) * Eval( B );
    
    if HasRingRelations( R ) then
        e := MatrixForHomalg( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasPreEval ],
        
  function( C )
    local R, RP, e;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  PreEval( C );
    
    #=====# begin of the core procedure #=====#
    
    return Eval( e );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalAddRhs ],
        
  function( C )
    local R, RP, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    A := EvalAddRhs( C );
    B := RightHandSide( C );
    
    if IsBound(RP!.AddRhs) then
        return RP!.AddRhs( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( A );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalAddBts ],
        
  function( C )
    local R, RP, A, B;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    A := EvalAddBts( C );
    B := BottomSide( C );
    
    if IsBound(RP!.AddBts) then
        return RP!.AddBts( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( A );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalGetSide ],
        
  function( C )
    local R, RP, e, side, A;
    
    R := HomalgRing( C );
    
    RP := HomalgTable( R );
    
    e :=  EvalGetSide( C );
    
    side := e[1];
    A := e[2];
    
    if IsBound(RP!.GetSide) then
        return RP!.GetSide( side, A );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if side = "rhs" then
        return RightHandSide( A );
    elif side = "bts" then
        return BottomSide( A );
    elif side = "lhs" or side = "ups" then
        return Eval( A );
    else
        Error( "the first argument must be either \"rhs\", \"bts\", \"lhs\", or \"ups\", but received: ", side, "\n" );
    fi;
    
end );

