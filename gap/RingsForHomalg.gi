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
                local r, var, der, anti;
                
                if HasName( R ) then
                    return Name( R );
                fi;
                
                if HasCoefficientsRing( R ) then
                    r := RingName( CoefficientsRing( R ) );
                else
                    r := "(some ring)";
                fi;
                
                ## the Weyl-Algebra:
                if HasIndeterminateCoordinatesOfRingOfDerivations( R ) and
                   HasIndeterminateDerivationsOfRingOfDerivations( R ) then
                    
                    var := IndeterminateCoordinatesOfRingOfDerivations( R );
                    der := IndeterminateDerivationsOfRingOfDerivations( R );
                    
                    var := JoinStringsWithSeparator( List( var, String ) );
                    der := JoinStringsWithSeparator( List( der, String ) );
                    
                    return String( Concatenation( [ r, "[", var, "]<", der, ">" ] ) );
                    
                ## the exterior algebra:
                elif HasIndeterminatesOfExteriorRing( R ) then
                    
                    if HasIndeterminateAntiCommutingVariablesOfExteriorRing( R ) and
                       HasBaseRing( R ) and HasIndeterminatesOfPolynomialRing( BaseRing( R ) ) then
                        
                        var := Indeterminates( BaseRing( R ) );
                        anti := IndeterminateAntiCommutingVariablesOfExteriorRing( R );
                        
                        var := JoinStringsWithSeparator( List( var, String ) );
                        anti := JoinStringsWithSeparator( List( anti, String ) );
                        
                        return String( Concatenation( [ r, "[", var, "]", "{", anti, "}" ] ) );
                        
                    else
                        
                        anti := IndeterminatesOfExteriorRing( R );
                        anti := JoinStringsWithSeparator( List( anti, String ) );
                        
                        return String( Concatenation( [ r, "{", anti, "}" ] ) );
                        
                    fi;
                    
                ## the (free) polynomial ring:
                elif HasIndeterminatesOfPolynomialRing( R ) then
                    
                    var := IndeterminatesOfPolynomialRing( R );
                    
                    var := JoinStringsWithSeparator( List( var, String ) );
                    
                    return String( Concatenation( [ r, "[", var, "]" ] ) );
                    
                ## certain fields:
                elif HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
                    
                    if Characteristic( R ) = 0 then
                       return "Q";
                   else
                       return Concatenation( "GF(", String( Characteristic( R ) ), ")" );
                   fi;
                   
               else
                   
                   return "some Ring";
                   
               fi;
               
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

##
InstallGlobalFunction( _PrepareInputForPolynomialRing,
  function( R, indets )
    local var, nr_var, properties, r, var_of_base_ring;
    
    if HasRingRelations( R ) then
        Error( "polynomial rings over homalg residue class rings are not supported yet\n" );
    fi;
    
    ## get the new indeterminates for the ring and save them in var
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_var := Length( var );
    
    properties := [ ];
    
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
        if not ForAll( var_of_base_ring, HasName ) then
            Error( "the indeterminates of the base ring must all have a name (use SetName)\n" );
        fi;
        var_of_base_ring := List( var_of_base_ring, Name );
        if Intersection2( var_of_base_ring, var ) <> [ ] then
            Error( "the following indeterminates are already elements of the base ring: ", Intersection2( var_of_base_ring, var ), "\n" );
        fi;
    else
        r := R;
        var_of_base_ring := [ ];
    fi;
    
    var := Concatenation( var_of_base_ring, var );
    
    return [ r, var, properties ];
    
end );

##
InstallGlobalFunction( _PrepareInputForRingOfDerivations,
  function( R, indets )
    local var, nr_var, der, nr_der;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        var := IndeterminatesOfPolynomialRing( R );
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    if ForAll( var, HasName ) then
        var := List( var, Name );
    else
        Error( "the indeterminates of the free polynomial ring must all have a name (use SetName)\n" );
    fi;
    
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
    
    return [ var, der ];
    
end );

##
InstallGlobalFunction( _PrepareInputForExteriorRing,
  function( R, T, indets )
    local var, nr_var, anti, comm, nr_anti, nr_comm;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        var := IndeterminatesOfPolynomialRing( R );
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    if ForAll( var, HasName ) then
        var := List( var, Name );
    else
        Error( "the indeterminates of the free polynomial ring must all have a name (use SetName)\n" );
    fi;
    
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
    
    if ForAll( comm, HasName ) then
        comm := List( comm, Name );
    else
        Error( "the indeterminates of the base ring must all have a name (use SetName)\n" );
    fi;
    
    nr_anti := Length( anti );
    nr_comm := Length( comm );
    
    if nr_var <> nr_anti + nr_comm then
        Error( "number of indeterminates of the given ring does not equal the number of the new anti commuting and old commuting variables\n" );
    fi;
    
    if Intersection2( anti, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the base ring: ", Intersection2( anti, var ), "\n" );
    fi;
    
    return [ var, anti, comm ];
    
end );
