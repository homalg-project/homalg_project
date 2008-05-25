nu:=ResolutionOfHomomorphism(TorsionSubmoduleEmb(W));
pi:=ResolutionOfHomomorphism(TorsionFreeFactorEpi(W));
s:=HomalgComplex(pi);
Add(s,nu);
IsComplex(s);
