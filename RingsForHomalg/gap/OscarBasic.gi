# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForOscarBasic",
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring

RowEchelonForm :=
  function( M )
    local ignore, N;
    
    ignore := ValueOption( "ignore" );
    
    if not IsInt( ignore ) then
        ignore := 0;
    fi;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberColumns( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = RowEchelonForm(", M, "; ignore = ", ignore, ")" ],
      "need_command",
      "ReducedEchelonForm"
    );
    
    return N;
    
  end,

ColumnEchelonForm :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      NumberRows( M ),
      "unknown_number_of_rows",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = ColumnEchelonForm(", M, ")" ],
      "need_command",
      "ReducedEchelonForm"
    );
    
    return N;
    
  end,

ReducedRowEchelonForm :=
  function( arg )
    local M, R, nargs, N, T;
      
    M := arg[1];
    
    R := HomalgRing( M );
    
    nargs := Length( arg );
    
    N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
    
    if nargs > 1 and IsHomalgMatrix( arg[2] ) then
        
        T := arg[2];
        
        homalgSendBlocking(
                [ N, T, " = map(transpose,hnf_with_transform(transpose(", M, ")))" ],
                "need_command",
                "ReducedEchelonForm"
                );
        
    else
        
        homalgSendBlocking(
                [ N, " = transpose(hnf(transpose(", M, ")))" ],
                "need_command",
                "ReducedEchelonForm"
                );
        
    fi;
    
    SetIsUpperStairCaseMatrix( N, true );
    
    return N;
    
  end,

ReducedColumnEchelonForm :=
  function( arg )
    local M, R, nargs, N, T;
    
    M := arg[1];
    
    R := HomalgRing( M );
    
    nargs := Length( arg );
    
    N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_rows", R );
    
    if nargs > 1 and IsHomalgMatrix( arg[2] ) then
        
        T := arg[2];
        
        homalgSendBlocking(
                [ N, T, " = hnf_with_transform(", M, ")" ],
                "need_command",
                "ReducedEchelonForm"
                );
        
    else
        
        homalgSendBlocking(
                [ N, " = hnf(", M, ")" ],
                "need_command",
                "ReducedEchelonForm"
                );
        
    fi;
    
    return N;
    
  end,

##  <#GAPDoc Label="BasisOfRowModule:Oscar">
##  <ManSection>
##    <Func Arg="M" Name="BasisOfRowModule" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfRowModule" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
BasisOfRowModule :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberColumns( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking( 
      [ N, " = BasisOfRowModule(", M, ")" ],
      "need_command",
      "BasisOfModule"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfColumnModule:Oscar">
##  <ManSection>
##    <Func Arg="M" Name="BasisOfColumnModule" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfColumnModule" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
BasisOfColumnModule :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      NumberRows( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = BasisOfColumnModule(", M, ")" ],
      "need_command",
      "BasisOfModule"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfRowsCoeff:Oscar">
##  <ManSection>
##    <Func Arg="M, T" Name="BasisOfRowsCoeff" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfRowsCoeff" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
BasisOfRowsCoeff :=
  function( M, T )
    local N;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberColumns( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, T, " = BasisOfRowsCoeff(", M, ")" ],
      "need_command",
      "BasisCoeff"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfColumnsCoeff:Oscar">
##  <ManSection>
##    <Func Arg="M, T" Name="BasisOfColumnsCoeff" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfColumnsCoeff" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
BasisOfColumnsCoeff :=
  function( M, T )
    local N;
    
    N := HomalgVoidMatrix(
      NumberRows( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking( 
      [ N, T, " = BasisOfColumnsCoeff(", M, ")" ],
      "need_command",
      "BasisCoeff"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroRows:Oscar">
##  <ManSection>
##    <Func Arg="A, B" Name="DecideZeroRows" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroRows" Label="Oscar macro"/> inside the computer algebra system. The rows of <A>B</A> must form a basis (see <Ref Func="BasisOfRowModule" Label="in the homalg table for Oscar"/>).
##      <Listing Type="Code"><![CDATA[
DecideZeroRows :=
  function( A, B )
    local N;
    
    N := HomalgVoidMatrix(
      NumberRows( A ),
      NumberColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking( 
      [ N, " = DecideZeroRows(", A, B, ")" ],
      "need_command",
      "DecideZero"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroColumns:Oscar">
##  <ManSection>
##    <Func Arg="A, B" Name="DecideZeroColumns" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroColumns" Label="Oscar macro"/> inside the computer algebra system. The columns of <A>B</A> must form a basis (see <Ref Func="BasisOfColumnModule" Label="in the homalg table for Oscar"/>).
##      <Listing Type="Code"><![CDATA[
DecideZeroColumns :=
  function( A, B )
    local N;
    
    N := HomalgVoidMatrix(
      NumberRows( A ),
      NumberColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking(
      [ N, " = DecideZeroColumns(", A, B, ")" ],
      "need_command",
      "DecideZero"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroRowsEffectively:Oscar">
##  <ManSection>
##    <Func Arg="A, B, T" Name="DecideZeroRowsEffectively" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroRowsEffectively" Label="Oscar macro"/> inside the computer algebra system. The rows of <A>B</A> must form a basis (see <Ref Func="BasisOfRowModule" Label="in the homalg table for Oscar"/>).
##      <Listing Type="Code"><![CDATA[
DecideZeroRowsEffectively :=
  function( A, B, T )
    local v, N;
    
    v := homalgStream( HomalgRing( A ) )!.variable_name;
    
    N := HomalgVoidMatrix(
      NumberRows( A ),
      NumberColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking(
      [ N, T, " = DecideZeroRowsEffectively(", A, B, ");" ],
      "need_command",
      "DecideZeroEffectively"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroColumnsEffectively:Oscar">
##  <ManSection>
##    <Func Arg="A, B, T" Name="DecideZeroColumnsEffectively" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroColumnsEffectively" Label="Oscar macro"/> inside the computer algebra system. The columns of <A>B</A> must form a basis (see <Ref Func="BasisOfColumnModule" Label="in the homalg table for Oscar"/>).
##      <Listing Type="Code"><![CDATA[
DecideZeroColumnsEffectively :=
  function( A, B, T )
    local v, N;
    
    v := homalgStream( HomalgRing( A ) )!.variable_name;
    
    N := HomalgVoidMatrix(
      NumberRows( A ),
      NumberColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking(
      [ N, T, " = DecideZeroColumnsEffectively(", A, B, ")" ],
      "need_command",
      "DecideZeroEffectively"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="SyzygiesGeneratorsOfRows:Oscar">
##  <ManSection>
##    <Func Arg="M" Name="SyzygiesGeneratorsOfRows" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="SyzygiesGeneratorsOfRows" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
SyzygiesGeneratorsOfRows :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = SyzygiesGeneratorsOfRows(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="SyzygiesGeneratorsOfColumns:Oscar">
##  <ManSection>
##    <Func Arg="M" Name="SyzygiesGeneratorsOfColumns" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="SyzygiesGeneratorsOfColumns" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
SyzygiesGeneratorsOfColumns :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      NumberColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = SyzygiesGeneratorsOfColumns(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfRows:Oscar">
##  <ManSection>
##    <Func Arg="M, M2" Name="RelativeSyzygiesGeneratorsOfRows" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="RelativeSyzygiesGeneratorsOfRows" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
RelativeSyzygiesGeneratorsOfRows :=
  function( M, M2 )
    local N;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = RelativeSyzygiesGeneratorsOfRows(", M, M2, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfColumns:Oscar">
##  <ManSection>
##    <Func Arg="M, M2" Name="RelativeSyzygiesGeneratorsOfColumns" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="RelativeSyzygiesGeneratorsOfColumns" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
RelativeSyzygiesGeneratorsOfColumns :=
  function( M, M2 )
    local N;
    
    N := HomalgVoidMatrix(
      NumberColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = RelativeSyzygiesGeneratorsOfColumns(", M, M2, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

## our fallback seems to be more efficient
X_PartiallyReducedBasisOfRowModule :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), HomalgRing( M ) );
    
    homalgSendBlocking( [ N, " = PartiallyReducedBasisOfRowModule(", M, ")" ], "need_command", "ReducedBasisOfModule" );
    
    return N;
    
  end,
  
## our fallback seems to be more efficient
X_PartiallyReducedBasisOfColumnModule :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
    
    homalgSendBlocking( [ N, " = PartiallyReducedBasisOfColumnModule(", M, ")" ], "need_command", "ReducedBasisOfModule" );
    
    return N;
    
  end,

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfRows:Oscar">
##  <ManSection>
##    <Func Arg="M" Name="ReducedSyzygiesGeneratorsOfRows" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="ReducedSyzygiesGeneratorsOfRows" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
X_ReducedSyzygiesGeneratorsOfRows :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = ReducedSyzygiesGeneratorsOfRows(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfColumns:Oscar">
##  <ManSection>
##    <Func Arg="M" Name="ReducedSyzygiesGeneratorsOfColumns" Label="in the homalg table for Oscar"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="ReducedSyzygiesGeneratorsOfColumns" Label="Oscar macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
X_ReducedSyzygiesGeneratorsOfColumns :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      NumberColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ N, " = ReducedSyzygiesGeneratorsOfColumns(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

        )
 );
