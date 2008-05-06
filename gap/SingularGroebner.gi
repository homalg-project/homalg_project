#############################################################################
##
##  SingularGroebner          RingsForHomalg package          Simon Goertzen
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
        
  function( arg )
    local RP, RP_default, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSingularTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForSingularDefault );
    
    RP_specific := rec(
                       Involution :=
                       function( M )
                         local R, I;
                         R := HomalgRing( M );
                         I := HomalgVoidMatrix( NrColumns( M ), NrRows( M ), R );
                         homalgSendBlocking( [ "map F = ", R, ", t, -D; matrix ", I, " = transpose( involution( ", M, ", F ) )" ], "need_command", HOMALG_IO.Pictograms.Involution ); #FIXME
                         ResetFilterObj( I, IsVoidMatrix );
                         return I;
                       end,
                       
                       TriangularBasisOfRows :=                                                                                                                                                         function( arg )                                                                                                                                                  
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
                               homalgSendBlocking( [ "list l=gauss_col(", M, ",1);",                                                                                                         
                                       "matrix ", U, "= l[2];",                                                                                                   
                                       "matrix ", N, "= l[1]"                                                                                                     
                                       ], "need_command", HOMALG_IO.Pictograms.TriangularBasisC );                                                                            
                           else                                                                                                                                                           
                               ## compute N only:                                                                                                                                         
                               homalgSendBlocking( [ "matrix ", N, " = gauss_col(", M, ")" ], "need_command", HOMALG_IO.Pictograms.TriangularBasis );                                        
                           fi;                                                                                                                                                            
                           
                           #SetRowRankOfMatrix( N, rank_of_N );                                                                                                                   
                           return N;
                           
                           end,
                       
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
