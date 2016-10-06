################################################################################################
##
##  ICTCurves.gd                       SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Irreducible, complete, torus-invariant curves and proper 1-cycles in a toric variety
##
################################################################################################



##############################################################################################
##
#! @Section GAP category of irreducible, complete, torus-invariant curves (= ICT curves)
##
##############################################################################################

#! @Description
#! The GAP category for irreducible, complete, torus-invariant curves
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsICTCurve",
                 IsObject );



##############################################################################################
##
#! @Section Constructors for ICT Curves
##
##############################################################################################

#! @Description
#! The arguments are a smooth and complete toric variety $X_\Sigma$ and two non-negative and distinct integers $i,j$.
#! We then consider the i-th and j-th maximal cones $\sigma_i$ and $\sigma_j$. ! If $\tau := \sigma_i \cap \sigma_j$ 
#! satisfies $\text{dim} \left( \tau \right) = \text{dim} \left( \sigma_1 \right) - 1$, then $\tau$ corresponds to 
#! an ICT-curve. We then construct this very ICT-curve.
#! @Returns an ICT curve
#! @Arguments X_Sigma, i, j
DeclareOperation( "ICTCurve",
                  [ IsToricVariety, IsInt, IsInt ] );

DeclareOperation( "ICTCurve",
                  [ IsToricVariety, IsInt, IsInt, IsBool ] );



##############################################################################################
##
#! @Section Attributes for ICT curves
##
##############################################################################################

#! @Description
#! The argument is an ICT curve $C$. The output is the toric variety, in which this curve $C$ lies.
#! @Returns a toric variety
#! @Arguments C
DeclareAttribute( "AmbientToricVariety",
                   IsICTCurve );

#! @Description
#! The argument is an ICT curve $C$. The output are two integers, which indicate which maximal rays 
#! were intersected to form the cone $\tau$ associated to this curve $C$.
#! @Returns a list of two positive and distinct integers
#! @Arguments C
DeclareAttribute( "IntersectedMaximalCones",
                   IsICTCurve );

#! @Description
#! The argument is an ICT curve $C$. The output is the list of ray-generators for the cone tau
#! @Returns a list of lists of integers
#! @Arguments C
DeclareAttribute( "RayGenerators",
                   IsICTCurve );

#! @Description
#! The argument is an ICT curve $C$. The output is the list of variables whose simultaneous vanishing locus 
#! cuts out this curve.
#! @Returns a list
#! @Arguments C
DeclareAttribute( "DefiningVariables",
                   IsICTCurve );

#! @Description
#! The argument is an ICT curve $C$. The output is the f.p. graded S-module which sheafifes to the structure sheaf 
#! of this curve $C$.
#! @Returns a f.p. graded module
#! @Arguments C
DeclareAttribute( "StructureSheaf",
                   IsICTCurve );

#! @Description
#! The argument is an ICT curve $C$. The output is the integral vector $u$ used to compute intersection products 
#! with Cartier divisors.
#! @Returns a list of integers
#! @Arguments C
DeclareAttribute( "IntersectionU",
                   IsICTCurve );

#! @Description
#! The argument is an ICT curve $C$. The output is a list with the intersection numbers of a canonical base 
#! of the class group. This basis is to take $\left( e_1, \dots, e_k \right)$ with $e_i = \left( 0, \dots, 0, 
#! 1, 0, \dots, 0 \right) \in \text{Cl} \left( X_\Sigma \right)$.
#! @Returns a list of integers
#! @Arguments C
DeclareAttribute( "IntersectionList",
                   IsICTCurve );



##############################################################################################
##
#! @Section Operations with ICTCurves
##
##############################################################################################

#! @Description
#! For a smooth and complete toric variety $X_\Sigma$, this method computes a list of all ICT-curves in $X_\Sigma$. 
#! Note that those curves can be numerically equivalent.
#! @Returns a list of ICT-curves.
#! @Arguments X_Sigma
DeclareAttribute( "ICTCurves",
                  IsToricVariety );

#! @Description
#! Given an ICT-curve $C$ and a divisor $D$ in a smooth and complete toric variety $X_\Sigma$, this method computes
#! their intersection product.
#! @Returns an integer
#! @Arguments C,D
DeclareOperation( "IntersectionProduct",
                 [ IsICTCurve, IsToricDivisor ] );
DeclareOperation( "IntersectionProduct",
                 [ IsToricDivisor, IsICTCurve ] );



##############################################################################################
##
#! @Section GAP category for proper 1-cycles
##
##############################################################################################

#! @Description
#! The GAP category for proper 1-cycles
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsProper1Cycle",
                 IsObject );

# canonically, every ICTCurve is a proper 1-cycle, but we do NOT make this identification here
# the reason for this is, that I would like to make sure that then ICTCurve has all attributes of a proper 1-cycle
# -> that would mean we need UnderlyingGroupElement
# -> this in turn means we need GeneratorsOfProper1Cycles
# -> and the latter method is still very slow (e.g. P2 x P2 x P5)



##############################################################################################
##
#! @Section Constructor For Proper 1-Cycles
##
##############################################################################################

#! @Description
#! For a smooth and complete toric variety $X_\Sigma$, this method computes a list of all ICT-curves which are not 
#! numerically equivalent. We use this list of ICT-curves as a basis of proper 1-cycles on $X_\Sigma$ in the 
#! constructor below, when computing the intersection form and the Nef-cone.
#! @Returns a list of ICT-curves.
#! @Arguments X_Sigma
DeclareAttribute( "GeneratorsOfProper1Cycles",
                  IsToricVariety );

#! @Description
#! The arguments are a smooth and complete toric variety $X_\Sigma$ and a list of integers. We then use the integers
#! in this list as 'coordinates' of the proper 1-cycle with respect to the list of proper 1-cycles produced by the 
#! previous method. We then return the corresponding proper 1-cycle.
#! @Returns a proper 1-cycle
#! @Arguments X_Sigma, list
DeclareOperation( "Proper1Cycle",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "Proper1Cycle",
                  [ IsToricVariety, IsHomalgModuleElement ] );


##############################################################################################
##
#! @Section Attributes for proper 1-cycles
##
##############################################################################################

#! @Description
#! The argument is a proper 1-cycle $C$. The output is the toric variety, in which this cycle $C$ lies.
#! @Returns a toric variety
#! @Arguments C
DeclareAttribute( "AmbientToricVariety",
                   IsICTCurve );

#! @Description
#! The argument is a proper 1-cycle. We then return the underlying group element (with respect to the generators 
#! computed from the method \emph{GeneratorsOfProper1Cycles}).
#! @Returns a list
#! @Arguments C
DeclareAttribute( "UnderlyingGroupElement",
                   IsProper1Cycle );



##############################################################################################
##
#! @Section Operations with proper 1-cycles
##
##############################################################################################

#! @Description
#! Given a proper 1-cycle $C$ and a divisor $D$ in a smooth and complete toric variety $X_\Sigma$, this method
#! computes their intersection product.
#! @Returns an integer
#! @Arguments C,D
DeclareOperation( "IntersectionProduct",
                 [ IsProper1Cycle, IsToricDivisor ] );
DeclareOperation( "IntersectionProduct",
                 [ IsToricDivisor, IsProper1Cycle ] );

#! @Description
#! Given a simplicial and complete toric variety, we can use proposition 6.4.1 of Cox-Schenk-Litte to compute
#! the intersection form <M>N^1 \left( X_\Sigma \right) \times N_1 \left( X_\Sigma \right) \to \mathbb{R} </M>.
#! We return a list of lists that encodes this mapping.
#! @Returns a list of lists
#! @Arguments vari
DeclareAttribute( "IntersectionForm",
                  IsToricVariety );