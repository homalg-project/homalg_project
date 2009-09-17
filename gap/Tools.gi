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
        [ IsHomalgRing ],
        
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
        [ IsHomalgRing ],
        
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
        [ IsHomalgRing ],
        
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
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    if R = fail then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsZero) then
        return RP!.IsZero( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsOne,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    if R = fail then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsOne) then
        return RP!.IsOne( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsMinusOne,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return IsZero( r + One( r ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg rings elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    if R = fail then
        TryNextMethod( );
    elif not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Minus) and IsBound(RP!.Zero) and HasRingElementConstructor( R ) then
        return RingElementConstructor( R )( RP!.Minus( Zero( R ), r ), R );
    fi;
    
    ## never fall back to:
    ## return Zero( r ) - r;
    ## this will cause an infinite loop with a method for \- in LIRNG.gi
    
    TryNextMethod( );
    
end );

##
InstallMethod( \/,
        "for homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( a, u )
    local R, RP;
    
    R := HomalgRing( a );
    
    if R = fail then
        TryNextMethod( );
    elif not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideByUnit) then
        return RingElementConstructor( R )( RP!.DivideByUnit( a, u ), R );
    fi;
    
    Error( "could not find a procedure called DivideByUnit in the homalgTable\n" );
    
end );

##
InstallMethod( DegreeMultivariatePolynomial,
        "for homalg rings elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP, weights, minus_r;
    
    R := HomalgRing( r );
    
    if R = fail then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if IsList( weights[1] ) then
            if IsBound(RP!.MultiWeightedDegreeMultivariatePolynomial) then
                return RP!.MultiWeightedDegreeMultivariatePolynomial( r, weights, R );
            fi;
        elif IsBound(RP!.WeightedDegreeMultivariatePolynomial) then
            return RP!.WeightedDegreeMultivariatePolynomial( r, weights, R );
        fi;
        
    elif IsBound(RP!.DegreeMultivariatePolynomial) then
        
        return RP!.DegreeMultivariatePolynomial( r, R );
        
    fi;
    
    TryNextMethod( );
    
end );

##
## operations for matrices:
##

##  <#GAPDoc Label="IsZero:matrix_method">
##  <ManSection>
##    <Meth Arg="A" Name="IsZero" Label="a method for matrices"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; matrix <A>A</A> is zero or not, taking possible ring relations into account. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IsZeroMatrix</C> is bound then
##      <M>RP</M>!.<C>IsZeroMatrix</C><M>(</M> <A>A</A> <M>)</M> is returned.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( ) / [ 2 ];
##  <A homalg internal ring>
##  gap> A := HomalgMatrix( "[ 2 ]", ZZ );
##  <A homalg internal 1 by 1 matrix>
##  gap> Display( A );
##  [ [  2 ] ]
##  gap> IsZero( A );
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( IsZero,
        "for homalg matrices",
        [ IsHomalgMatrix and IsReducedModuloRingRelations ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsZeroMatrix) then
        ## CAUTION: the external system must be able to check zero modulo possible ring relations!
        return RP!.IsZeroMatrix( M ); ## with this, \= can fall back to IsZero
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## From the documentation ?Zero: `ZeroSameMutability( <obj> )' is equivalent to `0 * <obj>'.
    
    return M = 0 * M; ## hence, by default, IsZero falls back to \= (see below)
    
end );

##  <#GAPDoc Label="Eval:IsInitialMatrix">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with HomalgInitialMatrix"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>IsInitialMatrix</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroMatrix</C> is bound then
##      <M>RP</M>!.<C>ZeroMatrix</C><M>(</M> <A>A</A> <M>)</M> is returned.
##      The filter <C>IsInitialMatrix</C> is reset.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: an initial matrix filled with zeros
        "for homalg matrices (IsInitialMatrix)",
        [ IsHomalgMatrix and IsInitialMatrix and HasNrRows and HasNrColumns ],
        
  function( C )
    local R, RP, z, zz;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.ZeroMatrix ) then
        ResetFilterObj( C, IsInitialMatrix );
        return RP!.ZeroMatrix( C );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called ZeroMatrix in the homalgTable to evaluate a non-internal initial matrix\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    ResetFilterObj( C, IsInitialMatrix );
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    return homalgInternalMatrixHull( List( [ 1 .. NrRows( C ) ],  i -> ShallowCopy( zz ) ) );
    
end );

##  <#GAPDoc Label="Eval:IsInitialIdentityMatrix">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with HomalgInitialIdentityMatrix"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>IsInitialIdentityMatrix</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IdentityMatrix</C> is bound then
##      <M>RP</M>!.<C>IdentityMatrix</C><M>(</M> <A>A</A> <M>)</M> is returned.
##      The filter <C>IsInitialIdentityMatrix</C> is reset.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: an initial quadratic matrix filled with ones on the diagonal and zeros otherwise
        "for homalg matrices (IsInitialIdentityMatrix)",
        [ IsHomalgMatrix and IsInitialIdentityMatrix and HasNrRows and HasNrColumns ],
        
  function( C )
    local R, RP, o, z, zz, id;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.IdentityMatrix ) then
        ResetFilterObj( C, IsInitialIdentityMatrix );
        return RP!.IdentityMatrix( C );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called IdentityMatrix in the homalgTable to evaluate a non-internal initial identity matrix\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    ResetFilterObj( C, IsInitialIdentityMatrix );
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return homalgInternalMatrixHull( id );
    
end );

##
InstallMethod( Eval,
        "for homalg matrices (HasEvalMatrixOperation)",
        [ IsHomalgMatrix and HasEvalMatrixOperation ],
        
  function( C )
    local func_arg;
    
    func_arg := EvalMatrixOperation( C );
    
    ResetFilterObj( C, EvalMatrixOperation );
    
    ## delete the component which was left over by GAP
    Unbind( C!.EvalMatrixOperation );
    
    return CallFuncList( func_arg[1], func_arg[2] );
    
end );

##  <#GAPDoc Label="Eval:HasEvalInvolution">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with Involution"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalInvolution</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>Involution</C> is bound then
##      <M>RP</M>!.<C>Involution</C> applied to the content of the attribute <C>EvalInvolution</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: Involution
        "for homalg matrices (HasEvalInvolution)",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    M :=  EvalInvolution( C );
    
    if IsBound(RP!.Involution) then
        return RP!.Involution( M );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called Involution in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return homalgInternalMatrixHull( TransposedMat( Eval( M )!.matrix ) );
    
end );

##  <#GAPDoc Label="Eval:HasEvalCertainRows">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with CertainRows"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalCertainRows</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>CertainRows</C> is bound then
##      <M>RP</M>!.<C>CertainRows</C> applied to the content of the attribute <C>EvalCertainRows</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: CertainRows
        "for homalg matrices (HasEvalCertainRows)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called CertainRows in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return homalgInternalMatrixHull( Eval( M )!.matrix{ plist } );
    
end );

##  <#GAPDoc Label="Eval:HasEvalCertainColumns">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with CertainColumns"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalCertainColumns</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>CertainColumns</C> is bound then
##      <M>RP</M>!.<C>CertainColumns</C> applied to the content of the attribute <C>EvalCertainColumns</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: CertainColumns
        "for homalg matrices (HasEvalCertainColumns)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called CertainColumns in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return homalgInternalMatrixHull( Eval( M )!.matrix{[ 1 .. NrRows( M ) ]}{plist} );
    
end );

##  <#GAPDoc Label="Eval:HasEvalUnionOfRows">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with UnionOfRows"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalUnionOfRows</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>UnionOfRows</C> is bound then
##      <M>RP</M>!.<C>UnionOfRows</C> applied to the content of the attribute <C>EvalUnionOfRows</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: UnionOfRows
        "for homalg matrices (HasEvalUnionOfRows)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called UnionOfRows in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := ShallowCopy( Eval( A )!.matrix );
    
    U{ [ NrRows( A ) + 1 .. NrRows( A ) + NrRows( B ) ] } := Eval( B )!.matrix;
    
    return homalgInternalMatrixHull( U );
    
end );

##  <#GAPDoc Label="Eval:HasEvalUnionOfColumns">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with UnionOfColumns"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalUnionOfColumns</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>UnionOfColumns</C> is bound then
##      <M>RP</M>!.<C>UnionOfColumns</C> applied to the content of the attribute <C>EvalUnionOfColumns</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: UnionOfColumns
        "for homalg matrices (HasEvalUnionOfColumns)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called UnionOfColumns in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    U := List( Eval( A )!.matrix, ShallowCopy );
    
    U{ [ 1 .. NrRows( A ) ] }{ [ NrColumns( A ) + 1 .. NrColumns( A ) + NrColumns( B ) ] } := Eval( B )!.matrix;
    
    return homalgInternalMatrixHull( U );
    
end );

##  <#GAPDoc Label="Eval:HasEvalDiagMat">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with DiagMat"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalDiagMat</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>DiagMat</C> is bound then
##      <M>RP</M>!.<C>DiagMat</C> applied to the content of the attribute <C>EvalDiagMat</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: DiagMat
        "for homalg matrices (HasEvalDiagMat)",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( C )
    local R, RP, e, z, m, n, diag, mat;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalDiagMat( C );
    
    if IsBound(RP!.DiagMat) then
        return RP!.DiagMat( e );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called DiagMat in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    z := Zero( R );
    
    m := Sum( List( e, NrRows ) );
    n := Sum( List( e, NrColumns ) );
    
    diag := List( [ 1 .. m ],  a -> List( [ 1 .. n ], b -> z ) );
    
    #=====# begin of the core procedure #=====#
    
    m := 0;
    n := 0;
    
    for mat in e do
        diag{ [ m + 1 .. m + NrRows( mat ) ] }{ [ n + 1 .. n + NrColumns( mat ) ] } := Eval( mat )!.matrix;
        m := m + NrRows( mat );
        n := n + NrColumns( mat );
    od;
    
    return homalgInternalMatrixHull( diag );
    
end );

##  <#GAPDoc Label="Eval:HasEvalKroneckerMat">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with KroneckerMat"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalKroneckerMat</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>KroneckerMat</C> is bound then
##      <M>RP</M>!.<C>KroneckerMat</C> applied to the content of the attribute <C>EvalKroneckerMat</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: KroneckerMat
        "for homalg matrices (HasEvalKroneckerMat)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called KroneckerMat in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return homalgInternalMatrixHull( KroneckerProduct( Eval( A )!.matrix, Eval( B )!.matrix ) ); ## this was easy :)
    
end );

##  <#GAPDoc Label="Eval:HasEvalMulMat">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with MulMat"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalMulMat</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>MulMat</C> is bound then
##      <M>RP</M>!.<C>MulMat</C> applied to the content of the attribute <C>EvalMulMat</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: MulMat
        "for homalg matrices (HasEvalMulMat)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called MulMat in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := a * Eval( A );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##  <#GAPDoc Label="Eval:HasEvalAddMat">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with AddMat"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalAddMat</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>AddMat</C> is bound then
##      <M>RP</M>!.<C>AddMat</C> applied to the content of the attribute <C>EvalAddMat</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: AddMat
        "for homalg matrices (HasEvalAddMat)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called AddMat in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) + Eval( B );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##  <#GAPDoc Label="Eval:HasEvalSubMat">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with SubMat"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalSubMat</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>SubMat</C> is bound then
##      <M>RP</M>!.<C>SubMat</C> applied to the content of the attribute <C>EvalSubMat</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: SubMat
        "for homalg matrices (HasEvalSubMat)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called SubMat in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) - Eval( B );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##  <#GAPDoc Label="Eval:HasEvalCompose">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with Compose"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>HasEvalCompose</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>Compose</C> is bound then
##      <M>RP</M>!.<C>Compose</C> applied to the content of the attribute <C>EvalCompose</C><M>(</M> <A>A</A> <M>)</M>
##      is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: Compose
        "for homalg matrices (HasEvalCompose)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called Compose in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := Eval( A ) * Eval( B );
    
    if HasRingRelations( R ) then
        e := HomalgMatrix( e, R );
        return Eval( DecideZero( e ) );
    fi;
    
    return e;
    
end );

##  <#GAPDoc Label="Eval:IsIdentityMatrix">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with HomalgIdentityMatrix"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>IsIdentityMatrix</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IdentityMatrix</C> is bound then
##      <M>RP</M>!.<C>IdentityMatrix</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: IdentityMap
        "for homalg matrices (IsIdentityMatrix)",
        [ IsHomalgMatrix and IsIdentityMatrix and HasNrRows and HasNrColumns ], 10,
        
  function( C )
    local R, RP, o, z, zz, id;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.IdentityMatrix ) then
        return RP!.IdentityMatrix( C );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called IdentityMatrix in the homalgTable to evaluate a non-internal identity matrix\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i) local z; z := ShallowCopy( zz ); z[i] := o; return z; end );
    
    return homalgInternalMatrixHull( id );
    
end );

##  <#GAPDoc Label="Eval:IsZeroMatrix">
##  <ManSection>
##    <Meth Arg="A" Name="Eval" Label="for matrices created with HomalgZeroMatrix"/>
##    <Returns>see below</Returns>
##    <Description>
##      This method of the attribute <C>Eval</C> is triggered in case the filter <C>IsZeroMatrix</C> for the matrix <A>A</A>
##      is set to true.
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroMatrix</C> is bound then
##      <M>RP</M>!.<C>ZeroMatrix</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eval,				### defines: ZeroMap
        "for homalg matrices (IsZero)",
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called ZeroMatrix in the homalgTable to evaluate a non-internal zero matrix\n" );
    fi;
    
    z := Zero( HomalgRing( C ) );
    
    #=====# begin of the core procedure #=====#
    
    ## copying the rows saves memory;
    ## we assume that the entries are never modified!!!
    return homalgInternalMatrixHull( ListWithIdenticalEntries( NrRows( C ),  ListWithIdenticalEntries( NrColumns( C ), z ) ) );
    
end );

##  <#GAPDoc Label="NrRows:meth">
##  <ManSection>
##    <Meth Arg="A" Name="NrRows" Label="for matrices"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      Return the number of rows of the matrix <A>A</A>. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>NrRows</C> is bound then
##      <M>RP</M>!.<C>NrRows</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called NrRows in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Length( Eval( C )!.matrix );
    
end );

##  <#GAPDoc Label="NrColumns:meth">
##  <ManSection>
##    <Meth Arg="A" Name="NrColumns" Label="for matrices"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      Return the number of columns of the matrix <A>A</A>. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>NrColumns</C> is bound then
##      <M>RP</M>!.<C>NrColumns</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
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
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called NrColumns in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Length( Eval( C )!.matrix[ 1 ] );
    
end );

##  <#GAPDoc Label="Determinant:meth">
##  <ManSection>
##    <Meth Arg="A" Name="Determinant" Label="for matrices"/>
##    <Returns>a ring element</Returns>
##    <Description>
##      Return the determinant of <A>A</A>. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>Determinant</C> is bound then
##      <M>RP</M>!.<C>Determinant</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Determinant,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Determinant) then
        return RingElementConstructor( R )( RP!.Determinant( C ), R );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called Determinant in the homalgTable to apply on a non-internal matrix\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return Determinant( Eval( C )!.matrix );
    
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
        [ IsHomalgRing, IsRingElement ],
        
  function( R, r )
    local RP;
    
    if HasIsZero( r ) and IsZero( r ) then
        return false;
    elif HasIsOne( r ) and IsOne( r ) then
        return true;
    fi;
    
    if IsBool( Eval( LeftInverse( HomalgMatrix( [ r ], 1, 1, R ) ) ) ) then
        return false;
    fi;
    
    return true;
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRing, IsHomalgRingElement ],
        
  function( R, r )
    local RP;
    
    if HasIsZero( r ) and IsZero( r ) then
        return false;
    elif HasIsOne( r ) and IsOne( r ) then
        return true;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsUnit) and not HasRingRelations( R ) then
        return RP!.IsUnit( R, r );
    fi;
    
    if IsBool( Eval( LeftInverse( HomalgMatrix( [ r ], 1, 1, R ) ) ) ) then
        return false;
    fi;
    
    return true;
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return IsUnit( HomalgRing( r ), r );
    
end );

##  <#GAPDoc Label="ZeroRows:meth">
##  <ManSection>
##    <Oper Arg="A" Name="ZeroRows" Label="for matrices"/>
##    <Returns>a list of positive integers</Returns>
##    <Description>
##      Return the list of zero rows of the matrix <A>A</A>. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroRows</C> is bound then
##      <M>RP</M>!.<C>ZeroRows</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
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

##  <#GAPDoc Label="ZeroColumns:meth">
##  <ManSection>
##    <Oper Arg="A" Name="ZeroColumns" Label="for matrices"/>
##    <Returns>a list of positive integers</Returns>
##    <Description>
##      Return the list of zero columns of the matrix <A>A</A>. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroColumns</C> is bound then
##      <M>RP</M>!.<C>ZeroColumns</C><M>(</M> <A>A</A> <M>)</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
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
InstallMethod( GetRidOfObsoleteRows,			### defines: GetRidOfObsoleteRows (BetterBasis)
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetRidOfObsoleteRows) then
        M := HomalgMatrix( RP!.GetRidOfObsoleteRows( DecideZero( C ) ), R );
        if HasNrColumns( C ) then
            SetNrColumns( M, NrColumns( C ) );
        fi;
        SetZeroRows( M, [ ] );
        return M;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## get rid of the rows containing the ring relations
    M := CertainRows( C, NonZeroRows( C ) );
    
    SetZeroRows( M, [ ] );
    
    return M;
    
end );

##
InstallMethod( GetRidOfObsoleteColumns,			### defines: GetRidOfObsoleteColumns (BetterBasis)
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetRidOfObsoleteColumns) then
        M := HomalgMatrix( RP!.GetRidOfObsoleteColumns( DecideZero( C ) ), R );
        if HasNrRows( C ) then
            SetNrRows( M, NrRows( C ) );
        fi;
        SetZeroColumns( M, [ ] );
        return M;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## get rid of the columns containing the ring relations
    M := CertainColumns( C, NonZeroColumns( C ) );
    
    SetZeroColumns( M, [ ] );
    
    return M;
    
end );

##  <#GAPDoc Label="EQ:matrix_method">
##  <ManSection>
##    <Meth Arg="A,B" Name="=" Label="a method for matrices"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; matrices <A>A</A> and <A>B</A> are equal, taking possible ring relations into account. <Br/>
##      Let <M>R :=</M> <C>HomalgRing</C><M>(</M> <A>A</A> <M>)</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>AreEqualMatrices</C> is bound then
##      <M>RP</M>!.<C>AreEqualMatrices</C><M>(</M> <A>A</A>, <A>B</A> <M>)</M> is returned.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( ) / [ 2 ];
##  <A homalg internal ring>
##  gap> A := HomalgMatrix( "[ 2 ]", ZZ );
##  <A homalg internal 1 by 1 matrix>
##  gap> Display( A );
##  [ [  2 ] ]
##  gap> IsZero( A );
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgMatrix and IsReducedModuloRingRelations,
          IsHomalgMatrix and IsReducedModuloRingRelations ],
        
  function( M1, M2 )
    local R, RP;
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.AreEqualMatrices) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations (known to the external system)!
        return RP!.AreEqualMatrices( M1, M2 );
    elif IsBound(RP!.Equal) then
        ## CAUTION: the external system must be able to check equality modulo possible ring relations (known to the external system)!
        return RP!.Equal( M1, M2 );
    elif IsBound(RP!.IsZeroMatrix) then	## ensuring this avoids infinite loops
        return IsZero( M1 - M2 );
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
    
    ## caution: we deliberately do not return a new hull for Eval( M )
    
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
    ## possible other Eval's, e.g. EvalCompose, we want to return
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
    ## possible other Eval's, e.g. EvalCompose, we want to return
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
    ## possible other Eval's, e.g. EvalCompose, we want to return
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
        return HomalgMatrix( ext_obj, r, c, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## to use
    ## CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( M ), c, r, R )
    ## we would need a transpose afterwards,
    ## which differs from Involution in general:
    
    l := List( [ 1 .. c ],  j -> CertainColumns( M, [ (j-1) * r + 1 .. j * r ] ) );
    l := List( l, GetListOfHomalgMatrixAsString );
    l := List( l, a -> CreateHomalgMatrixFromString( a, r, 1, R ) );
    
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
        return HomalgMatrix( ext_obj, r, c, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( M ), r, c, R ); ## delicate
    
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
        return HomalgMatrix( ext_obj, 1, NrRows( M ) * NrColumns( M ), R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    r := NrRows( M );
    c := NrColumns( M );
    
    ## CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( "Transpose"( M ) ), 1, r * c, R )
    ## would require a Transpose operation,
    ## which differs from Involution in general:
    
    l := List( [ 1 .. c ],  j -> CertainColumns( M, [ j ] ) );
    l := List( l, GetListOfHomalgMatrixAsString );
    l := List( l, a -> CreateHomalgMatrixFromString( a, 1, r, R ) );
    
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
        return HomalgMatrix( ext_obj, NrColumns( M ) * NrRows( M ), 1, R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( M ), NrColumns( M ) * NrRows( M ), 1, R ); ## delicate
    
end );

##
InstallMethod( Eval,
        "for homalg matrices (HasPreEval)",
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

##
InstallMethod( DegreesOfEntries,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, weights, e, c;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), ListWithIdenticalEntries( NrColumns( C ), -1 ) );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if IsList( weights[1] ) then
            if IsBound(RP!.MultiWeightedDegreesOfEntries) then
                return RP!.MultiWeightedDegreesOfEntries( C, weights );
            fi;
        elif IsBound(RP!.WeightedDegreesOfEntries) then
            return RP!.WeightedDegreesOfEntries( C, weights );
        fi;
        
    elif IsBound(RP!.DegreesOfEntries) then
        return RP!.DegreesOfEntries( C );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := EntriesOfHomalgMatrix( C );
    
    e := List( e, DegreeMultivariatePolynomial );
    
    c := NrColumns( C );
    
    return List( [ 1 .. NrRows( C ) ], r -> e{[ ( r - 1 ) * c + 1 .. r * c ]} );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, weights, e, deg0;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if IsList( weights[1] ) then
            if IsBound(RP!.NonTrivialMultiWeightedDegreePerRow) then
                return RP!.NonTrivialMultiWeightedDegreePerRow( C, weights );
            fi;
        elif IsBound(RP!.NonTrivialWeightedDegreePerRow) then
            return RP!.NonTrivialWeightedDegreePerRow( C, weights );
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerRow) then
        
        return RP!.NonTrivialDegreePerRow( C );
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( e, row -> First( row, a -> not a = deg0 ) );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( C, col_degrees )
    local R, RP, w, weights, e, deg0;
    
    if Length( col_degrees ) <> NrColumns( C ) then
        Error( "the number of entries in the list of column degrees does not match the number of columns of the matrix\n" );
    fi;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    w := Set( col_degrees );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if Length( w ) = 1 then
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerRow) then
                    return RP!.NonTrivialMultiWeightedDegreePerRow( C, weights ) + w[1];
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerRow) then
                return RP!.NonTrivialWeightedDegreePerRow( C, weights ) + w[1];
            fi;
        else
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerRowWithColPosition) then
                    e := RP!.NonTrivialMultiWeightedDegreePerRowWithColPosition( C, weights );
                    return List( [ 1 .. NrRows( C ) ], i -> e[1][i] + col_degrees[e[2][i]] );
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerRowWithColPosition) then
                e := RP!.NonTrivialWeightedDegreePerRowWithColPosition( C, weights );
                return List( [ 1 .. NrRows( C ) ], i -> e[1][i] + col_degrees[e[2][i]] );
            fi;
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerRow) then
        
        if Length( w ) = 1 then
            return RP!.NonTrivialDegreePerRow( C ) + w[1];
        else
            e := RP!.NonTrivialDegreePerRowWithColPosition( C );
            return List( [ 1 .. NrRows( C ) ], i -> e[1][i] + col_degrees[e[2][i]] );
        fi;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( e, function( r ) local c; c := PositionProperty( r, a -> not a = deg0 ); return r[c] + col_degrees[c]; end );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, weights, e, deg0;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if IsList( weights[1] ) then
            if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumn) then
                return RP!.NonTrivialMultiWeightedDegreePerColumn( C, weights );
            fi;
        elif IsBound(RP!.NonTrivialWeightedDegreePerColumn) then
            return RP!.NonTrivialWeightedDegreePerColumn( C, weights );
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerColumn) then
        
        return RP!.NonTrivialDegreePerColumn( C );
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( TransposedMat( e ), column -> First( column, a -> not a = deg0 ) );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( C, row_degrees )
    local R, RP, w, weights, e, deg0;
    
    if Length( row_degrees ) <> NrRows( C ) then
        Error( "the number of entries in the list of row degrees does not match the number of rows of the matrix\n" );
    fi;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    w := Set( row_degrees );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if Length( w ) = 1 then
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumn) then
                    return RP!.NonTrivialMultiWeightedDegreePerColumn( C, weights ) + w[1];
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerColumn) then
                return RP!.NonTrivialWeightedDegreePerColumn( C, weights ) + w[1];
            fi;
        else
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumnWithRowPosition) then
                    e := RP!.NonTrivialMultiWeightedDegreePerColumnWithRowPosition( C, weights );
                    return List( [ 1 .. NrColumns( C ) ], j -> e[1][j] + row_degrees[e[2][j]] );
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerColumnWithRowPosition) then
                e := RP!.NonTrivialWeightedDegreePerColumnWithRowPosition( C, weights );
                return List( [ 1 .. NrColumns( C ) ], j -> e[1][j] + row_degrees[e[2][j]] );
            fi;
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerColumn) then
        
        if Length( w ) = 1 then
            return RP!.NonTrivialDegreePerColumn( C ) + w[1];
        else
            e := RP!.NonTrivialDegreePerColumnWithRowPosition( C );
            return List( [ 1 .. NrColumns( C ) ], j -> e[1][j] + row_degrees[e[2][j]] );
        fi;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( TransposedMat( e ), function( c ) local r; r := PositionProperty( c, a -> not a = deg0 ); return c[r] + row_degrees[r]; end );
    
end );

####################################
#
# methods for operations (you probably don't urgently need to replace for an external CAS):
#
####################################

##
InstallMethod( SUM,
        "for homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( r1, r2 )
    local R, RP;
    
    R := HomalgRing( r1 );
    
    if R = fail then
        TryNextMethod( );
    elif not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Sum) then
        return RingElementConstructor( R )( RP!.Sum( r1,  r2 ), R ) ;
    elif IsBound(RP!.Minus) then
        return RingElementConstructor( R )( RP!.Minus( r1, RP!.Minus( Zero( R ), r2 ) ), R ) ;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PROD,
        "for homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( r1, r2 )
    local R, RP;
    
    R := HomalgRing( r1 );
    
    if R = fail then
        TryNextMethod( );
    elif not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Product) then
        return RingElementConstructor( R )( RP!.Product( r1,  r2 ), R ) ;
    fi;
    
    TryNextMethod( );
    
end );

