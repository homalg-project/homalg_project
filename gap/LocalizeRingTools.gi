#############################################################################
##
##  LocalizeRingTools.gd   LocalizeRingForHomalg package     Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for localized rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

#possibility to use the underlying global ringtable?

InstallValue( CommonHomalgTableForLocalizedRingsTools,

    rec(
               IsZero := a -> IsZero(NumeratorOfLocalElement(a)),
               
               IsOne := a -> IsZero(NumeratorOfLocalElement(a)-DenominatorOfLocalElement(a)),
               
               Minus :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*DenominatorOfLocalElement(b)
                                  -NumeratorOfLocalElement(b)*DenominatorOfLocalElement(a),
                                  DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                                  HomalgRing(a));
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a),
                                  DenominatorOfLocalElement(a)*u,
                                  HomalgRing(a));
                 end,
               
               IsUnit := #FIXME: just for polynomial rings(?)
                 function( R, u )
                   
                   #IsUnit CAS-dependent
                   
                 end,
               
               Sum :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*DenominatorOfLocalElement(b)
                                  +NumeratorOfLocalElement(b)*DenominatorOfLocalElement(a),
                                  DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                                  HomalgRing(a));
                 end,
               
               Product :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*NumeratorOfLocalElement(b),
                                  DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                                  HomalgRing(a));
                 end,
               
               CopyMatrix :=
                 function( C )
                   
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedGlobalRing( C );
                   
                   return [ One( R ), HomalgMatrix( homalgTable( R )!.ZeroMatrix( Eval( C )[2] ), R ) ];
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedGlobalRing( C );
                   
                   return HomalgLocalMatrix(
                     HomalgMatrix( homalgTable( R )!.IdentityMatrix(Eval(C)[2]), R ),
                     HomalgRing(C));
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   return homalgTable(A)!.IsZeroMatrix(A-B);
                 end,
               
               Involution :=
                 function( M )
                   local R;
                   
                   R := AssociatedGlobalRing( M );
                   
                   return HomalgLocalMatrix(
                     HomalgMatrix( homalgTable( R )!.Involution(Eval(M)[2]), R ),
                     Eval(M)[2],
                     HomalgRing(M));
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local R;
                   
                   R := AssociatedGlobalRing( M );
                   
                   return HomalgLocalMatrix(
                     HomalgMatrix( homalgTable( R )!.CertainRows(Eval(M)[2],plist), R ),
                     Eval(M)[2],
                     HomalgRing(M));
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local R;
                   
                   R := AssociatedGlobalRing( M );
                   
                   return HomalgLocalMatrix(
                     HomalgMatrix( homalgTable( R )!.CertainRows(Eval(M)[2],plist), R ),
                     Eval(M)[2],
                     HomalgRing(M));
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local R;
                   
                   R := AssociatedGlobalRing( A );
                   
                   return HomalgLocalMatrix(
                                  HomalgMatrix( homalgTable( R )!.UnionOfRows(Eval(B)[1]*Eval(A)[2],Eval(A)[1]*Eval(B)[2]), R ),
                                  Eval(A)[1]*Eval(B)[1],
                                  HomalgRing(A));
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local R;
                   
                   R := AssociatedGlobalRing( A );
                   
                   return HomalgLocalMatrix(
                                  HomalgMatrix( homalgTable( R )!.UnionOfColumns(Eval(B)[1]*Eval(A)[2],Eval(A)[1]*Eval(B)[2]), R ),
                                  Eval(A)[1]*Eval(B)[1],
                                  HomalgRing(A));
                 end,
               
               DiagMat :=
                 function( e )
                   
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   local R;
                   
                   R := AssociatedGlobalRing( A );
                   
                   return HomalgLocalMatrix(
                                  HomalgMatrix( homalgTable( R )!.KroneckerMat(Eval(A)[2],Eval(B)[2]), R ),
                                  Eval(A)[1]*Eval(B)[1],
                                  HomalgRing(A));
                 end,
               
               MulMat :=
                 function( a, A )
                   return HomalgLocalMatrix(
                                  NumeratorOfLocalElement(a)*Eval(A)[2],
                                  DenominatorOfLocalElement(a)*Eval(A)[1],
                                  HomalgRing(A));

                 end,
               
               AddMat :=
                 function( A, B )
                   return HomalgLocalMatrix(
                                  Eval(B)[1]*Eval(A)[2]+Eval(A)[1]*Eval(B)[2],
                                  Eval(A)[1]*Eval(B)[1],
                                  HomalgRing(A));
                 end,
               
               SubMat :=
                 function( A, B )
                   return HomalgLocalMatrix(
                                  Eval(B)[1]*Eval(A)[2]-Eval(A)[1]*Eval(B)[2],
                                  Eval(A)[1]*Eval(B)[1],
                                  HomalgRing(A));
                 end,
               
               Compose :=
                 function( A, B )
                   return HomalgLocalMatrix(
                                  Eval(A)[2]*Eval(B)[2],
                                  Eval(A)[1]*Eval(B)[1],
                                  HomalgRing(A));
                 end,
               
               NrRows :=
                 function( C )
                   return homalgTable(AssociatedGlobalRing(C))!.NrRows(Eval(C)[2]);
                 end,
               
               NrColumns :=
                 function( C )
                   return homalgTable(AssociatedGlobalRing(C))!.NrColumns(Eval(C)[2]);
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   return homalgTable(AssociatedGlobalRing(M))!.IsZeroMatrix(Eval(M)[2]);
                 end,

#  -> fallback
#               IsIdentityMatrix :=
#                 function( M )
#                   return homalgTable(AssociatedGlobalRing(M))!.IsIdentityMatrix(Eval(M)[2]) and IsOne(Eval(M)[1]);
#                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   return homalgTable(AssociatedGlobalRing(M))!.IsDiagonalMatrix(Eval(M)[2]);
                 end,
               
               ZeroRows :=
                 function( C )
                   return homalgTable(AssociatedGlobalRing(C))!.ZeroRows(Eval(C)[2]);
                 end,
               
               ZeroColumns :=
                 function( C )
                   return homalgTable(AssociatedGlobalRing(C))!.ZeroColumns(Eval(C)[2]);
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   
                   
                 end,
               
               DivideEntryByUnit :=
                 function( M, i, j, u )
                   
                   
                 end,
               
         
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   
                   
                 end,
    )
 );
