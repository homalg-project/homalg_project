mrel :=MatrixOfRelations( M );
mbas := BasisOfRowsCoeff( mrel );
U := RightHandSide( mbas );
Print( Eval( U * mrel - mbas ), "\n" );
nrel := MatrixOfRelations( N );
nbas := BasisOfColumnsCoeff( nrel );
V := BottomSide( nbas );
Print( Eval( nrel * V - nbas ), "\n" );
