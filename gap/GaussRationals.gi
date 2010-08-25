#############################################################################
##
##  GaussRationals.gi           GaussForHomalg package        Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Homalg Table for Q in GAP with the Gauss package
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for Q",
        [ IsRationals ],
        
  function( R )
    local RP, RP_default, RP_specific, component;
    
    if IsBound( HOMALG_MATRICES.PreferDenseMatrices ) and HOMALG_MATRICES.PreferDenseMatrices = true then
        RP := rec( );
    else
        RP := ShallowCopy( CommonHomalgTableForGaussTools );
    fi;
    
    RP_default := ShallowCopy( CommonHomalgTableForGaussBasic );
    
    RP_specific := rec( 
               ## Must be defined if other functions are not defined
               
               RowReducedEchelonForm := #compute the reduced row echelon form N of M and, if nargs=2, transformation matrix U
                 function( arg )
                   local M, R, nargs, result, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then
                       ## compute N and U:
                       result := EchelonMatTransformation( MyEval( M ) );
                       N := result.vectors;
                       ## assign U:
                       SetMyEval( arg[2], UnionOfRows( result.coeffs, result.relations ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only:
                       N := EchelonMat( MyEval( M ) ).vectors;
                   fi;
                   
                   if N = [ ] then
                       H := HomalgZeroMatrix( 0, NrColumns( M ), R );
                   else
                       H := HomalgMatrix( N, R ); ## and since this is not i.g. triangular:
                   fi;
                   
                   SetNrColumns( H, NrColumns( M ) );
		   
                   SetRowRankOfMatrix( H, NrRows( H ) );
		   
                   SetIsUpperTriangularMatrix( H, true );
                   
                   return H;
                   
                 end,
                 
		 RowRankOfMatrix :=
		   function( M )
		     return Rank( MyEval( M ) );
                   end
          );
                 
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
                 
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

