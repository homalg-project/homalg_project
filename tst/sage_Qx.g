LoadPackage( "RingsForHomalg" );
HOMALG_IO.color_display := true;
Qx := HomalgFieldOfRationalsInSage( ) * "x";
Display( Qx );
wmat := HomalgMatrix( " \
[ [1, 2*x+x^2, 2*x+3*x^3-3*x^2-x^4, -1+x^3+2*x^4-2*x^2+x-x^5], \
  [x, 2*x^2+x^3+x, x^2+4*x^4-4*x^3-x^5+x, x^4+2*x^2+3*x^5-4*x^3-x^6], \
  [1-x, 3*x-x^3, 4*x-7*x^2+2*x^5-4*x^4+5*x^3, 4*x-1+x^3-2*x^2+2*x^6-2*x^5], \
  [x, -x+x^3+x^2, -2*x+4*x^2-2*x^5+3*x^4-2*x^3, -3*x-2*x^6+x^5+2*x^4], \
  [x+1, 5*x+x^3+4*x^2, 6*x-5*x^2+4*x^4-3*x^3, 4*x-1-7*x^3+2*x^2+4*x^5+2*x^4] ]\
", Qx );
W := LeftPresentation( wmat );
