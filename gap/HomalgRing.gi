#############################################################################
##
##  HomalgRing.gi               homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, RWTH Aachen
##
##  Implementation stuff for homalg rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgInternalRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgInternalRingRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The internal representation of &homalg; rings. <P/>
##      (It is a subrepresentation of the &GAP; representation <Br/>
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgInternalRingRep",
        IsHomalgRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring", "homalgTable" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgRings",
        NewFamily( "TheFamilyOfHomalgRings" ) );

# a new type:
BindGlobal( "TheTypeHomalgInternalRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgInternalRingRep ) );

# a new family:
BindGlobal( "TheFamilyOfHomalgRingElements",
        NewFamily( "TheFamilyOfHomalgRingElements" ) );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( Zero,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( R )
    
    return Zero( R!.ring );
    
end );

##
InstallMethod( One,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( R )
    
    return One( R!.ring );
    
end );

##
InstallMethod( MinusOne,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( R )
    
    return -One( R!.ring );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg rings",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return Zero( HomalgRing( r ) );
    
end );

##
InstallMethod( OneMutable,
        "for homalg rings",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return One( HomalgRing( r ) );
    
end );

##
InstallMethod( MinusOneMutable,
        "for homalg rings",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return MinusOne( HomalgRing( r ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return R;
    
end );

##
InstallMethod( HomalgRing,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return r!.ring;
    
end );

##
InstallMethod( Indeterminates,
        "for homalg rings",
        [ IsHomalgRing and HasIndeterminatesOfPolynomialRing ],
        
  function( R )
    
    return IndeterminatesOfPolynomialRing( R );
    
end );

##
InstallMethod( Indeterminates,
        "for homalg rings",
        [ IsHomalgRing and HasIndeterminatesOfExteriorRing ],
        
  function( R )
    
    return IndeterminatesOfExteriorRing( R );
    
end );

InstallMethod( Indeterminate,
        "for homalg rings",
        [ IsHomalgRing, IsPosInt ],
        
  function( R, i )
    
    return Indeterminates( R )[i];
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for ring elements",
        [ IsRingElement ],
        
  function( r )
    
    return fail;
    
end );

##
InstallMethod( \=,
        "for two homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( r1, r2 )
    
    if IsIdenticalObj( HomalgRing( r1 ), HomalgRing( r2 ) ) then
        return IsZero( r1 - r2 );
    fi;
    
    return false;
    
end );

##
InstallMethod( RingName,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    local RP, c, v, r;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.RingName) then
        if IsFunction( RP!.RingName ) then
            return RP!.RingName( R );
        else
            return RP!.RingName;
        fi;
    elif HasName( R ) then
        return Name( R );
    elif HasCharacteristic( R ) then
        
        c := Characteristic( R );
        
        if HasIndeterminatesOfPolynomialRing( R ) then
            v := IndeterminatesOfPolynomialRing( R );
            if ForAll( v, HasName ) then
                v := List( v, Name );
            elif Length( v ) = 1 then
                v := [ "x" ];
            else
                v := List( [ 1 .. Length( v ) ], i -> Flat( [ "x", String( i ) ] ) );
            fi;
            v := JoinStringsWithSeparator( v );
            if IsPrime( c ) then
                return Flat( [ "GF(", String( c ), ")[", v, "]" ] );
            elif c = 0 then
                r := CoefficientsRing( R );
                if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
                    return Flat( [ "Z[", v, "]" ] );
                elif HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) then
                    return Flat( [ "Q[", v, "]" ] );
                fi;
            fi;
        elif c = 0 then
            if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) then
                return "Z";
            else
                return "Q";
            fi;
        elif IsPrime( c ) then
            return Flat( [ "GF(", String( c ), ")" ] );
        else
            return Flat( [ "Z/", String( c ), "Z" ] );
        fi;
        
    fi;
    
    return "couldn't find a way to display";
        
end );

##
InstallMethod( homalgRingStatistics,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return R!.statistics;
    
end );

##
InstallMethod( IncreaseRingStatistics,
        "for homalg rings",
        [ IsHomalgRing, IsString ],
        
  function( R, s )
    
    R!.statistics.(s) := R!.statistics.(s) + 1;
    
end );

##
InstallMethod( DecreaseRingStatistics,
        "for homalg rings",
        [ IsHomalgRing, IsString ],
        
  function( R, s )
    
    R!.statistics.(s) := R!.statistics.(s) - 1;
    
end );

##
InstallOtherMethod( AsList,
        "for homalg internal rings",
        [ IsHomalgInternalRingRep ],
        
  function( r )
    
    return AsList( r!.ring );
    
end );

##
InstallMethod( homalgSetName,
        "for homalg rings",
        [ IsHomalgRingElement, IsString ],
        
  SetName );

##
InstallMethod( SetRingProperties,
        "for homalg rings",
        [ IsHomalgRing and IsFreePolynomialRing, IsHomalgRing, IsList ],
        
  function( S, R, var )
    local d;
    
    d := Length( var );
    
    SetCoefficientsRing( S, R );
    
    if HasCharacteristic( R ) then
        SetCharacteristic( S, Characteristic( R ) );
    fi;
    
    SetIsCommutative( S, true );
    
    SetIndeterminatesOfPolynomialRing( S, var );
    
    if HasContainsAField( R ) and ContainsAField( R ) then
        SetContainsAField( S, true );
    fi;
    
    if d > 0 then
        SetIsLeftArtinian( S, false );
        SetIsRightArtinian( S, false );
    fi;
    
    if HasGlobalDimension( R ) then
        SetGlobalDimension( S, d + GlobalDimension( R ) );
    fi;
    
    if HasKrullDimension( R ) then
        SetKrullDimension( S, d + KrullDimension( R ) );
    fi;
    
    SetGeneralLinearRank( S, 1 );	## Quillen-Suslin Theorem (see [McCRob, 11.5.5]
    
    if d = 1 then			## [McCRob, 11.5.7]
        SetElementaryRank( S, 1 );
    elif d > 2 then
        SetElementaryRank( S, 2 );
    fi;
    
    SetIsIntegralDomain( S, true );
    
    SetBasisAlgorithmRespectsPrincipalIdeals( S, true );
    
end );

##
InstallMethod( SetRingProperties,
        "for homalg rings",
        [ IsHomalgRing and IsWeylRing, IsHomalgRing and IsFreePolynomialRing, IsList ],
        
  function( S, R, der )
    local r, var, d;
    
    r := CoefficientsRing( R );
    
    var := IndeterminatesOfPolynomialRing( R );
    
    d := Length( var );
    
    SetCoefficientsRing( S, r );
    
    SetCharacteristic( S, Characteristic( R ) );
    
    SetIsCommutative( S, false );
    
    SetIndeterminateCoordinatesOfRingOfDerivations( S, var );
    
    SetIndeterminateDerivationsOfRingOfDerivations( S, der );
    
    if d > 0 then
        SetIsLeftArtinian( S, false );
        SetIsRightArtinian( S, false );
    fi;
    
    SetIsLeftNoetherian( S, true );
    SetIsRightNoetherian( S, true );
    
    if HasGlobalDimension( r ) then
        SetGlobalDimension( S, d + GlobalDimension( r ) );
    fi;
    
    if HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) and Characteristic( S ) = 0 then
        SetGeneralLinearRank( S, 2 );	## [Stafford78], [McCRob, 11.2.15(i)]
        SetIsSimpleRing( S, true );	## [Coutinho, Thm 2.2.1]
    fi;
    
    if HasIsIntegralDomain( r ) and IsIntegralDomain( r ) then
        SetIsIntegralDomain( S, true );
    fi;
    
    SetBasisAlgorithmRespectsPrincipalIdeals( S, true );
    
end );

##
InstallMethod( SetRingProperties,
        "for homalg rings",
        [ IsHomalgRing and IsExteriorRing, IsHomalgRing and IsFreePolynomialRing, IsList ],
        
  function( S, R, anti )
    local r, d, comm, T;
    
    r := CoefficientsRing( R );
    
    d := Length( anti );
    
    SetCoefficientsRing( S, r );
    
    SetCharacteristic( S, Characteristic( R ) );
    
    SetIsCommutative( S, d = 0 );
    
    SetIsAnticommutative( S, true );
    
    SetIsIntegralDomain( S, d = 0 );
    
    comm := [ ];
    
    if HasBaseRing( R ) then
        T := BaseRing( R );
        if HasIndeterminatesOfPolynomialRing( T ) then
            comm := IndeterminatesOfPolynomialRing( T );
        fi;
    fi;
    
    SetIndeterminateAntiCommutingVariablesOfExteriorRing( S, anti );
    
    SetIndeterminatesOfExteriorRing( S, Concatenation( comm, anti ) );
    
    SetBasisAlgorithmRespectsPrincipalIdeals( S, true );
    
end );

##
InstallMethod( SetRingProperties,
        "for homalg rings",
        [ IsHomalgRing and IsResidueClassRingOfTheIntegers, IsInt ],
        
  function( R, c )
    local RP, powers;
    
    RP := homalgTable( R );
    
    SetCharacteristic( R, c );
    
    if c = 0 then
        SetIsIntegersForHomalg( R, true );
        SetContainsAField( R, false );
        SetIsArtinian( R, false );
        SetKrullDimension( R, 1 );	## FIXME: it is not set automatically although an immediate method is installed
    elif IsPrime( c ) then
        SetIsFieldForHomalg( R, true );
        SetRingProperties( R, c );
    else
        SetIsSemiLocalRing( R, true );
        SetIsIntegralDomain( R, false );
        powers := List( Collected( FactorsInt( c ) ), a -> a[2] );
        if Set( powers ) = [ 1 ] then
            SetIsSemiSimpleRing( R, true );
        else
            SetIsRegular( R, false );
            if Length( powers ) = 1 then
                SetIsLocalRing( R, true );
            fi;
        fi;
        SetKrullDimension( R, 0 );
    fi;
    
    if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        if IsBound( RP!.RowRankOfMatrixOverDomain ) then
            RP!.RowRankOfMatrix := RP!.RowRankOfMatrixOverDomain;
        fi;
        
        if IsBound( RP!.ColumnRankOfMatrixOverDomain ) then
            RP!.ColumnRankOfMatrix := RP!.ColumnRankOfMatrixOverDomain;
        fi;
    fi;
    
    SetBasisAlgorithmRespectsPrincipalIdeals( R, true );
    
end );

##
InstallMethod( SetRingProperties,
        "for homalg rings",
        [ IsHomalgRing and IsFieldForHomalg, IsInt ],
        
  function( R, c )
    local RP;
    
    RP := homalgTable( R );
    
    SetCharacteristic( R, c );
    
    if IsBound( RP!.RowRankOfMatrixOverDomain ) then
        RP!.RowRankOfMatrix := RP!.RowRankOfMatrixOverDomain;
    fi;
    
    if IsBound( RP!.ColumnRankOfMatrixOverDomain ) then
        RP!.ColumnRankOfMatrix := RP!.ColumnRankOfMatrixOverDomain;
    fi;
    
    SetBasisAlgorithmRespectsPrincipalIdeals( R, true );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( CreateHomalgRing,
  function( arg )
    local nargs, r, statistics, asserts, homalg_ring, table, properties,
          ar, type, matrix_type, ring_element_constructor, c, el;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "expecting a ring as the first argument\n" );
    fi;
    
    r := arg[1];
    
    statistics := rec(
                      BasisOfRowModule := 0,
                      BasisOfColumnModule := 0,
                      BasisOfRowsCoeff := 0,
                      BasisOfColumnsCoeff := 0,
                      DecideZeroRows := 0,
                      DecideZeroColumns := 0,
                      DecideZeroRowsEffectively := 0,
                      DecideZeroColumnsEffectively := 0,
                      SyzygiesGeneratorsOfRows := 0,
                      SyzygiesGeneratorsOfColumns := 0,
                      RelativeSyzygiesGeneratorsOfRows := 0,
                      RelativeSyzygiesGeneratorsOfColumns := 0,
                      ReducedBasisOfRowModule := 0,
                      ReducedBasisOfColumnModule := 0,
                      ReducedSyzygiesGeneratorsOfRows := 0,
                      ReducedSyzygiesGeneratorsOfColumns := 0
                      );
    
    asserts := rec(
                   BasisOfRowsCoeff := function( B, T, M ) return B = T * M; end,
                   BasisOfColumnsCoeff := function( B, M, T ) return B = M * T; end,
                   DecideZeroRowsEffectively := function( M, A, T, B ) return M = A + T * B; end,
                   DecideZeroColumnsEffectively := function( M, A, B, T ) return M = A + B * T; end,
                  );
    
    homalg_ring := rec( ring := r, statistics := statistics, asserts := asserts );
    
    if nargs > 1 and IshomalgTable( arg[nargs] ) then
        table := arg[nargs];
    else
        table := CreateHomalgTable( r );
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if IsFilter( ar ) then
            Add( properties, ar );
        elif not IsBound( type ) and IsList( ar ) and Length( ar ) = 2 and ForAll( ar, IsType ) then
            type := ar;
        elif not IsBound( ring_element_constructor ) and IsFunction( ar ) then
            ring_element_constructor := ar;
        fi;
    od;
    
    if IsBound( type ) then
        matrix_type := type[2];
        type := type[1];
    elif IsSemiringWithOneAndZero( r ) then
        matrix_type := ValueGlobal( "TheTypeHomalgInternalMatrix" ); ## will be defined later in HomalgMatrix.gi
        type := TheTypeHomalgInternalRing;
    else
        Error( "the types of the ring and matrices were not specified\n" );
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            homalg_ring, type,
            homalgTable, table );
    
    if IsBound( matrix_type ) then
        SetTypeOfHomalgMatrix( homalg_ring, matrix_type );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( homalg_ring, true );
        od;
    fi;
    
    if IsBound( HOMALG.RingCounter ) then
        HOMALG.RingCounter := HOMALG.RingCounter + 1;
    else
        HOMALG.RingCounter := 1;
    fi;
    
    ## this has to be done before we call
    ## ring_element_constructor below
    homalg_ring!.creation_number := HOMALG.RingCounter;
    
    ## do not invoke SetRingProperties here, since I might be
    ## the first step of creating a residue class ring!
    
    ## add distinguished ring elements like 0 and 1
    ## (sometimes also -1) to the homalg table:
    if IsBound( ring_element_constructor ) then
        
        for c in NamesOfComponents( table ) do
            if IsRingElement( table!.(c) ) then
                table!.(c) := ring_element_constructor( table!.(c), homalg_ring );
            fi;
        od;
        
        ## set the attribute
        SetRingElementConstructor( homalg_ring, ring_element_constructor );
        
    fi;
    
    homalg_ring!.AsLeftModule := HomalgFreeLeftModule( 1, homalg_ring );
    homalg_ring!.AsRightModule := HomalgFreeRightModule( 1, homalg_ring );
    
    homalg_ring!.AsLeftModule!.distinguished := true;
    homalg_ring!.AsRightModule!.distinguished := true;
    
    homalg_ring!.AsLeftModule!.not_twisted := true;
    homalg_ring!.AsRightModule!.not_twisted := true;
    
    homalg_ring!.ZeroLeftModule := HomalgZeroLeftModule( homalg_ring );
    homalg_ring!.ZeroRightModule := HomalgZeroRightModule( homalg_ring );
    
    homalg_ring!.ZeroLeftModule!.distinguished := true;
    homalg_ring!.ZeroRightModule!.distinguished := true;
    
    if IsBound( HOMALG.ByASmallerPresentation ) and HOMALG.ByASmallerPresentation = true then
        homalg_ring!.ByASmallerPresentation := true;
    fi;
    
    ## e.g. needed to construct residue class rings
    homalg_ring!.ConstructorArguments := arg;
    
    return homalg_ring;
    
end );

##  <#GAPDoc Label="HomalgRingOfIntegers">
##  <ManSection>
##    <Func Arg="" Name="HomalgRingOfIntegers" Label="constructor for the integers"/>
##    <Returns>a &homalg; ring</Returns>
##    <Func Arg="c" Name="HomalgRingOfIntegers" Label="constructor for the residue class rings of the integers"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The no-argument form returns the ring of integers <M>&ZZ;</M> for &homalg;. <P/>
##      The one-argument form accepts an integer <A>c</A> and returns
##      the ring <M>&ZZ; / c </M> for &homalg;:
##      <List>
##        <Item><A>c</A><M> = 0</M> defaults to <M>&ZZ;</M></Item>
##        <Item>if <A>c</A> is a prime power then the package &GaussForHomalg; is loaded (if it fails to load an error is issued)</Item>
##        <Item>otherwise, the residue class ring constructor <C>/</C>
##          (&see; <Ref Oper="\/" Label="constructor for residue class rings" Style="Number"/>) is invoked</Item>
##      </List>
##      The operation <C>SetRingProperties</C> is automatically invoked to set the ring properties. <P/>
##      If for some reason you don't want to use the &GaussForHomalg; package (maybe because you didn't install it), then use<P/>
##      <C>HomalgRingOfIntegers</C>( ) <C>/</C> <A>c</A>; <P/>
##      but note that the computations will then be considerably slower.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgRingOfIntegers,
  function( arg )
    local nargs, R, c, rel;
    
    nargs := Length( arg );
    
    if nargs = 0 or arg[1] = 0 then
        c := 0;
        R := CreateHomalgRing( Integers );
    elif IsInt( arg[1] ) then
        c := arg[1];
        if Length( Collected( FactorsInt( c ) ) ) = 1 then
            if LoadPackage( "GaussForHomalg" ) <> true then
                Error( "the package GaussForHomalg failed to load\n" );
            fi;
            if IsPrime( c ) then
                R := CreateHomalgRing( GF( c ) );
            else
                R := CreateHomalgRing( ZmodnZ( c ) );
            fi;
        else
            R := HomalgRingOfIntegers( );
            rel := HomalgRelationsForLeftModule( [ c ], R );
            return R / rel;
        fi;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##  <#GAPDoc Label="HomalgFieldOfRationals">
##  <ManSection>
##    <Func Arg="" Name="HomalgFieldOfRationals" Label="constructor for the field of rationals"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The package &GaussForHomalg; is loaded and the field of rationals <M>&QQ;</M> is returned.
##      If &GaussForHomalg; fails to load an error is issued. <P/>
##      The operation <C>SetRingProperties</C> is automatically invoked to set the ring properties.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgFieldOfRationals,
  function( arg )
    local R;
    
    if LoadPackage( "GaussForHomalg" ) <> true then
        Error( "the package GaussForHomalg failed to load\n" );
    fi;
    
    R := CreateHomalgRing( Rationals );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( ParseListOfIndeterminates,
        "for lists",
        [ IsList ],
        
  function( _indets )
    local err, l, indets, i, v, p1, p2, c;
    
    err := function( ) Error( "a list of variable strings or range strings is expected\n" ); end;
    
    if ForAll( _indets, IsRingElement and HasName ) then
        return ParseListOfIndeterminates( List( _indets, Name ) );
    fi;
    
    if not ForAll( _indets, e -> IsStringRep( e ) or ( IsList( e ) and ForAll( e, IsInt ) ) ) then
        TryNextMethod( );
    fi;
    
    l := Length( _indets );
    
    indets := [ ];
    
    for i in [ 1 .. l ] do
        v := _indets[i];
        if Position( v, ',' ) <> fail then
            err( );
        elif ForAll( v, IsInt ) then
            ## do nothing
        elif Position( v, '.' ) = fail then
            if i < l and ForAll( _indets[ i + 1 ], IsInt ) then
                Append( indets, List( _indets[ i + 1 ], i -> Concatenation( v, String( i ) ) ) );
            else
                Add( indets, v );
            fi;
        elif PositionSublist( v, ".." ) = fail then
            err( );
        else
            v := SplitString( v, "." );
            v := Filtered( v, s -> not IsEmpty( s ) );
            if Length( v ) <> 2 then
                err( );
            fi;
            p1 := PositionProperty( v[1], c -> Position( "0123456789", c ) <> fail );
            p2 := PositionProperty( v[2], c -> Position( "0123456789", c ) <> fail );
            if p1 = fail or p2 = fail or p1 = 1 then
                err( );
            fi;
            c := v[1]{[ 1 .. p1 - 1 ]};
            if p1 = p2 and c <> v[2]{[ 1 .. p2 - 1 ]} then
                err( );
            fi;
            p1 := EvalString( v[1]{[ p1 .. Length( v[1] ) ]} );
            p2 := EvalString( v[2]{[ p2 .. Length( v[2] ) ]} );
            Append( indets, List( [ p1 .. p2 ], i -> Concatenation( c, String( i ) ) ) );
        fi;
    od;
    
    return indets;
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgRing, IsList ], 1001,	## a high rank is necessary to overwrite the default behaviour of applying R to each list element
        
  function( R, indets )
    
    return PolynomialRing( R, ParseListOfIndeterminates( indets ) );
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgRing, IsString ], 1001, ## for this method to be triggered first it has to have at least the same rank as the above method
        
  function( R, indets )
    
    return R * SplitString( indets, "," );
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgRing and IsFreePolynomialRing and HasCoefficientsRing,
          IsHomalgRing and IsFreePolynomialRing and HasCoefficientsRing ],
        
  function( R1, R2 )
    local r, var2;
    
    r := CoefficientsRing( R1 );
    
    if not IsIdenticalObj( r, CoefficientsRing( R2 ) ) then
        TryNextMethod( );
    fi;
    
    var2 := IndeterminatesOfPolynomialRing( R2 );
    var2 := List( var2, Name );
    var2 := JoinStringsWithSeparator( var2 );
    
    return PolynomialRing( R1, var2 );
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings",
        [ IsHomalgRing and IsCommutative, IsString ], 1001,
        
  function( S, _der )
    local der, A;
    
    der := ParseListOfIndeterminates( SplitString( _der, "," ) );
    
    A := RingOfDerivations( S, der );
    
    S!.RingOfDerivations := A;
    
    return A;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings",
        [ IsHomalgRing and IsCommutative ],
        
  function( S )
    
    if IsBound(S!.RingOfDerivations) then
        return S!.RingOfDerivations;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings",
        [ IsHomalgRing and IsFreePolynomialRing, IsList ],
        
  function( S, _anti )
    local anti;
    
    if IsString( _anti ) then
        return ExteriorRing( S, SplitString( _anti, "," ) );
    else
        anti := ParseListOfIndeterminates( _anti );
    fi;
    
    if HasBaseRing( S ) then
        return ExteriorRing( S, BaseRing( S ), anti );
    else
        return ExteriorRing( S, CoefficientsRing( S ), anti );
    fi;
    
end );

##
InstallMethod( KoszulDualRing,
        "for homalg rings",
        [ IsHomalgRing and IsFreePolynomialRing, IsList ],
        
  function( S, anti )
    local A;
    
    if IsBound(S!.KoszulDualRing) then
        return S!.KoszulDualRing;
    fi;
    
    A := ExteriorRing( S, anti );
    
    ## thanks GAP4
    A!.KoszulDualRing := S;
    S!.KoszulDualRing := A;
    
    return A;
    
end );

##
InstallMethod( KoszulDualRing,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( S )
    
    if IsBound(S!.KoszulDualRing) then
        return S!.KoszulDualRing;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallGlobalFunction( HomalgRingElement,
  function( arg )
    local nargs, R, constructor;
    
    nargs := Length( arg );
    
    R := arg[nargs];
    
    if HasRingElementConstructor( R ) then
        constructor := RingElementConstructor( R );
    elif not IsHomalgInternalRingRep( R ) then
        Error( "the non-internal homalg ring must contain a ring element constructor as the attribute RingElementConstructor\n" );
    elif IsString( arg[1] ) then
        return EvalString( arg[1] );
    else
        return arg[1];
    fi;
    
    return CallFuncList( constructor, arg );
    
end );

##
InstallMethod( \/,
        "for ring elements",
        [ IsRingElement, IsHomalgRing ],
        
  function( r, R )
    
    return HomalgRingElement( String( r ), R );
    
end );

##
InstallMethod( \/,
        "for homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRing ],
        
  function( r, R )
    
    if IsIdenticalObj( HomalgRing( r ), R ) then
        return r;
    fi;
    
    return HomalgRingElement( String( r ), R );
    
end );

##
InstallGlobalFunction( StringToElementStringList,
  function( arg )
    
    return SplitString( arg[1], ",", "[ ]\n" );
    
end );

##
InstallGlobalFunction( _CreateHomalgRingToTestProperties,
  function( arg )
    local homalg_ring, type;
    
    homalg_ring := rec( );
    
    type := TheTypeHomalgInternalRing;
    
    ## Objectify:
    CallFuncList( ObjectifyWithAttributes, Concatenation([ homalg_ring, type ], arg ) );
    
    return homalg_ring;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( o )
    
    Print( "<A " );
    
    if IsPreHomalgRing( o ) then
        Print( "pre-" );
    fi;
    
    Print( "homalg internal ring>" );
    
end );

##
InstallMethod( Display,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( o )
    
    Print( RingName( o ), "\n" );
    
end );

##
InstallMethod( DisplayRing,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( o )
    
    Display( o );
    
end );

##
InstallMethod( ViewObj,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( o )
    
    Print( Name( o ) );	## this sets the attribute Name and the view method is never triggered again (as long as Name is set)
    
end );

