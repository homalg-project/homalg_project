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
                   
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   
                 end,
               
               DiagMat :=
                 function( e )
                   
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   
                   
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
