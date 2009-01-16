Read( "homalg.g" );
LoadPackage( "RingsForHomalg" );
b := true;
nr := NrRows( imat );
nc := NrColumns( imat );

## a way to change the ring
S := HomalgFieldOfRationals( );

Read( "convert_test.g" );

## GAP -> GAP

## a way to change the ring
S := HomalgRingOfIntegers( ) / [ 32001 ];

Read( "convert_test.g" );

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
