#############################################################################
##
##  SingularBasic.gi          RingsForHomalg package          Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSingularBasic,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring

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
      NrColumns( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking( 
      [ "matrix ", N, " = BasisOfRowModule(", M, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.BasisOfModule
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
      NrRows( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = BasisOfColumnModule(", M, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.BasisOfModule
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
      NrColumns( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [
        "list ", v, "l=BasisOfRowsCoeff(", M, "); ",
        "matrix ", N, " = ", v, "l[1]; ",
        "matrix ", T, " = ", v, "l[2]"
      ],
      "need_command",
      HOMALG_IO.Pictograms.BasisCoeff
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
      NrRows( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking( 
      [
        "list ", v, "l=BasisOfColumnsCoeff(", M, "); ",
        "matrix ", N, " = ", v, "l[1]; ",
        "matrix ", T, " = ", v, "l[2]"
      ],
      "need_command",
      HOMALG_IO.Pictograms.BasisCoeff
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
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroRows" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
DecideZeroRows :=
  function( A, B )
    local N;
    
    N := HomalgVoidMatrix(
      NrRows( A ),
      NrColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking( 
      [ "matrix ", N, " = DecideZeroRows(", A, B, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.DecideZero
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
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroColumns" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
DecideZeroColumns :=
  function( A, B )
    local N;
    
    N := HomalgVoidMatrix(
      NrRows( A ),
      NrColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = DecideZeroColumns(", A, B, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.DecideZero
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
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroRowsEffectively" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
DecideZeroRowsEffectively :=
  function( A, B, T )
    local v, N;
    
    v := homalgStream( HomalgRing( A ) )!.variable_name;
    
    N := HomalgVoidMatrix(
      NrRows( A ),
      NrColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking(
      [
        "list ", v, "l=DecideZeroRowsEffectively(", A, B, "); ",
        "matrix ", N, " = ", v, "l[1]; ",
        "matrix ", T, " = ", v, "l[2]"
      ],
      "need_command",
      HOMALG_IO.Pictograms.DecideZeroEffectively
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
##      This is the entry of the &homalg; table, which calls the corresponding macro <Ref Func="DecideZeroColumnsEffectively" Label="Singular macro"/> inside the computer algebra system.
##      <Listing Type="Code"><![CDATA[
DecideZeroColumnsEffectively :=
  function( A, B, T )
    local v, N;
    
    v := homalgStream( HomalgRing( A ) )!.variable_name;
    
    N := HomalgVoidMatrix(
      NrRows( A ),
      NrColumns( A ),
      HomalgRing( A )
    );
    
    homalgSendBlocking(
      [
        "list ", v, "l=DecideZeroColumnsEffectively(", A, B, "); ",
        "matrix ", N, " = ", v, "l[1]; ",
        "matrix ", T, " = ", v, "l[2]"
      ],
      "need_command",
      HOMALG_IO.Pictograms.DecideZeroEffectively
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
      NrRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = SyzygiesGeneratorsOfRows(", M, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.SyzygiesGenerators
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
      NrColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = SyzygiesGeneratorsOfColumns(", M, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.SyzygiesGenerators
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
      NrRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = RelativeSyzygiesGeneratorsOfRows(", M, M2, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.SyzygiesGenerators
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
      NrColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = RelativeSyzygiesGeneratorsOfColumns(", M, M2, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.SyzygiesGenerators
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
    
    N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
    
    homalgSendBlocking( [ "matrix ", N, " = PartiallyReducedBasisOfRowModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
    
    return N;
    
  end,
  
## our fallback seems to be more efficient
X_PartiallyReducedBasisOfColumnModule :=
  function( M )
    local N;
    
    N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
    
    homalgSendBlocking( [ "matrix ", N, " = PartiallyReducedBasisOfColumnModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
    
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
      NrRows( M ),
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = ReducedSyzygiesGeneratorsOfRows(", M, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.SyzygiesGenerators
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
      NrColumns( M ),
      "unknown_number_of_columns",
      HomalgRing( M )
    );
    
    homalgSendBlocking(
      [ "matrix ", N, " = ReducedSyzygiesGeneratorsOfColumns(", M, ")" ],
      "need_command",
      HOMALG_IO.Pictograms.SyzygiesGenerators
    );
    
    return N;
    
  end,
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

        )
 );
