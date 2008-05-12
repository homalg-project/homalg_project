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

# two new representations for the category IsHomalgRing:
DeclareRepresentation( "IsHomalgInternalRingRep",
        IsHomalgRing,
        [ "ring", "homalgTable" ] );

DeclareRepresentation( "IsHomalgExternalRingRep",
        IsHomalgRing,
        [ "ring", "homalgTable" ] );

# a new representation for the category IsHomalgExternalRingElement
DeclareRepresentation( "IsHomalgExternalRingElementRep",
        IshomalgExternalObjectRep and IsHomalgExternalRingElement,
        [ "object", "cas" ] );

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

####################################
#
# global variables:
#
####################################

InstallValue( SimpleLogicalImplicationsForHomalgRings,
        [ ## listed alphabetically (ignoring left/right):
          
          [ IsEuclideanRing,
            "implies", IsLeftPrincipalIdealRing ],
          
          ##
          
          [ IsIntegersForHomalg,
            "implies", IsPrincipalIdealRing ],
          
          [ IsFieldForHomalg,
            "implies", IsPrincipalIdealRing ],
          
          ## Serre's theorem: IsRegular <=> IsGlobalDimensionFinite:
          
          [ IsRegular,
            "implies", IsGlobalDimensionFinite ],
          
          [ IsGlobalDimensionFinite,
            "implies", IsRegular ],
          
          ##
          
          [ IsIntegralDomain, "and", IsLeftPrincipalIdealRing,
            "imply", IsGlobalDimensionFinite ],
          
          [ IsIntegralDomain, "and", IsRightPrincipalIdealRing,
            "imply", IsGlobalDimensionFinite ],
          
          ##
          
          [ IsCommutative, "and", IsRightNoetherian,
            "imply", IsLeftNoetherian ],
          
          [ IsCommutative, "and", IsLeftNoetherian,
            "imply", IsRightNoetherian ],
          
          ##
          
          [ IsLeftPrincipalIdealRing,
            "implies", IsLeftNoetherian ],
          
          [ IsRightPrincipalIdealRing,
            "implies", IsRightNoetherian ],
          
          ##
          
          [ IsCommutative, "and", IsRightOreDomain,
            "implies", IsLeftOreDomain ],
          
          [ IsCommutative, "and", IsLeftOreDomain,
            "implies", IsRightOreDomain ],
          
          ##
          
          [ IsIntegralDomain, "and", IsLeftNoetherian,
            "implies", IsLeftOreDomain ],
          
          [ IsIntegralDomain, "and", IsRightNoetherian,
            "implies", IsRightOreDomain ],
          
          ##
          
          [ IsCommutative, "and", IsRightPrincipalIdealRing,
            "implies", IsLeftPrincipalIdealRing ],
          
          [ IsCommutative, "and", IsLeftPrincipalIdealRing,
            "implies", IsRightPrincipalIdealRing ] ] );

####################################
#
# logical implications methods:
#
####################################

#LogicalImplicationsForHomalg( SimpleLogicalImplicationsForHomalgRings );

## FIXME: find a way to activate the above line and to delete the following
for property in SimpleLogicalImplicationsForHomalgRings do;
    
    if Length( property ) = 3 then
        
        InstallTrueMethod( property[3],
                property[1] );
        
        InstallImmediateMethod( property[1],
                IsHomalgModule and Tester( property[3] ), 0, ## NOTE: don't drop the Tester here!
                
          function( M )
            if Tester( property[3] )( M ) and not property[3]( M ) then  ## FIXME: find a way to get rid of Tester here
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    elif Length( property ) = 5 then
        
        InstallTrueMethod( property[5],
                property[1] and property[3] );
        
        InstallImmediateMethod( property[1],
                IsHomalgModule and Tester( property[3] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[3] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
               and property[3]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( property[3],
                IsHomalgModule and Tester( property[1] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[1] )( M ) and Tester( property[5] )( M ) ## FIXME: find a way to get rid of the Testers here
               and property[1]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    fi;
    
od;

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
InstallMethod( Zero,
        "for homalg rings",
        [ IsHomalgExternalRingElementRep ],
        
  function( r )
    
    return Zero( HomalgRing( r ) );
    
end );

##
InstallMethod( One,
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
InstallMethod( SUM,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep,
          IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r1, r2 )
    local R, RP, cas;
    
    R := HomalgRing( r1 );
    
    if not IsIdenticalObj( R, HomalgRing( r2 ) ) then
        return Error( "the two elements are not in the same ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Minus) then
        cas := homalgExternalCASystem( R );
        return HomalgExternalRingElement( RP!.Minus( r1, RP!.Minus( Zero( R ), r2 ) ), cas, R ) ;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsZero,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsZero) then
        return RP!.IsZero( r );
    else
        return homalgPointer( r ) = homalgPointer( Zero( R ) ); ## FIXME
    fi;
    
end );

##
InstallMethod( IsOne,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsOne) then
        return RP!.IsOne( r );
    else
        return homalgPointer( r ) = homalgPointer( One( R ) ); ## FIXME
    fi;
    
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
InstallMethod( \/,
        "for external homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep,
          IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep ],
        
  function( a, u )
    local R, RP;
    
    R := HomalgRing( a );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideByUnit) then
        return HomalgExternalRingElement( RP!.DivideByUnit( a, u ), u!.cas, R );
    fi;
    
    Error( "could not find a procedure called DivideByUnit in the homalgTable", RP, "\n" );
    
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

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( CreateHomalgRing,
  function( arg )
    local nargs, r, homalg_ring, table, properties, ar, type, c, el;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "expecting a ring as the first argument\n" );
    fi;
    
    r := arg[1];
    
    homalg_ring := rec( ring := r );
    
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
    
    homalg_ring!.ZeroLeftModule := HomalgZeroLeftModule( homalg_ring );
    homalg_ring!.ZeroRightModule := HomalgZeroRightModule( homalg_ring );
    
    return homalg_ring;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegers,
  function( arg )
    local nargs, R, c;
    
    nargs := Length( arg );
    
    if nargs = 0 or arg[1] = 0 then
        R := CreateHomalgRing( Integers );
    elif IsInt( arg[1] ) then
        c := arg[1];
        if IsPrime( c ) then
            R := CreateHomalgRing( GF( c ) );
        else
            R := CreateHomalgRing( ZmodnZ( c ) );
        fi;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationals,
  function( arg )
    local R;
    
    R := CreateHomalgRing( Rationals );
    
    SetIsFieldForHomalg( R, true );
    
    return R;
    
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
    local nargs, properties, ar, ring, pointer, r;
    
    nargs := Length( arg );
    
    properties := [ ];
    
    for ar in arg{[ 3 .. nargs ]} do
        if not IsBound( ring ) and IsHomalgExternalRingRep( ar ) then
            ring := ar;
        elif IsFilter( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsRecord, IsFilter } bur recieved: ", ar,"\n" );
        fi;
    od;
    
    pointer := arg[1];
    
    if IsBound( ring ) then
        
        if IsFunction( pointer ) then
            pointer := pointer( ring );
        fi;
        
        r := rec( pointer := pointer, cas := arg[2], ring := ring );
        
        ## Objectify:
        Objectify( TheTypeHomalgExternalRingElementWithIOStream, r );
    else
        r := rec( pointer := pointer, cas := arg[2] );
        
        ## Objectify:
        Objectify( TheTypeHomalgExternalRingElement, r );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( r, true );
        od;
    fi;
    
    if not IsFunction( pointer ) and IsBound( ring ) then
	homalgSetName( r, pointer, ring );
    fi;
    
    return r;
    
end );

##
InstallGlobalFunction( StringToElementStringList,
  function( arg )
    
    return SplitString( arg[1], ",", "[ ]\n" );
    
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

InstallMethod( ViewObj,
        "for homalg external objects",
        [ IsHomalgExternalRingElementRep ],
        
  function( o )
    
    Print( "<A homalg external ring element for the CAS " );
    Print( homalgExternalCASystem( o ), ">" );
    
end );

