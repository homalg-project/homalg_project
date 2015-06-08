# <#GAPDoc Label="HilbertBasis">
# <Subsection Label="HilbertBasisEq">
# <Heading>Generators of semigroup</Heading>
# We want to compute the Hilbert basis of the cone obtained
# by intersecting the positive orthant with the hyperplane
# given by the equation below.
# <Example>
# <![CDATA[
# gap> LoadPackage( "4ti2Interface" );
# true
# gap> gens := [ 23,25,37,49 ];
# [ 23, 25, 37, 49 ]
# gap> equation := [ Concatenation( gens, -gens ) ];
# [ [ 23, 25, 37, 49, -23, -25, -37, -49 ] ]
# gap> basis := 4ti2Interface_hilbert_equalities_in_positive_orthant( equation );;
# gap> time;
# 12
# gap> Length( basis );
# 436
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "4ti2Interface" );
gens := [ 23,25,37,49 ];
equation := [ Concatenation( gens, -gens ) ];
basis := 4ti2Interface_hilbert_equalities_in_positive_orthant( equation );;
time;
Length( basis );