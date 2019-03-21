#############################################################################
##
##  LIMAT.gd                    LIMAT subpackage             Mohamed Barakat
##
##         LIMAT = Logical Implications for homalg MATrices
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the LIMAT subpackage.
##
#############################################################################

# our info class:
DeclareInfoClass( "InfoLIMAT" );
SetInfoLevel( InfoLIMAT, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIMAT" );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "LogicalImplicationsForHomalgMatrices" );

DeclareGlobalVariable( "LogicalImplicationsForHomalgMatricesOverSpecialRings" );

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMAT,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ "IsZero",
              "IsOne",
              "IsPermutationMatrix",
              "IsSpecialSubidentityMatrix",
              "IsSubidentityMatrix",
              "IsLeftRegular",
              "IsRightRegular",
              "IsInvertibleMatrix",
              "IsLeftInvertibleMatrix",
              "IsRightInvertibleMatrix",
              "IsEmptyMatrix",
              "IsDiagonalMatrix",
              "IsScalarMatrix",
              "IsUpperTriangularMatrix",
              "IsLowerTriangularMatrix",
              "IsStrictUpperTriangularMatrix",
              "IsStrictLowerTriangularMatrix",
              "IsUpperStairCaseMatrix",
              "IsLowerStairCaseMatrix",
              "IsBasisOfRowsMatrix",
              "IsBasisOfColumnsMatrix",
              "IsReducedBasisOfRowsMatrix",
              "IsReducedBasisOfColumnsMatrix",
              "IsUnitFree",
              ],
            intrinsic_attributes :=
            [ "NrRows",
              "NrColumns",
              "RowRankOfMatrix",
              "ColumnRankOfMatrix",
              "ZeroRows",
              "ZeroColumns",
              "NonZeroRows",
              "NonZeroColumns",
              "PositionOfFirstNonZeroEntryPerRow",
              "PositionOfFirstNonZeroEntryPerColumn",
              ],
            ShallowCopy_attributes :=
            [
              "BasisOfRowModule",
              "BasisOfColumnModule",
              "SyzygiesGeneratorsOfRows",
              "SyzygiesGeneratorsOfColumns",
              "ReducedBasisOfRowModule",
              "ReducedBasisOfColumnModule",
              "ReducedSyzygiesGeneratorsOfRows",
              "ReducedSyzygiesGeneratorsOfColumns",
              ],
            intrinsic_components :=
            [ "DecideZeroRows",
              "DecideZeroColumns",
              "BasisOfRowsCoeff",
              "BasisOfColumnsCoeff",
              "DecideZeroRowsEffectively",
              "DecideZeroColumnsEffectively",
              ],
            )
        );

##
InstallValue( LogicalImplicationsForHomalgMatrices,
        [ ## logical implications for matrices
          
          [ IsEmptyMatrix,
            "implies", IsZero ],
          
          [ IsEmptyMatrix,
            "implies", IsSpecialSubidentityMatrix ],
          
          ## follows from the rest, but this gives a direct way
          [ IsZero,
            "implies", IsDiagonalMatrix ],
          
          [ IsZero,
            "implies", IsUpperStairCaseMatrix ],
          
          [ IsZero,
            "implies", IsLowerStairCaseMatrix ],
          
          [ IsZero,
            "implies", IsStrictUpperTriangularMatrix ],
          
          [ IsZero,
            "implies", IsStrictLowerTriangularMatrix ],
          
          [ IsOne,
            "implies", IsPermutationMatrix ],
          
          [ IsOne,
            "implies", IsScalarMatrix ],
          
          [ IsScalarMatrix,
            "implies", IsDiagonalMatrix ],
          
          [ IsOne,
            "implies", IsUpperStairCaseMatrix ],
          
          [ IsOne,
            "implies", IsLowerStairCaseMatrix ],
          
          [ IsSubidentityMatrix, "and", IsInvertibleMatrix,
            "imply", IsPermutationMatrix ],
          
          [ IsPermutationMatrix,
            "implies", IsInvertibleMatrix ],
          
          [ IsPermutationMatrix,
            "implies", IsSubidentityMatrix ],
          
          [ IsSpecialSubidentityMatrix,
            "implies", IsSubidentityMatrix ],
          
          ## a split injective morphism (of free modules) is injective
          [ IsRightInvertibleMatrix,
            "implies", IsLeftRegular ],
          
          [ IsLeftInvertibleMatrix,
            "implies", IsRightRegular ],
          
          ## an isomorphism is split injective
          [ IsInvertibleMatrix,
            "implies", IsRightInvertibleMatrix ],
          
          ## an isomorphism is split surjective
          [ IsInvertibleMatrix,
            "implies", IsLeftInvertibleMatrix ],
          
          ## a split surjective and split injective morphism (of free modules) is an isomorphism
          [ IsLeftInvertibleMatrix, "and", IsRightInvertibleMatrix,
            "imply", IsInvertibleMatrix ],
          
          [ IsDiagonalMatrix,
            "implies", IsUpperTriangularMatrix ],
          
          [ IsDiagonalMatrix,
            "implies", IsLowerTriangularMatrix ],
          
          [ IsStrictUpperTriangularMatrix,
            "implies", IsUpperTriangularMatrix ],
          
          [ IsStrictLowerTriangularMatrix,
            "implies", IsLowerTriangularMatrix ],
          
          [ IsUpperStairCaseMatrix,
            "implies", IsUpperTriangularMatrix ],
          
          [ IsLowerStairCaseMatrix,
            "implies", IsLowerTriangularMatrix ],
          
          [ IsUpperTriangularMatrix,
            "implies", IsTriangularMatrix ],
          
          [ IsLowerTriangularMatrix,
            "implies", IsTriangularMatrix ],
          
          [ IsUpperTriangularMatrix, "and", IsLowerTriangularMatrix,
            "imply", IsDiagonalMatrix ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgMatricesOverSpecialRings,
        [ ## logical implications for matrices over special rings
          
          ] );

