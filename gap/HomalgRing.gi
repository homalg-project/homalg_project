#############################################################################
##
##  HomalgRing.gi               homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

# two new representations for the GAP-category IsHomalgRing
# which are subrepresentations of IsHomalgRingOrFinitelyPresentedModuleRep:
DeclareRepresentation( "IsHomalgInternalRingRep",
        IsHomalgRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring", "homalgTable" ] );

DeclareRepresentation( "IsHomalgExternalRingRep",
        IsHomalgRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring", "homalgTable" ] );

# a new representation for the GAP-category IsHomalgExternalRingElement:
DeclareRepresentation( "IsHomalgExternalRingElementRep",
        IshomalgExternalObjectRep and IsHomalgExternalRingElement,
        [ "object", "cas" ] );

# a new subrepresentation of the representation IsContainerForWeakPointersRep:
DeclareRepresentation( "IsContainerForWeakPointersOnHomalgExternalRingsRep",
        IsContainerForWeakPointersRep,
        [ "weak_pointers", "streams", "counter", "deleted" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgRings",
        NewFamily( "TheFamilyOfHomalgRings" ) );

# two new types:
BindGlobal( "TheTypeHomalgInternalRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgInternalRingRep ) );

BindGlobal( "TheTypeHomalgExternalRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingRep ) );

# two new families:
BindGlobal( "TheFamilyOfHomalgExternalRingElements",
        NewFamily( "TheFamilyOfHomalgExternalRingElements" ) );

BindGlobal( "TheFamilyOfHomalgExternalRingElementsWithIOStream",
        NewFamily( "TheFamilyOfHomalgExternalRingElementsWithIOStream" ) );

# two new types:
BindGlobal( "TheTypeHomalgExternalRingElement",
        NewType( TheFamilyOfHomalgExternalRingElements,
                IsHomalgExternalRingElementRep ) );

BindGlobal( "TheTypeHomalgExternalRingElementWithIOStream",
        NewType( TheFamilyOfHomalgExternalRingElementsWithIOStream,
                IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ) );

# a new family:
BindGlobal( "TheFamilyOfContainersForWeakPointersOnHomalgExternalRings",
        NewFamily( "TheFamilyOfContainersForWeakPointersOnHomalgExternalRings" ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnHomalgExternalRings",
        NewType( TheFamilyOfContainersForWeakPointersOnHomalgExternalRings,
                IsContainerForWeakPointersOnHomalgExternalRingsRep ) );

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
        [ IsHomalgExternalRingElementRep ],
        
  function( r )
    
    return Zero( HomalgRing( r ) );
    
end );

##
InstallMethod( OneMutable,
        "for homalg rings",
        [ IsHomalgExternalRingElementRep ],
        
  function( r )
    
    return One( HomalgRing( r ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgStream,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( o )
    
    return homalgStream( HomalgRing( o ) );
    
end );

##
InstallMethod( HomalgRing,
        "for external homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r )
    
    return r!.ring;
    
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
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep,
          IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r1, r2 )
    local R, RP;
    
    if not IsIdenticalObj( homalgStream( r1 ), homalgStream( r2 ) ) then
        return false;
    elif homalgPointer( r1 ) = homalgPointer( r2 ) then
        return true;
    fi;
    
    return IsZero( r1 - r2 );
    
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
InstallOtherMethod( AsList,
        "for external homalg ring elements",
        [ IsHomalgInternalRingRep ],
        
  function( r )
    
    return AsList( r!.ring );
    
end );

##
InstallMethod( AsLeftModule,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return R!.AsLeftModule;
    
end );

##
InstallMethod( AsRightModule,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return R!.AsRightModule;
    
end );

##
InstallMethod( homalgSetName,
        "for homalg rings",
        [ IsHomalgExternalRingElementRep, IsString ],
        
  function( r, name )
    
    SetName( r, name );
    
end );

##
InstallMethod( SetRingProperties,
        "constructor",
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

##
InstallMethod( SetRingProperties,
        "constructor",
        [ IsHomalgRing and IsResidueClassRingOfTheIntegers, IsInt ],
        
  function( R, c )
    local RP, powers;
    
    RP := homalgTable( R );
    
    SetCharacteristic( R, c );
    
    if c = 0 then
        SetIsIntegersForHomalg( R, true );
        SetContainsAField( R, false );
        SetKrullDimension( R, 1 );	## FIXME: it is not set automatically although an immediate method is installed
    elif IsPrime( c ) then
        SetIsFieldForHomalg( R, true );
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
        "constructor",
        [ IsHomalgRing and IsFreePolynomialRing, IsHomalgRing, IsList ],
        
  function( S, R, var )
    local d;
    
    d := Length( var );
    
    SetCoefficientsRing( S, R );
    SetCharacteristic( S, Characteristic( R ) );
    SetIsCommutative( S, true );
    SetIndeterminatesOfPolynomialRing( S, var );
    SetGlobalDimension( S, d );
    SetKrullDimension( S, d + KrullDimension( R ) );
    SetGeneralLinearRank( S, 1 );	## Quillen-Suslin Theorem (see [McCRob, 11.5.5]
    if d = 1 then			## [McCRob, 11.5.7]
        SetElementaryRank( S, 1 );
    elif d > 2 then
        SetElementaryRank( S, 2 );
    fi;
          
    SetIsIntegralDomain( S, true );
    
end );

##
InstallMethod( SetRingProperties,
        "constructor",
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
    SetGlobalDimension( S, d );
    if HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) and Characteristic( S ) = 0 then
        SetGeneralLinearRank( S, 2 );	## [Stafford78, McCRob, 11.2.15(i)]
        SetIsSimpleRing( S, true );
    fi;
    if HasIsIntegralDomain( r ) and IsIntegralDomain( r ) then
        SetIsIntegralDomain( S, true );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

HOMALG.ContainerForWeakPointersOnHomalgExternalRings :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnHomalgExternalRings, [ "streams", [ ] ] );

##
InstallGlobalFunction( CreateHomalgRing,
  function( arg )
    local nargs, r, statistics, homalg_ring, table, properties, ar, type, c,
          el, container, weak_pointers, l, deleted, streams;
    
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
                      SyzygiesGeneratorsOfColumns := 0
                      );
    
    homalg_ring := rec( ring := r, statistics := statistics );
    
    if nargs > 1 and IshomalgTable( arg[nargs] ) then
        table := arg[nargs];
    else
        table := CreateHomalgTable( r );
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if IsFilter( ar ) then
            Add( properties, ar );
        elif not IsBound( type ) and IsType( ar ) then
            type := ar;
        fi;
    od;
    
    if not IsBound( type ) then
        if IsSemiringWithOneAndZero( arg[1] ) then
            type := TheTypeHomalgInternalRing;
        else
            type := TheTypeHomalgExternalRing;
        fi;
    fi;
    
    ## Objectify:
    ObjectifyWithAttributes(
            homalg_ring, type,
            homalgTable, table );
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( homalg_ring, true );
        od;
    fi;
    
    if IsRing( r ) then
        SetCharacteristic( homalg_ring, Characteristic( r ) );
    fi;
    
    if HasIsField( r ) then
        SetIsFieldForHomalg( homalg_ring, IsField( r ) );
    fi;
    
    if IsIntegers( r ) then
        SetIsIntegersForHomalg( homalg_ring, true );
    fi;
    
    for c in NamesOfComponents( table ) do
        if IsHomalgExternalRingElementRep( table!.( c ) ) then
            el := table!.( c );
            properties := KnownTruePropertiesOfObject( el );
            ar := [ homalgPointer( el ), homalgExternalCASystem( el ), homalg_ring ];
            Append( ar, List( properties, ValueGlobal ) );
            table!.( c ) := CallFuncList( HomalgExternalRingElement, ar );
        fi;
    od;
    
    homalg_ring!.AsLeftModule := HomalgFreeLeftModule( 1, homalg_ring );
    homalg_ring!.AsRightModule := HomalgFreeRightModule( 1, homalg_ring );
    
    homalg_ring!.AsLeftModule!.distinguished := true;
    homalg_ring!.AsRightModule!.distinguished := true;
    
    homalg_ring!.ZeroLeftModule := HomalgZeroLeftModule( homalg_ring );
    homalg_ring!.ZeroRightModule := HomalgZeroRightModule( homalg_ring );
    
    homalg_ring!.ZeroLeftModule!.distinguished := true;
    homalg_ring!.ZeroRightModule!.distinguished := true;
    
    if IsHomalgExternalRingRep( homalg_ring ) then
        
        container := HOMALG.ContainerForWeakPointersOnHomalgExternalRings;
        
        weak_pointers := container!.weak_pointers;
        
        l := container!.counter;
        
        deleted := Filtered( [ 1 .. l ], i -> not IsBoundElmWPObj( weak_pointers, i ) );
        
        container!.deleted := deleted;
        
        l := l + 1;
        
        container!.counter := l;
        
        SetElmWPObj( weak_pointers, l, homalg_ring );
        
        streams := container!.streams;
        
        if not homalgExternalCASystemPID( homalg_ring ) in List( streams, s -> s.pid ) then
            Add( streams, homalgStream( homalg_ring ) );
        fi;
        
    fi;
    
    if IsBound( HOMALG.RingCounter ) then
        HOMALG.RingCounter := HOMALG.RingCounter + 1;
    else
        HOMALG.RingCounter := 1;
    fi;
    
    homalg_ring!.creation_number := HOMALG.RingCounter;
    
    return homalg_ring;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegers,
  function( arg )
    local nargs, R, c;
    
    nargs := Length( arg );
    
    if nargs = 0 or arg[1] = 0 then
        c := 0;
        R := CreateHomalgRing( Integers );
    elif IsInt( arg[1] ) then
        if LoadPackage( "GaussForHomalg" ) <> true then
            Error( "the package GaussForHomalg failed to load\n" );
        fi;
        c := arg[1];
        if IsPrime( c ) then
            R := CreateHomalgRing( GF( c ) );
        else
            R := CreateHomalgRing( ZmodnZ( c ) );
        fi;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

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
InstallMethod( \*,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    if rank = 0 then
        return R!.ZeroLeftModule;
    elif rank = 1 then
        return AsLeftModule( R );
    elif rank > 1 then
        return HomalgFreeLeftModule( rank, R );
    fi;
    
    Error( "virtual modules are not supported (yet)\n" );
    
end );

##
InstallMethod( \*,
        "constructor",
        [ IsHomalgRing, IsInt ],
        
  function( R, rank )
    
    if rank = 0 then
        return R!.ZeroRightModule;
    elif rank = 1 then
        return AsRightModule( R );
    elif rank > 1 then
        return HomalgFreeRightModule( rank, R );
    fi;
    
    Error( "virtual modules are not supported (yet)\n" );
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgExternalRingRep, IsString ],
        
  function( R, indets )
    
    return PolynomialRing( R, SplitString( indets, "," ) );
    
end );

##
InstallGlobalFunction( HomalgExternalRingElement,
  function( arg )
    local nargs, properties, ar, cas, ring, pointer, r;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgExternalRingElementRep( arg[1] ) then
        return arg[1];
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( cas ) and IsString( ar ) then
            cas := ar;
        elif not IsBound( ring ) and IsHomalgExternalRingRep( ar ) then
            ring := ar;
            cas := homalgExternalCASystem( ring );
        elif IsFilter( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsString, IsHomalgExternalRingRep, IsFilter } bur recieved: ", ar,"\n" );
        fi;
    od;
    
    pointer := arg[1];
    
    if IsBound( ring ) then
        
        if IsFunction( pointer ) then
            pointer := pointer( ring );
        fi;
        
        r := rec( pointer := pointer, cas := cas, ring := ring );
        
        ## Objectify:
        Objectify( TheTypeHomalgExternalRingElementWithIOStream, r );
    else
        r := rec( pointer := pointer, cas := cas );
        
        ## Objectify:
        Objectify( TheTypeHomalgExternalRingElement, r );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( r, true );
        od;
    fi;
    
    return r;
    
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

InstallMethod( ViewObj,
        "for homalg rings",
        [ IsHomalgInternalRingRep ],
        
  function( o )
    
    Print( "<A homalg internal ring>" );
    
end );

InstallMethod( ViewObj,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( o )
    
    Print( "<A homalg external ring residing in the CAS " );
    Print( homalgExternalCASystem( o ), ">" );
    
end );

InstallMethod( Display,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( o )
    
    Print( RingName( o ), "\n" );
    
end );

InstallMethod( DisplayRing,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( o )
    
    Display( o );
    
end );

InstallMethod( Name,
        "for homalg external ring elements",
        [ IsHomalgExternalRingElementRep ],
        
  function( o )
    local pointer;
    
    pointer := homalgPointer( o );
    
    if not IsFunction( pointer ) then
        
        homalgSetName( o, pointer );
        
        return Name( o );
        
    fi;
    
    TryNextMethod( );
    
end );

InstallMethod( ViewObj,
        "for homalg external ring elements",
        [ IsHomalgExternalRingElementRep ],
        
  function( o )
    
    Print( Name( o ) );	## this sets the attribute Name and the view method is never triggered again (as long as Name is set)
    
    #Print( "<A homalg external ring element for the CAS " );
    #Print( homalgExternalCASystem( o ), ">" );
    
end );

InstallMethod( ViewObj,
        "for containers of weak pointers on homalg external rings",
        [ IsContainerForWeakPointersOnHomalgExternalRingsRep ],
        
  function( o )
    local del;
    
    del := Length( o!.deleted );
    
    Print( "<A container of weak pointers on homalg external rings: active = ", o!.counter - del, ", deleted = ", del, ">" );
    
end );

InstallMethod( Display,
        "for containers of weak pointers on homalg external rings",
        [ IsContainerForWeakPointersOnHomalgExternalRingsRep ],
        
  function( o )
    local weak_pointers;
    
    weak_pointers := o!.weak_pointers;
    
    Print( List( [ 1 .. LengthWPObj( weak_pointers ) ], function( i ) if IsBoundElmWPObj( weak_pointers, i ) then return i; else return 0; fi; end ), "\n" );
    
end );

