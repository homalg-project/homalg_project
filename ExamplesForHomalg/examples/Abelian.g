## Abelian.g
Read( "ReducedBasisOfModule.g" );

## abelian category: [HS, Prop. II.9.6]
d := Resolution( W );
d2 := CertainMorphism( d, 2 );
C_coker := CokernelSequence( d2 );
C_ker := KernelSequence( d2 );
