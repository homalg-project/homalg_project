# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

DeclareOperation( "FullyDividePairTrafo",
        [ IsRingElement, IsRingElement, IsHomalgRing ] );

DeclareOperation( "FullyDividePairTrafoInflated",
        [ IsRingElement, IsRingElement, IsInt, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "FullyDivideColumnTrafo",
        [ IsHomalgMatrix ] );

DeclareOperation( "FullyDivideMatrixTrafo",
        [ IsHomalgMatrix ] );

DeclareOperation( "DivideColumnTrafo",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "StrictlyFullyDivideMatrixTrafo",
        [ IsHomalgMatrix ] );
