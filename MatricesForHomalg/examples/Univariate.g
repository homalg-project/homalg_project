Q := HomalgFieldOfRationals( );
R := Q["x"];
AssignGeneratorVariables( R );
mat :=
  [ [ 2*x^2-2*x+2, x^4+4*x^3-2*x^2+x, x^6+3*x^5-x^4-5*x^3+2*x^2-2*x,   -2*x^5-2*x^4+2*x^3+x^2+x+2 ],
    [     x^2+x-1, x^4+4*x^3+5*x^2+x,         x^6+4*x^5+5*x^4-3*x^2, -2*x^5-5*x^4-5*x^3-2*x^2-x-1 ],
    [         x-1,         x^3+3*x^2,         x^5+3*x^4+x^3-2*x^2+x,         -2*x^4-3*x^3-x^2-x-1 ] ];
mat := HomalgMatrix( mat, R );
