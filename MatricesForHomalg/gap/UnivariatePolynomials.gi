#############################################################################
##
##  UnivariatePolynomials.gi    MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2018, Mohamed Barakat, University of Siegen
##
##  The univariate polynomial ring
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for univariate polynomial rings",
        [ IsUnivariatePolynomialRing ],
        
  function( ring )
    local RP_General, RP, component;
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP := rec( 
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               ## Must be defined if other functions are not defined
               
               RowReducedEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not RowReducedEchelonForm( M, "" )
                       ## compute N and U:
                       #N;
                       
                       # assign U:
                       SetEval( arg[2], homalgInternalMatrixHull( N.rowtrans ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only:
                       #N;
                   fi;
                   
                   H := HomalgMatrix( N.normal, R );
                   
                   SetNrRows( H, NrRows( M ) );
                   SetNrColumns( H, NrColumns( M ) );
                   SetZeroRows( H, [ N.rank + 1 .. NrRows( H ) ] );
                   
                   SetIsUpperStairCaseMatrix( H, true );
                   
                   return H;
                   
                 end
                 
          );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
