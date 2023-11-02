# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by Singular.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForSingularBasic",
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring

               RowEchelonForm :=
                 function( M )
                   local R, v, N;
                   
                   R := HomalgRing( M );
                   
                   v := homalgStream( R ).variable_name;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
                   
                   homalgSendBlocking( [ "intvec ", v, "option = option(get); option(none); option(prompt); option(intStrategy)" ], R, "need_command", "initialize" );
                   
                   homalgSendBlocking(
                           [ "matrix ", N, " = BasisOfRowModule(", M, ")" ],
                           "need_command",
                           "ReducedEchelonForm"
                           );
                   
                   homalgSendBlocking( [ "option(set,", v, "option)" ], R, "need_command", "initialize" );
                   
                   return CertainRows( N, Reversed( [ 1 .. NumberRows( N ) ] ) );
                   
                 end,
               
##  <#GAPDoc Label="BasisOfRowModule:Singular">
##  <ManSection>
##    <Func Arg="M" Name="BasisOfRowModule" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfRowModule" Label="Singular macro"/> inside the computer algebra system.
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
      [ "matrix ", N, " = BasisOfRowModule(", M, ")" ],
      "need_command",
      "BasisOfModule"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfColumnModule:Singular">
##  <ManSection>
##    <Func Arg="M" Name="BasisOfColumnModule" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfColumnModule" Label="Singular macro"/> inside the computer algebra system.
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
      [ "matrix ", N, " = BasisOfColumnModule(", M, ")" ],
      "need_command",
      "BasisOfModule"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfRowsCoeff:Singular">
##  <ManSection>
##    <Func Arg="M, T" Name="BasisOfRowsCoeff" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfRowsCoeff" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
BasisOfRowsCoeff :=
  function( M, T )
    local v, N;
    
    v := homalgStream( HomalgRing( M ) )!.variable_name;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberColumns( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, T, " = BasisOfRowsCoeff(", M, ")" ],
      "need_command",
      "BasisCoeff"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfColumnsCoeff:Singular">
##  <ManSection>
##    <Func Arg="M, T" Name="BasisOfColumnsCoeff" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="BasisOfColumnsCoeff" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
BasisOfColumnsCoeff :=
  function( M, T )
    local v, N;
    
    v := homalgStream( HomalgRing( M ) )!.variable_name;
    
    N := HomalgVoidMatrix(
      NumberRows( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking( 
      [ "matrix ", N, T, " = BasisOfColumnsCoeff(", M, ")" ],
      "need_command",
      "BasisCoeff"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroRows:Singular">
##  <ManSection>
##    <Func Arg="A, B" Name="DecideZeroRows" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroRows" Label="Singular macro"/> inside the computer algebra system. The rows of <A>B</A> must form a basis (see <Ref Func="BasisOfRowModule" Label="in the homalg table for Singular"/>).
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
      [ "matrix ", N, " = DecideZeroRows(", A, B, ")" ],
      "need_command",
      "DecideZero"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroColumns:Singular">
##  <ManSection>
##    <Func Arg="A, B" Name="DecideZeroColumns" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroColumns" Label="Singular macro"/> inside the computer algebra system. The columns of <A>B</A> must form a basis (see <Ref Func="BasisOfColumnModule" Label="in the homalg table for Singular"/>).
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
      [ "matrix ", N, " = DecideZeroColumns(", A, B, ")" ],
      "need_command",
      "DecideZero"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroRowsEffectively:Singular">
##  <ManSection>
##    <Func Arg="A, B, T" Name="DecideZeroRowsEffectively" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroRowsEffectively" Label="Singular macro"/> inside the computer algebra system. The rows of <A>B</A> must form a basis (see <Ref Func="BasisOfRowModule" Label="in the homalg table for Singular"/>).
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
      [ "matrix ", N, T, " = DecideZeroRowsEffectively(", A, B, ")" ],
      "need_command",
      "DecideZeroEffectively"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroColumnsEffectively:Singular">
##  <ManSection>
##    <Func Arg="A, B, T" Name="DecideZeroColumnsEffectively" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroColumnsEffectively" Label="Singular macro"/> inside the computer algebra system. The columns of <A>B</A> must form a basis (see <Ref Func="BasisOfColumnModule" Label="in the homalg table for Singular"/>).
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
      [ "matrix ", N, T, " = DecideZeroColumnsEffectively(", A, B, ")" ],
      "need_command",
      "DecideZeroEffectively"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="SyzygiesGeneratorsOfRows:Singular">
##  <ManSection>
##    <Func Arg="M" Name="SyzygiesGeneratorsOfRows" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="SyzygiesGeneratorsOfRows" Label="Singular macro"/> inside the computer algebra system.
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
      [ "matrix ", N, " = SyzygiesGeneratorsOfRows(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="SyzygiesGeneratorsOfColumns:Singular">
##  <ManSection>
##    <Func Arg="M" Name="SyzygiesGeneratorsOfColumns" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="SyzygiesGeneratorsOfColumns" Label="Singular macro"/> inside the computer algebra system.
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
      [ "matrix ", N, " = SyzygiesGeneratorsOfColumns(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfRows:Singular">
##  <ManSection>
##    <Func Arg="M, M2" Name="RelativeSyzygiesGeneratorsOfRows" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="RelativeSyzygiesGeneratorsOfRows" Label="Singular macro"/> inside the computer algebra system.
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
      [ "matrix ", N, " = RelativeSyzygiesGeneratorsOfRows(", M, M2, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfColumns:Singular">
##  <ManSection>
##    <Func Arg="M, M2" Name="RelativeSyzygiesGeneratorsOfColumns" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="RelativeSyzygiesGeneratorsOfColumns" Label="Singular macro"/> inside the computer algebra system.
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
      [ "matrix ", N, " = RelativeSyzygiesGeneratorsOfColumns(", M, M2, ")" ],
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
    
    homalgSendBlocking( [ "matrix ", N, " = PartiallyReducedBasisOfRowModule(", M, ")" ], "need_command", "ReducedBasisOfModule" );
    
    return N;
    
  end,
  
## our fallback seems to be more efficient
X_PartiallyReducedBasisOfColumnModule :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
    
    homalgSendBlocking( [ "matrix ", N, " = PartiallyReducedBasisOfColumnModule(", M, ")" ], "need_command", "ReducedBasisOfModule" );
    
    return N;
    
  end,

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfRows:Singular">
##  <ManSection>
##    <Func Arg="M" Name="ReducedSyzygiesGeneratorsOfRows" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="ReducedSyzygiesGeneratorsOfRows" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
ReducedSyzygiesGeneratorsOfRows :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      "unknown_number_of_rows",
      NumberRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = ReducedSyzygiesGeneratorsOfRows(", M, ")" ],
      "need_command",
      "SyzygiesGenerators"
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfColumns:Singular">
##  <ManSection>
##    <Func Arg="M" Name="ReducedSyzygiesGeneratorsOfColumns" Label="in the homalg table for Singular"/>
##    <Returns></Returns>
##    <Description>
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="ReducedSyzygiesGeneratorsOfColumns" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
ReducedSyzygiesGeneratorsOfColumns :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix(
      NumberColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = ReducedSyzygiesGeneratorsOfColumns(", M, ")" ],
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
