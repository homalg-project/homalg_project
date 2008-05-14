#############################################################################
##
##  SingularQX.gd            RingsForHomalg package   Markus Lange-Hegermann
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the principal ideal ring Q[x] in Singular.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for the pricipal ideal ring Q[x] in Singular",
        [ IsHomalgExternalRingObjectInSingularRep
          and IsPrincipalIdealRing ],

  function( R )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSingularTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSingularBestBasis );
    
    InitializeSingularBestBasis( R );
    
    RP_specific :=
          rec(
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, U, rank_of_N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( NrRows( M ), NrColumns( M ), R );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( N, true );
                   else
                       SetIsUpperTriangularMatrix( N, true );
                   fi;
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNrRows( U, NrRows( M ) );
                       SetNrColumns( U, NrRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U, such that N=UM
                       homalgSendBlocking( [ "list l=rowred(", M, ",1);",
                                             "matrix ", U, "=transpose(l[2]);",
                                             "matrix ", N, "=transpose(l[1])"
                                           ], "need_command", HOMALG_IO.Pictograms.TriangularBasisC );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ "matrix ", N, " = rowred(", M, ")" ], "need_command", HOMALG_IO.Pictograms.TriangularBasis );
                   fi;
                   
#SetRowRankOfMatrix( N, rank_of_N );
                   
                   return N;
                   
                 end
               
          );
    
    for component in NamesOfComponents( RP_BestBasis ) do
        RP.(component) := RP_BestBasis.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
