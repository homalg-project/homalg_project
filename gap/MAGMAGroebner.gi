#############################################################################
##
##  MAGMAGroebner          RingsForHomalg package           Markus Kirschmer
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for Groebner basis related calculations in MAGMA.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner basis computations provided by MAGMA",
        [ IsHomalgExternalRingObjectInMAGMARep ],
        
  function( ext_ring_obj )
    local RP, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMAGMATools );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMAGMABasic );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMAGMABestBasis );
    
    RP_specific := 
      rec(
           RingName :=
	     function ( R )#todo: more cases than Weylalgebra and Polynomials Ring
	       local var,der;
	       
	       if HasName( R ) then 
	         return Name( R );
	       fi;
	       
	       if HasIndeterminateCoordinatesOfRingOfDerivations( R ) and HasIndeterminateDerivationsOfRingOfDerivations( R ) then
                 var := JoinStringsWithSeparator( 
                           List( IndeterminateCoordinatesOfRingOfDerivations( R ), String ) 
                          );
                 der := JoinStringsWithSeparator( 
                            List( IndeterminateDerivationsOfRingOfDerivations( R ), String ) 
                          );
	         return String( Concatenation( [ RingName( CoefficientsRing( R ) ), "[", var, "]<", der, ">" ] ) );
	       elif HasIndeterminatesOfPolynomialRing( R ) then
                  var := JoinStringsWithSeparator( 
                            List( IndeterminatesOfPolynomialRing( R ), String ) 
                          );
                  return String( Concatenation( [ RingName( CoefficientsRing( R ) ), "[", var, "]" ] ) );
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

      );
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
