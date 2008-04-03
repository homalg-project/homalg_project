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
        [ IsHomalgExternalObjectRep
          and IsHomalgExternalObjectWithIOStream
          and IsQXForHomalgInSingular ],

  function( arg )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSingularTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSingularBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := "Q[x]",
               
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, U, rank_of_N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgMatrix( "void", NrRows( M ), NrColumns( M ), R );
                   
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
                       
                       ## compute N and U:
#rank_of_N := Int( HomalgSendBlocking( [ "list l=rowred(", M, ",1);", U, "=l[2];", N, "=l[1]; rank(", N, ")" ], "need_output" ) );
                       HomalgSendBlocking( [ "list l=rowred(", M, ",1);", U, "=l[2];", N, "=l[1]" ], "need_command" );
                   else
                       ## compute N only:
#rank_of_N := Int( HomalgSendBlocking( [ "matrix ", N, " = rowred(", M, "); rank(", N, ")" ], "need_output" ) );
                       HomalgSendBlocking( [ "matrix ", N, " = rowred(", M, ")" ], "need_command" );
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
    
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
