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
##      Given a toric variety, this method returns a list of hyperplane constraints that define the Greg Smith cone.
##      The method assumes that the toric variety is smooth and complete. Otherwise it raises and error.
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
##      Given a toric variety (= variety) this method returns a record with the monomials of all degree layers of the Coxring, that have been 
##      computed for this toric variety thus far.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXParts",
                 [ IsToricVariety ] );


#################################
##
## Methods for truncation
##
#################################

##  <#GAPDoc Label="Exponents">
##  <ManSection>
##    <Oper Arg="variety, degree" Name="Exponents"/>
##    <Returns>a list</Returns>
##    <Description>
##      Given a toric variety (= variety) and a list (= degree) corresponding to an element of the class group, this method return a list of 
##      integer valued lists. These lists correspond to the exponents of the monomials in the Cox ring of variety of the given degree. The
##      method assumes that the variety is smooth and complete and raises and error otherwise.
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
##      Given a toric variety (= variety) and a list (= degree) corresponding to an element of the class group, this method returns the list 
##      of monomials in the Cox ring of the given degree. To this end the NormalizInterface is used. The method assumes that the variety is 
##      smooth and complete and raises and error otherwise.
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
##      Given a toric variety (= variety) and a list (= degree) corresponding to an element of the class group, this method returns the list 
##      of monomials in the Cox ring of the given degree. To this end it uses MonomsOfCoxRingOfDegreeByNormaliz.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPart",
                 [ IsToricVariety, IsList ] );

DeclareOperation( "replacer",
               [ IsInt, IsInt, IsRingElement ] );

##  <#GAPDoc Label="DegreeXPartVects">
##  <ManSection>
##    <Oper Arg="variety, degree, i,l" Name="DegreeXPartVects"/>
##    <Returns>a list</Returns>
##    <Description>
##      Given a toric variety (= variety), a list (= degree) corresponding to an element of the class group, and two positive integers, this 
##      method returns a list of lists. The sublists are of length l and have at position i the monoms of the Coxring of the specified 
##      degree. Otherwise the entries are zero. The method assumes that the variety is smooth and complete and raises and error otherwise.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartVects",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );

##  <#GAPDoc Label="DegreeXPartVectsII">
##  <ManSection>
##    <Oper Arg="variety, degree, i,l" Name="DegreeXPartVectsII"/>
##    <Returns>a list</Returns>
##    <Description>
##      Just as DegreeXPartVects, but the lists of length l are turned into matrices valued in the Coxring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartVectsII",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );

##  <#GAPDoc Label="DegreeXPartOfFreeModule">
##  <ManSection>
##    <Oper Arg="variety, module, degree" Name="DegreeXPartOfFreeModule"/>
##    <Returns>a list</Returns>
##    <Description>
##      Given that variety is a smooth and complete toric variety with Coxring S and module a free S-module, this method computes the degree 
##      part of this module. The result is a list of lists.
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
##      Just as DegreeXPartOfFreeModule, but the result is a vector space of appropriate dimension.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeXPartOfFreeModuleAsVectorSpace",
                 [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ] );

##  <#GAPDoc Label="DegreeXPartOfFreeModuleAsMatrix">
##  <ManSection>
##    <Oper Arg="variety, module, degree" Name="DegreeXPartOfFreeModuleAsMatrix"/>
##    <Returns>a list</Returns>
##    <Description>
##      Just as DegreeXPartOfFreeModule, but the result is a list of matrices.
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
##      Given that variety is a smooth and complete toric variety with Coxring S and module a finitely presented S-module, this method 
##      computes the degree part of this module. The result is a vector space.
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
##      Given that variety is a smooth and complete toric variety with Coxring S and that the module M is a finitely presented graded S-module, 
##      this method computes the degree 0 part of Hom( B(x), M ) for x in [a,b]. In this expression B(x) is the x-th Frobenius power of the 
##      irrelevant ideal of variety.
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

DeclareOperation( "Contained",
                  [ IsList, IsList ] );

DeclareOperation( "Checker",
                  [ IsToricVariety, IsInt, IsGradedModuleOrGradedSubmoduleRep ] );

##  <#GAPDoc Label="H0ByGS">
##  <ManSection>
##    <Oper Arg="variety, M" Name="H0ByGS"/>
##    <Returns>a list consisting of an integer and a vector space</Returns>
##    <Description>
##      Given that variety is a smooth, complete and projective toric variety with Coxring S and that the module M is a finitely presented 
##      graded S-module, this method computes an integer e, by means of a theorem by Greg Smith, such that the degree 0 part of Hom( B(e), M 
##      ) is isomorphic to H^0( variety, tilde(M) ). The degree 0 part is computed as vector space v. The method then returns the list [e, v].
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "H0ByGS",
                  [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ] );


##################################
##
## Constructors
##
##################################
