################################################################################################
##
##  NefMoriAndIntersection.gd          SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Nef and Mori Cone
##
################################################################################################



#############################################
##
#! @Section New Properties For Toric Divisors
##
#############################################

#! @Description
#! Checks if the torus invariant Weil divisor <A>divi</A> is nef.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsNef",
                 IsToricDivisor );

#! @Description
#! Checks if the class of the torus invariant Weil divisor <A>divi</A> lies in the interior of the nef cone. 
#! Given that the ambient toric variety is projective this implies that <A>divi</A> is ample.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsAmpleViaNefCone",
                 IsToricDivisor );



#################################
##
#! @Section Attributes
##
#################################

#! @Description
#! Given a toric variety <A>vari</A>, we compute the integral vectors in 
#! <M>\mathbb{Z}^{n \left| \Sigma_{\text{max}} \right|}</M>, <M>n</M> is the rank of the character lattice 
#! which encodes a toric Cartier divisor according to theorem 4.2.8. in Cox-Schenk-Little. We return a list of lists. 
#! When interpreting this list of lists as a matrix, then the kernel of this matrix is the set of these vectors.
#! @Returns a list of lists
#! @Arguments vari
DeclareAttribute( "CartierDataGroup",
                  IsToricVariety );

#! @Description
#! Given a smooth and complete toric variety <A>vari</A>, we compute the nef cone within the proper Cartier data in 
#! <M>\mathbb{Z}^{n \left| \Sigma_{\text{max}} \right|}</M>, <M>n</M> is the rank of the character lattice. 
#! We return a list of ray generators of this cone.
#! @Returns a list of lists
#! @Arguments vari
DeclareAttribute( "NefConeInCartierDataGroup",
                  IsToricVariety );

#! @Description
#! Given a smooth and complete toric variety, we compute the nef cone within 
#! <M> \text{Div}_T \left( X_\Sigma \right) </M>. We return a list of ray generators of this cone.
#! @Returns a list of lists
#! @Arguments vari
DeclareAttribute( "NefConeInTorusInvariantWeilDivisorGroup",
                  IsToricVariety );

#! @Description
#! Given a smooth and complete toric variety, we compute the nef cone within 
#! <M> \text{Cl} \left( X_\Sigma \right) </M>. We return a list of ray generators of this cone.
#! @Returns a list of lists
#! @Arguments vari
DeclareAttribute( "NefConeInClassGroup",
                  IsToricVariety );
DeclareAttribute( "NefCone",
                  IsToricVariety );

#! @Description
#! Given a smooth and complete toric variety, we compute the smallest divisor class, such that the 
#! associated divisor is ample. This is based on theorem 6.3.22 in Cox-Schenk-Little, which implies that this 
#! task is equivalent to finding the smallest lattice point within the nef cone 
#! (in <M>\text{Cl} \left( X_\Sigma \right)</M>). We return a list of integers encoding this lattice point.
#! @Returns a list of integers
#! @Arguments vari
DeclareAttribute( "ClassOfSmallestAmpleDivisor",
                  IsToricVariety );

#! @Description
#! Given a simplicial and complete toric variety, we use proposition 6.4.1 of Cox-Schenk-Litte to compute 
#! the group of proper 1-cycles. We return the corresponding kernel submodule. 
#! @Returns a kernel submodule
#! @Arguments vari
DeclareAttribute( "GroupOfProper1Cycles",
                  IsToricVariety );

#! @Description
#! Given a smooth and complete toric variety, we can compute both the intersection form and the Nef cone in 
#! the class group. Then the Mori cone is the dual cone of the Nef cone with respect to the intersection product. 
#! We compute an H-presentation of this dual cone and use those to produce a cone with the normaliz interface.
#! @Returns an NmzCone6
#! @Arguments vari
DeclareAttribute( "MoriCone",
                  IsToricVariety );