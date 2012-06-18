#############################################################################
##
##  MatricesForHomalg.gi                           MatricesForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for MatricesForHomalg.
##
#############################################################################

####################################
#
# representations:
#
####################################

####################################
#
# families and types:
#
####################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_MATRICES,
        rec(
            OtherInternalMatrixTypes := [ ],
            
            colors := rec(   ## (B)asic (O)perations:
                             BOE := "\033[1;37;40m",	## reduced (E)chelon form: RowReducedEchelonForm/Columns
                             BOB := "\033[1;37;45m",	## (B)asis: BasisOfRow/ColumnModule
                             BOC := "\033[1;37;45m",	## Basis: BasisOfRows/Columns(C)oeff
                             BOD := "\033[1;37;42m",	## existence of a particular solution: (D)ecideZeroRows/Columns
                             BOP := "\033[1;37;42m",	## (P)articular solution: DecideZeroRows/Columns(Effectively)
                             BOH := "\033[1;37;41m",	## solutions of the (H)omogeneous system: SyzygiesGeneratorsOfRows/Columns
                             busy := "\033[01m\033[4;31;40m",
                             done := "\033[01m\033[4;32;40m",
                             ),
            
            matrix_logic_infolevels := [ InfoCOLEM, InfoLIMAT ],
            
            color_display := false,
            
            PreferDenseMatrices := false,
            
            ByASmallerPresentationDoesNotDecideZero := false,
            
            Intersect_uses_ReducedBasisOfModule := true,
            
            SubQuotient_uses_Intersect := false,
            
            MaximumNumberOfResolutionSteps := 1001,
            
            RandomSource := GlobalMersenneTwister,
            
           )
);

####################################
#
# global functions:
#
####################################

##  <#GAPDoc Label="homalgMode">
##  <ManSection>
##    <Meth Arg="str[, str2]" Name="homalgMode"/>
##    <Description>
##      This function sets different modes which influence how much of the basic matrix operations and
##      the logical matrix methods become visible (&see; Appendices <Ref Chap="Basic_Operations"/>, <Ref Chap="Logic"/>).
##      Handling the string <A>str</A> is <E>not</E> case-sensitive.
##      If a second string <A>str2</A> is given, then <C>homalgMode</C>( <A>str2</A> ) is invoked at the end.
##      In case you let &homalg; delegate matrix operations to an external system the you might also want to
##      check <C>homalgIOMode</C> in the &HomalgToCAS; package manual.
##      <Table Align="l|c|l">
##      <Row>
##        <Item><A>str</A></Item>
##        <Item><A>str</A> (long form)</Item>
##        <Item>mode description</Item>
##      </Row>
##      <HorLine/>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>""</Item>
##        <Item>""</Item>
##        <Item>the default mode, i.e. the computation protocol won't be visible</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item>(<C>homalgMode</C>( ) is a short form for <C>homalgMode</C>( "" ))</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"b"</Item>
##        <Item>"basic"</Item>
##        <Item>make the basic matrix operations visible + <C>homalgMode</C>( "logic" )</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"d"</Item>
##        <Item>"debug"</Item>
##        <Item>same as "basic" but also makes <C>Row/ColumnReducedEchelonForm</C> visible</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"l"</Item>
##        <Item>"logic"</Item>
##        <Item>make the logical methods in &LIMAT; and &COLEM; visible</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <HorLine/>
##      </Table>
##      All modes other than the "default"-mode only set their specific values and leave
##      the other values untouched, which allows combining them to some extent. This also means that
##      in order to get from one mode to a new mode (without the aim to combine them)
##      one needs to reset to the "default"-mode first. This can be done using <C>homalgMode</C>( "", new_mode );
##      <Listing Type="Code"><![CDATA[
InstallGlobalFunction( homalgMode,
  function( arg )
    local nargs, mode, s;
    
    nargs := Length( arg );
    
    if nargs = 0 or ( IsString( arg[1] ) and arg[1] = "" ) then
        mode := "default";
    elif IsString( arg[1] ) then	## now we know, the string is not empty
        s := arg[1];
        if LowercaseString( s{[1]} ) = "b" then
            mode := "basic";
        elif LowercaseString( s{[1]} ) = "d" then
            mode := "debug";
        elif LowercaseString( s{[1]} ) = "l" then
            mode := "logic";
        else
            mode := "";
        fi;
    else
        Error( "the first argument must be a string\n" );
    fi;
    
    if mode = "default" then
        HOMALG_MATRICES.color_display := false;
        for s in HOMALG_MATRICES.matrix_logic_infolevels do
            SetInfoLevel( s, 1 );
        od;
        SetInfoLevel( InfoHomalgBasicOperations, 1 );
    elif mode = "basic" then
        SetInfoLevel( InfoHomalgBasicOperations, 3 );
        homalgMode( "logic" );
    elif mode = "debug" then
        SetInfoLevel( InfoHomalgBasicOperations, 4 );
        homalgMode( "logic" );
    elif mode = "logic" then
        HOMALG_MATRICES.color_display := true;
        for s in HOMALG_MATRICES.matrix_logic_infolevels do
            SetInfoLevel( s, 2 );
        od;
    fi;
    
    if nargs > 1 and IsString( arg[2] ) then
        homalgMode( arg[2] );
    fi;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
