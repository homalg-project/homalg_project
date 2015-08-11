# <#GAPDoc Label="CohomologyExample">
# <Subsection Label="CohomologyExampleSubsection">
# <Heading>Cohomology of coherent sheaves on a toric variety</Heading>
# <Example><![CDATA[
# gap> F1 := Fan( [[1],[-1]], [[1],[2]] );
# <A fan in |R^1>
# gap> CP1 := ToricVariety( F1 );
# <A toric variety of dimension 1>
# gap> B := GradedLeftSubmodule( "x_1, x_2", CoxRing( CP1 ) );
# <A graded torsion-free (left) ideal given by 2 generators>
# gap> ByASmallerPresentation( ClassGroup( CP1 ) );
# <A free left module of rank 1 on a free generator>
# gap> H0FromBTransformInInterval( CP1, B, 0, 5 );
# warning: matrix has rank 0. Please check input data.
# warning: matrix has rank 0. Please check input data.
# [ ( Q^0 ), ( Q^1 ), ( Q^1 ), ( Q^1 ), ( Q^1 ), ( Q^1 ) ]
# H0ByGS( CP1, B );
# [ 2, ( Q^1 ) ]
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "ToricVarieties" );
F1 := Fan( [[1],[-1]], [[1],[2]] );
CP1 := ToricVariety( F1 );
B := GradedLeftSubmodule( "x_1, x_2", CoxRing( CP1 ) );
ByASmallerPresentation( ClassGroup( CP1 ) );
H0FromBTransformInInterval( CP1, B, 0, 5 );
H0ByGS( CP1, B );
