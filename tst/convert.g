b := true;
nr := NrRows( imat );
nc := NrColumns( imat );

## GAP -> GAP

## a way to copy a matrix internally
tmat := HomalgMatrix( imat, R );
IsIdenticalObj( Eval( imat ), Eval( imat ) );
IsIdenticalObj( Eval( imat ), Eval( tmat ) );

## a way to change the ring
S := HomalgFieldOfRationals( );

Read( "convert_test.g" );

b;

## GAP <-> External GAP

S := HomalgRingOfIntegersInExternalGAP( );

Read( "convert_test.g" );

b;

## GAP <-> Maple

S := HomalgRingOfIntegersInMaple( );

Read( "convert_test.g" );

b;

## GAP <-> Sage

S := HomalgRingOfIntegersInSage( );

Read( "convert_test.g" );

b;

## GAP <-> MAGMA

S := HomalgRingOfIntegersInMAGMA( );

Read( "convert_test.g" );

b;
