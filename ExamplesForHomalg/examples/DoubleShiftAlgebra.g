#! @Chunk DoubleShiftAlgebra

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( "m" );
#! Q(m)
B := Q["b,c"];
#! Q(m)[b,c]
A := B["a1..3"];
#! Q(m)[b,c][a1,a2,a3]
Y := DoubleShiftAlgebra( A, "Y1,Y2,Y3,Y1_,Y2_,Y3_" );
#! Q(m)[b,c][a1,a2,a3]<Y1,Y2,Y3,Y1_,Y2_,Y3_>/( Y1*Y1_-1, Y2*Y2_-1, Y3*Y3_-1 )
P := DoubleShiftAlgebra( A, "Y1,Y1_,Y2,Y2_,Y3,Y3_" : pairs := true );
#! Q(m)[b,c][a1,a2,a3]<Y1,Y1_,Y2,Y2_,Y3,Y3_>/( Y1*Y1_-1, Y2*Y2_-1, Y3*Y3_-1 )
S := DoubleShiftAlgebra( A, "Y1,Y1_,Y2,Y2_,Y3,Y3_" : pairs := true, steps := [ 1, -1, 1/2 ] );
#! Q(m)[b,c][a1,a2,a3]<Y1,Y1_,Y2,Y2_,Y3,Y3_>/( Y1*Y1_-1, Y2*Y2_-1, Y3*Y3_-1 )
ExportVariables( S );
#! [ m, |[ b ]|, |[ c ]|, |[ a1 ]|, |[ a2 ]|, |[ a3 ]|,
#!  |[ Y1 ]|, |[ Y1_ ]|, |[ Y2 ]|, |[ Y2_ ]|, |[ Y3 ]|, |[ Y3_ ]| ]
Y1 * Y1_;
#! |[ 1 ]|
Y1 * a1;
#! |[ a1*Y1+Y1 ]|
Y1_ * a1;
#! |[ a1*Y1_-Y1_ ]|
Y2 * a2;
#! |[ a2*Y2-Y2 ]|
Y2_ * a2;
#! |[ a2*Y2_+Y2_ ]|
Y3 * a3;
#! |[ a3*Y3+1/2*Y3 ]|
Y3_ * a3;
#! |[ a3*Y3_-1/2*Y3_ ]|
#! @EndExample
