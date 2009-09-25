#############################################################################
##
##  ResidueClassRingBasic.gi    homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( CommonHomalgTableForResidueClassRingsBasic,

        rec(
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local Mrel;
                   
                   Mrel := UnionOfRows( M );
                   
                   Mrel := HomalgResidueClassMatrix( BasisOfRowModule( Mrel ), HomalgRing( M ) );
                   
                   return GetRidOfObsoleteRows( Mrel );
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local Mrel;
                   
                   Mrel := UnionOfColumns( M );
                   
                   Mrel := HomalgResidueClassMatrix( BasisOfColumnModule( Mrel ), HomalgRing( M ) );
                   
                   return GetRidOfObsoleteColumns( Mrel );
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local Mrel, TT, bas;
                   
                   Mrel := UnionOfRows( M );
                   
                   TT := HomalgVoidMatrix( HomalgRing( Mrel ) );
                   
                   bas := BasisOfRowsCoeff( Mrel, TT );
                   
                   SetEval( T, CertainColumns( TT, [ 1 .. NrRows( M ) ] ) ); ResetFilterObj( T, IsVoidMatrix );
                   
                   return HomalgResidueClassMatrix( bas, HomalgRing( M ) );	## FIXME: GetRidOfObsoleteRows and correct T
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local Mrel, TT, bas;
                   
                   Mrel := UnionOfColumns( M );
                   
                   TT := HomalgVoidMatrix( HomalgRing( Mrel ) );
                   
                   bas := BasisOfColumnsCoeff( Mrel, TT );
                   
                   SetEval( T, CertainRows( TT, [ 1 .. NrColumns( M ) ] ) ); ResetFilterObj( T, IsVoidMatrix );
                   
                   return HomalgResidueClassMatrix( bas, HomalgRing( M ) );	## FIXME: GetRidOfObsoleteColumns and correct T
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local Brel;
                   
                   Brel := UnionOfRows( B );
                   
                   return HomalgResidueClassMatrix( DecideZeroRows( Eval( A ), Brel ), HomalgRing( A ) );
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local Brel;
                   
                   Brel := UnionOfColumns( B );
                   
                   return HomalgResidueClassMatrix( DecideZeroColumns( Eval( A ), Brel ), HomalgRing( A ) );
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local Brel, TT, red;
                   
                   Brel := UnionOfRows( B );
                   
                   TT := HomalgVoidMatrix( HomalgRing( Brel ) );
                   
                   red := DecideZeroRowsEffectively( Eval( A ), Brel, TT );
                   
                   SetEval( T, CertainColumns( TT, [ 1 .. NrRows( B ) ] ) ); ResetFilterObj( T, IsVoidMatrix );
                   
                   return HomalgResidueClassMatrix( red, HomalgRing( A ) );
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local Brel, TT, red;
                   
                   Brel := UnionOfColumns( B );
                   
                   TT := HomalgVoidMatrix( HomalgRing( Brel ) );
                   
                   red := DecideZeroColumnsEffectively( Eval( A ), Brel, TT );
                   
                   SetEval( T, CertainRows( TT, [ 1 .. NrColumns( B ) ] ) ); ResetFilterObj( T, IsVoidMatrix );
                   
                   return HomalgResidueClassMatrix( red, HomalgRing( A ) );
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( M )
                   local R, ring_rel, rel, S;
                   
                   R := HomalgRing( M );
                   
                   ring_rel := RingRelations( R );
                   
                   rel := MatrixOfRelations( ring_rel );
                   
                   if IsHomalgRelationsOfRightModule( ring_rel ) then
                       rel := Involution( rel );
                   fi;
                   
                   rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
                   
                   S := SyzygiesGeneratorsOfRows( Eval( M ), rel );
                   
                   S := HomalgResidueClassMatrix( S, R );
                   
                   S := GetRidOfObsoleteRows( S );
                   
                   if IsZero( S ) then
                       
                       SetIsLeftRegularMatrix( M, true );
                       
                   fi;
                   
                   return S;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( M )
                   local R, ring_rel, rel, S;
                   
                   R := HomalgRing( M );
                   
                   ring_rel := RingRelations( R );
                   
                   rel := MatrixOfRelations( ring_rel );
                   
                   if IsHomalgRelationsOfLeftModule( ring_rel ) then
                       rel := Involution( rel );
                   fi;
                   
                   rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
                   
                   S := SyzygiesGeneratorsOfColumns( Eval( M ), rel );
                   
                   S := HomalgResidueClassMatrix( S, R );
                   
                   S := GetRidOfObsoleteColumns( S );
                   
                   if IsZero( S ) then
                       
                       SetIsRightRegularMatrix( M, true );
                       
                   fi;
                   
                   return S;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfRows :=
                 function( M, M2 )
                   local M2rel, S;
                   
                   M2rel := UnionOfRows( M2 );
                   
                   S := SyzygiesGeneratorsOfRows( Eval( M ), M2rel );
                   
                   S := HomalgResidueClassMatrix( S, HomalgRing( M ) );
                   
                   S := GetRidOfObsoleteRows( S );
                   
                   if IsZero( S ) then
                       
                       SetIsLeftRegularMatrix( M, true );
                       
                   fi;
                   
                   return S;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local M2rel, S;
                   
                   M2rel := UnionOfColumns( M2 );
                   
                   S := SyzygiesGeneratorsOfColumns( Eval( M ), M2rel );
                   
                   S := HomalgResidueClassMatrix( S, HomalgRing( M ) );
                   
                   S := GetRidOfObsoleteColumns( S );
                   
                   if IsZero( S ) then
                       
                       SetIsRightRegularMatrix( M, true );
                       
                   fi;
                   
                   return S;
                   
                 end,
               
               X_ReducedBasisOfRowModule :=
                 function( M )
                   local Mrel;
                   
                   Mrel := UnionOfRows( M );
                   
                   Mrel := HomalgResidueClassMatrix( ReducedBasisOfRowModule( Mrel ), HomalgRing( M ) );
                   
                   return GetRidOfObsoleteRows( Mrel );
                   
                 end,
               
               X_ReducedBasisOfColumnModule :=
                 function( M )
                   local Mrel;
                   
                   Mrel := UnionOfColumns( M );
                   
                   Mrel := HomalgResidueClassMatrix( ReducedBasisOfColumnModule( Mrel ), HomalgRing( M ) );
                   
                   return GetRidOfObsoleteColumns( Mrel );
                   
                 end,
               
               X_ReducedSyzygiesGeneratorsOfRows :=
                 function( M )
                   
                 end,
               
               X_ReducedSyzygiesGeneratorsOfColumns :=
                 function( M )
                   
                 end,
               
        )
 );
