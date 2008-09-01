Read( "ReducedBasisOfModule.g" );

W := Hom( Qxyz, W );

d := Resolution( W );
dW := d * W;
EdW := Ext( 1, dW, W );
C := Cohomology( EdW );
