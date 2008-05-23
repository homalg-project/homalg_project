#############################################################################
##
##  SingularDefault.gd        RingsForHomalg package          Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSingularDefault,

  rec(
    ## Must only then be provided by the RingPackage in case the default
    ## "service" function does not match the Ring
    
    DecideZeroRows :=
    function( A, B )
      local R, N;
      R := HomalgRing( A );
      N := HomalgVoidMatrix( R );
      homalgSendBlocking( [ "matrix ", N, " = reduce(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
      ResetFilterObj( N, IsVoidMatrix );
      return N;
    end,
      
    DecideZeroRowsEffectively := ## FIXME: this is wrong in general
    function( Atr, Btr, Ttr )  
    local Mtr, TTtr, R;
      
      R := HomalgRing( Atr );
      
#todo: read part of the unit matrix in singular help!
#      it is ignored right now.
# division(A^t,B^t) returns (TT^t, M^t, U^t) with
#                A^t*U^t = B^t*TT^t + M^t
# <=> (ignore U) M^t = A^t - B^t*TT^tr
# <=>            M   = A   + (-TT) * B
# <=> (T:=-TT)   M   = A   + T * B
#M^t=A^t-T^t*B^t
#      homalgSendBlocking( [ "list l = division(", Atr, Btr, ")" ], "need_command", 
#      Mtr := HomalgVoidMatrix( R );
#      homalgSendBlocking( [ Mtr, " = l[2]" ], [ "matrix" ], HOMALG_IO.Pictograms.DecideZero );
#      ResetFilterObj( Mtr, IsVoidMatrix );
#      TTtr := HomalgVoidMatrix( R );
#      homalgSendBlocking( [ TTtr, " = l[1]" ], [ "matrix" ], HOMALG_IO.Pictograms.DecideZero );
#      ResetFilterObj( TTtr, IsVoidMatrix );
#      SetPreEval( Ttr, -TTtr ); ResetFilterObj( Ttr, IsVoidMatrix );
      
      Mtr := HomalgVoidMatrix( R );
      homalgSendBlocking( [ "matrix ", Mtr, " = reduce(", Atr, Btr, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
      ResetFilterObj( Mtr, IsVoidMatrix );
      
      TTtr := HomalgVoidMatrix( R );
      homalgSendBlocking( [ "matrix ", TTtr, " = lift(", Btr, Mtr - Atr, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
      SetPreEval( Ttr, TTtr ); 
      ResetFilterObj( Ttr, IsVoidMatrix );
      
      return Mtr;
      
    end,
    
    SyzygiesGeneratorsOfRows :=
    function( arg )
      local M, R, N;
      M := arg[1];
      R := HomalgRing( M );
      N := HomalgVoidMatrix(  R );
      if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
        homalgSendBlocking( [ "matrix ", N, " = syz(", UnionOfRows( M, arg[2] ), ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
	N := CertainColumns( N, [1.. NrRows( M )] );
      else
        homalgSendBlocking( [ "matrix ", N, " = syz(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
      fi;
      SetNrColumns( N, NrRows( M ) );
      ResetFilterObj( N, IsVoidMatrix );
      return N;
    
    end,
    
    BasisOfRowModule :=
    function( M )
      local R, N;
      R := HomalgRing( M );
      N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
      homalgSendBlocking( [ "matrix ", N, " = std(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
      ResetFilterObj( N, IsVoidMatrix );
      return N;
    end,
    
    BasisOfRowsCoeff :=
    function( M, T )
    local R, B;
      R := HomalgRing( M );
      B := HomalgVoidMatrix( R );
      ## compute B and T, such that B=TM
      homalgSendBlocking( [ "matrix ", T, "; matrix ", B, " = liftstd(", M, T, ");"
              ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
      B := T * M;
      ResetFilterObj( B, IsVoidMatrix );
      return B;
    end,
    
  )
);
