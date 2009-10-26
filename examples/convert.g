Read( "homalg.g" );
LoadPackage( "HomalgToCAS" );

HOMALG_IO.color_display := true;

b := true;
nr := NrRows( imat );
nc := NrColumns( imat );

## GAP -> GAP (Gauss Q)

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgFieldOfRationals( );

Read( "convert_test.g" );

## GAP -> GAP (Gauss GF(32003))

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegers( 32003 );

Read( "convert_test.g" );

## GAP -> GAP (Gauss Z/2^15)

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegers( 2^15 );

Read( "convert_test.g" );

## GAP -> GAP

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegers( ) / 32003;

Read( "convert_test.g" );

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LoadPackage( "RingsForHomalg" );
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## GAP <-> External GAP

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegersInExternalGAP( );

Read( "convert_test.g" );

## GAP <-> Maple

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegersInMaple( );

Read( "convert_test.g" );

## GAP <-> Sage

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegersInSage( );

Read( "convert_test.g" );

## GAP <-> MAGMA

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgRingOfIntegersInMAGMA( );

Read( "convert_test.g" );

## GAP <-> Singular

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgFieldOfRationalsInSingular( );

Read( "convert_test.g" );

## GAP <-> Macaulay2

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

S := HomalgFieldOfRationalsInMacaulay2( );

Read( "convert_test.g" );

## result:

Print( "~~~~~~~~~~~~~~~~~~\n\n" );

Print( "Success: ", b, "\n\n" );

Assert( 0, b );
