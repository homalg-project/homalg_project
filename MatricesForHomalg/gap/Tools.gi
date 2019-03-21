#############################################################################
##
##  Tools.gi                    MatricesForHomalg package    Mohamed Barakat
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

################################
##
## operations for ring elements:
##
################################

##
InstallMethod( Zero,
        "for homalg rings",
        [ IsHomalgRing ], 10001,
        
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
        [ IsHomalgRing ], 1001,
        
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
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsOne) then
        return RP!.IsOne( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsMinusOne,
        "for ring elements",
        [ IsRingElement ],
        
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
    
    if not HasRingElementConstructor( R ) then
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
    local R, RP, au;
    
    R := HomalgRing( a );
    
    if not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideByUnit) and IsUnit( u ) then
        au := RP!.DivideByUnit( a, u );
        if au = fail then
            return fail;
        fi;
        return RingElementConstructor( R )( au, R );
    fi;
    
    au := RightDivide( HomalgMatrix( [ a ], 1, 1, R ), HomalgMatrix( [ u ], 1, 1, R ) );
    
    if not IsHomalgMatrix( au ) then
        return fail;
    fi;
    
    return MatElm( au, 1, 1 );
    
end );

###########################
##
## operations for matrices:
##
###########################

##  <#GAPDoc Label="IsZeroMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M" Name="IsZeroMatrix" Label="homalgTable entry"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IsZeroMatrix</C> is bound then the standard method
##      for the property <Ref Prop="IsZero" Label="for matrices"/> shown below returns
##      <M>RP</M>!.<C>IsZeroMatrix</C><M>( <A>M</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( IsZero,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsZeroMatrix) then
        ## CAUTION: the external system must be able
        ## to check zero modulo possible ring relations!
        
        return RP!.IsZeroMatrix( M ); ## with this, \= can fall back to IsZero
    fi;
    
    #=====# the fallback method #=====#
    
    ## from the GAP4 documentation: ?Zero
    ## `ZeroSameMutability( <obj> )' is equivalent to `0 * <obj>'.
    
    return M = 0 * M; ## hence, by default, IsZero falls back to \= (see below)
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##----------------------
## the methods for Eval:
##----------------------

##  <#GAPDoc Label="Eval:IsInitialMatrix">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with HomalgInitialMatrix"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix <A>C</A> was created using
##      <Ref Meth="HomalgInitialMatrix" Label="constructor for initial matrices filled with zeros"/>
##      then the filter <C>IsInitialMatrix</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      (&see; <Ref Meth="InitialMatrix" Label="homalgTable entry for initial matrices"/>)
##      will be used to set the attribute <C>Eval</C> and resets the filter <C>IsInitialMatrix</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
        "for homalg matrices (IsInitialMatrix)",
        [ IsHomalgMatrix and IsInitialMatrix and
          HasNrRows and HasNrColumns ],
        
  function( C )
    local R, RP, z, zz;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.InitialMatrix ) then
        ResetFilterObj( C, IsInitialMatrix );
        return RP!.InitialMatrix( C );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called InitialMatrix in the ",
               "homalgTable to evaluate a non-internal initial matrix\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    z := Zero( HomalgRing( C ) );
    
    ResetFilterObj( C, IsInitialMatrix );
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    return homalgInternalMatrixHull(
                   List( [ 1 .. NrRows( C ) ], i -> ShallowCopy( zz ) ) );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="InitialMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="InitialMatrix" Label="homalgTable entry for initial matrices"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>InitialMatrix</C> is bound then the method
##      <Ref Meth="Eval" Label="for matrices created with HomalgInitialMatrix"/>
##      resets the filter <C>IsInitialMatrix</C> and returns <M>RP</M>!.<C>InitialMatrix</C><M>( <A>C</A> )</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:IsInitialIdentityMatrix">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with HomalgInitialIdentityMatrix"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix <A>C</A> was created using
##      <Ref Meth="HomalgInitialIdentityMatrix" Label="constructor for initial quadratic matrices with ones on the diagonal"/>
##      then the filter <C>IsInitialIdentityMatrix</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      (&see; <Ref Meth="InitialIdentityMatrix" Label="homalgTable entry for initial identity matrices"/>)
##      will be used to set the attribute <C>Eval</C> and resets the filter <C>IsInitialIdentityMatrix</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
        "for homalg matrices (IsInitialIdentityMatrix)",
        [ IsHomalgMatrix and IsInitialIdentityMatrix and
          HasNrRows and HasNrColumns ],
        
  function( C )
    local R, RP, o, z, zz, id;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.InitialIdentityMatrix ) then
        ResetFilterObj( C, IsInitialIdentityMatrix );
        return RP!.InitialIdentityMatrix( C );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called InitialIdentityMatrix in the ",
               "homalgTable to evaluate a non-internal initial identity matrix\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    ResetFilterObj( C, IsInitialIdentityMatrix );
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i)
                  local z;
                  z := ShallowCopy( zz ); z[i] := o; return z;
                end );
    
    return homalgInternalMatrixHull( id );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="InitialIdentityMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="InitialIdentityMatrix" Label="homalgTable entry for initial identity matrices"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>InitialIdentityMatrix</C> is bound then the method
##      <Ref Meth="Eval" Label="for matrices created with HomalgInitialIdentityMatrix"/>
##      resets the filter <C>IsInitialIdentityMatrix</C> and returns <M>RP</M>!.<C>InitialIdentityMatrix</C><M>( <A>C</A> )</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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
##    <Meth Arg="C" Name="Eval" Label="for matrices created with Involution"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="Involution" Label="for matrices"/>
##      then the filter <C>HasEvalInvolution</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="Involution" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        Error( "could not find a procedure called Involution ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return homalgInternalMatrixHull( TransposedMat( Eval( M )!.matrix ) );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Involution:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M" Name="Involution" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>Involution</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with Involution"/> returns
##      <M>RP</M>!.<C>Involution</C> applied to the content of the attribute <C>EvalInvolution</C><M>( <A>C</A> ) = <A>M</A></M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalCertainRows">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with CertainRows"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="CertainRows" Label="for matrices"/>
##      then the filter <C>HasEvalCertainRows</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="CertainRows" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        Error( "could not find a procedure called CertainRows ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return homalgInternalMatrixHull( Eval( M )!.matrix{ plist } );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="CertainRows:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, plist" Name="CertainRows" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>CertainRows</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with CertainRows"/> returns
##      <M>RP</M>!.<C>CertainRows</C> applied to the content of the attribute
##      <C>EvalCertainRows</C><M>( <A>C</A> ) = [ <A>M</A>, <A>plist</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalCertainColumns">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with CertainColumns"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="CertainColumns" Label="for matrices"/>
##      then the filter <C>HasEvalCertainColumns</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="CertainColumns" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        Error( "could not find a procedure called CertainColumns ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return homalgInternalMatrixHull(
                   Eval( M )!.matrix{[ 1 .. NrRows( M ) ]}{plist} );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="CertainColumns:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, plist" Name="CertainColumns" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>CertainColumns</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with CertainColumns"/> returns
##      <M>RP</M>!.<C>CertainColumns</C> applied to the content of the attribute
##      <C>EvalCertainColumns</C><M>( <A>C</A> ) = [ <A>M</A>, <A>plist</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalUnionOfRows">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with UnionOfRows"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="UnionOfRows" Label="for matrices"/>
##      then the filter <C>HasEvalUnionOfRows</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="UnionOfRows" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        Error( "could not find a procedure called UnionOfRows ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    U := ShallowCopy( Eval( A )!.matrix );
    
    U{ [ NrRows( A ) + 1 .. NrRows( A ) + NrRows( B ) ] } := Eval( B )!.matrix;
    
    return homalgInternalMatrixHull( U );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="UnionOfRows:homalgTable_entry">
##  <ManSection>
##    <Func Arg="A, B" Name="UnionOfRows" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>UnionOfRows</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with UnionOfRows"/> returns
##      <M>RP</M>!.<C>UnionOfRows</C> applied to the content of the attribute
##      <C>EvalUnionOfRows</C><M>( <A>C</A> ) = [ <A>A</A>, <A>B</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalUnionOfColumns">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with UnionOfColumns"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="UnionOfColumns" Label="for matrices"/>
##      then the filter <C>HasEvalUnionOfColumns</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="UnionOfColumns" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        Error( "could not find a procedure called UnionOfColumns ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    U := List( Eval( A )!.matrix, ShallowCopy );
    
    U{ [ 1 .. NrRows( A ) ] }
      { [ NrColumns( A ) + 1 .. NrColumns( A ) + NrColumns( B ) ] }
      := Eval( B )!.matrix;
    
    return homalgInternalMatrixHull( U );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="UnionOfColumns:homalgTable_entry">
##  <ManSection>
##    <Func Arg="A, B" Name="UnionOfColumns" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>UnionOfColumns</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with UnionOfColumns"/> returns
##      <M>RP</M>!.<C>UnionOfColumns</C> applied to the content of the attribute
##      <C>EvalUnionOfColumns</C><M>( <A>C</A> ) = [ <A>A</A>, <A>B</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalDiagMat">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with DiagMat"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="DiagMat" Label="for matrices"/>
##      then the filter <C>HasEvalDiagMat</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="DiagMat" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        Error( "could not find a procedure called DiagMat ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    z := Zero( R );
    
    m := Sum( List( e, NrRows ) );
    n := Sum( List( e, NrColumns ) );
    
    diag := List( [ 1 .. m ], a -> List( [ 1 .. n ], b -> z ) );
    
    m := 0;
    n := 0;
    
    for mat in e do
        diag{ [ m + 1 .. m + NrRows( mat ) ] }{ [ n + 1 .. n + NrColumns( mat ) ] }
          := Eval( mat )!.matrix;
        
        m := m + NrRows( mat );
        n := n + NrColumns( mat );
    od;
    
    return homalgInternalMatrixHull( diag );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DiagMat:homalgTable_entry">
##  <ManSection>
##    <Func Arg="e" Name="DiagMat" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>DiagMat</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with DiagMat"/> returns
##      <M>RP</M>!.<C>DiagMat</C> applied to the content of the attribute
##      <C>EvalDiagMat</C><M>( <A>C</A> ) = <A>e</A></M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalKroneckerMat">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with KroneckerMat"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="KroneckerMat" Label="for matrices"/>
##      then the filter <C>HasEvalKroneckerMat</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="KroneckerMat" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
        "for homalg matrices (HasEvalKroneckerMat)",
        [ IsHomalgMatrix and HasEvalKroneckerMat ],
        
  function( C )
    local R, RP, A, B;
    
    R := HomalgRing( C );
    
    if ( HasIsCommutative( R ) and not IsCommutative( R ) ) and
       ( HasIsSuperCommutative( R ) and not IsSuperCommutative( R ) ) then
        Info( InfoWarning, 1, "\033[01m\033[5;31;47m",
              "the Kronecker product is only defined for (super) commutative rings!",
              "\033[0m" );
    fi;
    
    RP := homalgTable( R );
    
    A :=  EvalKroneckerMat( C )[1];
    B :=  EvalKroneckerMat( C )[2];
    
    if IsBound(RP!.KroneckerMat) then
        return RP!.KroneckerMat( A, B );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called KroneckerMat ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return homalgInternalMatrixHull(
                   KroneckerProduct( Eval( A )!.matrix, Eval( B )!.matrix ) );
    ## this was easy, thanks GAP :)
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="KroneckerMat:homalgTable_entry">
##  <ManSection>
##    <Func Arg="A, B" Name="KroneckerMat" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>KroneckerMat</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with KroneckerMat"/> returns
##      <M>RP</M>!.<C>KroneckerMat</C> applied to the content of the attribute
##      <C>EvalKroneckerMat</C><M>( <A>C</A> ) = [ <A>A</A>, <A>B</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalMulMat">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with MulMat"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="\*" Label="for ring elements and matrices"/>
##      then the filter <C>HasEvalMulMat</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="MulMat" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        return RP!.MulMat( a, A );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called MulMat ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return a * Eval( A );
    
end );

InstallMethod( Eval,
        "for homalg matrices (HasEvalMulMatRight)",
        [ IsHomalgMatrix and HasEvalMulMatRight ],
        
  function( C )
    local R, RP, e, A, a;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    e :=  EvalMulMatRight( C );
    
    A := e[1];
    a := e[2];
    
    if IsBound(RP!.MulMatRight) then
        return RP!.MulMatRight( A, a );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called MulMatRight ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Eval( A ) * a;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="MulMat:homalgTable_entry">
##  <ManSection>
##    <Func Arg="a, A" Name="MulMat" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>MulMat</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with MulMat"/> returns
##      <M>RP</M>!.<C>MulMat</C> applied to the content of the attribute
##      <C>EvalMulMat</C><M>( <A>C</A> ) = [ <A>a</A>, <A>A</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalAddMat">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with AddMat"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="\+" Label="for matrices"/>
##      then the filter <C>HasEvalAddMat</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="AddMat" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        return RP!.AddMat( A, B );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called AddMat ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Eval( A ) + Eval( B );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="AddMat:homalgTable_entry">
##  <ManSection>
##    <Func Arg="A, B" Name="AddMat" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>AddMat</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with AddMat"/> returns
##      <M>RP</M>!.<C>AddMat</C> applied to the content of the attribute
##      <C>EvalAddMat</C><M>( <A>C</A> ) = [ <A>A</A>, <A>B</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalSubMat">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with SubMat"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="\-" Label="for matrices"/>
##      then the filter <C>HasEvalSubMat</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="SubMat" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        return RP!.SubMat( A, B );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called SubMat ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Eval( A ) - Eval( B );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="SubMat:homalgTable_entry">
##  <ManSection>
##    <Func Arg="A, B" Name="SubMat" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>SubMat</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with SubMat"/> returns
##      <M>RP</M>!.<C>SubMat</C> applied to the content of the attribute
##      <C>EvalSubMat</C><M>( <A>C</A> ) = [ <A>A</A>, <A>B</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:HasEvalCompose">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with Compose"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix was created using
##      <Ref Meth="\*" Label="for composable matrices"/>
##      then the filter <C>HasEvalCompose</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      <Ref Meth="Compose" Label="homalgTable entry"/>
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
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
        return RP!.Compose( A, B );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called Compose ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Eval( A ) * Eval( B );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Compose:homalgTable_entry">
##  <ManSection>
##    <Func Arg="A, B" Name="Compose" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>Compose</C> is bound then
##      the method <Ref Meth="Eval" Label="for matrices created with Compose"/> returns
##      <M>RP</M>!.<C>Compose</C> applied to the content of the attribute
##      <C>EvalCompose</C><M>( <A>C</A> ) = [ <A>A</A>, <A>B</A> ]</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:IsIdentityMatrix">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with HomalgIdentityMatrix"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix <A>C</A> was created using
##      <Ref Meth="HomalgIdentityMatrix" Label="constructor for identity matrices"/>
##      then the filter <C>IsOne</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      (&see; <Ref Meth="IdentityMatrix" Label="homalgTable entry"/>)
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
        "for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne and HasNrRows and HasNrColumns ], 10,
        
  function( C )
    local R, id, RP, o, z, zz;
    
    R := HomalgRing( C );
    
    if IsBound( R!.IdentityMatrices ) then
        id := ElmWPObj( R!.IdentityMatrices!.weak_pointers, NrColumns( C ) );
        if id <> fail then
            R!.IdentityMatrices!.cache_hits := R!.IdentityMatrices!.cache_hits + 1;
            return id;
        fi;
        ## we do not count cache_misses as it is equivalent to counter
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.IdentityMatrix ) then
        id := RP!.IdentityMatrix( C );
        SetElmWPObj( R!.IdentityMatrices!.weak_pointers, NrColumns( C ), id );
        R!.IdentityMatrices!.counter := R!.IdentityMatrices!.counter + 1;
        return id;
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called IdentityMatrix ",
               "homalgTable to evaluate a non-internal identity matrix\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    z := Zero( HomalgRing( C ) );
    o := One( HomalgRing( C ) );
    
    zz := ListWithIdenticalEntries( NrColumns( C ), z );
    
    id := List( [ 1 .. NrRows( C ) ],
                function(i)
                  local z;
                  z := ShallowCopy( zz ); z[i] := o; return z;
                end );
    
    id := homalgInternalMatrixHull( id );
    
    SetElmWPObj( R!.IdentityMatrices!.weak_pointers, NrColumns( C ), id );
    
    return id;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IdentityMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="IdentityMatrix" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IdentityMatrix</C> is bound then the method
##      <Ref Meth="Eval" Label="for matrices created with HomalgIdentityMatrix"/> returns
##      <M>RP</M>!.<C>IdentityMatrix</C><M>( <A>C</A> )</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Eval:IsZeroMatrix">
##  <ManSection>
##    <Meth Arg="C" Name="Eval" Label="for matrices created with HomalgZeroMatrix"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      In case the matrix <A>C</A> was created using
##      <Ref Meth="HomalgZeroMatrix" Label="constructor for zero matrices"/>
##      then the filter <C>IsZeroMatrix</C> for <A>C</A> is set to true and the <C>homalgTable</C> function
##      (&see; <Ref Meth="ZeroMatrix" Label="homalgTable entry"/>)
##      will be used to set the attribute <C>Eval</C>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( Eval,
        "for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero and HasNrRows and HasNrColumns ], 20,
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if ( NrRows( C ) = 0 or NrColumns( C ) = 0 ) and
       not ( IsBound( R!.SafeToEvaluateEmptyMatrices ) and
             R!.SafeToEvaluateEmptyMatrices = true ) then
        Info( InfoWarning, 1, "\033[01m\033[5;31;47m",
              "an empty matrix is about to get evaluated!",
              "\033[0m" );
    fi;
    
    if IsBound( RP!.ZeroMatrix ) then
        return RP!.ZeroMatrix( C );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called ZeroMatrix ",
               "homalgTable to evaluate a non-internal zero matrix\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    z := Zero( HomalgRing( C ) );
    
    ## copying the rows saves memory;
    ## we assume that the entries are never modified!!!
    return homalgInternalMatrixHull(
                   ListWithIdenticalEntries( NrRows( C ),
                           ListWithIdenticalEntries( NrColumns( C ), z ) ) );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ZeroMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="ZeroMatrix" Label="homalgTable entry"/>
##    <Returns>the <C>Eval</C> value of a &homalg; matrix <A>C</A></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroMatrix</C> is bound then the method
##      <Ref Meth="Eval" Label="for matrices created with HomalgZeroMatrix"/> returns
##      <M>RP</M>!.<C>ZeroMatrix</C><M>( <A>C</A> )</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="NrRows:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="NrRows" Label="homalgTable entry"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>NrRows</C> is bound then the standard method
##      for the attribute <Ref Attr="NrRows"/> shown below returns
##      <M>RP</M>!.<C>NrRows</C><M>( <A>C</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( NrRows,
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
        Error( "could not find a procedure called NrRows ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Length( Eval( C )!.matrix );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="NrColumns:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="NrColumns" Label="homalgTable entry"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>NrColumns</C> is bound then the standard method
##      for the attribute <Ref Attr="NrColumns"/> shown below returns
##      <M>RP</M>!.<C>NrColumns</C><M>( <A>C</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( NrColumns,
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
        Error( "could not find a procedure called NrColumns ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Length( Eval( C )!.matrix[ 1 ] );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="Determinant:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="Determinant" Label="homalgTable entry"/>
##    <Returns>a ring element</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>Determinant</C> is bound then the standard method
##      for the attribute <Ref Attr="DeterminantMat"/> shown below returns
##      <M>RP</M>!.<C>Determinant</C><M>( <A>C</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( DeterminantMat,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if NrRows( C ) <> NrColumns( C ) then
        Error( "the matrix is not a square matrix\n" );
    fi;
    
    if IsEmptyMatrix( C ) then
        return One( R );
    elif IsZero( C ) then
        return Zero( R );
    fi;
    
    if IsBound(RP!.Determinant) then
        return RingElementConstructor( R )( RP!.Determinant( C ), R );
    fi;
    
    if not IsHomalgInternalMatrixRep( C ) then
        Error( "could not find a procedure called Determinant ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    #=====# can only work for homalg internal matrices #=====#
    
    return Determinant( Eval( C )!.matrix );
    
end );

##
InstallMethod( Determinant,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    
    return DeterminantMat( C );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# methods for operations (you probably want to replace for an external CAS):
#
####################################

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRing, IsRingElement ], 100,
        
  function( R, r )
    local RP;
    
    if HasIsZero( r ) and IsZero( r ) then
        return false;
    elif HasIsOne( r ) and IsOne( r ) then
        return true;
    fi;
    
    return not IsBool( LeftInverse( HomalgMatrix( [ r ], 1, 1, R ) ) );
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRing, IsHomalgRingElement ], 100,
        
  function( R, r )
    local RP;
    
    if HasIsZero( r ) and IsZero( r ) then
        return false;
    elif HasIsOne( r ) and IsOne( r ) then
        return true;
    elif HasIsMinusOne( r ) and IsMinusOne( r ) then
        return true;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsUnit) then
        return RP!.IsUnit( R, r );
    fi;
    
    #=====# the fallback method #=====#
    
    return not IsBool( LeftInverse( HomalgMatrix( [ r ], 1, 1, R ) ) );
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgInternalRingRep, IsRingElement ], 100,
        
  function( R, r )
    
    return IsUnit( R!.ring, r );
    
end );

##
InstallMethod( IsUnit,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    if HasIsZero( r ) and IsZero( r ) then
        return false;
    elif HasIsOne( r ) and IsOne( r ) then
        return true;
    elif HasIsMinusOne( r ) and IsMinusOne( r ) then
        return true;
    fi;
    
    if not IsBound( r!.IsUnit ) then
        r!.IsUnit := IsUnit( HomalgRing( r ), r );
    fi;
    
    return r!.IsUnit;
    
end );

##  <#GAPDoc Label="ZeroRows:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="ZeroRows" Label="homalgTable entry"/>
##    <Returns>a (possibly empty) list of positive integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroRows</C> is bound then the standard method
##      of the attribute <Ref Attr="ZeroRows"/> shown below returns
##      <M>RP</M>!.<C>ZeroRows</C><M>( <A>C</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( ZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ZeroRows) then
        return RP!.ZeroRows( C );
    fi;
    
    #=====# the fallback method #=====#
    
    z := HomalgZeroMatrix( 1, NrColumns( C ), R );
    
    return Filtered( [ 1 .. NrRows( C ) ], a -> CertainRows( C, [ a ] ) = z );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ZeroColumns:homalgTable_entry">
##  <ManSection>
##    <Func Arg="C" Name="ZeroColumns" Label="homalgTable entry"/>
##    <Returns>a (possibly empty) list of positive integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>C</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>ZeroColumns</C> is bound then the standard method
##      of the attribute <Ref Attr="ZeroColumns"/> shown below returns
##      <M>RP</M>!.<C>ZeroColumns</C><M>( <A>C</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( ZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, z;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ZeroColumns) then
        return RP!.ZeroColumns( C );
    fi;
    
    #=====# the fallback method #=====#
    
    z := HomalgZeroMatrix( NrRows( C ), 1, R );
    
    return Filtered( [ 1 .. NrColumns( C ) ], a -> CertainColumns( C, [ a ] ) = z );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( GetRidOfObsoleteRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetRidOfObsoleteRows) then
        M := HomalgMatrix( RP!.GetRidOfObsoleteRows( C ), R );
        if HasNrColumns( C ) then
            SetNrColumns( M, NrColumns( C ) );
        fi;
        SetZeroRows( M, [ ] );
        return M;
    fi;
    
    #=====# the fallback method #=====#
    
    ## get rid of zero rows
    ## (e.g. those rows containing the ring relations)
    
    M := CertainRows( C, NonZeroRows( C ) );
    
    SetZeroRows( M, [ ] );
    
    ## forgetting C may save memory
    if HasEvalCertainRows( M ) then
        if not IsEmptyMatrix( M ) then
            Eval( M );
        fi;
        ResetFilterObj( M, EvalCertainRows );
        Unbind( M!.EvalCertainRows );
    fi;
    
    return M;
    
end );

##
InstallMethod( GetRidOfObsoleteColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, M;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetRidOfObsoleteColumns) then
        M := HomalgMatrix( RP!.GetRidOfObsoleteColumns( C ), R );
        if HasNrRows( C ) then
            SetNrRows( M, NrRows( C ) );
        fi;
        SetZeroColumns( M, [ ] );
        return M;
    fi;
    
    #=====# the fallback method #=====#
    
    ## get rid of zero columns
    ## (e.g. those columns containing the ring relations)
    
    M := CertainColumns( C, NonZeroColumns( C ) );
    
    SetZeroColumns( M, [ ] );
    
    ## forgetting C may save memory
    if HasEvalCertainColumns( M ) then
        if not IsEmptyMatrix( M ) then
            Eval( M );
        fi;
        ResetFilterObj( M, EvalCertainColumns );
        Unbind( M!.EvalCertainColumns );
    fi;
    
    return M;
    
end );

##  <#GAPDoc Label="AreEqualMatrices:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M1,M2" Name="AreEqualMatrices" Label="homalgTable entry"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M1</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>AreEqualMatrices</C> is bound then the standard method
##      for the operation <Ref Oper="\=" Label="for matrices"/> shown below returns
##      <M>RP</M>!.<C>AreEqualMatrices</C><M>( <A>M1</A>, <A>M2</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, are_equal;
    
    ## do not touch mutable matrices
    if not ( IsMutable( M1 ) or IsMutable( M2 ) ) then
        
        if IsBound( M1!.AreEqual ) then
            are_equal := _ElmWPObj_ForHomalg( M1!.AreEqual, M2, fail );
            if are_equal <> fail then
                return are_equal;
            fi;
        else
            M1!.AreEqual :=
              ContainerForWeakPointers(
                      TheTypeContainerForWeakPointersOnComputedValues,
                      [ "operation", "AreEqual" ] );
        fi;
        
        if IsBound( M2!.AreEqual ) then
            are_equal := _ElmWPObj_ForHomalg( M2!.AreEqual, M1, fail );
            if are_equal <> fail then
                return are_equal;
            fi;
        fi;
        ## do not store things symmetrically below to ``save'' memory
        
    fi;
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.AreEqualMatrices) then
        ## CAUTION: the external system must be able to check equality
        ## modulo possible ring relations (known to the external system)!
        are_equal := RP!.AreEqualMatrices( M1, M2 );
    elif IsBound(RP!.Equal) then
        ## CAUTION: the external system must be able to check equality
        ## modulo possible ring relations (known to the external system)!
        are_equal := RP!.Equal( M1, M2 );
    elif IsBound(RP!.IsZeroMatrix) then   ## ensuring this avoids infinite loops
        are_equal := IsZero( M1 - M2 );
    fi;
    
    if IsBound( are_equal ) then
        
        ## do not touch mutable matrices
        if not ( IsMutable( M1 ) or IsMutable( M2 ) ) then
            
            if are_equal then
                MatchPropertiesAndAttributes( M1, M2,
                        LIMAT.intrinsic_properties,
                        LIMAT.intrinsic_attributes,
                        LIMAT.intrinsic_components
                        );
            fi;
            
            ## do not store things symmetrically to ``save'' memory
            _AddTwoElmWPObj_ForHomalg( M1!.AreEqual, M2, are_equal );
            
        fi;
        
        return are_equal;
    fi;
    
    TryNextMethod( );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsIdentityMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M" Name="IsIdentityMatrix" Label="homalgTable entry"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IsIdentityMatrix</C> is bound then the standard method
##      for the property <Ref Prop="IsOne"/> shown below returns
##      <M>RP</M>!.<C>IsIdentityMatrix</C><M>( <A>M</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( IsOne,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    if NrRows( M ) <> NrColumns( M ) then
        return false;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsIdentityMatrix) then
        return RP!.IsIdentityMatrix( M );
    fi;
    
    #=====# the fallback method #=====#
    
    return M = HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsDiagonalMatrix:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M" Name="IsDiagonalMatrix" Label="homalgTable entry"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>IsDiagonalMatrix</C> is bound then the standard method
##      for the property <Ref Meth="IsDiagonalMatrix"/> shown below returns
##      <M>RP</M>!.<C>IsDiagonalMatrix</C><M>( <A>M</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( IsDiagonalMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, diag;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsDiagonalMatrix) then
        return RP!.IsDiagonalMatrix( M );
    fi;
    
    #=====# the fallback method #=====#
    
    diag := DiagonalEntries( M );
    
    return M = HomalgDiagonalMatrix( diag, NrRows( M ), NrColumns( M ), R );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="GetColumnIndependentUnitPositions">
##  <ManSection>
##    <Oper Arg="A, poslist" Name="GetColumnIndependentUnitPositions" Label="for matrices"/>
##    <Returns>a (possibly empty) list of pairs of positive integers</Returns>
##    <Description>
##      The list of column independet unit position of the matrix <A>A</A>.
##      We say that a unit <A>A</A><M>[i,k]</M> is column independet from the unit <A>A</A><M>[l,j]</M>
##      if <M>i>l</M> and <A>A</A><M>[l,k]=0</M>.
##      The rows are scanned from top to bottom and within each row the columns are
##      scanned from right to left searching for new units, column independent from the preceding ones.
##      If <A>A</A><M>[i,k]</M> is a new column independent unit then <M>[i,k]</M> is added to the
##      output list. If <A>A</A> has no units the empty list is returned.<P/>
##      (for the installed standard method see <Ref Meth="GetColumnIndependentUnitPositions" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="GetColumnIndependentUnitPositions:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, poslist" Name="GetColumnIndependentUnitPositions" Label="homalgTable entry"/>
##    <Returns>a (possibly empty) list of pairs of positive integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>GetColumnIndependentUnitPositions</C> is bound then the standard method
##      of the operation <Ref Meth="GetColumnIndependentUnitPositions" Label="for matrices"/> shown below returns
##      <M>RP</M>!.<C>GetColumnIndependentUnitPositions</C><M>( <A>M</A>, <A>poslist</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( GetColumnIndependentUnitPositions,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, poslist )
    local cache, R, RP, rest, pos, i, j, k;
    
    if IsBound( M!.GetColumnIndependentUnitPositions ) then
        cache := M!.GetColumnIndependentUnitPositions;
        if IsBound( cache.(String( poslist )) ) then
            return cache.(String( poslist ));
        fi;
    else
        cache := rec( );
        M!.GetColumnIndependentUnitPositions := cache;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetColumnIndependentUnitPositions) then
        pos := RP!.GetColumnIndependentUnitPositions( M, poslist );
        if pos <> [ ] then
            SetIsZero( M, false );
        fi;
        cache.(String( poslist )) := pos;
        return pos;
    fi;
    
    #=====# the fallback method #=====#
    
    rest := [ 1 .. NrColumns( M ) ];
    
    pos := [ ];
    
    for i in [ 1 .. NrRows( M ) ] do
        for k in Reversed( rest ) do
            if not [ i, k ] in poslist and
               IsUnit( R, MatElm( M, i, k ) ) then
                Add( pos, [ i, k ] );
                rest := Filtered( rest,
                                a -> IsZero( MatElm( M, i, a ) ) );
                break;
            fi;
        od;
    od;
    
    if pos <> [ ] then
        SetIsZero( M, false );
    fi;
    
    cache.(String( poslist )) := pos;
    
    return pos;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="GetRowIndependentUnitPositions">
##  <ManSection>
##    <Oper Arg="A, poslist" Name="GetRowIndependentUnitPositions" Label="for matrices"/>
##    <Returns>a (possibly empty) list of pairs of positive integers</Returns>
##    <Description>
##      The list of row independet unit position of the matrix <A>A</A>.
##      We say that a unit <A>A</A><M>[k,j]</M> is row independet from the unit <A>A</A><M>[i,l]</M>
##      if <M>j>l</M> and <A>A</A><M>[k,l]=0</M>.
##      The columns are scanned from left to right and within each column the rows are
##      scanned from bottom to top searching for new units, row independent from the preceding ones.
##      If <A>A</A><M>[k,j]</M> is a new row independent unit then <M>[j,k]</M> (yes <M>[j,k]</M>) is added to the
##      output list. If <A>A</A> has no units the empty list is returned.<P/>
##      (for the installed standard method see <Ref Meth="GetRowIndependentUnitPositions" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="GetRowIndependentUnitPositions:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, poslist" Name="GetRowIndependentUnitPositions" Label="homalgTable entry"/>
##    <Returns>a (possibly empty) list of pairs of positive integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>GetRowIndependentUnitPositions</C> is bound then the standard method
##      of the operation <Ref Meth="GetRowIndependentUnitPositions" Label="for matrices"/> shown below returns
##      <M>RP</M>!.<C>GetRowIndependentUnitPositions</C><M>( <A>M</A>, <A>poslist</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( GetRowIndependentUnitPositions,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, poslist )
    local cache, R, RP, rest, pos, j, i, k;
    
    if IsBound( M!.GetRowIndependentUnitPositions ) then
        cache := M!.GetRowIndependentUnitPositions;
        if IsBound( cache.(String( poslist )) ) then
            return cache.(String( poslist ));
        fi;
    else
        cache := rec( );
        M!.GetRowIndependentUnitPositions := cache;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetRowIndependentUnitPositions) then
        pos := RP!.GetRowIndependentUnitPositions( M, poslist );
        if pos <> [ ] then
            SetIsZero( M, false );
        fi;
        cache.( String( poslist ) ) := pos;
        return pos;
    fi;
    
    #=====# the fallback method #=====#
    
    rest := [ 1 .. NrRows( M ) ];
    
    pos := [ ];
    
    for j in [ 1 .. NrColumns( M ) ] do
        for k in Reversed( rest ) do
            if not [ j, k ] in poslist and
               IsUnit( R, MatElm( M, k, j ) ) then
                Add( pos, [ j, k ] );
                rest := Filtered( rest,
                                a -> IsZero( MatElm( M, a, j ) ) );
                break;
            fi;
        od;
    od;
    
    if pos <> [ ] then
        SetIsZero( M, false );
    fi;
    
    cache.( String( poslist ) ) := pos;
    
    return pos;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="GetUnitPosition">
##  <ManSection>
##    <Oper Arg="A, poslist" Name="GetUnitPosition" Label="for matrices"/>
##    <Returns>a (possibly empty) list of pairs of positive integers</Returns>
##    <Description>
##      The position <M>[i,j]</M> of the first unit <A>A</A><M>[i,j]</M> in the matrix <A>A</A>, where
##      the rows are scanned from top to bottom and within each row the columns are
##      scanned from left to right. If <A>A</A><M>[i,j]</M> is the first occurrence of a unit
##      then the position pair <M>[i,j]</M> is returned. Otherwise <C>fail</C> is returned.<P/>
##      (for the installed standard method see <Ref Meth="GetUnitPosition" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="GetUnitPosition:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, poslist" Name="GetUnitPosition" Label="homalgTable entry"/>
##    <Returns>a (possibly empty) list of pairs of positive integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>GetUnitPosition</C> is bound then the standard method
##      of the operation <Ref Meth="GetUnitPosition" Label="for matrices"/> shown below returns
##      <M>RP</M>!.<C>GetUnitPosition</C><M>( <A>M</A>, <A>poslist</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( GetUnitPosition,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomogeneousList ],
        
  function( M, poslist )
    local R, RP, pos, m, n, i, j;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.GetUnitPosition) then
        pos := RP!.GetUnitPosition( M, poslist );
        if IsList( pos ) and IsPosInt( pos[1] ) and IsPosInt( pos[2] ) then
            SetIsZero( M, false );
        fi;
        return pos;
    fi;
    
    #=====# the fallback method #=====#
    
    m := NrRows( M );
    n := NrColumns( M );
    
    for i in [ 1 .. m ] do
        for j in [ 1 .. n ] do
            if not [ i, j ] in poslist and not j in poslist and
               IsUnit( R, MatElm( M, i, j ) ) then
                SetIsZero( M, false );
                return [ i, j ];
            fi;
        od;
    od;
    
    return fail;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="PositionOfFirstNonZeroEntryPerRow:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, poslist" Name="PositionOfFirstNonZeroEntryPerRow" Label="homalgTable entry"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>PositionOfFirstNonZeroEntryPerRow</C> is bound then the standard method
##      of the attribute <Ref Attr="PositionOfFirstNonZeroEntryPerRow"/> shown below returns
##      <M>RP</M>!.<C>PositionOfFirstNonZeroEntryPerRow</C><M>( <A>M</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( PositionOfFirstNonZeroEntryPerRow,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, pos, entries, r, c, i, k, j;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.PositionOfFirstNonZeroEntryPerRow) then
        return RP!.PositionOfFirstNonZeroEntryPerRow( M );
    elif IsBound(RP!.PositionOfFirstNonZeroEntryPerColumn) then
        return PositionOfFirstNonZeroEntryPerColumn( Involution( M ) );
    fi;
    
    #=====# the fallback method #=====#
    
    entries := EntriesOfHomalgMatrix( M );
    
    r := NrRows( M );
    c := NrColumns( M );
    
    pos := ListWithIdenticalEntries( r, 0 );
    
    for i in [ 1 .. r ] do
        k := (i - 1) * c;
        for j in [ 1 .. c ] do
            if not IsZero( entries[k + j] ) then
                pos[i] := j;
                break;
            fi;
        od;
    od;
    
    return pos;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="PositionOfFirstNonZeroEntryPerColumn:homalgTable_entry">
##  <ManSection>
##    <Func Arg="M, poslist" Name="PositionOfFirstNonZeroEntryPerColumn" Label="homalgTable entry"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      Let <M>R :=</M> <C>HomalgRing</C><M>( <A>M</A> )</M> and <M>RP :=</M> <C>homalgTable</C><M>( R )</M>.
##      If the <C>homalgTable</C> component <M>RP</M>!.<C>PositionOfFirstNonZeroEntryPerColumn</C> is bound then the standard method
##      of the attribute <Ref Attr="PositionOfFirstNonZeroEntryPerColumn"/> shown below returns
##      <M>RP</M>!.<C>PositionOfFirstNonZeroEntryPerColumn</C><M>( <A>M</A> )</M>.
##    <Listing Type="Code"><![CDATA[
InstallMethod( PositionOfFirstNonZeroEntryPerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, pos, entries, r, c, j, i, k;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.PositionOfFirstNonZeroEntryPerColumn) then
        return RP!.PositionOfFirstNonZeroEntryPerColumn( M );
    elif IsBound(RP!.PositionOfFirstNonZeroEntryPerRow) then
        return PositionOfFirstNonZeroEntryPerRow( Involution( M ) );
    fi;
    
    #=====# the fallback method #=====#
    
    entries := EntriesOfHomalgMatrix( M );
    
    r := NrRows( M );
    c := NrColumns( M );
    
    pos := ListWithIdenticalEntries( c, 0 );
    
    for j in [ 1 .. c ] do
        for i in [ 1 .. r ] do
            k := (i - 1) * c;
            if not IsZero( entries[k + j] ) then
                pos[j] := i;
                break;
            fi;
        od;
    od;
    
    return pos;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( DivideEntryByUnit,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt, IsRingElement ],
        
  function( M, i, j, u )
    local R, RP;
    
    if IsEmptyMatrix( M ) then
        return;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideEntryByUnit) then
        RP!.DivideEntryByUnit( M, i, j, u );
    else
        SetMatElm( M, i, j, MatElm( M, i, j ) / u );
    fi;
    
    ## caution: we deliberately do not return a new hull for Eval( M )
    
end );
    
##
InstallMethod( DivideRowByUnit,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsRingElement, IsInt ],
        
  function( M, i, u, j )
    local R, RP, a, mat;
    
    if IsEmptyMatrix( M ) then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideRowByUnit) then
        RP!.DivideRowByUnit( M, i, u, j );
    else
        
        #=====# the fallback method #=====#
        
        if j > 0 then
            ## the two for's avoid creating non-dense lists:
            for a in [ 1 .. j - 1 ] do
                DivideEntryByUnit( M, i, a, u );
            od;
            for a in [ j + 1 .. NrColumns( M ) ] do
                DivideEntryByUnit( M, i, a, u );
            od;
            SetMatElm( M, i, j, One( R ) );
        else
            for a in [ 1 .. NrColumns( M ) ] do
                DivideEntryByUnit( M, i, a, u );
            od;
        fi;
        
    fi;
    
    ## since all what we did had a side effect on Eval( M ) ignoring
    ## possible other Eval's, e.g. EvalCompose, we want to return
    ## a new homalg matrix object only containing Eval( M )
    mat := HomalgMatrixWithAttributes( [
                   Eval, Eval( M ),
                   NrRows, NrRows( M ),
                   NrColumns, NrColumns( M ),
                   ], R );
    
    if HasIsZero( M ) and not IsZero( M ) then
        SetIsZero( mat, false );
    fi;
    
    return mat;
    
end );

##
InstallMethod( DivideColumnByUnit,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsRingElement, IsInt ],
        
  function( M, j, u, i )
    local R, RP, a, mat;
    
    if IsEmptyMatrix( M ) then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideColumnByUnit) then
        RP!.DivideColumnByUnit( M, j, u, i );
    else
        
        #=====# the fallback method #=====#
        
        if i > 0 then
            ## the two for's avoid creating non-dense lists:
            for a in [ 1 .. i - 1 ] do
                DivideEntryByUnit( M, a, j, u );
            od;
            for a in [ i + 1 .. NrRows( M ) ] do
                DivideEntryByUnit( M, a, j, u );
            od;
            SetMatElm( M, i, j, One( R ) );
        else
            for a in [ 1 .. NrRows( M ) ] do
                DivideEntryByUnit( M, a, j, u );
            od;
        fi;
        
    fi;
    
    ## since all what we did had a side effect on Eval( M ) ignoring
    ## possible other Eval's, e.g. EvalCompose, we want to return
    ## a new homalg matrix object only containing Eval( M )
    mat := HomalgMatrixWithAttributes( [
                   Eval, Eval( M ),
                   NrRows, NrRows( M ),
                   NrColumns, NrColumns( M ),
                   ], R );
    
    if HasIsZero( M ) and not IsZero( M ) then
        SetIsZero( mat, false );
    fi;
    
    return mat;
    
end );

##
InstallMethod( CopyRowToIdentityMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsList, IsPosInt ],
        
  function( M, i, L, j )
    local R, RP, v, vi, l, r;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CopyRowToIdentityMatrix) then
        RP!.CopyRowToIdentityMatrix( M, i, L, j );
    else
        
        #=====# the fallback method #=====#
        
        if Length( L ) > 0 and IsHomalgMatrix( L[1] ) then
            v := L[1];
        fi;
        
        if Length( L ) > 1 and IsHomalgMatrix( L[2] ) then
            vi := L[2];
        fi;
        
        if IsBound( v ) and IsBound( vi ) then
            ## the two for's avoid creating non-dense lists:
            for l in [ 1 .. j - 1 ] do
                r := MatElm( M, i, l );
                if not IsZero( r ) then
                    SetMatElm( v, j, l, -r );
                    SetMatElm( vi, j, l, r );
                fi;
            od;
            for l in [ j + 1 .. NrColumns( M ) ] do
                r := MatElm( M, i, l );
                if not IsZero( r ) then
                    SetMatElm( v, j, l, -r );
                    SetMatElm( vi, j, l, r );
                fi;
            od;
        elif IsBound( v ) then
            ## the two for's avoid creating non-dense lists:
            for l in [ 1 .. j - 1 ] do
                r := MatElm( M, i, l );
                SetMatElm( v, j, l, -r );
            od;
            for l in [ j + 1 .. NrColumns( M ) ] do
                r := MatElm( M, i, l );
                SetMatElm( v, j, l, -r );
            od;
        elif IsBound( vi ) then
            ## the two for's avoid creating non-dense lists:
            for l in [ 1 .. j - 1 ] do
                r := MatElm( M, i, l );
                SetMatElm( vi, j, l, r );
            od;
            for l in [ j + 1 .. NrColumns( M ) ] do
                r := MatElm( M, i, l );
                SetMatElm( vi, j, l, r );
            od;
        fi;
        
    fi;
    
end );

##
InstallMethod( CopyColumnToIdentityMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsList, IsPosInt ],
        
  function( M, j, L, i )
    local R, RP, u, ui, m, k, r;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CopyColumnToIdentityMatrix) then
        RP!.CopyColumnToIdentityMatrix( M, j, L, i );
    else
        
        #=====# the fallback method #=====#
        
        if Length( L ) > 0 and IsHomalgMatrix( L[1] ) then
            u := L[1];
        fi;
        
        if Length( L ) > 1 and IsHomalgMatrix( L[2] ) then
            ui := L[2];
        fi;
        
        if IsBound( u ) and IsBound( ui ) then
            ## the two for's avoid creating non-dense lists:
            for k in [ 1 .. i - 1 ] do
                r := MatElm( M, k, j );
                if not IsZero( r ) then
                    SetMatElm( u, k, i, -r );
                    SetMatElm( ui, k, i, r );
                fi;
            od;
            for k in [ i + 1 .. NrRows( M ) ] do
                r := MatElm( M, k, j );
                if not IsZero( r ) then
                    SetMatElm( u, k, i, -r );
                    SetMatElm( ui, k, i, r );
                fi;
            od;
        elif IsBound( u ) then
            ## the two for's avoid creating non-dense lists:
            for k in [ 1 .. i - 1 ] do
                r := MatElm( M, k, j );
                SetMatElm( u, k, i, -r );
            od;
            for k in [ i + 1 .. NrRows( M ) ] do
                r := MatElm( M, k, j );
                SetMatElm( u, k, i, -r );
            od;
        elif IsBound( ui ) then
            ## the two for's avoid creating non-dense lists:
            for k in [ 1 .. i - 1 ] do
                r := MatElm( M, k, j );
                SetMatElm( ui, k, i, r );
            od;
            for k in [ i + 1 .. NrRows( M ) ] do
                r := MatElm( M, k, j );
                SetMatElm( ui, k, i, r );
            od;
        fi;
        
    fi;
    
end );

##
InstallMethod( SetColumnToZero,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt ],
        
  function( M, i, j )
    local R, RP, zero, k;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.SetColumnToZero) then
        RP!.SetColumnToZero( M, i, j );
    else
        
        #=====# the fallback method #=====#
        
        zero := Zero( R );
        
        ## the two for's avoid creating non-dense lists:
        for k in [ 1 .. i - 1 ] do
            SetMatElm( M, k, j, zero );
        od;
        
        for k in [ i + 1 .. NrRows( M ) ] do
            SetMatElm( M, k, j, zero );
        od;
        
    fi;
    
    ## since all what we did had a side effect on Eval( M ) ignoring
    ## possible other Eval's, e.g. EvalCompose, we want to return
    ## a new homalg matrix object only containing Eval( M )
    return HomalgMatrixWithAttributes( [
                 Eval, Eval( M ),
                 NrRows, NrRows( M ),
                 NrColumns, NrColumns( M ),
                 ], R );
    
end );

##
InstallMethod( GetCleanRowsPositions,
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
    
    #=====# the fallback method #=====#
    
    clean_rows := [ ];
    
    m := NrRows( M );
    
    for j in clean_columns do
        for i in [ 1 .. m ] do
            if IsOne( MatElm( M, i, j ) ) then
                Add( clean_rows, i );
                break;
            fi;
        od;
    od;
    
    return clean_rows;
    
end );

##
InstallMethod( ConvertRowToMatrix,
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
    
    #=====# the fallback method #=====#
    
    ## to use
    ## CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( M ), c, r, R )
    ## we would need a transpose afterwards,
    ## which differs from Involution in general:
    
    l := List( [ 1 .. c ], j -> CertainColumns( M, [ (j-1) * r + 1 .. j * r ] ) );
    l := List( l, GetListOfHomalgMatrixAsString );
    l := List( l, a -> CreateHomalgMatrixFromString( a, r, 1, R ) );
    
    mat := HomalgZeroMatrix( r, 0, R );
    
    for j in [ 1 .. c ] do
        mat := UnionOfColumnsOp( mat, l[j] );
    od;
    
    return mat;
    
end );

##
InstallMethod( ConvertColumnToMatrix,
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
    
    #=====# the fallback method #=====#
    
    return CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( M ), r, c, R ); ## delicate
    
end );

##
InstallMethod( ConvertMatrixToRow,
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
    
    #=====# the fallback method #=====#
    
    r := NrRows( M );
    c := NrColumns( M );
    
    ## CreateHomalgMatrixFromString( GetListOfHomalgMatrixAsString( "Transpose"( M ) ), 1, r * c, R )
    ## would require a Transpose operation,
    ## which differs from Involution in general:
    
    l := List( [ 1 .. c ], j -> CertainColumns( M, [ j ] ) );
    l := List( l, GetListOfHomalgMatrixAsString );
    l := List( l, a -> CreateHomalgMatrixFromString( a, 1, r, R ) );
    
    mat := HomalgZeroMatrix( 1, 0, R );
    
    for j in [ 1 .. c ] do
        mat := UnionOfColumnsOp( mat, l[j] );
    od;
    
    return mat;
    
end );

##
InstallMethod( ConvertMatrixToColumn,
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
    
    #=====# the fallback method #=====#
    
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
    
    #=====# the fallback method #=====#
    
    return Eval( e );
    
end );

##
InstallMethod( MaxDimensionalRadicalSubobjectOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, rad;
    
    if IsBound( M!.MaxDimensionalRadicalSubobjectOp ) then
        return M!.MaxDimensionalRadicalSubobjectOp;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.MaxDimensionalRadicalSubobject) then
        rad := RP!.MaxDimensionalRadicalSubobject( M );	## the external object
        rad := HomalgMatrix( rad, R );
        if IsZero( rad ) then
            return HomalgZeroMatrix( 0, 1, R );
        fi;
        SetNrColumns( rad, 1 );
        NrRows( rad );
        IsOne( rad );
        M!.MaxDimensionalRadicalSubobjectOp := rad;
        rad!.MaxDimensionalRadicalSubobjectOp := rad;
        return rad;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called MaxDimensionalRadicalSubobject ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RadicalSubobjectOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, rad;
    
    if IsBound( M!.RadicalSubobjectOp ) then
        return M!.RadicalSubobjectOp;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.RadicalSubobject) then
        rad := RP!.RadicalSubobject( M );	## the external object
        rad := HomalgMatrix( rad, R );
        if IsZero( rad ) then
            return HomalgZeroMatrix( 0, 1, R );
        fi;
        SetNrColumns( rad, 1 );
        NrRows( rad );
        IsOne( rad );
        M!.RadicalSubobjectOp := rad;
        rad!.RadicalSubobjectOp := rad;
        return rad;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called RadicalSubobject ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RadicalDecompositionOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, triv;
    
    if IsBound( M!.RadicalDecomposition ) then
        return M!.RadicalDecomposition;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        if NrColumns( M ) = 0 then
            triv := HomalgZeroMatrix( 0, 0, R );
        else
            triv := HomalgZeroMatrix( 0, 1, R );
        fi;
        M!.RadicalDecomposition := [ triv ];
        return M!.RadicalDecomposition;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.RadicalDecomposition ) then
        M!.RadicalDecomposition := RP!.RadicalDecomposition( M );
        return M!.RadicalDecomposition;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called RadicalDecomposition ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( EquiDimensionalDecompositionOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, triv;
    
    if IsBound( M!.EquiDimensionalDecomposition ) then
        return M!.EquiDimensionalDecomposition;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        if NrColumns( M ) = 0 then
            triv := HomalgZeroMatrix( 0, 0, R );
        else
            triv := HomalgZeroMatrix( 0, 1, R );
        fi;
        M!.EquiDimensionalDecomposition := [ triv ];
        return M!.EquiDimensionalDecomposition;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.EquiDimensionalDecomposition ) then
        M!.EquiDimensionalDecomposition := RP!.EquiDimensionalDecomposition( M );
        return M!.EquiDimensionalDecomposition;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called EquiDimensionalDecomposition ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( MaxDimensionalSubobjectOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, max;
    
    if IsBound( M!.MaxDimensionalSubobjectOp ) then
        return M!.MaxDimensionalSubobjectOp;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.MaxDimensionalSubobject) then
        max := RP!.MaxDimensionalSubobject( M );	## the external object
        max := HomalgMatrix( max, R );
        if IsZero( max ) then
            return HomalgZeroMatrix( 0, 1, R );
        fi;
        SetNrColumns( max, 1 );
        NrRows( max );
        IsOne( max );
        M!.MaxDimensionalSubobjectOp := max;
        max!.MaxDimensionalSubobjectOp := max;
        return max;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called MaxDimensionalSubobject ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PrimaryDecompositionOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, triv;
    
    if IsBound( M!.PrimaryDecomposition ) then
        return M!.PrimaryDecomposition;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        if NrColumns( M ) = 0 then
            triv := HomalgZeroMatrix( 0, 0, R );
        else
            triv := HomalgZeroMatrix( 0, 1, R );
        fi;
        M!.PrimaryDecomposition := [ [ triv, triv ] ];
        return M!.PrimaryDecomposition;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.PrimaryDecomposition ) then
        M!.PrimaryDecomposition := RP!.PrimaryDecomposition( M );
        return M!.PrimaryDecomposition;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called PrimaryDecomposition ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##  <#GAPDoc Label="Eliminate">
##  <ManSection>
##    <Oper Arg="rel, indets" Name="Eliminate"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Eliminate the independents <A>indets</A> from the matrix (or list of ring elements) <A>rel</A>,
##      i.e. compute a generating set
##      of the ideal defined as the intersection of the ideal generated by the entries of the list <A>rel</A>
##      with the subring generated by all indeterminates except those in <A>indets</A>.
##      by the list of indeterminates <A>indets</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eliminate,
        "for a homalg matrix and list of homalg ring elements",
        [ IsHomalgMatrix, IsList ],
        
  function( rel, indets )
    local R, RP, elim;
    
    R := HomalgRing( rel );
    
    if IsZero( rel ) then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    rel := EntriesOfHomalgMatrix( rel );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Eliminate) then
        elim := RP!.Eliminate( rel, indets, R );	## the external object
        elim := HomalgMatrix( elim, R );
        if IsZero( elim ) then
            return HomalgZeroMatrix( 0, 1, R );
        fi;
        SetNrColumns( elim, 1 );
        NrRows( elim );
        return elim;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called Eliminate ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Eliminate,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( rel )
    local R, indets, B;
    
    R := HomalgRing( rel );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
        B := BaseRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
        B := CoefficientsRing( R );
    else
        Error( "the ring is not a polynomial ring" );
    fi;
    
    return B * Eliminate( rel, indets );
    
end );

##
InstallMethod( Eliminate,
        "for two lists of ring elements and a homalg ring",
        [ IsList, IsList, IsHomalgRing ],
        
  function( rel, indets, R )
    
    rel := HomalgMatrix( rel, Length( rel ), 1, R );
    
    return Eliminate( rel, indets );
    
end );

##
InstallMethod( Eliminate,
        "for two lists of ring elements",
        [ IsList, IsList ],
        
  function( rel, indets )
    local R;
    
    if not rel = [ ] then
        R := HomalgRing( rel[1] );
    elif not indets = [ ] then
        R := HomalgRing( indets[1] );
    else
        Error( "cannot extract ring out of two empty input lists\n" );
    fi;
    
    return Eliminate( rel, indets, R );
    
end );

##
InstallMethod( Eliminate,
        "for a homalg matrix and ring element",
        [ IsHomalgMatrix, IsHomalgRingElement ],
        
  function( rel, v )
    
    return Eliminate( rel, [ v ] );
    
end );

##
InstallMethod( Eliminate,
        "for a list and ring element",
        [ IsList, IsHomalgRingElement ],
        
  function( rel, v )
    
    return Eliminate( rel, [ v ] );
    
end );

##
InstallMethod( Coefficients,
        "for a ring element and a list of indeterminates",
        [ IsHomalgRingElement, IsList ],
        
  function( poly, var )
    local R, RP, both, monomials, coeffs;
    
    R := HomalgRing( poly );
    
    if IsZero( poly ) then
        coeffs := HomalgZeroMatrix( 1, 0, R );
        coeffs!.monomials := MakeImmutable( [ ] );
        return coeffs;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Coefficients) then
        both := RP!.Coefficients( poly, var );	## the pair of external objects
        monomials := HomalgMatrix( both[1], R );
        monomials := EntriesOfHomalgMatrix( monomials );
        coeffs := HomalgMatrix( both[2], Length( monomials ), 1, R );
        coeffs!.monomials := MakeImmutable( monomials );
        return coeffs;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called Coefficients ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Coefficients,
        "for a ring element and an indeterminate",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( poly, var )
    
    return Coefficients( poly, [ var ] );
    
end );

##
InstallMethod( Coefficients,
        "for a homalg ring element and a string",
        [ IsHomalgRingElement, IsString ],
        
  function( poly, var_name )
    
    return Coefficients( poly, var_name / HomalgRing( poly ) );
    
end );

##
InstallMethod( Coefficients,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( poly )
    local R, indets, coeffs;
    
    R := HomalgRing( poly );
    
    if IsBound( poly!.Coefficients ) then
        return poly!.Coefficients;
    fi;
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
    elif HasRelativeIndeterminateAntiCommutingVariablesOfExteriorRing( R ) then
        indets := RelativeIndeterminateAntiCommutingVariablesOfExteriorRing( R );
    elif HasIndeterminateAntiCommutingVariablesOfExteriorRing( R ) then
        indets := IndeterminateAntiCommutingVariablesOfExteriorRing( R );
    else
        TryNextMethod( );
    fi;
    
    coeffs := Coefficients( poly, indets );
    
    poly!.Coefficients := coeffs;
    
    return coeffs;
    
end );

##
InstallMethod( CoefficientsOfUnivariatePolynomial,
        "for two homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( r, var )
    local R, RP, ext_obj;
    
    if IsZero( r ) then
        return HomalgZeroMatrix( 1, 0, R );
    fi;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CoefficientsOfUnivariatePolynomial) then
        ext_obj := RP!.CoefficientsOfUnivariatePolynomial( r, var );
        return HomalgMatrix( ext_obj, 1, "unknown_number_of_columns", R );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CoefficientsOfUnivariatePolynomial,
        "for a homalg ring element and a string",
        [ IsHomalgRingElement, IsString ],
        
  function( r, var_name )
    
    return CoefficientsOfUnivariatePolynomial( r, var_name / HomalgRing( r ) );
    
end );

## for univariate polynomials over arbitrary base rings
InstallMethod( CoefficientsOfUnivariatePolynomial,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, indets;
    
    R := HomalgRing( r );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
    fi;
    
    if not Length( indets ) = 1 then
        TryNextMethod( );
    fi;
    
    return CoefficientsOfUnivariatePolynomial( r, indets[1] );
    
end );

## for univariate polynomials over arbitrary base rings
InstallMethod( CoefficientOfUnivariatePolynomial,
        "for a homalg ring element and an integer",
        [ IsHomalgRingElement, IsInt ],
        
  function( r, j )
    local coeffs;
    
    coeffs := CoefficientsOfUnivariatePolynomial( r );
    coeffs := EntriesOfHomalgMatrix( coeffs );
    
    if j > Length( coeffs ) - 1 then
        return Zero( r );
    fi;
    
    return coeffs[j + 1];
    
end );

##
InstallMethod( LeadingCoefficient,
        "for lists of ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( poly, var )
    
    return MatElm( Coefficients( poly, var ), 1, 1 );
    
end );

##
InstallMethod( LeadingCoefficient,
        "for a homalg ring element and a string",
        [ IsHomalgRingElement, IsString ],
        
  function( r, var_name )
    
    return LeadingCoefficient( r, var_name / HomalgRing( r ) );
    
end );

##
InstallMethod( LeadingCoefficient,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( poly )
    local lc;
    
    if IsBound( poly!.LeadingCoefficient ) then
        return poly!.LeadingCoefficient;
    fi;
    
    lc := MatElm( Coefficients( poly ), 1, 1 );
    
    poly!.LeadingCoefficient := lc;
    
    return lc;
    
end );

## FIXME: make this a fallback method
InstallMethod( LeadingMonomial,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( poly )
    local lm;
    
    if IsBound( poly!.LeadingMonomial ) then
        return poly!.LeadingMonomial;
    fi;
    
    if IsZero( poly ) then
        lm := poly;
    else
        lm := Coefficients( poly )!.monomials[1];
    fi;
    
    poly!.LeadingMonomial := lm;
    
    return lm;

end );

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( mat )
    local R, RP, result, r, c, i, j;
    
    R := HomalgRing( mat );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IndicatorMatrixOfNonZeroEntries) then
        return RP!.IndicatorMatrixOfNonZeroEntries( mat );
    fi;
    
    r := NrRows( mat );
    c := NrColumns( mat );
    
    result := List( [ 1 .. r ], a -> ListWithIdenticalEntries( c, 0 ) );
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            if not IsZero( MatElm( mat, i, j ) ) then
                result[i][j] := 1;
            fi;
        od;
    od;
    
    return result;
    
end );

##
InstallMethod( Pullback,
        "for homalg rings",
        [ IsHomalgRingMap, IsHomalgMatrix ],
        
  function( phi, M )
    local T, r, c, RP;
    
    if not IsIdenticalObj( HomalgRing( Source( phi ) ), HomalgRing( M ) ) then
        Error( "the source ring of the ring map and the ring of the matrix are not identical\n" );
    fi;
    
    T := HomalgRing( Range( phi ) );
    
    r := NrRows( M );
    c := NrColumns( M );
    
    if IsZero( M ) then
        
        return HomalgZeroMatrix( r, c, T );
        
    fi;
    
    RP := homalgTable( T );
    
    if IsBound( RP!.Pullback ) then
        
        return HomalgMatrix( RP!.Pullback( phi, M ), NrRows( M ), NrColumns( M ), T );
        
    fi;
    
    if not IsHomalgInternalRingRep( T ) then
        Error( "could not find a procedure called Pullback ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
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
    
    if not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Sum) then
        return RingElementConstructor( R )( RP!.Sum( r1, r2 ), R );
    elif IsBound(RP!.Minus) then
        return RingElementConstructor( R )( RP!.Minus( r1, RP!.Minus( Zero( R ), r2 ) ), R );
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
    
    if not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Product) then
        return RingElementConstructor( R )( RP!.Product( r1, r2 ), R ) ;
    fi;
    
    #=====# the fallback method #=====#
    
    return MatElm( HomalgMatrix( [ r1 ], 1, 1, R ) * HomalgMatrix( [ r2 ], 1, 1, R ), 1, 1 );
    
end );

##
InstallMethod( Degree,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP, deg;
    
    if IsBound( r!.Degree ) then
        return r!.Degree;
    fi;
    
    R := HomalgRing( r );
    
    ## do not delete this
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if not IsBound(RP!.DegreeOfRingElement) then
        TryNextMethod( );
    fi;
    
    deg := RP!.DegreeOfRingElement( r, R );
    
    r!.Degree := deg;
    
    return deg;
    
end );

##
InstallMethod( Degree,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP, coeffs, deg;
    
    if IsBound( r!.Degree ) then
        return r!.Degree;
    fi;
    
    if IsZero( r ) then
        return -1;
    fi;
    
    R := HomalgRing( r );
    
    if not HasRelativeIndeterminatesOfPolynomialRing( R ) then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if not ( IsBound(RP!.Coefficients) and IsBound( RP!.DegreeOfRingElement ) ) then
        TryNextMethod( );
    fi;
    
    coeffs := Coefficients( r );
    
    deg := RP!.DegreeOfRingElement( coeffs!.monomials[1], R );
    
    r!.Degree := deg;
    
    return deg;
    
end );

##
InstallMethod( MatrixOfSymbols,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( mat )
    local S, R, RP, symb;
    
    R := HomalgRing( mat );
    
    S := AssociatedGradedRing( R );
    
    if IsZero( mat ) then
        return HomalgZeroMatrix( NrRows( mat ), NrColumns( mat ), S );
    elif IsOne( mat ) then
        return HomalgIdentityMatrix( NrRows( mat ), S );
    fi;
    
    RP := homalgTable( R );
    
    if not IsBound(RP!.MatrixOfSymbols) then
        Error( "could not find a procedure called MatrixOfSymbols ",
               "in the homalgTable of the ring\n" );
    fi;
    
    symb := RP!.MatrixOfSymbols( mat );
    
    symb := S * HomalgMatrix( symb, NrRows( mat ), NrColumns( mat ), R );
    
    ## TODO: add more properties and attributes to symb
    
    return symb;
    
end );

##
InstallMethod( GetRidOfRowsAndColumnsWithUnits,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local MM, R, RP, rr, cc, r, c, UI, VI, U, V, rows, columns,
          deleted_rows, deleted_columns, pos, i, j, e,
          column, column_range, row, row_range, IdU, IdV, u, v, U_M_V;
    
    if IsBound( M!.GetRidOfRowsAndColumnsWithUnits ) then
        return M!.GetRidOfRowsAndColumnsWithUnits;
    fi;
    
    MM := M;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    rr := NrRows( M );
    cc := NrColumns( M );
    
    r := rr;
    c := cc;
    
    UI := HomalgIdentityMatrix( rr, R );
    VI := HomalgIdentityMatrix( cc, R );
    
    U := UI;
    V := VI;
    
    if IsBound( RP!.GetRidOfRowsAndColumnsWithUnits ) then
        
        M := RP!.GetRidOfRowsAndColumnsWithUnits( M );
        
        rows := M[2];
        columns := M[3];
        
        deleted_rows := M[4];
        deleted_columns := M[5];
        
        M := M[1];
        
        Assert( 6, IsUnitFree( M ) );
        SetIsUnitFree( M, true );
        
    else
        
        rows := [ ];
        columns := [ ];
        
        deleted_rows := [ ];
        deleted_columns := [ ];
        
    fi;
    
    #=====# the fallback method #=====#
    
    pos := GetUnitPosition( M );
    
    SetIsUnitFree( M, pos = fail );
    
    while not IsUnitFree( M ) do
        
        i := pos[1]; j := pos[2];
        
        e := MatElm( M, i, j );
        
        Assert( 6, IsUnit( e ) );
        Assert( 6, not IsZero( e ) );
        
        if IsHomalgRingElement( e ) then
            e!.IsUnit := true;
            SetIsZero( e, false );
        fi;
        
        if IsOne( e ) then
            e := HomalgIdentityMatrix( 1, R );
        else
            e := e^-1;
            Assert( 0, not e = fail );
            e := HomalgMatrix( [ e ], 1, 1, R );
            
            Assert( 6, not IsZero( e ) );
            SetIsZero( e, false );
            
        fi;
        
        Add( rows, i );
        Add( columns, j );
        
        column := CertainColumns( M, [ j ] );
        
        column_range := Concatenation( [ 1 .. j - 1 ], [ j + 1 .. c ] );
        
        M := CertainColumns( M, column_range ); c := c - 1;
        
        row := CertainRows( M, [ i ] );
        
        row_range := Concatenation( [ 1 .. i - 1 ], [ i + 1 .. r ] );
        
        column := CertainRows( column, row_range );
        
        M := CertainRows( M, row_range ); r := r - 1;
        
        ## the following line breaks the symmetry of the line redefining M,
        ## which could have been M := M - column * e * row;
        ## but since the adapted row will be reused in creating
        ## the trafo matrix V below, I decided to redefine the row
        ## for effeciency reasons
        
        row := e * row;
        
        M := M - column * row;
        
        column := column * e;
        
        Add( deleted_rows, -row );
        Add( deleted_columns, -column );
        
        pos := GetUnitPosition( M );
        
        SetIsUnitFree( M, pos = fail );
        
    od;
    
    r := rr;
    c := cc;
    
    for pos in [ 1 .. Length( rows ) ] do
        
        r := r - 1;
        c := c - 1;
        
        i := rows[pos]; j := columns[pos];
        
        IdU := HomalgIdentityMatrix( r, R );
        IdV := HomalgIdentityMatrix( c, R );
        
        u := CertainColumns( IdU, [ 1 .. i - 1 ] );
        u := UnionOfColumnsOp( u, deleted_columns[pos] );
        u := UnionOfColumnsOp( u, CertainColumns( IdU, [ i .. r ] ) );
        
        v := CertainRows( IdV, [ 1 .. j - 1 ] );
        v := UnionOfRowsOp( v, deleted_rows[pos] );
        v := UnionOfRowsOp( v, CertainRows( IdV, [ j .. c ] ) );
        
        U := u * U;
        V := V * v;
        
    od;
    
    ## now bring rows and columns to absolute positions
    
    rr := [ 1 .. rr ];
    cc := [ 1 .. cc ];
    
    Perform( rows, function( i ) Remove( rr, i ); end );
    Perform( columns, function( j ) Remove( cc, j ); end );
    
    UI := CertainColumns( UI, rr );
    VI := CertainRows( VI, cc );
    
    ## 1. Left/RightInverse is better than Left/RightInverseLazy here
    ##    as V and U are known to be a subidentity matrices
    ## 2. Caution:
    ##    (-) U * MM * V is NOT = M, in general, nor
    ##    (-) UI * M * VI is NOT = MM, in general, but
    ##    (+) U * MM and M generate the same column space
    ##    (+) MM * V and M generate the same row space
    ##    (+) UI * M generate column subspace of MM
    ##    (+) M * VI generate row subspace of MM
    
    Assert( 6, GenerateSameColumnModule( U * MM, M ) );
    Assert( 6, GenerateSameRowModule( MM * V, M ) );
    
    Assert( 6, IsZero( DecideZeroColumns( UI * M, BasisOfColumnModule( MM ) ) ) );
    Assert( 6, IsZero( DecideZeroRows( M * VI, BasisOfRowModule( MM ) ) ) );
    
    U_M_V := [ U, UI, M, VI, V ];
    
    MM!.GetRidOfRowsAndColumnsWithUnits := U_M_V;
    
    return U_M_V;
    
end );

##
InstallMethod( Random,
        "for a homalg ring and a list",
        [ IsHomalgRing, IsList ],
        
  function( R, L )
    local RP;
    
    RP := homalgTable( R );
    
    L := Concatenation( [ R ], L );
    
    if IsBound(RP!.RandomPol) then
        return RingElementConstructor( R )( CallFuncList( RP!.RandomPol, L ), R );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Random,
        "for a homalg ring and an integer",
        [ IsHomalgRing, IsInt ],
        
  function( R, maxdeg )
    
    return Random( R, [ maxdeg ] );
    
end );

##
InstallMethod( Random,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    
    return Random( R, Random( [ 1 .. 10 ] ) );
    
end );

##
InstallMethod( Value,
        "polynomial substitution",
        [ IsHomalgRingElement, IsList, IsList ],
        
  function( p, V, O )
    local lv, lo, R, i, RP, L;
    
    lv := Length( V );
    lo := Length( O );
    
    if not ( lv > 0 and lo = lv ) then
        Error( "Second and third parameters should be nonempty lists of same size\n" );
    fi;
    
    R := HomalgRing( p );
    
    Perform( [ 1 .. lo ],
      function( i )
        if not IsHomalgRingElement( O[ i ] ) then
            O[ i ] := O[ i ] / R;
        fi;
    end );
    
    if not ( ForAll( [ 1 .. lv ], i -> IsIdenticalObj( R, HomalgRing( V[ i ] ) ) ) and ForAll( [ 1 .. lo ], i -> IsIdenticalObj( R, HomalgRing( O[ i ] ) ) ) ) then
        Error( "All the elements of the list should be in same ring\n" );
    fi;
    
    if not ForAll( V, i -> i in Indeterminates( R ) ) then
        Error( "entries in the second parameter should be ring variables\n" );
    fi;
    
    if not ForAll( O, i -> IsHomalgRingElement( i ) ) then
        Error( "entries in the third parameter should be ring elements\n" );
    fi;
    
    RP := homalgTable( R );
    
    if not IsBound(RP!.Evaluate) then
        Error( "table entry Evaluate not found\n" );
    fi;
    
    L := [ ];
    
    for i in [ 1 .. lv ] do
        L[ 2*i-1 ] := V[ i ];
        L[ 2*i ] := O[ i ];
    od;
    
    return RingElementConstructor( R )( RP!.Evaluate( p, L ), R );
    
end );

##
InstallMethod( Value,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, V, O )
    local R, RP, r, c, L, lv, MM, i, j;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    r := NrRows( M );
    c := NrColumns( M );
    
    if IsBound( RP!.EvaluateMatrix ) then
        
        L := [ ];
        
        lv := Length( V );
        
        for i in [ 1 .. lv ] do
            L[ 2*i-1 ] := V[ i ];
            L[ 2*i ] := O[ i ];
        od;
        
        return HomalgMatrix( RP!.EvaluateMatrix( M, L ), r, c, R );
        
    fi;
    
    #=====# the fallback method #=====#
    
    MM := HomalgInitialMatrix( r, c, HomalgRing( M ) );
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            SetMatElm( MM, i, j, Value( MatElm( M, i, j ), V, O ) );
        od;
    od;
    
    MakeImmutable( MM );
    
    return MM;
    
end );

##
InstallMethod( Value,
        "polynomial substitution",
        [ IsObject, IsHomalgRingElement, IsRingElement ],
        
  function( p, v, o )
    
    return Value( p, [ v ], [ o ] );
    
end );

##
InstallMethod( Value,
        "polynomial substitution",
        [ IsObject, IsHomalgRingElement ],
        
  function( p, v )
    
    return o -> Value( p, v, o );
    
end );

##
InstallMethod( Numerator,
        "for homalg ring element",
        [ IsHomalgRingElement ],
        
  function( p )
    local R, RP, l;
    
    R :=  HomalgRing( p );
    
    if IsBound( p!.Numerator ) then
        return p!.Numerator;
    fi;
    
    RP := homalgTable( R );
    
    if not IsBound( RP!.NumeratorAndDenominatorOfPolynomial ) then
        Error( "table entry for NumeratorAndDenominatorOfPolynomial not found\n" );
    fi;
    
    l := RP!.NumeratorAndDenominatorOfPolynomial( p );
    
    p!.Numerator := l[1];
    p!.Denominator := l[2];
    
    return l[1];
    
end );

##
InstallMethod( Denominator,
        "for homalg ring element",
        [ IsHomalgRingElement ],
        
  function( p )
    
    if not IsBound( p!.Denominator ) then
        ## this will trigger setting p!.Denominator
        Numerator( p );
    fi;
    
    return p!.Denominator;
    
end );

##
InstallMethod( Denominator,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    if not IsBound( M!.Denominator ) then
        ## this will trigger setting M!.Denominator
        Numerator( M );
    fi;
    
    return M!.Denominator;
    
end );

##
InstallMethod( Value,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, V, O )
    local R, r, c, MM, i, j;
    
    R := HomalgRing( M );
    
    #=====# the fallback method #=====#
    
    r := NrRows( M );
    c := NrColumns( M );
    
    MM := HomalgInitialMatrix( r, c, HomalgRing( M ) );
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            SetMatElm( MM, i, j, Value( MatElm( M, i, j ), V, O ) );
        od;
    od;
    
    MakeImmutable( MM );
    
    return MM;
    
end );

##
InstallMethod( MonomialMatrixWeighted,
        "for homalg rings",
        [ IsInt, IsHomalgRing, IsList ],
        
  function( d, R, weights )
    local dd, set_weights, RP, vars, mon;
    
    RP := homalgTable( R );
    
    if not Length( weights ) = Length( Indeterminates( R ) ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    set_weights := Set( weights );
    
    if set_weights = [1] or set_weights = [0,1] then
        dd := d;
    elif set_weights = [-1] or set_weights = [-1,0] then
        dd := -d;
    else
        Error( "Only weights -1, 0 or 1 are accepted. The weights -1 and 1 must not appear at once." );
    fi;
    
    if dd < 0 then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    vars := Indeterminates( R );

    if HasIsExteriorRing( R ) and IsExteriorRing( R ) and dd > Length( vars ) then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    if not ( set_weights = [ 1 ] or set_weights = [ -1 ] ) then
        
        ## the variables of weight 1 or -1
        vars := vars{Filtered( [ 1 .. Length( weights ) ], p -> weights[p] <> 0 )};
        
    fi;
    
    if IsBound(RP!.MonomialMatrix) then
        mon := RP!.MonomialMatrix( dd, vars, R );        ## the external object
        mon := HomalgMatrix( mon, R );
        SetNrColumns( mon, 1 );
        if d = 0 then
            IsOne( mon );
        fi;
        
        return mon;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called MonomialMatrix in the homalgTable of the external ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( MonomialMatrixWeighted,
        "for homalg rings",
        [ IsList, IsHomalgRing, IsList ],
        
  function( d, R, weights )
    local l, mon, w;
    
    if not Length( weights ) = Length( Indeterminates( R ) ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    l := Length( d );
    
    w := ListOfDegreesOfMultiGradedRing( l, R, weights );
    
    mon := List( [ 1 .. l ] , i -> MonomialMatrixWeighted( d[i], R, w[i] ) );
    
    return Iterated( mon, KroneckerMat );
    
end );

##
InstallMethod( ListOfDegreesOfMultiGradedRing,
        "for homalg rings",
        [ IsInt, IsHomalgRing, IsHomogeneousList ],
        
  function( l, R, weights )
    local indets, n, B, j, w, wlist, i, k;
    
    if l < 1 then
        Error( "the first argument must be a positiv integer\n" );
    fi;
    
    indets := Indeterminates( R );
    
    if not Length( weights ) = Length( indets ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if IsList( weights[1] ) and Length( weights[1] ) = l then
        return List( [ 1 .. l ], i -> List( weights, w -> w[i] ) );
    fi;
    
    ## the rest handles the (improbable?) case of successive extensions
    ## without multiple weights
    
    if l = 1 then
        return [ weights ];
    fi;
    
    n := Length( weights );
    
    if not HasBaseRing( R ) then
        Error( "no 1. base ring found\n" );
    fi;
    
    B := BaseRing( R );
    j := Length( Indeterminates( B ) );
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 0 ),
                 ListWithIdenticalEntries( n - j, 1 )
                 );
    
    wlist := [ ListN( w, weights, \* ) ];
    
    for i in [ 2 .. l - 1 ] do
        
        if not HasBaseRing( B ) then
            Error( "no ", i, ". base ring found\n" );
        fi;
        
        B := BaseRing( B );
        k := Length( Indeterminates( B ) );
        
        w := Concatenation(
                     ListWithIdenticalEntries( k, 0 ),
                     ListWithIdenticalEntries( j - k, 1 ),
                     ListWithIdenticalEntries( n - j, 0 )
                     );
        
        Add( wlist, ListN( w, weights, \* ) );
        
        j := k;
        
    od;
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 1 ),
                 ListWithIdenticalEntries( n - j, 0 )
                 );
    
    Add( wlist, ListN( w, weights, \* ) );
    
    return wlist;
    
end );

##
InstallMethod( RandomMatrixBetweenGradedFreeLeftModulesWeighted,
        "for homalg rings",
        [ IsList, IsList, IsHomalgRing, IsList ],
        
  function( degreesS, degreesT, R, weights )
    local RP, r, c, rand, i, j, mon;
    
    RP := homalgTable( R );
    
    r := Length( degreesS );
    c := Length( degreesT );
    
    if degreesT = [ ] then
        return HomalgZeroMatrix( 0, c, R );
    elif degreesS = [ ] then
        return HomalgZeroMatrix( r, 0, R );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, degreesT, degreesS, weights );      ## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return rand;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := MonomialMatrixWeighted( degreesS[i] - degreesT[j], R, weights );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG_MATRICES.ZZ ) ) * mon;
            mon := MatElm( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return HomalgMatrix( rand, r, c, R );
    
end );

##
InstallMethod( RandomMatrixBetweenGradedFreeRightModulesWeighted,
        "for homalg rings",
        [ IsList, IsList, IsHomalgRing, IsList ],
        
  function( degreesT, degreesS, R, weights )
    local RP, r, c, rand, i, j, mon;
    
    RP := homalgTable( R );
    
    r := Length( degreesT );
    c := Length( degreesS );
    
    if degreesT = [ ] then
        return HomalgZeroMatrix( 0, c, R );
    elif degreesS = [ ] then
        return HomalgZeroMatrix( r, 0, R );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, degreesT, degreesS, weights );      ## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return rand;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := MonomialMatrixWeighted( degreesS[j] - degreesT[i], R, weights );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG_MATRICES.ZZ ) ) * mon;
            mon := MatElm( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return HomalgMatrix( rand, r, c, R );
    
end );

##
InstallMethod( RandomMatrix,
        "for three integers, a homalg ring, and a list",
        [ IsInt, IsInt, IsInt, IsHomalgRing, IsList ],
        
  function( r, c, d, R, weights )
    local degreesS, degreesT;
    
    degreesS := ListWithIdenticalEntries( r, d );
    degreesT := ListWithIdenticalEntries( c, 0 );

    return RandomMatrixBetweenGradedFreeLeftModulesWeighted( degreesS, degreesT, R, weights );
    
end );

##
InstallMethod( RandomMatrix,
        "for three integers and a homalg ring",
        [ IsInt, IsInt, IsInt, IsHomalgRing ],
        
  function( r, c, d, R )
    local weights;
    
    weights := ListWithIdenticalEntries( Length( Indeterminates( R ) ), 1 );

    return RandomMatrix( r, c, d, R, weights );
    
end );

##
InstallMethod( GeneralLinearCombination,
        "for a homalg ring, an integer, a list and an integer",
        [ IsHomalgRing, IsInt, IsList, IsInt ],
        
  function( R, bound, weights, n )
    local mat, m, s, B, A, r, i, indets;
    
    if n = 0 then
        return [ ];
    fi;
    
    mat := MonomialMatrixWeighted( 0, R, weights );
    
    for i in [ 1 .. bound ] do
        
        mat := UnionOfRowsOp( mat, MonomialMatrixWeighted( i, R, weights ) );
        
    od;
    
    m := NrRows( mat );
    
    # todo: better names for the bi: use the corresponding degree of the monomial
    s := List( [ 1 .. n ], i -> Concatenation( "b_", String( i ), "_0..", String( m - 1 ) ) );
    
    s := JoinStringsWithSeparator( s );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
        B := BaseRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
        B := CoefficientsRing( R );
    elif HasRingRelations( R ) then
        B := CoefficientsRing( AmbientRing( R ) );
        indets := Indeterminates( AmbientRing( R ) );
        
    else
        indets := [ ];
        B := R;
    fi;
    
    B := ( B * s );
    
    A := B * indets;
    
    if HasRingRelations( R ) then
        A := A / ( A * RingRelations( R ) );
    fi;
    
    if HasRelativeIndeterminatesOfPolynomialRing( B ) then
        indets := RelativeIndeterminatesOfPolynomialRing( B );
    else
        indets := IndeterminatesOfPolynomialRing( B );
    fi;
    
    indets := List( indets, a -> a / A );
    
    indets := ListToListList( indets, n, m );
    
    indets := List( indets, l -> HomalgMatrix( l, 1, m, A ) );
    
    mat := A * mat;
    
    r := List( indets, i -> MatElm( i * mat, 1, 1 ) );
    
    return List( r, rr -> rr / A );
    
end );

##
InstallMethod( GetMonic,
        "for a homalg matrix and a positive integer",
        [ IsHomalgMatrix, IsPosInt ],
        
  function( M, i )
    local R, indets, l, B, newR, m, n, p, q, f, coeffs;
    
    R := HomalgRing( M );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
        B := BaseRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
        B := CoefficientsRing( R );
    else
        Error( "the ring is not a polynomial ring\n" );
    fi;

    l := [ 1 .. Length( indets ) ];
    Remove( l, i );
    
    newR := ( B * indets{l} ) * [ indets[i] ];
    
    M := newR * M;
    
    m := NrRows( M );
    n := NrColumns( M );
    
    for p in [ 1 .. m ] do
        for q in [ 1 .. n ] do
            
            f := MatElm( M, p, q );
            
            if IsMonic( f ) then
                return [ f, [ p, q ] ];
            fi;
            
        od;
    od;
    
    return fail;
    
end );

##
InstallMethod( GetMonic,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, indets, i, l;
    
    R := HomalgRing( M );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
    else
        Error( "the ring is not a polynomial ring\n" );
    fi;

    for i in Reversed( [ 1 .. Length( indets ) ] ) do
        
        l := GetMonic( M, i );
        
        if not l = fail then
            return [ l[1], l[2], i ];
        fi;
        
    od;
    
    return fail;

end );

##
InstallMethod( GetMonicUptoUnit,
        "for a homalg matrix and a positive integer",
        [ IsHomalgMatrix, IsPosInt ],
        
  function( M, i )
    local R, indets, l, B, newR, m, n, p, q, f, coeffs;
    
    R := HomalgRing( M );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
        B := BaseRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
        B := CoefficientsRing( R );
    else
        Error( "the ring is not a polynomial ring\n" );
    fi;

    l := [ 1 .. Length( indets ) ];
    Remove( l, i );
    
    newR := ( B * indets{l} ) * [ indets[i] ];
    
    M := newR * M;
    
    m := NrRows( M );
    n := NrColumns( M );
    
    for p in [ 1 .. m ] do
        for q in [ 1 .. n ] do
            
            f := MatElm( M, p, q );
            
            if IsMonicUptoUnit( f ) then
                return [ f, [ p, q ] ];
            fi;
            
        od;
    od;
    
    return fail;
    
end );

##
InstallMethod( GetMonicUptoUnit,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, indets, i, l;
    
    R := HomalgRing( M );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
    else
        Error( "the ring is not a polynomial ring\n" );
    fi;

    for i in Reversed( [ 1 .. Length( indets ) ] ) do
        
        l := GetMonicUptoUnit( M, i );
        
        if not l = fail then
            return [ l[1], l[2], i ];
        fi;
        
    od;
    
    return fail;

end );

##
InstallMethod( Diff,
        "for two homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( x, r )
    local R;
    
    R := HomalgRing( r );
    
    x := HomalgMatrix( [ x ], 1, 1, R );
    r := HomalgMatrix( [ r ], 1, 1, R );
    
    return MatElm( Diff( x, r ), 1, 1 );
    
end );

##
InstallMethod( Diff,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, var, x;
    
    R := HomalgRing( r );
    var := IndeterminatesOfPolynomialRing( R );
    x := var[Length( var )];
    
    return Diff( x, r );
    
end );

##
InstallMethod( NoetherNormalization,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, r, char, indets, l, k, K, m, rand_mat, rand_inv;
    
    R := HomalgRing( M );
    r := CoefficientsRing( R );
    
    char := Characteristic( r );
    
    if char > 0 and not IsPrimeInt( char ) then
        TryNextMethod( );
    elif not HasIndeterminatesOfPolynomialRing( R ) then
        TryNextMethod( );
    fi;
    
    indets := Indeterminates( R );
    
    l := Length( indets );
    
    indets := HomalgMatrix( indets, 1, l, R );
    
    if char > 0 then
        if HasRationalParameters( r ) then
            k := HomalgRingOfIntegers( char );
        else
            k := HomalgRingOfIntegers( char, DegreeOverPrimeField( r ) );
        fi;
        K := k!.ring;
    else
        k := HOMALG_MATRICES.ZZ;
    fi;
    
    m := GetMonicUptoUnit( M );
    
    if not m = fail then
        return [ M, m, true, true ];
    fi;
    
    repeat
        
        if IsPrimeInt( char ) then
            rand_mat := Random( SL( l, K ) );
        else
            if l = 1 then
                rand_mat := [ [ 1 ] ];
            else
                rand_mat := RandomUnimodularMat( l );
            fi;
        fi;
        
        rand_inv := rand_mat^-1;
        
        rand_mat := HomalgMatrix( rand_mat, k );
        rand_inv := HomalgMatrix( rand_inv, k );
        
        rand_mat := R * rand_mat;
        rand_inv := R * rand_inv;
        
        SetLeftInverse( rand_mat, rand_inv );
        SetRightInverse( rand_mat, rand_inv );
        SetLeftInverse( rand_inv, rand_mat );
        SetRightInverse( rand_inv, rand_mat );
        
        rand_mat := indets * rand_mat;
        rand_inv := indets * rand_inv;
        
        rand_mat := RingMap( rand_mat, R, R );
        
        M := Pullback( rand_mat, M );
        
        m := GetMonicUptoUnit( M );
        
    until not m = fail;
    
    rand_inv := RingMap( rand_inv, R, R );
    
    SetIsIsomorphism( rand_mat, true );
    SetIsIsomorphism( rand_inv, true );
    
    return [ M, m, rand_mat, rand_inv ];
    
end );

##
InstallMethod( Inequalities,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local r, RP, J;
    
    r := R;
    
    RP := homalgTable( R );
    
    if not IsBound(RP!.Inequalities) then
        Error( "could not find a procedure called Inequalities in the homalgTable\n" );
    fi;
    
    J := RP!.Inequalities( R );
    
    J := DuplicateFreeList( J );
    
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
        r := R;
    else
        r := CoefficientsRing( R );
    fi;
    
    r := AssociatedPolynomialRing( r );
    
    J := List( J, a -> a / r );
    
    if IsBound( R!.Inequalities ) then
        Append( J, R!.Inequalities );
    fi;
    
    J := DuplicateFreeList( J );
    
    R!.Inequalities := J;
    
    return J;
    
end );

##
InstallMethod( ClearDenominatorsRowWise,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, m, n, coeffs;
    
    if IsZero( M ) then
        return M;
    elif IsOne( M ) then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    m := NrRows( M );
    n := NrColumns( M );
    
    if IsBound(RP!.ClearDenominatorsRowWise) then
        return HomalgMatrix( RP!.ClearDenominatorsRowWise( M ), m, n, R ); ## the external object
    fi;
    
    #=====# begin of the core procedure #=====#
    
    coeffs := EntriesOfHomalgMatrixAsListList( M );
    
    coeffs := List( coeffs, a -> Concatenation( List( a, b -> EntriesOfHomalgMatrix( Coefficients( b ) ) ) ) );
    
    coeffs := List( coeffs, a -> List( a, b -> DenominatorRat( Rat( String( b ) ) ) ) );
    
    coeffs := List( coeffs, Lcm );
    
    coeffs := HomalgDiagonalMatrix( List( coeffs, a -> a / R ) );
    
    return coeffs * M;
    
end );


##
InstallMethod( MaximalDegreePart,
        "for a homalg ring element",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP, var, B, base, weights, d, coeffs, monoms, plist;
    
    if IsZero( r ) then
        return r;
    fi;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.MaximalDegreePart) then
        if HasRelativeIndeterminatesOfPolynomialRing( R ) then
            var := RelativeIndeterminatesOfPolynomialRing( R );
            B := BaseRing( R );
            if HasIndeterminatesOfPolynomialRing( B ) then
                base := IndeterminatesOfPolynomialRing( B );
            else
                base := [ ];
            fi;
            weights := Concatenation( ListWithIdenticalEntries( Length( base ), 0 ), ListWithIdenticalEntries( Length( var ), 1 ) );
        else
            var := RelativeIndeterminatesOfPolynomialRing( R );
            weights := ListWithIdenticalEntries( Length( var ), 1 );
        fi;
        
        return RingElementConstructor( R )( RP!.MaximalDegreePart( r, weights ), R );
        
    fi;
    
    d := Degree( r );
    
    coeffs := Coefficients( r );
    
    monoms := coeffs!.monomials;
    
    coeffs := EntriesOfHomalgMatrix( coeffs );
    
    plist := Positions( List( monoms, Degree ), d );
    
    return coeffs{plist} * monoms{plist};
    
end );

##
InstallMethod( MaximalDegreePartOfColumnMatrix,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R;
    
    if not NrColumns( M ) = 1 then
        Error( "the number of columns is not 1\n" );
    fi;
    
    if IsZero( M ) then
        return M;
    fi;
    
    R := HomalgRing( M );
    
    M := List( EntriesOfHomalgMatrix( M ), MaximalDegreePart );
    
    return HomalgMatrix( M, Length( M ), 1, R );
    
end );
