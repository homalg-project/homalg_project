#############################################################################
##
##  SageIntegers.gi           RingsForHomalg package           Simon Görtzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the ring of integers in Sage.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for the ring of integers in Sage",
        [ IsHomalgExternalRingObjectInSageRep
          and IsPrincipalIdealRing ],
        
  function( R )
    local RP, RP_BestBasis, command, RP_specific, component;
    
    InitializeSageTools( R );
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
    InitializeSageBestBasis( R );
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSageBestBasis );
    
    command := Concatenation(
            
            "def ElementaryDivisors(M):\n",
            "  return M.transpose().elementary_divisors()\n\n",
            
            "def TriangularBasisOfRows_NU(M):\n",
            "  M = M.dense_matrix()\n",
            "  N, U = M.echelon_form(transformation=True)\n",
            "  N = N.sparse_matrix()\n",
            "  U = U.sparse_matrix()\n",
            "  return N, U\n\n",
            
            "def TriangularBasisOfRows_N_only(M):\n",
            "  N = M.echelon_form()\n",
            "  N = N.sparse_matrix()\n",
            "  return N\n\n"
            
            );
            
    HomalgSendBlocking( [ command ], "need_command", R ); ## the last lines to initialize
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := "Z",
               
               ElementaryDivisors :=
                 function( arg )
                   local M;
                   
                   M:=arg[1];

                   return HomalgSendBlocking( [ "ElementaryDivisors(", M, ")" ], "need_output" );
                   
                 end,
                 
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
                       rank_of_N := Int( HomalgSendBlocking( [ N, U, " = TriangularBasisOfRows_NU(", M, "); ", N, ".rank()" ], "need_output" ) );
                   else
                       ## compute N only:
                       rank_of_N := Int( HomalgSendBlocking( [ N, " = TriangularBasisOfRows_N_only(", M, "); ", N, ".rank()" ], "need_output" ) );
                   fi; 
                   
                   SetRowRankOfMatrix( N, rank_of_N );
                   
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
