#! @Chunk AsZFunctionWithInductiveSides

LoadPackage( "ToolsForHomalg" );

#! @Example
f := function (i) Print( "Current i is ", i, "\n" ); return i^2; end;;
seq := AsZFunction( f );
#! <ZFunction>
seq[ 0 ];
#! Current i is 0
#! 0
seq[ 0 ];
#! 0
upper_func := function ( a )
  if a[ 2 ] <> 0 then return [ a[ 2 ], a[ 1 ] mod a[ 2 ] ]; fi; return a; end;;
lower_func := IdFunc;;
gcd_seq := ZFunctionWithInductiveSides( 0, [ 111, 259 ],
              lower_func, upper_func, \= );
#! <ZFunction>
HasStableLowerValue( gcd_seq );
#! false
gcd_seq[ -1 ];
#! [ 111, 259 ]
HasStableLowerValue( gcd_seq );
#! true
StableLowerValue( gcd_seq );
#! [ 111, 259 ]
IndexOfStableLowerValue( gcd_seq );
#! 0
gcd_seq[ 0 ];
#! [ 111, 259 ]
gcd_seq[ 1 ];
#! [ 259, 111 ]
gcd_seq[ 2 ];
#! [ 111, 37 ]
gcd_seq[ 3 ];
#! [ 37, 0 ]
HasStableUpperValue( gcd_seq );
#! false
gcd_seq[ 4 ];
#! [ 37, 0 ]
HasStableUpperValue( gcd_seq );
#! true
StableUpperValue( gcd_seq );
#! [ 37, 0 ]
IndexOfStableUpperValue( gcd_seq );
#! 3
sum := ApplyMap( gcd_seq, Sum );
#! <ZFunction>
sum[ 0 ];
#! 370
sum[ 100 ];
#! 37
c := CombineZFunctions( [ gcd_seq, sum ] );
#! <ZFunction>
c[ 0 ];
#! [ [ 111, 259 ], 370 ]
#! @EndExample
