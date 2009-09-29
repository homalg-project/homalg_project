LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInSingular( ) * "x";

S := Scheme( GradedLeftSubmodule( "x^3*(x-1)^2", R ) );

irrS := IrreducibleComponents( S );

Sred := ReducedScheme( S );

irrSred := IrreducibleComponents( Sred );
