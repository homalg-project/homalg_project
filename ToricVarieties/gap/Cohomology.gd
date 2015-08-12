#############################################################################
##
##  Cohomology.gd     ToricVarieties       Martin Bies
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  cohomology and multitruncations
##
#############################################################################


#################################
##
## Properties
##
#################################



#################################
##
## Attributes
##
#################################

##  <#GAPDoc Label="GSCone">
##  <ManSection>
##    <Attr Arg="variety" Name="GSCone"/>
##    <Returns>a list</Returns>
##    <Description>
##      Given a smooth and complete toric variety, this method returns a list of hyperplane constraints that define the Greg Smith cone.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GSCone",
                 IsToricVariety );


#################################
##
## Methods to extract the thus-far computed DegreeXParts of a toric variety
##
#################################

##  <#GAPDoc Label="DegreeXParts">
##  <ManSection>
##    <Oper Arg="variety" Name="DegreeXParts"/>
##    <Returns>a record</Returns>
##    <Description>
##      Given a toric variety, this method returns a record with the monomials of all degree layers of the Coxring, that have been computed 
##      for this toric variety thus far.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXParts",
                 [ IsToricVariety ] );


#################################
##
## Methods for (multi-) truncation
##
#################################

##  <#GAPDoc Label="Exponents">
##  <ManSection>
##    <Oper Arg="variety, degree" Name="Exponents"/>
##    <Returns>a list of lists of integers</Returns>
##    <Description>
##      Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of the class group of the 
##      variety, this method return a list of integer valued lists. These lists correspond to the exponents of the monomials of degree in 
##      the Cox ring of this toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Exponents",
               [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="MonomsOfCoxRingOfDegreeByNormaliz">
##  <ManSection>
##    <Oper Arg="variety, degree" Name="MonomsOfCoxRingOfDegreeByNormaliz"/>
##    <Returns>a list</Returns>
##    <Description>
##      Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of the class group of the 
##      variety, this method returns the list of all monomials in the Cox ring of the given degree. This method uses NormalizInterface. 
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormaliz",
               [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="DegreeXPart">
##  <ManSection>
##    <Oper Arg="variety, degree" Name="DegreeXPart"/>
##    <Returns>a list</Returns>
##    <Description>
##      Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of the class group of the 
##      variety, this method returns the list of all monomials in the Cox ring of the given degree. This method uses NormalizInterface. 
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPart",
                 [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="DegreeXPartVects">
##  <ManSection>
##    <Oper Arg="variety, degree, i, l" Name="DegreeXPartVects"/>
##    <Returns>a list of lists</Returns>
##    <Description>
##      Given a smooth and complete toric variety, a list of integers (= degree) corresponding to an element of the class group of the 
##      variety, and two non-negative integers i and l, this method returns a list of lists. The sublists are of length l and have at 
##      position i the monoms of the Coxring of degree 'degree'.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartVectors",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );

##  <#GAPDoc Label="DegreeXPartVectsII">
##  <ManSection>
##    <Oper Arg="variety, degree, i, l" Name="DegreeXPartVectsII"/>
##    <Returns>a list</Returns>
##    <Description>
##      Just as DegreeXPartVects, but the sublists of length l are turned into matrices valued in the Coxring of the toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartVectorsII",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );

##  <#GAPDoc Label="DegreeXPartOfFreeModule">
##  <ManSection>
##    <Oper Arg="variety, module, degree" Name="DegreeXPartOfFreeModule"/>
##    <Returns>a list of lists</Returns>
##    <Description>
##      Given a smooth and complete toric variety with Coxring S, a graded free S-module 'module' and list of integers (=degree) corresponding to an
##      element of the class group of the toric variety, this method returns a list of generators of the degree layer of the 'module'.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartOfFreeModule",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

##  <#GAPDoc Label="DegreeXPartOfFreeModuleAsVectorSpace">
##  <ManSection>
##    <Oper Arg="variety, module, degree" Name="DegreeXPartOfFreeModuleAsVectorSpace"/>
##    <Returns>a vector space</Returns>
##    <Description>
##      Just as DegreeXPartOfFreeModule, but the result is a vector space over the coefficient ring of the Coxring of the variety. Its
##      dimension is the length of the list of generators that the method DegreeXPartOfFreeModule would compute.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartOfFreeModuleAsVectorSpace",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

##  <#GAPDoc Label="DegreeXPartOfFreeModuleAsMatrix">
##  <ManSection>
##    <Oper Arg="variety, module, degree" Name="DegreeXPartOfFreeModuleAsMatrix"/>
##    <Returns>a list of matrices</Returns>
##    <Description>
##      Just as DegreeXPartOfFreeModule, but the generators are turned into matrices over the Coxring of the variety. Therefore this method
##      returns a list of matrices over the Coxring rather than a list of lists.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartOfFreeModuleAsMatrix",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

##  <#GAPDoc Label="DegreeXPartOfFPModule">
##  <ManSection>
##    <Oper Arg="variety, module, degree" Name="DegreeXPartOfFPModule"/>
##    <Returns>a vector space</Returns>
##    <Description>
##      Given a smooth and complete toric variety with Coxring S, a f.p. graded S-module 'module' and list of integers (=degree) corresponding
##      to an element of the class group of the toric variety, this method computes the degree 'degree' layer of (a) presentation morphisms
##      of 'module' and returns the cokernel object of this homomorphism of vector spaces.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartOfFPModule",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

DeclareOperation( "UnionOfRows",
                 [ IsList ] );


#################################
##
## Methods for B-transform
##
#################################

DeclareOperation( "H0FromBTransform",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ] );

##  <#GAPDoc Label="H0FromBTransformInInterval">
##  <ManSection>
##    <Oper Arg="variety, M, a, b" Name="H0FromBTransformInInterval"/>
##    <Returns>a list of vector spaces</Returns>
##    <Description>
##      Given a smooth and complete toric variety with Coxring <M>S</M>, a f.p. graded S-module <M>M</M> and two non-negative integers 
##      <M>a</M> and <M>b</M>, this method computes the degree zero layer of <M>\text{Hom} \left( B \left( x \right) , M \right)</M> for 
##      <M>x \in \left[ a,b \right]</M>. In this expression <M>B\left(x\right) </M> is the <M>x</M>-th Frobenius power of the irrelevant 
##      ideal of the toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0FromBTransformInInterval",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt, IsInt ] );


#######################################
##
## Methods to apply theorem by G. Smith
##
#######################################


DeclareOperation( "MultiGradedBetti", 
                  [ IsGradedModuleOrGradedSubmoduleRep ] );

DeclareOperation( "PointContainedInCone",
                  [ IsList, IsList ] );

##  <#GAPDoc Label="H0ByGS">
##  <ManSection>
##    <Oper Arg="variety, M" Name="H0ByGS"/>
##    <Returns>a list consisting of an integer and a vector space</Returns>
##    <Description>
##      Given a smooth, complete and projective toric variety with Coxring <M>S</M> and a f.p. graded S-module <M>M</M>, this method uses a 
##      theorem by Greg Smith to compute <M>H^0</M> of the sheaf <M>\widetilde{M}</M> on this toric variety. This is achieved by computing the 
##      degree zero layer of <M>\text{Hom} \left( B \left(e \right), M \right)</M>. The method computes this degree zero layer as a vector 
##      space and return a list consisting of the integer <M>e</M> and this vector space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0ByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

##  <#GAPDoc Label="HiByGS">
##  <ManSection>
##    <Oper Arg="variety, M, index" Name="HiByGS"/>
##    <Returns>a list consisting of an integer and a vector space</Returns>
##    <Description>
##      Given a smooth, complete and projective toric variety with Coxring <M>S</M> and a f.p. graded S-module <M>M</M>, this method uses a 
##      theorem by Greg Smith to compute <M>H^{\text{index}}</M> of the sheaf <M>\widetilde{M}</M> on this toric variety. This is achieved by 
##      computing the degree zero layer of <M>\text{Ext}^{\text{index}} \left( B \left( e \right), M \right) </M>. The method computes this 
##      degree zero layer as a vector space and returns a list consisting of the integer <M>e</M> and this vector space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "HiByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ] );

##  <#GAPDoc Label="AllCohomsByGS">
##  <ManSection>
##    <Oper Arg="variety, M" Name="AllCohomsByGS"/>
##    <Returns>a list consisting of an integer and of a list of vector spaces</Returns>
##    <Description>
##      Given a smooth, complete and projective toric variety <M> X_\Sigma </M> with Coxring <M>S</M> and a f.p. graded S-module <M>M</M>, 
##      this method computes all cohomology classes of <M>\widetilde{M}</M>. To this end an integer <M>e</M> is computed such that the degree 
##      zero layer of <M> \text{Ext}^{\text{index}} \left( B \left(e \right), M \right) </M> is isomorphic to 
##      <M> H^{\text{index}} \left( X_\Sigma, \widetilde{M} \right) </M> for all <M>i \in \left[ 0, \text{dim} \left( X_\Sigma \right) \right] 
##      </M>. The method returns this integer <M>e</M> and the collection of all degree zero parts (represented as vector spaces).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "AllCohomsByGS", 
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );


####################################################
##
## Methods for computation of H^0 specialised to CPN
##
####################################################

DeclareOperation( "IsCPN",
                  [ IsToricVariety ] );

##  <#GAPDoc Label="H0OnCPNViaLinReg">
##  <ManSection>
##    <Oper Arg="variety, M" Name="H0OnCPNViaLinReg"/>
##    <Returns>an integer</Returns>
##    <Description>
##      Given that variety is a complex projective space with Coxring S and <M>M</M> a f.p. graded S-module, this method computes the 
##      dimension of the vector space <M>H^0 \left( \widetilde{M} \right)</M> and returns this integer. To achieve this an integer <M>e</M> is 
##      computed such that <M>H^0 \left( \tilde{M} \right) \cong H_S^0 \left( \mathfrak{m}^e , \tilde{M} \right)_0</M>. This integer 
##      <M>e</M> in turn is computed by use of linear regularity of the module <M>M</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0OnCPNViaLinReg",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

##  <#GAPDoc Label="H0OnCPNForAllTwistsViaLinReg">
##  <ManSection>
##    <Oper Arg="variety, M" Name="H0OnCPNForAllTwistsViaLinReg"/>
##    <Returns>a function</Returns>
##    <Description>
##      Given that variety is a complex projective space with Coxring S and <M>M</M> a f.p. graded S-module, this method computes a function
##      <M>f \colon \mathbb{N}_{\geq 0} \to \mathbb{N}_{\geq 0}</M> such that <M>f \left( n \right) = \text{dim} \left( H^0 \left( 
##      \widetilde{M} \left( n \right) \right) \right)</M>. This function is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0OnCPNForAllTwistsViaLinReg",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );

##  <#GAPDoc Label="H0OnCPNInRangeViaLinReg">
##  <ManSection>
##    <Oper Arg="variety, M, range" Name="H0OnCPNInRangeViaLinReg"/>
##    <Returns>a list of non-negative integers</Returns>
##    <Description>
##      Given that variety is a complex projective space with Coxring S and <M>M</M> a f.p. graded S-module, this method uses the function
##      <M>f \colon \mathbb{N}_{\geq 0} \to \mathbb{N}_{\geq 0}</M> computed by <A>\emph{H0OnCPNForAllTwistsViaLinReg}</A> and evaluates it
##      for all integers in <A>\emph{range}</A>. The resulting list of non-negative integers is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0OnCPNInRangeViaLinReg",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );


####################################################
##
## Methods for the computation of H^0 on smooth and compact toric varieties
## which hand the input over to the fastest knwon method implemented thus far
##
####################################################

##  <#GAPDoc Label="H0">
##  <ManSection>
##    <Oper Arg="variety, M" Name="H0"/>
##    <Returns>a vector space or its dimension</Returns>
##    <Description>
##      Given that variety is a smooth and complete toric variety with Coxring S and <M>M</M> a f.p. graded S-module, this method computes
##      <M>H^0 \left( \widetilde{M} \right)</M>. To this end it hands the input of one of the above presented methods. Which method the input
##      is handed to depends on the input. In general however, the method that computes this cohomology class the fastest should be chosen.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );
      
##################################
##
## Constructors
##
##################################
