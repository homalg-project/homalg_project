#############################################################################
##
##  GaussFields.gi              RingsForHomalg package        Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Homalg Table for Fields in GAP with the Gauss package
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for a field",
        [ IsField ],
        
  function( arg )
    local RP_default, RP_specific, RP, component;
    
    RP_default := ShallowCopy( CommonHomalgTableForGaussDefault );
    
    RP_specific := rec( 
               ## Must be defined if other functions are not defined
                   
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, result, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then
                       ## compute N and U:
                       result := EchelonMatTransformation( Eval( M ) );
                       N := result.vectors;
                       ## assign U:
                       SetEval( arg[2], Concatenation( result.coeffs, result.relations ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only:
                       N := EchelonMat( Eval( M ) ).vectors;
                   fi;
                   
                   if N = [ ] then
                       H := HomalgZeroMatrix( 0, NrColumns( M ), R );
                   else
                       H := HomalgMatrix( N, R ); ## and since this is not i.g. triangular:
                   fi;
                   
                   SetNrColumns( H, NrColumns( M ) );
                   SetRowRankOfMatrix( H, NrRows( H ) );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( H, true );   
                   else
                       SetIsUpperTriangularMatrix( H, true );
                   fi;
                   
                   return H;
                   
                 end
                 
          );
                 
    RP := rec( );
    
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
                 
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
