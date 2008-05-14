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
    function( A, B, T )  
      local R, l, m, n, id, zz, M, TT;
      
      R := HomalgRing( A );
      
      l := NrRows( A );
      m := NrColumns( A );
    
      n := NrRows( B );
    
      id := HomalgIdentityMatrix( l, R );
    
      zz := HomalgZeroMatrix( n, l, R );
    
      M := UnionOfRows( UnionOfColumns( id, A ), UnionOfColumns( zz, B ) );
    
      TT := HomalgVoidMatrix( R );
    
      M := BasisOfRowsCoeff( M, TT );
    
      M := CertainRows( CertainColumns( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
      TT := CertainColumns( CertainRows( TT, [ 1 .. l ] ), [ l + 1 .. l + n ] );
    
      SetPreEval( T, TT ); ResetFilterObj( T, IsVoidMatrix );
    
      return M;
    
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
