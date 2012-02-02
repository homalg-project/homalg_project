LoadPackage( "ToricVarieties" );

## We start with affine varieties, 3 and 2 dimensional.

sigma1 := Cone( [ [1,0,0], [0,1,0], [1,0,1], [0,1,1] ] );

U1 := ToricVariety( sigma1 );

## We first check the properties

Dimension( U1 );

IsSmooth( U1 );

IsOrbifold( U1 );

IsAffine( U1 );

IsProjective( U1 );

HasTorusFactor( U1 );

DimensionOfTorusFactor( U1 );

## We already know this variety

CoordinateRing( U1, "x" );

## and for further computations, we might set

CoordinateRingOfTorus( U1, [ "x", "y", "z" ] );

## Maybe we ask about the divisorgroup.

DivisorGroup( U1 );

## And the class group

ClassGroup( U1 );

## This resultant now is something we know

PicardGroup( U1 );

## as this holds

IsAffine( U1 );

#####
##### We want to have a look at the divisors.
#####

P := PrimeDivisors( U1 );

List( P, IsPrincipal );

## This suprises, we take a look

List( P, ClassOfDivisor );

## And might get lucky with this one

D := P[ 1 ] + P[ 2 ];

## This one seems to be better

IsPrincipal( D );

## and

IsCartier( D );

## Maybe we take a last look at the sheaf

BasisOfGlobalSectionsOfDivisorSheaf( D );

## Maybe we want to check another divisor