#############################################################################
##
##  MapleHomalgDefault.gi       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings with BestBasis provided by the ring packages
## of the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMapleHomalgDefault,
        
        rec(
               BasisOfRowsCoeff :=
                 function( arg )
                   local M, R, nargs, N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgMatrix( "void", "unknown_number_of_rows", NrColumns( M ), R );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BasisOfRowsCoeff( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNrColumns( U, NrRows( M ) );
                       
                       ## compute N and U:
                       HomalgSendBlocking( [ N, " := `homalg/BasisCoeff`(", M, R, "[1],", U, R, "[2])" ], "need_command" );
                   else
                       ## compute N only:
                       HomalgSendBlocking( [ N, " := `homalg/BasisCoeff`(", M, R, ")" ], "need_command" );
                   fi;
                   
                   return N;
                   
                 end,
                 
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( arg )
                   local M, R, nargs, N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgMatrix( "void", "unknown_number_of_rows", NrColumns( M ), R );
                   
                   HomalgSendBlocking( [ N, " := `homalg/BasisOfModule`(", M, R, ")" ], "need_command" );
                   
                   return N;
                   
                 end
               
        )
 );
