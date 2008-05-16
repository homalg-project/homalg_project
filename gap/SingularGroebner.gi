#############################################################################
##
##  SingularGroebner          RingsForHomalg package          Simon Goertzen
##                                                     Markus Lange-Hegermann
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for Grobner Basis calculations in Singular            
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner Basis calculations provided by Singular",
        [ IsHomalgExternalRingObjectInSingularRep ],
        
  function( ext_obj )
    local RP, RP_default, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSingularTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForSingularDefault );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSingularBestBasis );
    
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
	       elif IsFieldForHomalg( R ) then
	         if Characteristic( R ) = 0 then
	           return "Q";
	         else
	           return Concatenation( "GF(", String( Characteristic( R ) ), ")" );
	         fi;
	       else
	         return "some Ring";
	       fi;
	     end,

           Involution :=
             function( M )
               local R, I;
               R := HomalgRing( M );
               I := HomalgVoidMatrix( NrColumns( M ), NrRows( M ), R );
               if HasIndeterminateCoordinatesOfRingOfDerivations( R ) and HasIndeterminateDerivationsOfRingOfDerivations( R ) then
                 ## in case of a non-commutative ring (right now: in case of a wezl algebra: todo)
                 homalgSendBlocking( Concatenation(
                                        [ "map F = ", R, ", " ],
                                        IndeterminateCoordinatesOfRingOfDerivations( R ),
                                        [ ", " ] ,
                                        Concatenation( List( IndeterminateDerivationsOfRingOfDerivations( R ), a -> [ "-" , a ] ) ),
                                        [ "; matrix ", I, " = transpose( involution( ", M, ", F ) )" ]
                                      ), "need_command", HOMALG_IO.Pictograms.Involution );
               else
                  ## in case of a commutative ring
                  homalgSendBlocking( [ "matrix ", I, " = transpose( involution( ", M, ", F ) )" ], "need_command", HOMALG_IO.Pictograms.Involution );
               fi;
               ResetFilterObj( I, IsVoidMatrix );
               return I;
             end,
             
      );
    
#todo: insert again, as soon as Singular really computes smith forms
#    if HasPrincipalIdealRing( ext_obj ) and IsPrincipalIdealRing( ext_obj ) then
#      for component in NamesOfComponents( RP_BestBasis ) do
#          RP.(component) := RP_BestBasis.(component);
#      od;
#    fi;
    
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
