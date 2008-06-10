Read( "ReducedBasisOfModule.g" );
nu:=Resolution(TorsionSubmoduleEmb(W));
pi:=Resolution(TorsionFreeFactorEpi(W));
s:=HomalgComplex(pi);
Add(s,nu);
IsComplex(s);
