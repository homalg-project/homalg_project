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
