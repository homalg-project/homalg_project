# <#GAPDoc Label="HilbertBasis2">
# <Subsection Label="HilbertBasisIneq">
# <Heading>Hilbert basis of dual cone</Heading>
# We want to compute the Hilbert basis of the cone which faces
# are represented by the inequalities below. This example is
# taken from the toric and the ToricVarieties package manual.
# In both packages it is very slow with the internal algorithms.
# <Example>
# <![CDATA[
# gap> LoadPackage( "4ti2Interface" );
# true
# gap> inequalities := [ [1,2,3,4],[0,1,0,7],[3,1,0,2],[0,0,1,0] ];
# [ [ 1, 2, 3, 4 ], [ 0, 1, 0, 7 ], [ 3, 1, 0, 2 ], [ 0, 0, 1, 0 ] ]
# gap> basis := 4ti2Interface_hilbert_inequalities( inequalities );;
# gap> time;
# 0
# gap> Length( basis );
# 29
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "4ti2Interface" );
inequalities := [ [1,2,3,4],[0,1,0,7],[3,1,0,2],[0,0,1,0] ];
basis := 4ti2Interface_hilbert_inequalities( inequalities );;
time;
Length( basis );