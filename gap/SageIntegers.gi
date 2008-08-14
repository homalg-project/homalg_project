#############################################################################
##
##  SageIntegers.gi           RingsForHomalg package          Simon Goertzen
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
        
  function( ext_ring_obj )
    local RP, RP_BestBasis, command, RP_specific, component;
    
    InitializeSageTools( ext_ring_obj );
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
    InitializeSageBestBasis( ext_ring_obj );
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSageBestBasis );
    
    command := Concatenation(
            
            "def ElementaryDivisors(M):\n",
            "  return M.transpose().elementary_divisors()\n\n",
            
            "def TriangularBasisOfRows_NU(M):\n",
            "  N, U = M.echelon_form(transformation=True)\n",
            "  return N, U\n\n",
            
            "def TriangularBasisOfRows_N_only(M):\n",
            "  N = M.echelon_form()\n",
            "  return N\n\n"
            
            );
            
    homalgSendBlocking( [ command ], "need_command", ext_ring_obj, HOMALG_IO.Pictograms.define ); ## the last procedures to initialize
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               ElementaryDivisors :=
                 function( arg )
                   local M;
                   
                   M:=arg[1];
                   
                   return homalgSendBlocking( [ "ElementaryDivisors(", M, ")" ], "need_output" );
                   
                 end,
                 
	       RowRankOfMatrix :=
	         function( M )
                   
                   return Int( homalgSendBlocking( [ M, ".rank()" ], "need_output" ) );
                   
		 end,
               
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( NrRows( M ), NrColumns( M ), R );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNrRows( U, NrRows( M ) );
                       SetNrColumns( U, NrRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U:
                       homalgSendBlocking( [ N, U, " = TriangularBasisOfRows_NU(", M, ")" ], "need_command", HOMALG_IO.Pictograms.TriangularBasisC );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, " = TriangularBasisOfRows_N_only(", M, ")" ], "need_command", HOMALG_IO.Pictograms.TriangularBasis );
                   fi; 
                                      
                   SetIsUpperStairCaseMatrix( N, true );
		   
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
