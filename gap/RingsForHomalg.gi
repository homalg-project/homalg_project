#############################################################################
##
##  RingsForHomalg.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for RingsForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_RINGS,
        rec(
            RingOfIntegersDefaultCAS := "Maple",
            FieldOfRationalsDefaultCAS := "Singular",
           )
);

##
InstallValue( CommonHomalgTableForRings,
        rec(
            RingName :=
              function( R )
                local minimal_polynomial, var, brackets, r;
                
                if IsBound( R!.MinimalPolynomialOfPrimitiveElement ) then
                    minimal_polynomial := R!.MinimalPolynomialOfPrimitiveElement;
                fi;
                
                ## the Weyl algebra (relative version):
                if HasRelativeIndeterminateDerivationsOfRingOfDerivations( R ) then
                    
                    var := RelativeIndeterminateDerivationsOfRingOfDerivations( R );
                    
                    brackets := [ "<", ">" ];
                    
                ## the Weyl algebra:
                elif HasIndeterminateDerivationsOfRingOfDerivations( R ) then
                    
                    var := IndeterminateDerivationsOfRingOfDerivations( R );
                    
                    brackets := [ "<", ">" ];
                    
                ## the exterior algebra (relative version):
                elif HasRelativeIndeterminateAntiCommutingVariablesOfExteriorRing( R ) then
                    
                    var := RelativeIndeterminateAntiCommutingVariablesOfExteriorRing( R );
                    
                    brackets := [ "{", "}" ];
                    
                ## the exterior algebra:
                elif HasIndeterminateAntiCommutingVariablesOfExteriorRing( R ) then
                    
                    var := IndeterminateAntiCommutingVariablesOfExteriorRing( R );
                    
                    brackets := [ "{", "}" ];
                    
                ## the (free) polynomial ring (relative version):
                elif HasRelativeIndeterminatesOfPolynomialRing( R ) then
                    
                    var := RelativeIndeterminatesOfPolynomialRing( R );
                    
                    brackets := [ "[", "]" ];
                    
                ## the (free) polynomial ring:
                elif HasIndeterminatesOfPolynomialRing( R ) then
                    
                    var := IndeterminatesOfPolynomialRing( R );
                    
                    brackets := [ "[", "]" ];
                    
                elif HasRationalParameters( R ) then
                    
                    var := RationalParameters( R );
                    
                    if IsBound( minimal_polynomial ) then
                        brackets := [ "[", "]" ];
                    else
                        brackets := [ "(", ")" ];
                    fi;
                    
                fi;
                
                if not IsBound( var ) then
                    return fail;
                fi;
                
                var := JoinStringsWithSeparator( List( var, String ) );
                
                var := Concatenation( brackets[1], var, brackets[2] );
                
                if HasBaseRing( R ) and HasCoefficientsRing( R ) and
                   not IsIdenticalObj( BaseRing( R ), CoefficientsRing( R ) ) then
                    r := RingName( BaseRing( R ) );
                elif HasCoefficientsRing( R ) then
                    r := CoefficientsRing( R );
                    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
                        r := Concatenation( "(", RingName( r ), ")" );
                    else
                        r := RingName( r );
                    fi;
                else
                    r := "(some ring)";
                fi;
                
                r := Concatenation( r, var );
                
                if IsBound( minimal_polynomial ) then
                    r := Concatenation( r, "/(", minimal_polynomial, ")" );
                fi;
                
                return String( r );
                
            end,
         
         )
);

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgRingOfIntegersInDefaultCAS,
  function( arg )
    local nargs, integers;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgRing( arg[nargs] ) then
        integers := ValueGlobal( Concatenation( "HomalgRingOfIntegersIn", homalgExternalCASystem( arg[nargs] ) ) );
    elif not IsBound( HOMALG_RINGS.RingOfIntegersDefaultCAS ) or HOMALG_RINGS.RingOfIntegersDefaultCAS = "" then
        integers := HomalgRingOfIntegers;
    else
        integers := ValueGlobal( Concatenation( "HomalgRingOfIntegersIn", HOMALG_RINGS.RingOfIntegersDefaultCAS ) );
    fi;
    
    return CallFuncList( integers, arg );
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInDefaultCAS,
  function( arg )
    local nargs, rationals;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgRing( arg[nargs] ) then
        rationals := ValueGlobal( Concatenation( "HomalgFieldOfRationalsIn", homalgExternalCASystem( arg[nargs] ) ) );
    elif not IsBound( HOMALG_RINGS.FieldOfRationalsDefaultCAS ) or HOMALG_RINGS.FieldOfRationalsDefaultCAS = "" then
        rationals := HomalgFieldOfRationals;
    else
        rationals := ValueGlobal(  Concatenation( "HomalgFieldOfRationalsIn", HOMALG_RINGS.FieldOfRationalsDefaultCAS ) );
    fi;
    
    return CallFuncList( rationals, arg );
    
end );

####################################
#
# install global functions
#
####################################

##
InstallGlobalFunction( _PrepareInputForPolynomialRing,
  function( R, indets )
    local var, nr_var, properties, r, var_of_base_ring, param;
    
    if HasRingRelations( R ) then
        Error( "polynomial rings over homalg residue class rings are not supported yet\nUse the generic residue class ring constructor '/' provided by homalg after defining the ambient ring\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    ## get the new indeterminates for the ring and save them in var
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    if not IsDuplicateFree( var ) then
        Error( "your list of indeterminates is not duplicate free: ", var, "\n" );
    fi;
    
    nr_var := Length( var );
    
    properties := [ IsCommutative ];
    
    ## K[x] is a principal ideal ring for a field K
    if Length( var ) = 1 and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    ## r is set to the ring of coefficients
    ## further a check is done, whether the old indeterminates (if exist) and the new
    ## ones are disjoint
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
        var_of_base_ring := IndeterminatesOfPolynomialRing( R );
        var_of_base_ring := List( var_of_base_ring, Name );
        if Intersection2( var_of_base_ring, var ) <> [ ] then
            Error( "the following indeterminates are already elements of the base ring: ", Intersection2( var_of_base_ring, var ), "\n" );
        fi;
    else
        r := R;
        var_of_base_ring := [ ];
    fi;
    
    var := Concatenation( var_of_base_ring, var );
    
    if HasRationalParameters( r ) then
        param := Concatenation( ",", JoinStringsWithSeparator( RationalParameters( r ) ) );
    else
        param := "";
    fi;
    
    return [ r, var, nr_var, properties, param ];
    
end );

##
InstallGlobalFunction( _PrepareInputForRingOfDerivations,
  function( R, indets )
    local var, nr_var, der, nr_der, r, param, base;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        if HasRelativeIndeterminatesOfPolynomialRing( R ) then
            var := RelativeIndeterminatesOfPolynomialRing( R );
        else
            var := IndeterminatesOfPolynomialRing( R );
        fi;
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    var := List( var, Name );
    
    ## get the new indeterminates (the derivatives) for the ring and save them in der
    if IsString( indets ) and indets <> "" then
        der := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        der := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_der := Length( der );
    
    if nr_var <> nr_der then
        Error( "the number of indeterminates of the given polynomial ring is not equal to the number of specified derivations\n" );
    fi;
    
    if Intersection2( der, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the polynomial ring: ", Intersection2( der, var ), "\n" );
    fi;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
    else
        r := R;
    fi;
    

    if HasRationalParameters( r ) then
        param := Concatenation( ",", JoinStringsWithSeparator( RationalParameters( r ) ) );
    else
        param := "";
    fi;
    
    if HasBaseRing( R ) and HasCoefficientsRing( R ) and
       not IsIdenticalObj( BaseRing( R ), CoefficientsRing( R ) ) and
       HasIndeterminatesOfPolynomialRing( BaseRing( R ) ) then
        base := IndeterminatesOfPolynomialRing( BaseRing( R ) );
    else
        base := "";
    fi;
    
    return [ r, var, der, param, base ];
    
end );

##
InstallGlobalFunction( _PrepareInputForExteriorRing,
  function( R, T, indets )
    local var, nr_var, anti, comm, nr_anti, nr_comm, r, param;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        var := IndeterminatesOfPolynomialRing( R );
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    var := List( var, Name );
    
    ## get the new anti commuting variables for the ring and save them in anti
    if IsString( indets ) and indets <> "" then
        anti := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        anti := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    ## get the new commuting variables for the ring and save them in comm
    if HasIndeterminatesOfPolynomialRing( T ) then
        comm := Indeterminates( T );
    else
        comm := [ ];
    fi;
    
    comm := List( comm, Name );
    
    nr_anti := Length( anti );
    nr_comm := Length( comm );
    
    if nr_var <> nr_anti + nr_comm then
        Error( "number of indeterminates of the given ring does not equal the number of the new anti commuting and old commuting variables\n" );
    fi;
    
    if Intersection2( anti, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the base ring: ", Intersection2( anti, var ), "\n" );
    fi;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
    else
        r := R;
    fi;
    
    if HasRationalParameters( r ) then
        param := Concatenation( ",", JoinStringsWithSeparator( RationalParameters( r ) ) );
    else
        param := "";
    fi;
    
    return [ r, param, var, anti, comm ];
    
end );

