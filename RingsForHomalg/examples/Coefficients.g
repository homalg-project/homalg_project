LoadPackage( "RingsForHomalg" );

test_coefficients := function( QQ )
  local R, poly, monomials, coeffs;
    
    R := QQ * "x,y";
    
    poly := "2*x^2+3*x*y+5" / R;
    
    monomials := [ "1" / R, "x*y" / R, "x^2" / R, "y^2" / R ];
    
    coeffs := CoefficientsWithGivenMonomials( poly, monomials );
    
    Assert( 0, coeffs = HomalgMatrix( "[ 5, 3, 2, 0 ]", 1, 4, R ) );
    
end;

test_coefficients( HomalgFieldOfRationalsInSingular( ) );
