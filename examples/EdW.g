Read( "ReducedBasisOfModule.g" );

d := Resolution( W );
dW := d * W;
EdW := Ext( 1, dW, W );
C := Cohomology( EdW );
