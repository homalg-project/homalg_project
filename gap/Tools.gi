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
    
    z := Zero( C!.ring );
    
    #=====# begin of the core procedure #=====#
    
    return ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and IsIdentityMatrix ],
        
  function( C )
    local o, z, zz, id;
    
    z := Zero( C!.ring );
    o := One( C!.ring );
    
    #=====# begin of the core procedure #=====#
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return id;
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalCertainRows ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := C!.ring;
    
    RP := HomalgTable( R );
    
    e :=  EvalCertainRows( C );
    
    M := e[1];
    plist := e[2];
    
    if IsBound(RP!.CertainRows) then
        return RP!.CertainRows( M, plist );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( M ){plist};
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalCertainColumns ],
        
  function( C )
    local R, RP, e, M, plist;
    
    R := C!.ring;
    
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
    
    R := C!.ring;
    
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
    
    R := C!.ring;
    
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
    
    R := C!.ring;
    
    RP := HomalgTable( R );
    
    e :=  EvalDiagMat( C );
    
    if IsBound(RP!.DiagMat) then
        return RP!.DiagMat( e );
    fi;
    
    z := Zero( e[1]!.ring );
    
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
        [ IsHomalgInternalMatrixRep and HasEvalAdd ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := C!.ring;
    
    RP := HomalgTable( R );
    
    e :=  EvalAdd( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.Add) then
        return RP!.Add( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( A ) + Eval( B );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep and HasEvalCompose ],
        
  function( C )
    local R, RP, e, A, B;
    
    R := C!.ring;
    
    RP := HomalgTable( R );
    
    e :=  EvalCompose( C );
    
    A := e[1];
    B := e[2];
    
    if IsBound(RP!.Compose) then
        return RP!.Compose( A, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Eval( A ) * Eval( B );
    
end );

