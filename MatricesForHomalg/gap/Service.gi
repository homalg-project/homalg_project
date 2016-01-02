#############################################################################
##
##  Service.gi                  MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg service procedures.
##
#############################################################################

####################################
#
# global variables:
#
####################################

HOMALG_MATRICES.colored_info :=
  rec(
      ## Basic Operations:
      
      ## reduced Echelon form
      RowReducedEchelonForm := [ 4, HOMALG_MATRICES.colors.BOE ],
      ColumnReducedEchelonForm := [ 4, HOMALG_MATRICES.colors.BOE ],
      ## Basis
      BasisOfRowModule := [ 3, HOMALG_MATRICES.colors.BOB ],
      BasisOfColumnModule := [ 3, HOMALG_MATRICES.colors.BOB ],
      ## BasisCoeff
      BasisOfRowsCoeff := [ 3, HOMALG_MATRICES.colors.BOB ],
      BasisOfColumnsCoeff := [ 3, HOMALG_MATRICES.colors.BOB ],
      
      ## partially reduced Basis
      PartiallyReducedBasisOfRowModule := [ 3, HOMALG_MATRICES.colors.BOB ],
      PartiallyReducedBasisOfColumnModule := [ 3, HOMALG_MATRICES.colors.BOB ],
      ## reduced Basis
      ReducedBasisOfRowModule := [ 3, HOMALG_MATRICES.colors.BOB ],
      ReducedBasisOfColumnModule := [ 3, HOMALG_MATRICES.colors.BOB ],
      
      ## Decide zero
      DecideZeroRows := [ 2, HOMALG_MATRICES.colors.BOD ],
      DecideZeroColumns := [ 2, HOMALG_MATRICES.colors.BOD ],
      ## Decide zero effectively
      DecideZeroRowsEffectively := [ 2, HOMALG_MATRICES.colors.BOD ],
      DecideZeroColumnsEffectively := [ 2, HOMALG_MATRICES.colors.BOD ],
      
      ## solutions of Homogeneous system
      SyzygiesGeneratorsOfRows := [ 2, HOMALG_MATRICES.colors.BOH ],
      SyzygiesGeneratorsOfColumns := [ 2, HOMALG_MATRICES.colors.BOH ],
      ## relative solutions of Homogeneous system
      RelativeSyzygiesGeneratorsOfRows := [ 2, HOMALG_MATRICES.colors.BOH ],
      RelativeSyzygiesGeneratorsOfColumns := [ 2, HOMALG_MATRICES.colors.BOH ],
      ## reduced solutions of Homogeneous system
      ReducedSyzygiesGeneratorsOfRows := [ 2, HOMALG_MATRICES.colors.BOH ],
      ReducedSyzygiesGeneratorsOfColumns := [ 2, HOMALG_MATRICES.colors.BOH ],
      );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( ColoredInfoForService,
  function( arg )
    local nargs, a, string, l, color, s;
    
    nargs := Length( arg );
    
    a := arg[2];
    
    if IsString( a ) then
        string := a;
        if IsBound( HOMALG_MATRICES.colored_info.(string) ) then
            l := HOMALG_MATRICES.colored_info.(string)[1];
            color := HOMALG_MATRICES.colored_info.(string)[2];
        else
            l := 2;
            color := "\033[1m";
        fi;
    elif IsList( a ) and Length( a ) = 2 and IsString( a[1] ) and IsRecord( a[2] ) then
        string := a[1];
        if IsBound( a[2].(string) ) then
            l := a[2].(string)[1];
            color := a[2].(string)[2];
        else
            l := 2;
            color := "\033[1m";
        fi;
    else
        string := "unknown";
        l := 2;
        color := "\033[1m";
    fi;
    
    if arg[1] = "busy" then
        
        s := Concatenation( HOMALG_MATRICES.colors.busy, "BUSY>\033[0m ", color );
        
        s := Concatenation( s, string, "\033[0m \033[7m", color );
        
        Append( s, Concatenation( List( arg{[ 3 .. nargs ]}, function( a ) if IsStringRep( a ) then return a; else return String( a ); fi; end ) ) );
        
        s := Concatenation( s, "\033[0m " );
        
        if l < 4 then
            Info( InfoHomalgBasicOperations, l , "" );
        fi;
        
        Info( InfoHomalgBasicOperations, l, s );
    
    else
        
        s := Concatenation( HOMALG_MATRICES.colors.done, "<DONE\033[0m ", color );
        
        s := Concatenation( s, string, "\033[0m \033[7m", color );
        
        Append( s, Concatenation( List( arg{[ 3 .. nargs ]}, function( a ) if IsStringRep( a ) then return a; else return String( a ); fi; end ) ) );
        
        s := Concatenation( s, "\033[0m ", "	in ", homalgTotalRuntimes( arg[1], "" ) );
        
        Info( InfoHomalgBasicOperations, l, s );
    
        if l < 4 then
            Info( InfoHomalgBasicOperations, l , "" );
        fi;
        
    fi;
    
end );

####################################
#
# methods for operations:
#
####################################

################################################################
##
## CAUTION: !!!
##
## the following procedures never take ring relations into
## account and hence should never be part of a homalgTable
## of a homalg residue class ring
##
################################################################

##
InstallMethod( RowReducedEchelonForm,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    ColoredInfoForService( "busy", "RowReducedEchelonForm", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
    
    t := homalgTotalRuntimes( );
    
    if IsBound(RP!.RowReducedEchelonForm) then
        
        B := RP!.RowReducedEchelonForm( M );
        
        ColoredInfoForService( t, "RowReducedEchelonForm", Length( NonZeroRows( B ) ) );
        
        return B;
        
    elif IsBound(RP!.ColumnReducedEchelonForm) then
        
        B := Involution( RP!.ColumnReducedEchelonForm( Involution( M ) ) );
        
        ColoredInfoForService( t, "RowReducedEchelonForm", Length( NonZeroRows( B ) ) );
        
        return B;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RowReducedEchelonForm,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    ColoredInfoForService( "busy", "RowReducedEchelonForm (M,T)", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
    
    t := homalgTotalRuntimes( );
    
    if IsBound(RP!.RowReducedEchelonForm) then
        
        B := RP!.RowReducedEchelonForm( M, T );
        
        ColoredInfoForService( t, "RowReducedEchelonForm (M,T)", Length( NonZeroRows( B ) ) );
        
        return B;
        
    elif IsBound(RP!.ColumnReducedEchelonForm) then
        
        TI := HomalgVoidMatrix( R );
        
        B := Involution( RP!.ColumnReducedEchelonForm( Involution( M ), TI ) );
        
        ColoredInfoForService( t, "RowReducedEchelonForm (M,T)", Length( NonZeroRows( B ) ) );
        
        SetPreEval( T, Involution( TI ) ); ResetFilterObj( T, IsVoidMatrix );
        
        return B;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ColumnReducedEchelonForm,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ColumnReducedEchelonForm) then
        
        t := homalgTotalRuntimes( );
        
        ColoredInfoForService( "busy", "ColumnReducedEchelonForm", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
        
        B := RP!.ColumnReducedEchelonForm( M );
        
        ColoredInfoForService( t, "ColumnReducedEchelonForm", Length( NonZeroColumns( B ) ) );
        
        return B;
        
    fi;
    
    B := Involution( RowReducedEchelonForm( Involution( M ) ) );
    
    return B;
    
end );

##
InstallMethod( ColumnReducedEchelonForm,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ColumnReducedEchelonForm) then
        
        t := homalgTotalRuntimes( );
        
        ColoredInfoForService( "busy", "ColumnReducedEchelonForm (M,T)", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
        
        B := RP!.ColumnReducedEchelonForm( M, T );
        
        ColoredInfoForService( t, "ColumnReducedEchelonForm (M,T)", Length( NonZeroColumns( B ) ) );
        
        return B;
        
    fi;
    
    TI := HomalgVoidMatrix( R );
    
    B := Involution( RowReducedEchelonForm( Involution( M ), TI ) );
    
    SetPreEval( T, Involution( TI ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return B;
    
end );

#### Basis, DecideZero, Syzygies:

##  <#GAPDoc Label="BasisOfRowModule">
##  <ManSection>
##    <Oper Arg="M" Name="BasisOfRowModule" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <M>R</M> be the ring over which <A>M</A> is defined (<M>R:=</M><C>HomalgRing</C>( <A>M</A> )) and
##      <M>S</M> be the row span of <A>M</A>, i.e. the <M>R</M>-submodule of the free module
##      <M>R^{(1 \times NrColumns( <A>M</A> ))}</M> spanned by the rows of <A>M</A>. A solution to the
##      <Q>submodule membership problem</Q> is an algorithm which can decide if an element <M>m</M> in
##      <M>R^{(1 \times NrColumns( <A>M</A> ))}</M> is contained in <M>S</M> or not. And exactly like
##      the Gaussian (resp. Hermite) normal form when <M>R</M> is a field (resp. principal ideal ring), the row span of
##      the resulting matrix <M>B</M> coincides with the row span <M>S</M> of <A>M</A>, and computing <M>B</M> is typically
##      the first step of such an algorithm. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfRowModule,		### defines: BasisOfRowModule (BasisOfModule (low-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, nr_cols, nr_rows, MI, B, nz;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    nr_cols := NrColumns( M );
    
    ColoredInfoForService( "busy", "BasisOfRowModule", NrRows( M ), " x ", nr_cols, " : ", RingName( R ) );
    
    if IsBound(RP!.BasisOfRowModule) then
        
        B := RP!.BasisOfRowModule( M );
        
        if HasRowRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr_cols );
        
        nr_rows := NrRows( B );
        
        if HasIsZero( M ) and not IsZero( M ) then
            
            ## check assertion
            Assert( 6, IsZero( B ) = IsZero( M ) );
            
            SetIsZero( B, false );
            
        elif nr_rows = 1 and IsZero( B ) then
            
            ## most computer algebra systems do not support empty matrices
            ## and return for a trivial BasisOfRowModule a one-row zero matrix
            
            B := HomalgZeroMatrix( 0, nr_cols, R );
            
            SetIsZero( M, true );
            
        else
            
            ## check assertion
            Assert( 6, R!.asserts.BasisOfRowModule( B ) );
            
            SetIsZero( B, nr_rows = 0 );
            SetIsZero( M, nr_rows = 0 );
            
        fi;
        
        SetIsBasisOfRowsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfRowModule", NrRows( B ) );
        
        IncreaseRingStatistics( R, "BasisOfRowModule" );
        
        return B;
        
    elif IsBound(RP!.BasisOfColumnModule) then
        
        MI := Involution( M );
        
        B := RP!.BasisOfColumnModule( MI );
        
        if HasColumnRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr_cols );
        
        nr_rows := NrColumns( B );	## this is not a mistake
        
        if HasIsZero( M ) and not IsZero( M ) then
            
            ## check assertion
            Assert( 6, IsZero( B ) = IsZero( M ) );
            
            SetIsZero( B, false );
            
        elif nr_rows = 1 and IsZero( B ) then
            
            ## most computer algebra systems do not support empty matrices
            ## and return for a trivial BasisOfColumnModule a one-column zero matrix
            
            B := HomalgZeroMatrix( nr_cols, 0, R );
            
            SetIsZero( M, true );
            
        else
            
            ## check assertion
            Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
            
            SetIsZero( B, nr_rows = 0 );
            SetIsZero( M, nr_rows = 0 );
            
        fi;
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        SetBasisOfColumnModule( MI, B );
        
        B := Involution( B );
        
        SetIsBasisOfRowsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfRowModule", NrRows( B ) );
        
        DecreaseRingStatistics( R, "BasisOfRowModule" );
        
        IncreaseRingStatistics( R, "BasisOfColumnModule" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    B := RowReducedEchelonForm( M );
    
    nz := Length( NonZeroRows( B ) );
    
    if nz = 0 then
        B := HomalgZeroMatrix( 0, NrColumns( B ), R );
    else
        B := CertainRows( B, [ 1 .. nz ] );
    fi;
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfRowModule( B ) );
    
    nr_rows := NrRows( B );
    
    SetIsZero( B, nr_rows = 0 );
    SetIsZero( M, nr_rows = 0 );
    
    SetIsBasisOfRowsMatrix( B, true );
    
    ColoredInfoForService( t, "BasisOfRowModule", NrRows( B ) );
    
    IncreaseRingStatistics( R, "BasisOfRowModule" );
    
    return B;
    
end );

##  <#GAPDoc Label="BasisOfColumnModule">
##  <ManSection>
##    <Oper Arg="M" Name="BasisOfColumnModule" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <M>R</M> be the ring over which <A>M</A> is defined (<M>R:=</M><C>HomalgRing</C>( <A>M</A> )) and
##      <M>S</M> be the column span of <A>M</A>, i.e. the <M>R</M>-submodule of the free module
##      <M>R^{(NrRows( <A>M</A> ) \times 1)}</M> spanned by the columns of <A>M</A>. A solution to the
##      <Q>submodule membership problem</Q> is an algorithm which can decide if an element <M>m</M> in
##      <M>R^{(NrRows( <A>M</A> ) \times 1)}</M> is contained in <M>S</M> or not. And exactly like
##      the Gaussian (resp. Hermite) normal form when <M>R</M> is a field (resp. principal ideal ring), the column span of
##      the resulting matrix <M>B</M> coincides with the column span <M>S</M> of <A>M</A>, and computing <M>B</M> is typically
##      the first step of such an algorithm. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfColumnModule,		### defines: BasisOfColumnModule (BasisOfModule (low-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, nr_rows, nr_cols, MI, B, nz;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    nr_rows := NrRows( M );
    
    ColoredInfoForService( "busy", "BasisOfColumnModule", nr_rows, " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(RP!.BasisOfColumnModule) then
        
        B := RP!.BasisOfColumnModule( M );
        
        if HasColumnRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr_rows );
        
        nr_cols := NrColumns( B );
        
        if HasIsZero( M ) and not IsZero( M ) then
            
            ## check assertion
            Assert( 6, IsZero( B ) = IsZero( M ) );
            
            SetIsZero( B, false );
            
        elif nr_cols = 1 and IsZero( B ) then
            
            ## most computer algebra systems do not support empty matrices
            ## and return for a trivial BasisOfColumnModule a one-column zero matrix
            
            B := HomalgZeroMatrix( nr_rows, 0, R );
            
            SetIsZero( M, true );
            
        else
            
            ## check assertion
            Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
            
            SetIsZero( B, nr_cols = 0 );
            SetIsZero( M, nr_cols = 0 );
            
        fi;
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfColumnModule", NrColumns( B ) );
        
        IncreaseRingStatistics( R, "BasisOfColumnModule" );
        
        return B;
        
    elif IsBound(RP!.BasisOfRowModule) then
        
        MI := Involution( M );
        
        B := RP!.BasisOfRowModule( MI );
        
        if HasRowRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr_rows );
        
        nr_cols := NrRows( B );		## this is not a mistake
        
        if HasIsZero( M ) and not IsZero( M ) then
            
            ## check assertion
            Assert( 6, IsZero( B ) = IsZero( M ) );
            
            SetIsZero( B, false );
            
        elif nr_cols = 1 and IsZero( B ) then
            
            ## most computer algebra systems do not support empty matrices
            ## and return for a trivial BasisOfRowModule a one-row zero matrix
            
            B := HomalgZeroMatrix( 0, nr_rows, R );
            
            SetIsZero( M, true );
            
        else
            
            ## check assertion
            Assert( 6, R!.asserts.BasisOfRowModule( B ) );
            
            SetIsZero( B, nr_cols = 0 );
            SetIsZero( M, nr_cols = 0 );
            
        fi;
        
        SetIsBasisOfRowsMatrix( B, true );
        
        SetBasisOfRowModule( MI, B );
        
        B := Involution( B );
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfColumnModule", NrColumns( B ) );
        
        DecreaseRingStatistics( R, "BasisOfColumnModule" );
        
        IncreaseRingStatistics( R, "BasisOfRowModule" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    B := ColumnReducedEchelonForm( M );
    
    nz := Length( NonZeroColumns( B ) );
    
    if nz = 0 then
        B := HomalgZeroMatrix( NrRows( B ), 0, R );
    else
        B := CertainColumns( B, [ 1 .. nz ] );
    fi;
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
    
    nr_cols := NrColumns( B );
    
    SetIsZero( B, nr_cols = 0 );
    SetIsZero( M, nr_cols = 0 );
    
    SetIsBasisOfColumnsMatrix( B, true );
    
    ColoredInfoForService( t, "BasisOfColumnModule", NrColumns( B ) );
    
    IncreaseRingStatistics( R, "BasisOfColumnModule" );
    
    return B;
    
end );

##  <#GAPDoc Label="DecideZeroRows">
##  <ManSection>
##    <Oper Arg="A, B" Name="DecideZeroRows" Label="for pairs of matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <A>A</A> and <A>B</A> be matrices having the same number of columns and defined over the same ring <M>R</M>
##      (<M>:=</M><C>HomalgRing</C>( <A>A</A> )) and <M>S</M> be the row span of <A>B</A>,
##      i.e. the <M>R</M>-submodule of the free module <M>R^{(1 \times NrColumns( <A>B</A> ))}</M>
##      spanned by the rows of <A>B</A>. The result is a matrix <M>C</M> having the same shape as <A>A</A>,
##      for which the <M>i</M>-th row <M><A>C</A>^i</M> is equivalent to the <M>i</M>-th row <M><A>A</A>^i</M> of <A>A</A> modulo <M>S</M>,
##      i.e. <M><A>C</A>^i-<A>A</A>^i</M> is an element of the row span <M>S</M> of <A>B</A>. Moreover, the row <M><A>C</A>^i</M> is zero,
##      if and only if the row <M><A>A</A>^i</M> is an element of <M>S</M>. So <C>DecideZeroRows</C> decides which rows of <A>A</A>
##      are zero modulo the rows of <A>B</A>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DecideZeroRows,			### defines: DecideZeroRows (Reduce)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, RP, t, l, m, n, id, zz, M, C;
    
    ## we can only reduce with respect to a distinguished basis
    B := BasisOfRowModule( B );
    
    if IsBound( A!.DecideZeroRows ) and
       IsIdenticalObj( A!.DecideZeroRows, B ) then
        
        return A;
        
    fi;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        if IsBound( B!.DecideZeroRows ) then
            C := _ElmWPObj_ForHomalg( B!.DecideZeroRows, A, fail );
            if C <> fail then
                return C;
            fi;
        else
            B!.DecideZeroRows :=
              ContainerForWeakPointers(
                      TheTypeContainerForWeakPointersOnComputedValues,
                      [ "operation", "DecideZeroRows" ] );
        fi;
    fi;
    
    ### causes many IsZero external calls without
    ### reducing the effective number of DecideZero calls;
    ### observed with Purity.g in ExamplesForHomalg
    ## if IsZero( A ) or IsZero( B ) then
    ##     ## dispatch to the immediate methods
    ##     return DecideZeroRows( A, B );
    ## fi;
    
    R := HomalgRing( B );
    
    R!.asserts.DecideZeroRowsWRTNonBasis( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    l := NrRows( A );
    m := NrColumns( A );
    
    n := NrRows( B );
    
    ColoredInfoForService( "busy", "DecideZeroRows", "( ", l, " + ", n, " ) x ", m, " : ", RingName( R ) );
    
    if IsBound(RP!.DecideZeroRows) then
        
        C := RP!.DecideZeroRows( A, B );
        
        SetNrRows( C, l ); SetNrColumns( C, m );
        
        if not IsZero( C ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        C!.DecideZeroRows := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroRows, A, C );
        fi;
        
        ColoredInfoForService( t, "DecideZeroRows" );
        
        IncreaseRingStatistics( R, "DecideZeroRows" );
        
        return C;
        
    elif IsBound(RP!.DecideZeroColumns) then
        
        C := RP!.DecideZeroColumns( Involution( A ), Involution( B ) );
        
        SetNrRows( C, m ); SetNrColumns( C, l );
        
        if not IsZero( C ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        C := Involution( C );
        
        C!.DecideZeroRows := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroRows, A, C );
        fi;
        
        ColoredInfoForService( t, "DecideZeroRows" );
        
        DecreaseRingStatistics( R, "DecideZeroRows" );
        
        IncreaseRingStatistics( R, "DecideZeroColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if HasIsOne( A ) and IsOne( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( n, l, R );
    
    M := UnionOfRows( UnionOfColumns( id, A ), UnionOfColumns( zz, B ) );
    
    M := RowReducedEchelonForm( M );
    
    C := CertainRows( CertainColumns( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    if not IsZero( C ) then
        Assert( 6, not IsZero( A ) );
        SetIsZero( A, false );
    fi;
    
    C!.DecideZeroRows := B;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        _AddTwoElmWPObj_ForHomalg( B!.DecideZeroRows, A, C );
    fi;
    
    ColoredInfoForService( t, "DecideZeroRows" );
    
    IncreaseRingStatistics( R, "DecideZeroRows" );
    
    return C;
    
end );

##  <#GAPDoc Label="DecideZeroColumns">
##  <ManSection>
##    <Oper Arg="A, B" Name="DecideZeroColumns" Label="for pairs of matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <A>A</A> and <A>B</A> be matrices having the same number of rows and defined over the same ring <M>R</M>
##      (<M>:=</M><C>HomalgRing</C>( <A>A</A> )) and <M>S</M> be the column span of <A>B</A>,
##      i.e. the <M>R</M>-submodule of the free module <M>R^{(NrRows( <A>B</A> ) \times 1)}</M>
##      spanned by the columns of <A>B</A>. The result is a matrix <M>C</M> having the same shape as <A>A</A>,
##      for which the <M>i</M>-th column <M><A>C</A>_i</M> is equivalent to the <M>i</M>-th column <M><A>A</A>_i</M> of <A>A</A>
##      modulo <M>S</M>, i.e. <M><A>C</A>_i-<A>A</A>_i</M> is an element of the column span <M>S</M> of <A>B</A>. Moreover,
##      the column <M><A>C</A>_i</M> is zero, if and only if the column <M><A>A</A>_i</M> is an element of <M>S</M>.
##      So <C>DecideZeroColumns</C> decides which columns of <A>A</A> are zero modulo the columns of <A>B</A>.
##      (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DecideZeroColumns,		### defines: DecideZeroColumns (Reduce)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, RP, t, l, m, n, id, zz, M, C;
    
    ## we can only reduce with respect to a distinguished basis
    B := BasisOfColumnModule( B );
    
    if IsBound( A!.DecideZeroColumns ) and
       IsIdenticalObj( A!.DecideZeroColumns, B ) then
        
        return A;
        
    fi;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        if IsBound( B!.DecideZeroColumns ) then
            C := _ElmWPObj_ForHomalg( B!.DecideZeroColumns, A, fail );
            if C <> fail then
                return C;
            fi;
        else
            B!.DecideZeroColumns :=
              ContainerForWeakPointers(
                      TheTypeContainerForWeakPointersOnComputedValues,
                      [ "operation", "DecideZeroColumns" ] );
        fi;
    fi;
    
    ### causes many IsZero external calls without
    ### reducing the effective number of DecideZero calls;
    ### observed with Purity.g in ExamplesForHomalg
    ## if IsZero( A ) or IsZero( B ) then
    ##     ## dispatch to the immediate methods
    ##     return DecideZeroColumns( A, B );
    ## fi;
    
    R := HomalgRing( B );
    
    R!.asserts.DecideZeroColumnsWRTNonBasis( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    l := NrColumns( A );
    m := NrRows( A );
    
    n := NrColumns( B );
    
    ColoredInfoForService( "busy", "DecideZeroColumns", m, " x ( ", l, " + ", n, " ) : ", RingName( R ) );
    
    if IsBound(RP!.DecideZeroColumns) then
        
        C := RP!.DecideZeroColumns( A, B );
        
        SetNrRows( C, m ); SetNrColumns( C, l );
        
        if not IsZero( C ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        C!.DecideZeroColumns := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroColumns, A, C );
        fi;
        
        ColoredInfoForService( t, "DecideZeroColumns" );
        
        IncreaseRingStatistics( R, "DecideZeroColumns" );
        
        return C;
        
    elif IsBound(RP!.DecideZeroRows) then
        
        C := RP!.DecideZeroRows( Involution( A ), Involution( B ) );
        
        SetNrRows( C, l ); SetNrColumns( C, m );
        
        if not IsZero( C ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        C := Involution( C );
        
        C!.DecideZeroColumns := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroColumns, A, C );
        fi;
        
        ColoredInfoForService( t, "DecideZeroColumns" );
        
        DecreaseRingStatistics( R, "DecideZeroColumns" );
        
        IncreaseRingStatistics( R, "DecideZeroRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if HasIsOne( A ) and IsOne( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( l, n, R );
    
    M := UnionOfColumns( UnionOfRows( id, A ), UnionOfRows( zz, B ) );
    
    M := ColumnReducedEchelonForm( M );
    
    C := CertainColumns( CertainRows( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    if not IsZero( C ) then
        Assert( 6, not IsZero( A ) );
        SetIsZero( A, false );
    fi;
    
    C!.DecideZeroColumns := B;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        _AddTwoElmWPObj_ForHomalg( B!.DecideZeroColumns, A, C );
    fi;
    
    ColoredInfoForService( t, "DecideZeroColumns" );
    
    IncreaseRingStatistics( R, "DecideZeroColumns" );
    
    return C;
    
end );

##  <#GAPDoc Label="SyzygiesGeneratorsOfRows">
##  <ManSection>
##    <Oper Arg="M" Name="SyzygiesGeneratorsOfRows" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <M>R</M> be the ring over which <A>M</A> is defined (<M>R:=</M><C>HomalgRing</C>( <A>M</A> )).
##      The matrix of row syzygies <C>SyzygiesGeneratorsOfRows</C>( <A>M</A> ) is a matrix whose rows span
##      the left kernel of <A>M</A>, i.e. the <M>R</M>-submodule of the free module <M>R^{(1 \times NrRows( <A>M</A> ))}</M>
##      consisting of all rows <M>X</M> satisfying <M>X<A>M</A>=0</M>.
##      (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, MI, C, B, nz;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "SyzygiesGeneratorsOfRows", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(R!.ComputeBasisBeforeSyzygies) and R!.ComputeBasisBeforeSyzygies = true then
        BasisOfRowModule( M );
    fi;
    
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := RP!.SyzygiesGeneratorsOfRows( M );
        
        if IsZero( C ) then
            
            SetIsLeftRegular( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );	## most of the computer algebra systems cannot handle degenerated matrices
            
        else
            
            SetNrColumns( C, NrRows( M ) );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        MI := Involution( M );
        
        C := RP!.SyzygiesGeneratorsOfColumns( MI );
        
        SetSyzygiesGeneratorsOfColumns( MI, C );
        
        C := Involution( C );
        
        if IsZero( C ) then
            
            SetIsLeftRegular( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );	## most of the computer algebra systems cannot handle degenerated matrices
            
        else
            
            SetNrColumns( C, NrRows( M ) );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
        
        DecreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := HomalgVoidMatrix( R );
    
    B := RowReducedEchelonForm( M, C );
    
    nz := Length( NonZeroRows( B ) );
    
    C := CertainRows( C, [ nz + 1 .. NrRows( C ) ] );
    
    if IsZero( C ) then
        
        SetIsLeftRegular( M, true );
        
        C := HomalgZeroMatrix( 0, NrRows( M ), R );
        
    fi;
    
    ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
    
    IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
    
    return C;
    
end );

##  <#GAPDoc Label="SyzygiesGeneratorsOfColumns">
##  <ManSection>
##    <Oper Arg="M" Name="SyzygiesGeneratorsOfColumns" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <M>R</M> be the ring over which <A>M</A> is defined (<M>R:=</M><C>HomalgRing</C>( <A>M</A> )).
##      The matrix of column syzygies <C>SyzygiesGeneratorsOfColumns</C>( <A>M</A> ) is a matrix whose columns span
##      the right kernel of <A>M</A>, i.e. the <M>R</M>-submodule of the free module <M>R^{(NrColumns( <A>M</A> ) \times 1)}</M>
##      consisting of all columns <M>X</M> satisfying <M><A>M</A>X=0</M>.
##      (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, MI, C, B, nz;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "SyzygiesGeneratorsOfColumns", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(R!.ComputeBasisBeforeSyzygies) and R!.ComputeBasisBeforeSyzygies = true then
        BasisOfColumnModule( M );
    fi;
    
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := RP!.SyzygiesGeneratorsOfColumns( M );
        
        if IsZero( C ) then
            
            SetIsRightRegular( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M ) );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        MI := Involution( M );
        
        C := RP!.SyzygiesGeneratorsOfRows( MI );
        
        SetSyzygiesGeneratorsOfRows( MI, C );
        
        C := Involution( C );
        
        if IsZero( C ) then
            
            SetIsRightRegular( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M ) );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        DecreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := HomalgVoidMatrix( R );
    
    B := ColumnReducedEchelonForm( M, C );
    
    nz := Length( NonZeroColumns( B ) );
    
    C := CertainColumns( C, [ nz + 1 .. NrColumns( C ) ] );
    
    if IsZero( C ) then
        
        SetIsRightRegular( M, true );
        
        C := HomalgZeroMatrix( NrColumns( M ), 0, R );
        
    fi;
    
    ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
    
    IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
    
    return C;
    
end );

#### Relative:

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfRows">
##  <ManSection>
##    <Oper Arg="M, M2" Name="SyzygiesGeneratorsOfRows" Label="for pairs of matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <M>R</M> be the ring over which <A>M</A> is defined (<M>R:=</M><C>HomalgRing</C>( <A>M</A> )).
##      The matrix of <E>relative</E> row syzygies <C>SyzygiesGeneratorsOfRows</C>( <A>M</A>, <A>M2</A> ) is a matrix
##      whose rows span the left kernel of <A>M</A> modulo <A>M2</A>, i.e. the <M>R</M>-submodule of the free module
##      <M>R^{(1 \times NrRows( <A>M</A> ))}</M> consisting of all rows <M>X</M> satisfying <M>X<A>M</A>+Y<A>M2</A>=0</M>
##      for some row <M>Y \in R^{(1 \times NrRows( <A>M2</A> ))}</M>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SyzygiesGeneratorsOfRows,	### defines: SyzygiesGeneratorsOfRows (SyzygiesGenerators)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, t, M, C, nz;
    
    ## a LIMAT method takes care of the case when M2 is _known_ to be zero
    ## checking IsZero( M2 ) causes too many obsolete calls
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "RelativeSyzygiesGeneratorsOfRows", "( ", NrRows( M1 ), " + ", NrRows( M2 ), " ) x ", NrColumns( M1 ), " : ", RingName( R ) );
    
    if IsBound(R!.ComputeBasisBeforeSyzygies) and R!.ComputeBasisBeforeSyzygies = true then
        BasisOfRowModule( M1 );
        BasisOfRowModule( M2 );
    fi;
    
    if IsBound(RP!.RelativeSyzygiesGeneratorsOfRows) then
        
        C := RP!.RelativeSyzygiesGeneratorsOfRows( M1, M2 );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
            
        else
            
            SetNrColumns( C, NrRows( M1 ) );
            
        fi;
        
        ColoredInfoForService( t, "RelativeSyzygiesGeneratorsOfRows", NrRows( C ) );
        
        IncreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.RelativeSyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.RelativeSyzygiesGeneratorsOfColumns( Involution( M1 ), Involution( M2 ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
            
        else
            
            SetNrColumns( C, NrRows( M1 ) );
            
        fi;
        
        ColoredInfoForService( t, "RelativeSyzygiesGeneratorsOfRows", NrRows( C ) );
        
        DecreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfRows" );
        
        IncreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := UnionOfRows( M1, M2 );
    
    C := SyzygiesGeneratorsOfRows( M );
    
    C := CertainColumns( C, [ 1 .. NrRows( M1 ) ] );
    
    ## since we first compute the syzygies matrix of
    ## the stack of M1 and M2, and then keep only
    ## those columns C corresponding to M1,
    ## zero rows can potentially exist in C
    ## (and we like to remove them)
    
    C := GetRidOfObsoleteRows( C );
    
    if IsZero( C ) then
        
        SetIsLeftRegular( M1, true );
        
    fi;
    
    ## forgetting the original obsolete C may save memory
    if HasEvalCertainColumns( C ) then
        if not IsEmptyMatrix( C ) then
            Eval( C );
        fi;
        ResetFilterObj( C, EvalCertainColumns );
        Unbind( C!.EvalCertainColumns );
    fi;
    
    ColoredInfoForService( t, "RelativeSyzygiesGeneratorsOfRows", NrRows( C ) );
    
    DecreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfRows" );
    
    return C;
    
end );

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfColumns">
##  <ManSection>
##    <Oper Arg="M, M2" Name="SyzygiesGeneratorsOfColumns" Label="for pairs of matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <M>R</M> be the ring over which <A>M</A> is defined (<M>R:=</M><C>HomalgRing</C>( <A>M</A> )).
##      The matrix of <E>relative</E> column syzygies <C>SyzygiesGeneratorsOfColumns</C>( <A>M</A>, <A>M2</A> ) is a matrix
##      whose columns span the right kernel of <A>M</A> modulo <A>M2</A>, i.e. the <M>R</M>-submodule of the free module
##      <M>R^{(NrColumns( <A>M</A> ) \times 1)}</M> consisting of all columns <M>X</M> satisfying <M><A>M</A>X+<A>M2</A>Y=0</M>
##      for some column <M>Y \in R^{(NrColumns( <A>M2</A> ) \times 1)}</M>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SyzygiesGeneratorsOfColumns,	### defines: SyzygiesGeneratorsOfColumns (SyzygiesGenerators)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, t, M, C, nz;
    
    ## a LIMAT method takes care of the case when M2 is _known_ to be zero
    ## checking IsZero( M2 ) causes too many obsolete calls
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "RelativeSyzygiesGeneratorsOfColumns", NrRows( M1 ), " x ( ", NrColumns( M1 ), " + ", NrColumns( M2 ), " ) : ", RingName( R ) );
    
    if IsBound(R!.ComputeBasisBeforeSyzygies) and R!.ComputeBasisBeforeSyzygies = true then
        BasisOfColumnModule( M1 );
        BasisOfColumnModule( M2 );
    fi;
    
    if IsBound(RP!.RelativeSyzygiesGeneratorsOfColumns) then
        
        C := RP!.RelativeSyzygiesGeneratorsOfColumns( M1, M2 );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M1 ) );
            
        fi;
        
        ColoredInfoForService( t, "RelativeSyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        IncreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.RelativeSyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.RelativeSyzygiesGeneratorsOfRows( Involution( M1 ), Involution( M2 ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M1 ) );
            
        fi;
        
        ColoredInfoForService( t, "RelativeSyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        DecreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfColumns" );
        
        IncreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := UnionOfColumns( M1, M2 );
    
    C := SyzygiesGeneratorsOfColumns( M );
    
    C := CertainRows( C, [ 1 .. NrColumns( M1 ) ] );
    
    ## since we first computes the syzygies matrix of
    ## the augmentation of M1 and M2, and then keep
    ## only those rows C corresponding to M1,
    ## zero columns can potentially exist in C
    ## (and we like to remove them)
    
    C := GetRidOfObsoleteColumns( C );
    
    if IsZero( C ) then
        
        SetIsRightRegular( M1, true );
        
    fi;
    
    ## forgetting the original obsolete C may save memory
    if HasEvalCertainRows( C ) then
        if not IsEmptyMatrix( C ) then
            Eval( C );
        fi;
        ResetFilterObj( C, EvalCertainRows );
        Unbind( C!.EvalCertainRows );
    fi;
    
    ColoredInfoForService( t, "RelativeSyzygiesGeneratorsOfColumns", NrColumns( C ) );
    
    DecreaseRingStatistics( R, "RelativeSyzygiesGeneratorsOfColumns" );
    
    return C;
    
end );

#### Reduced:

##  <#GAPDoc Label="ReducedBasisOfRowModule">
##  <ManSection>
##    <Oper Arg="M" Name="ReducedBasisOfRowModule" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Like <C>BasisOfRowModule</C>( <A>M</A> ) but where the matrix
##      <C>SyzygiesGeneratorsOfRows</C>( <C>ReducedBasisOfRowModule</C>( <A>M</A> ) ) contains no units. This can easily
##      be achieved starting from <M>B:=</M><C>BasisOfRowModule</C>( <A>M</A> )
##      (and using <Ref Oper="GetColumnIndependentUnitPositions" Label="for matrices"/> applied to the matrix of row syzygies of <M>B</M>,
##       etc). (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ReducedBasisOfRowModule,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, nr, MI, B, S, unit_pos;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    nr := NrColumns( M );
    
    ColoredInfoForService( "busy", "ReducedBasisOfRowModule", NrRows( M ), " x ", nr, " : ", RingName( R ) );
    
    if IsBound(RP!.ReducedBasisOfRowModule) then
        
        B := RP!.ReducedBasisOfRowModule( M );
        
        if HasRowRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowModule( B ) );
        
        nr := NrRows( B );
        
        SetIsZero( B, nr = 0 );
        
        if M = B then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfRowModule( M, B ) );
        fi;
        
        SetIsReducedBasisOfRowsMatrix( B, true );
        
        ColoredInfoForService( t, "ReducedBasisOfRowModule", NrRows( B ) );
        
        IncreaseRingStatistics( R, "ReducedBasisOfRowModule" );
        
        return B;
        
    elif IsBound(RP!.ReducedBasisOfColumnModule) then
        
        MI := Involution( M );
        
        B := RP!.ReducedBasisOfColumnModule( MI );
        
        if HasColumnRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr );
        
        SetIsReducedBasisOfColumnsMatrix( B, true );
        
        SetReducedBasisOfColumnModule( MI, B );
        
        B := Involution( B );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowModule( B ) );
        
        nr := NrRows( B );
        
        SetIsZero( B, nr = 0 );
        
        if M = B then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfRowModule( M, B ) );
        fi;
        
        SetIsReducedBasisOfRowsMatrix( B, true );
        
        ColoredInfoForService( t, "ReducedBasisOfRowModule", NrRows( B ) );
        
        DecreaseRingStatistics( R, "ReducedBasisOfRowModule" );
        
        IncreaseRingStatistics( R, "ReducedBasisOfColumnModule" );
        
        return B;
        
    fi;
    
    ## try RP!.PartiallyReducedBasisOf*Module
    if IsBound(RP!.PartiallyReducedBasisOfRowModule) then
        
        B := RP!.PartiallyReducedBasisOfRowModule( M );
        
        if HasRowRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowModule( B ) );
        
        nr := NrRows( B );
        
        SetIsZero( B, nr = 0 );
        
        if NrRows( M ) <= nr then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfRowModule( M, B ) );
        fi;
        
        IncreaseRingStatistics( R, "PartiallyReducedBasisOfRowModule" );
        
    elif IsBound(RP!.PartiallyReducedBasisOfColumnModule) then
        
        MI := Involution( M );
        
        B := RP!.PartiallyReducedBasisOfColumnModule( MI );
        
        if HasColumnRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr );
        
        B := Involution( B );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowModule( B ) );
        
        nr := NrRows( B );
        
        SetIsZero( B, nr = 0 );
        
        if NrRows( M ) <= nr then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfRowModule( M, B ) );
        fi;
        
        DecreaseRingStatistics( R, "PartiallyReducedBasisOfRowModule" );
        
        IncreaseRingStatistics( R, "PartiallyReducedBasisOfColumnModule" );
        
    else
        
        B := M;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## iterate the syzygy trick
    while true do
        S := SyzygiesGeneratorsOfRows( B );
        
        unit_pos := GetColumnIndependentUnitPositions( S );
        unit_pos := List( unit_pos, a -> a[2] );
        
        if NrRows( S ) = 0 or unit_pos = [ ] then
            break;
        fi;
        
        B := CertainRows( B, Filtered( [ 1 .. NrRows( B ) ], j -> not j in unit_pos ) );
    od;
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfRowModule( B ) );
    
    nr := NrRows( B );
    
    SetIsZero( B, nr = 0 );
    SetIsZero( M, nr = 0 );
    
    ## check assertion
    Assert( 6, R!.asserts.ReducedBasisOfRowModule( M, B ) );
    
    SetIsReducedBasisOfRowsMatrix( B, true );
    
    ColoredInfoForService( t, "ReducedBasisOfRowModule", NrRows( B ) );
    
    DecreaseRingStatistics( R, "ReducedBasisOfRowModule" );
    
    return B;
    
end );

##  <#GAPDoc Label="ReducedBasisOfColumnModule">
##  <ManSection>
##    <Oper Arg="M" Name="ReducedBasisOfColumnModule" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Like <C>BasisOfColumnModule</C>( <A>M</A> ) but where the matrix
##      <C>SyzygiesGeneratorsOfColumns</C>( <C>ReducedBasisOfColumnModule</C>( <A>M</A> ) ) contains no units. This can easily
##      be achieved starting from <M>B:=</M><C>BasisOfColumnModule</C>( <A>M</A> )
##      (and using <Ref Oper="GetRowIndependentUnitPositions" Label="for matrices"/> applied to the matrix of column syzygies of <M>B</M>,
##       etc.). (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ReducedBasisOfColumnModule,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, nr, MI, B, S, unit_pos;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    nr := NrRows( M );
    
    ColoredInfoForService( "busy", "ReducedBasisOfColumnModule", nr, " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(RP!.ReducedBasisOfColumnModule) then
        
        B := RP!.ReducedBasisOfColumnModule( M );
        
        if HasColumnRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
        
        nr := NrColumns( B );
        
        SetIsZero( B, nr = 0 );
        
        if M = B then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfColumnModule( M, B ) );
        fi;
        
        SetIsReducedBasisOfColumnsMatrix( B, true );
        
        ColoredInfoForService( t, "ReducedBasisOfColumnModule", NrColumns( B ) );
        
        IncreaseRingStatistics( R, "ReducedBasisOfColumnModule" );
        
        return B;
        
    elif IsBound(RP!.ReducedBasisOfRowModule) then
        
        MI := Involution( M );
        
        B := RP!.ReducedBasisOfRowModule( MI );
        
        if HasRowRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr );
        
        SetIsReducedBasisOfRowsMatrix( B, true );
        
        SetReducedBasisOfRowModule( MI, B );
        
        B := Involution( B );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
        
        nr := NrColumns( B );
        
        SetIsZero( B, nr = 0 );
        
        if M = B then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfColumnModule( M, B ) );
        fi;
        
        SetIsReducedBasisOfColumnsMatrix( B, true );
        
        ColoredInfoForService( t, "ReducedBasisOfColumnModule", NrColumns( B ) );
        
        DecreaseRingStatistics( R, "ReducedBasisOfColumnModule" );
        
        IncreaseRingStatistics( R, "ReducedBasisOfRowModule" );
        
        return B;
        
    fi;
    
    ## try RP!.PartiallyReducedBasisOf*Module
    if IsBound(RP!.PartiallyReducedBasisOfColumnModule) then
        
        B := RP!.PartiallyReducedBasisOfColumnModule( M );
        
        if HasColumnRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
        
        nr := NrColumns( B );
        
        SetIsZero( B, nr = 0 );
        
        if NrColumns( M ) <= nr then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfColumnModule( M, B ) );
        fi;
        
        IncreaseRingStatistics( R, "PartiallyReducedBasisOfColumnModule" );
        
    elif IsBound(RP!.PartiallyReducedBasisOfRowModule) then
        
        MI := Involution( M );
        
        B := RP!.PartiallyReducedBasisOfRowModule( MI );
        
        if HasRowRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr );
        
        B := Involution( B );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
        
        nr := NrColumns( B );
        
        SetIsZero( B, nr = 0 );
        
        if NrColumns( M ) <= nr then
            B := M;	## we might know more about M
        else
            SetIsZero( M, nr = 0 );
            
            ## check assertion
            Assert( 6, R!.asserts.ReducedBasisOfColumnModule( M, B ) );
        fi;
        
        DecreaseRingStatistics( R, "PartiallyReducedBasisOfColumnModule" );
        
        IncreaseRingStatistics( R, "PartiallyReducedBasisOfRowModule" );
        
    else
        
        B := M;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ## iterate the syzygy trick
    while true do
        S := SyzygiesGeneratorsOfColumns( B );
        
        unit_pos := GetRowIndependentUnitPositions( S );
        unit_pos := List( unit_pos, a -> a[2] );
        
        if NrColumns( S ) = 0 or unit_pos = [ ] then
            break;
        fi;
        
        B := CertainColumns( B, Filtered( [ 1 .. NrColumns( B ) ], j -> not j in unit_pos ) );
    od;
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
    
    nr := NrColumns( B );
    
    SetIsZero( B, nr = 0 );
    SetIsZero( M, nr = 0 );
    
    ## check assertion
    Assert( 6, R!.asserts.ReducedBasisOfColumnModule( M, B ) );
    
    SetIsReducedBasisOfColumnsMatrix( B, true );
    
    ColoredInfoForService( t, "ReducedBasisOfColumnModule", NrColumns( B ) );
    
    DecreaseRingStatistics( R, "ReducedBasisOfColumnModule" );
    
    return B;
    
end );

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfRows">
##  <ManSection>
##    <Oper Arg="M" Name="ReducedSyzygiesGeneratorsOfRows" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Like <C>SyzygiesGeneratorsOfRows</C>( <A>M</A> ) but where the matrix
##      <C>SyzygiesGeneratorsOfRows</C>( <C>ReducedSyzygiesGeneratorsOfRows</C>( <A>M</A> ) ) contains no units.
##      This can easily be achieved starting from <M>C:=</M><C>SyzygiesGeneratorsOfRows</C>( <A>M</A> )
##      (and using <Ref Oper="GetColumnIndependentUnitPositions" Label="for matrices"/> applied to the matrix of row syzygies of <M>C</M>,
##       etc.). (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, MI, C, B, nz;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "ReducedSyzygiesGeneratorsOfRows", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(R!.ComputeBasisBeforeSyzygies) and R!.ComputeBasisBeforeSyzygies = true then
        BasisOfRowModule( M );
    fi;
    
    if IsBound(RP!.ReducedSyzygiesGeneratorsOfRows) then
        
        C := RP!.ReducedSyzygiesGeneratorsOfRows( M );
        
        if IsZero( C ) then
            
            SetIsLeftRegular( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );
            
        else
            
            SetNrColumns( C, NrRows( M ) );
            
        fi;
        
        ## check assertion
        Assert( 6, R!.asserts.ReducedSyzygiesGeneratorsOfRows( M, C ) );
        
        ColoredInfoForService( t, "ReducedSyzygiesGeneratorsOfRows", NrRows( C ) );
        
        IncreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.ReducedSyzygiesGeneratorsOfColumns) then
        
        MI := Involution( M );
        
        C := RP!.ReducedSyzygiesGeneratorsOfColumns( MI );
        
        SetReducedSyzygiesGeneratorsOfColumns( MI, C );
        
        C := Involution( C );
        
        if IsZero( C ) then
            
            SetIsLeftRegular( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );
            
        else
            
            SetNrColumns( C, NrRows( M ) );
            
        fi;
        
        ## check assertion
        Assert( 6, R!.asserts.ReducedSyzygiesGeneratorsOfRows( M, C ) );
        
        ColoredInfoForService( t, "ReducedSyzygiesGeneratorsOfRows", NrRows( C ) );
        
        DecreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfRows" );
        
        IncreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := SyzygiesGeneratorsOfRows( M );
    
    C := ReducedBasisOfRowModule( C );	## a priori computing a basis of C causes obsolete computations, at least in general
    
    ColoredInfoForService( t, "ReducedSyzygiesGeneratorsOfRows", NrRows( C ) );
    
    DecreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfRows" );
    
    return C;
    
end );

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfColumns">
##  <ManSection>
##    <Oper Arg="M" Name="ReducedSyzygiesGeneratorsOfColumns" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Like <C>SyzygiesGeneratorsOfColumns</C>( <A>M</A> ) but where the matrix
##      <C>SyzygiesGeneratorsOfColumns</C>( <C>ReducedSyzygiesGeneratorsOfColumns</C>( <A>M</A> ) ) contains no units.
##      This can easily be achieved starting from <M>C:=</M><C>SyzygiesGeneratorsOfColumns</C>( <A>M</A> )
##      (and using <Ref Oper="GetRowIndependentUnitPositions" Label="for matrices"/> applied to the matrix of column syzygies of <M>C</M>,
##       etc.). (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, MI, C, B, nz;
    
    ## this is an attribute
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "ReducedSyzygiesGeneratorsOfColumns", NrRows( M ), " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(R!.ComputeBasisBeforeSyzygies) and R!.ComputeBasisBeforeSyzygies = true then
        BasisOfColumnModule( M );
    fi;
    
    if IsBound(RP!.ReducedSyzygiesGeneratorsOfColumns) then
        
        C := RP!.ReducedSyzygiesGeneratorsOfColumns( M );
        
        if IsZero( C ) then
            
            SetIsRightRegular( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M ) );
            
        fi;
        
        ## check assertion
        Assert( 6, R!.asserts.ReducedSyzygiesGeneratorsOfColumns( M, C ) );
        
        ColoredInfoForService( t, "ReducedSyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        IncreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.ReducedSyzygiesGeneratorsOfRows) then
        
        MI := Involution( M );
        
        C := RP!.ReducedSyzygiesGeneratorsOfRows( MI );
        
        SetReducedSyzygiesGeneratorsOfRows( MI, C );
        
        C := Involution( C );
        
        if IsZero( C ) then
            
            SetIsRightRegular( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M ) );
            
        fi;
        
        ## check assertion
        Assert( 6, R!.asserts.ReducedSyzygiesGeneratorsOfColumns( M, C ) );
        
        ColoredInfoForService( t, "ReducedSyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        DecreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfColumns" );
        
        IncreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := SyzygiesGeneratorsOfColumns( M );
    
    C := ReducedBasisOfColumnModule( C );	## a priori computing a basis of C causes obsolete computations, at least in general
    
    ColoredInfoForService( t, "ReducedSyzygiesGeneratorsOfColumns", NrColumns( C ) );
    
    DecreaseRingStatistics( R, "ReducedSyzygiesGeneratorsOfColumns" );
    
    return C;
    
end );

#### Effectively:

##  <#GAPDoc Label="BasisOfRowsCoeff">
##  <ManSection>
##    <Oper Arg="M, T" Name="BasisOfRowsCoeff" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Returns <M>B:=</M><C>BasisOfRowModule</C>( <A>M</A> ) and assigns the <E>void</E> matrix <A>T</A>
##      (&see; <Ref Func="HomalgVoidMatrix" Label="constructor for void matrices"/>) such that
##      <M>B = <A>T</A> <A>M</A></M>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfRowsCoeff,		### defines: BasisOfRowsCoeff (BasisCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, nr, TI, MI, B, TT, nz;
    
    if IsBound( M!.BasisOfRowsCoeff ) and IsBound( M!.BasisOfRows ) then
        if HasEval( M!.BasisOfRowsCoeff ) then
            SetEval( T, Eval( M!.BasisOfRowsCoeff ) );
        else
            SetPreEval( T, M!.BasisOfRowsCoeff );
        fi;
        ResetFilterObj( T, IsVoidMatrix );
        ## M!.BasisOfRows should be bounded as well
        return M!.BasisOfRows;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    nr := NrColumns( M );
    
    ColoredInfoForService( "busy", "BasisOfRowsCoeff", NrRows( M ), " x ", nr, " : ", RingName( R ) );
    
    if IsBound(RP!.BasisOfRowsCoeff) then
        
        B := RP!.BasisOfRowsCoeff( M, T ); ResetFilterObj( T, IsVoidMatrix );
        
        if HasRowRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr );
        
        nr := NrRows( B );
        
        SetNrRows( T, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowModule( B ) );
        
        SetIsZero( B, nr = 0 );
        SetIsZero( M, nr = 0 );
        SetIsZero( T, nr = 0 );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowsCoeff( B, T, M ) );	## B = T * M;
        
        SetIsBasisOfRowsMatrix( B, true );
        
        SetBasisOfRowModule( M, B );
        
        M!.BasisOfRows := B;
        M!.BasisOfRowsCoeff := T;
        
        ColoredInfoForService( t, "BasisOfRowsCoeff", nr );
        
        IncreaseRingStatistics( R, "BasisOfRowsCoeff" );
        
        return B;
        
    elif IsBound(RP!.BasisOfColumnsCoeff) then
        
        TI := HomalgVoidMatrix( R );
        
        MI := Involution( M );
        
        B := RP!.BasisOfColumnsCoeff( MI, TI ); ResetFilterObj( TI, IsVoidMatrix );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        if HasColumnRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr );
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        MI!.BasisOfColumnModule := B;
        
        B := Involution( B );
        
        nr := NrRows( B );
        
        SetNrRows( T, nr ); SetNrColumns( TI, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowModule( B ) );
        
        SetIsZero( B, nr = 0 );
        SetIsZero( M, nr = 0 );
        SetIsZero( T, nr = 0 );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfRowsCoeff( B, T, M ) );	## B = T * M;
        
        SetIsBasisOfRowsMatrix( B, true );
        
        SetBasisOfRowModule( M, B );
        
        M!.BasisOfRows := B;
        M!.BasisOfRowsCoeff := T;
        
        ColoredInfoForService( t, "BasisOfRowsCoeff", nr );
        
        DecreaseRingStatistics( R, "BasisOfRowsCoeff" );
        
        IncreaseRingStatistics( R, "BasisOfColumnsCoeff" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TT := HomalgVoidMatrix( R );
    
    B := RowReducedEchelonForm( M, TT );
    
    nz := Length( NonZeroRows( B ) );
    
    SetPreEval( T, CertainRows( TT, [ 1 .. nz ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    if nz = 0 then
        B := HomalgZeroMatrix( 0, NrColumns( B ), R );
    else
        B := CertainRows( B, [ 1 .. nz ] );
    fi;
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfRowModule( B ) );
    
    SetIsZero( B, nz = 0 );
    SetIsZero( M, nz = 0 );
    SetIsZero( T, nz = 0 );
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfRowsCoeff( B, T, M ) );	## B = T * M;
    
    SetIsBasisOfRowsMatrix( B, true );
    
    SetBasisOfRowModule( M, B );
    
    M!.BasisOfRows := B;
    M!.BasisOfRowsCoeff := T;
    
    ColoredInfoForService( t, "BasisOfRowsCoeff", nz );
    
    IncreaseRingStatistics( R, "BasisOfRowsCoeff" );
    
    return B;
    
end );

##  <#GAPDoc Label="BasisOfColumnsCoeff">
##  <ManSection>
##    <Oper Arg="M, T" Name="BasisOfColumnsCoeff" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Returns <M>B:=</M><C>BasisOfRowModule</C>( <A>M</A> ) and assigns the <E>void</E> matrix <A>T</A>
##      (&see; <Ref Func="HomalgVoidMatrix" Label="constructor for void matrices"/>) such that
##      <M>B = <A>M</A> <A>T</A></M>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( BasisOfColumnsCoeff,		### defines: BasisOfColumnsCoeff (BasisCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, nr, TI, MI, B, TT, nz;
    
    if IsBound( M!.BasisOfColumnsCoeff ) and IsBound( M!.BasisOfColumns ) then
        if HasEval( M!.BasisOfColumnsCoeff ) then
            SetEval( T, Eval( M!.BasisOfColumnsCoeff ) );
        else
            SetPreEval( T, M!.BasisOfColumnsCoeff );
        fi;
        ResetFilterObj( T, IsVoidMatrix );
        ## M!.BasisOfColumns should be bounded as well
        return M!.BasisOfColumns;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    nr := NrRows( M );
    
    ColoredInfoForService( "busy", "BasisOfColumnsCoeff", nr, " x ", NrColumns( M ), " : ", RingName( R ) );
    
    if IsBound(RP!.BasisOfColumnsCoeff) then
        
        B := RP!.BasisOfColumnsCoeff( M, T ); ResetFilterObj( T, IsVoidMatrix );
        
        if HasColumnRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetNrRows( B, nr );
        
        nr := NrColumns( B );
        
        SetNrColumns( T, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
        
        SetIsZero( B, nr = 0 );
        SetIsZero( M, nr = 0 );
        SetIsZero( T, nr = 0 );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnsCoeff( B, M, T ) );	# B = M * T
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        SetBasisOfColumnModule( M, B );
        
        M!.BasisOfColumns := B;
        M!.BasisOfColumnsCoeff := T;
        
        ColoredInfoForService( t, "BasisOfColumnsCoeff", nr );
        
        IncreaseRingStatistics( R, "BasisOfColumnsCoeff" );
        
        return B;
        
    elif IsBound(RP!.BasisOfRowsCoeff) then
        
        TI := HomalgVoidMatrix( R );
        
        MI := Involution( M );
        
        B := RP!.BasisOfRowsCoeff( MI, TI ); ResetFilterObj( TI, IsVoidMatrix );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        if HasRowRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetNrColumns( B, nr );
        
        SetIsBasisOfRowsMatrix( B, true );
        
        MI!.BasisOfRowModule := B;
        
        B := Involution( B );
        
        nr := NrColumns( B );
        
        SetNrColumns( T, nr ); SetNrRows( TI, nr );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
        
        SetIsZero( B, nr = 0 );
        SetIsZero( M, nr = 0 );
        SetIsZero( T, nr = 0 );
        
        ## check assertion
        Assert( 6, R!.asserts.BasisOfColumnsCoeff( B, M, T ) );	# B = M * T
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        SetBasisOfColumnModule( M, B );
        
        M!.BasisOfColumns := B;
        M!.BasisOfColumnsCoeff := T;
        
        ColoredInfoForService( t, "BasisOfColumnsCoeff", nr );
        
        DecreaseRingStatistics( R, "BasisOfColumnsCoeff" );
        
        IncreaseRingStatistics( R, "BasisOfRowsCoeff" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TT := HomalgVoidMatrix( R );
    
    B := ColumnReducedEchelonForm( M, TT );
    
    nz := Length( NonZeroColumns( B ) );
    
    SetPreEval( T, CertainColumns( TT, [ 1 .. nz ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    if nz = 0 then
        B := HomalgZeroMatrix( NrRows( B ), 0, R );
    else
        B := CertainColumns( B, [ 1 .. nz ] );
    fi;
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfColumnModule( B ) );
    
    SetIsZero( B, nz = 0 );
    SetIsZero( M, nz = 0 );
    SetIsZero( T, nz = 0 );
    
    ## check assertion
    Assert( 6, R!.asserts.BasisOfColumnsCoeff( B, M, T ) );	# B = M * T
    
    SetIsBasisOfColumnsMatrix( B, true );
    
    SetBasisOfColumnModule( M, B );
    
    M!.BasisOfColumns := B;
    M!.BasisOfColumnsCoeff := T;
    
    ColoredInfoForService( t, "BasisOfColumnsCoeff", nz );
    
    IncreaseRingStatistics( R, "BasisOfColumnsCoeff" );
    
    return B;
    
end );

##  <#GAPDoc Label="DecideZeroRowsEffectively">
##  <ManSection>
##    <Oper Arg="A, B, T" Name="DecideZeroRowsEffectively" Label="for pairs of matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Returns <M>M:=</M><C>DecideZeroRows</C>( <A>A</A>, <A>B</A> ) and assigns the <E>void</E> matrix <A>T</A>
##      (&see; <Ref Func="HomalgVoidMatrix" Label="constructor for void matrices"/>) such that
##      <M>M = <A>A</A> + <A>T</A><A>B</A></M>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DecideZeroRowsEffectively,	### defines: DecideZeroRowsEffectively (ReduceCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( A, B, T )
    local R, RP, t, TI, l, m, n, id, zz, M, TT, MM;
    
    R := HomalgRing( B );
    
    if IsBound( A!.DecideZeroRowsEffectively ) and
       IsIdenticalObj( A!.DecideZeroRowsEffectively, B ) then
        
        SetPreEval( T, HomalgIdentityMatrix( NrRows( A ), R ) );
        ResetFilterObj( T, IsVoidMatrix );
        
        return A;
        
    fi;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        if IsBound( B!.DecideZeroRowsEffectively ) then
            M := _ElmWPObj_ForHomalg( B!.DecideZeroRowsEffectively, A, fail );
            if M <> fail then
                SetPreEval( T, M[2] ); ResetFilterObj( T, IsVoidMatrix );
                return M[1];
            fi;
        else
            B!.DecideZeroRowsEffectively :=
              ContainerForWeakPointers(
                      TheTypeContainerForWeakPointersOnComputedValues,
                      [ "operation", "DecideZeroRowsEffectively" ] );
        fi;
    fi;
    
    ### causes many IsZero external calls without
    ### reducing the effective number of DecideZero calls;
    ### observed with Purity.g in ExamplesForHomalg
    ## if IsZero( A ) or IsZero( B ) then
    ##     ## dispatch to the immediate methods
    ##     return DecideZeroRowsEffectively( A, B, T );
    ## fi;
    
    R!.asserts.DecideZeroRowsWRTNonBasis( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    l := NrRows( A );
    m := NrColumns( A );
    
    n := NrRows( B );
    
    SetNrRows( T, l );
    SetNrColumns( T, n );
    
    ColoredInfoForService( "busy", "DecideZeroRowsEffectively", "( ", l, " + ", n, " ) x ", m, " : ", RingName( R ) );
    
    if IsBound(RP!.DecideZeroRowsEffectively) then
        
        M := RP!.DecideZeroRowsEffectively( A, B, T ); ResetFilterObj( T, IsVoidMatrix );
        
        SetNrRows( M, l ); SetNrColumns( M, m );
        
        if not IsZero( M ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        ## check assertions
        Assert( 6,
                R!.asserts.DecideZeroRowsEffectively( M, A, T, B ) and		# M = A + T * B
                R!.asserts.DecideZeroRows_Effectively( M, A, B ) );		# M = DecideZeroRows( A, B )
        
        M!.DecideZeroRowsEffectively := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroRowsEffectively, A, [ M, T ] );
        fi;
        
        ColoredInfoForService( t, "DecideZeroRowsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroRowsEffectively" );
        
        return M;
        
    elif IsBound(RP!.DecideZeroColumnsEffectively) then
        
        TI := HomalgVoidMatrix( R );
        
        M := RP!.DecideZeroColumnsEffectively( Involution( A ), Involution( B ), TI );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix ); ResetFilterObj( TI, IsVoidMatrix );
        
        SetNrRows( M, m ); SetNrColumns( M, l );
        
        if not IsZero( M ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        M := Involution( M );
        
        ## check assertions
        Assert( 6,
                R!.asserts.DecideZeroRowsEffectively( M, A, T, B ) and		# M = A + T * B
                R!.asserts.DecideZeroRows_Effectively( M, A, B ) );		# M = DecideZeroRows( A, B )
        
        M!.DecideZeroRowsEffectively := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroRowsEffectively, A, [ M, T ] );
        fi;
        
        ColoredInfoForService( t, "DecideZeroRowsEffectively" );
        
        DecreaseRingStatistics( R, "DecideZeroRowsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
        
        return M;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if HasIsOne( A ) and IsOne( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( n, l, R );
    
    M := UnionOfRows( UnionOfColumns( id, A ), UnionOfColumns( zz, B ) );
    
    TT := HomalgVoidMatrix( R );
    
    M := RowReducedEchelonForm( M, TT );
    
    M := CertainRows( CertainColumns( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    TT := CertainColumns( CertainRows( TT, [ 1 .. l ] ), [ l + 1 .. l + n ] );
    
    SetPreEval( T, TT ); ResetFilterObj( T, IsVoidMatrix );
    
    if not IsZero( M ) then
        Assert( 6, not IsZero( A ) );
        SetIsZero( A, false );
    fi;
    
    ## check assertions
    Assert( 6,
            R!.asserts.DecideZeroRowsEffectively( M, A, T, B ) and	# M = A + T * B
            R!.asserts.DecideZeroRows_Effectively( M, A, B ) );		# M = DecideZeroRows( A, B )
    
    M!.DecideZeroRowsEffectively := B;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        _AddTwoElmWPObj_ForHomalg( B!.DecideZeroRowsEffectively, A, [ M, T ] );
    fi;
    
    ColoredInfoForService( t, "DecideZeroRowsEffectively" );
    
    IncreaseRingStatistics( R, "DecideZeroRowsEffectively" );
    
    return M;
    
end );

##  <#GAPDoc Label="DecideZeroColumnsEffectively">
##  <ManSection>
##    <Oper Arg="A, B, T" Name="DecideZeroColumnsEffectively" Label="for pairs of matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Returns <M>M:=</M><C>DecideZeroColumns</C>( <A>A</A>, <A>B</A> ) and assigns the <E>void</E> matrix <A>T</A>
##      (&see; <Ref Func="HomalgVoidMatrix" Label="constructor for void matrices"/>) such that
##      <M>M = <A>A</A> + <A>B</A><A>T</A></M>. (&see; Appendix <Ref Chap="Basic_Operations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DecideZeroColumnsEffectively,	### defines: DecideZeroColumnsEffectively (ReduceCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( A, B, T )
    local R, RP, t, TI, l, m, n, id, zz, M, TT;
    
    R := HomalgRing( B );
    
    if IsBound( A!.DecideZeroColumnsEffectively ) and
       IsIdenticalObj( A!.DecideZeroColumnsEffectively, B ) then
        
        SetPreEval( T, HomalgIdentityMatrix( NrColumns( A ), R ) );
        ResetFilterObj( T, IsVoidMatrix );
        
        return A;
        
    fi;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        if IsBound( B!.DecideZeroColumnsEffectively ) then
            M := _ElmWPObj_ForHomalg( B!.DecideZeroColumnsEffectively, A, fail );
            if M <> fail then
                SetPreEval( T, M[2] ); ResetFilterObj( T, IsVoidMatrix );
                return M[1];
            fi;
        else
            B!.DecideZeroColumnsEffectively :=
              ContainerForWeakPointers(
                      TheTypeContainerForWeakPointersOnComputedValues,
                      [ "operation", "DecideZeroColumnsEffectively" ] );
        fi;
    fi;
    
    ### causes many IsZero external calls without
    ### reducing the effective number of DecideZero calls;
    ### observed with Purity.g in ExamplesForHomalg
    ## if IsZero( A ) or IsZero( B ) then
    ##     ## dispatch to the immediate methods
    ##     return DecideZeroColumnsEffectively( A, B, T );
    ## fi;
    
    R!.asserts.DecideZeroColumnsWRTNonBasis( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    l := NrColumns( A );
    m := NrRows( A );
    
    n := NrColumns( B );
    
    SetNrColumns( T, l );
    SetNrRows( T, n );
    
    ColoredInfoForService( "busy", "DecideZeroColumnsEffectively", m, " x ( ", l, " + ", n, " ) : ", RingName( R ) );
    
    if IsBound(RP!.DecideZeroColumnsEffectively) then
        
        M := RP!.DecideZeroColumnsEffectively( A, B, T ); ResetFilterObj( T, IsVoidMatrix );
        
        SetNrColumns( M, l ); SetNrRows( M, m );
        
        if not IsZero( M ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        ## check assertions
        Assert( 6,
                R!.asserts.DecideZeroColumnsEffectively( M, A, B, T ) and	# M = A + B * T
                R!.asserts.DecideZeroColumns_Effectively( M, A, B ) );		# M = DecideZeroColumns( A, B )
        
        M!.DecideZeroColumnsEffectively := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroColumnsEffectively, A, [ M, T ] );
        fi;
        
        ColoredInfoForService( t, "DecideZeroColumnsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
        
        return M;
        
    elif IsBound(RP!.DecideZeroRowsEffectively) then
        
        TI := HomalgVoidMatrix( R );
        
        M := RP!.DecideZeroRowsEffectively( Involution( A ), Involution( B ), TI );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix ); ResetFilterObj( TI, IsVoidMatrix );
        
        SetNrColumns( M, m ); SetNrRows( M, l );
        
        if not IsZero( M ) then
            Assert( 6, not IsZero( A ) );
            SetIsZero( A, false );
        fi;
        
        M := Involution( M );
        
        ## check assertions
        Assert( 6,
                R!.asserts.DecideZeroColumnsEffectively( M, A, B, T ) and	# M = A + B * T
                R!.asserts.DecideZeroColumns_Effectively( M, A, B ) );		# M = DecideZeroColumns( A, B )
        
        M!.DecideZeroColumnsEffectively := B;
        
        if not ( IsMutable( A ) or IsMutable( B ) ) then
            _AddTwoElmWPObj_ForHomalg( B!.DecideZeroColumnsEffectively, A, [ M, T ] );
        fi;
        
        ColoredInfoForService( t, "DecideZeroColumnsEffectively" );
        
        DecreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroRowsEffectively" );
        
        return M;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if HasIsOne( A ) and IsOne( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( l, n, R );
    
    M := UnionOfColumns( UnionOfRows( id, A ), UnionOfRows( zz, B ) );
    
    TT := HomalgVoidMatrix( R );
    
    M := ColumnReducedEchelonForm( M, TT );
    
    M := CertainColumns( CertainRows( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    TT := CertainRows( CertainColumns( TT, [ 1 .. l ] ), [ l + 1 .. l + n ] );
    
    SetPreEval( T, TT ); ResetFilterObj( T, IsVoidMatrix );
    
    if not IsZero( M ) then
        Assert( 6, not IsZero( A ) );
        SetIsZero( A, false );
    fi;
    
    ## check assertions
    Assert( 6,
            R!.asserts.DecideZeroColumnsEffectively( M, A, B, T ) and	# M = A + B * T
            R!.asserts.DecideZeroColumns_Effectively( M, A, B ) );	# M = DecideZeroColumns( A, B )
    
    M!.DecideZeroColumnsEffectively := B;
    
    if not ( IsMutable( A ) or IsMutable( B ) ) then
        _AddTwoElmWPObj_ForHomalg( B!.DecideZeroColumnsEffectively, A, [ M, T ] );
    fi;
    
    ColoredInfoForService( t, "DecideZeroColumnsEffectively" );
    
    IncreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
    
    return M;
    
end );
