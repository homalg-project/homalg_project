#############################################################################
##
##  GaussDefault.gi           GaussForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the Gauss package.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGaussDefault,
        
  rec(
      ## Must only then be provided by the RingPackage in case the default
      ## "service" function does not match the Ring
    
    #this uses the ReduceMatWithEchelonMat from the Gauss Package to reduce A with B
    DecideZeroRows :=
    function( A, B )
      local R, N;
     
      R := HomalgRing( A );
      N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
      SetEval( N, ReduceMatWithEchelonMat( Eval( A ), Eval ( B ) ) );
      ResetFilterObj( N, IsVoidMatrix );
      return N;
    
    end,
  
    #this uses KernelMat from the Gauss Package to compute Syzygies
    SyzygiesGeneratorsOfRows :=
    function( arg )
      local M, R, syz, N;
      M := arg[1];
      R := HomalgRing( M );
      if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
          syz := KernelMat( Eval( UnionOfRows( M, arg[2] ) ), [1..NrRows( M )] ).relations;
      else
          syz := KernelMat( Eval( M ) ).relations;
      fi;
          
      N := HomalgVoidMatrix( nrows( syz ), NrRows( M ), R );
      SetEval( N, syz );
      ResetFilterObj( N, IsVoidMatrix );
      return N;
      
    end,
    
    #this just calls TriangularBasisOfRows, which computes the RREF using EchelonMat from the Gauss Package
    BasisOfRowModule :=
    function( M )
      return TriangularBasisOfRows( M );
    end,
  )
);
