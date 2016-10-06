########################################################################################
##
##  DegreeXLayer.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Truncations of the Coxring to single degrees
##
########################################################################################

##########################################################
##
#! @Section DegreeXLayers of the Cox ring
##
##########################################################

#! @Description
#! Given a toric variety, this method returns a record with the monomials of all degree layers of the Coxring, 
#! that have been computed for this toric variety thus far.
#! @Returns a record
#! @Arguments vari
DeclareOperation( "DegreeXLayers",
                 [ IsToricVariety ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element of 
#! the class group of the variety, this method return a list of integer valued lists. These lists correspond 
#! to the exponents of the monomials of degree in the Cox ring of this toric variety.
#! @Returns a list of lists of integers
#! @Arguments vari, degree
DeclareOperation( "Exponents",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element
#! of the class group of the variety, this method returns the list of all monomials in the Cox ring of the
#! given degree. This method uses NormalizInterface. 
#! @Returns a list
#! @Arguments vari, degree
DeclareOperation( "MonomsOfCoxRingOfDegreeByNormaliz",
               [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety and a list of integers (= degree) corresponding to an element
#! of the class group of the variety, this method returns the list of all monomials in the Cox ring of the
#! given degree. This method uses NormalizInterface. 
#! @Returns a list
#! @Arguments vari, degree
DeclareOperation( "DegreeXLayer",
                 [ IsToricVariety, IsList ] );

#! @Description
#! Given a smooth and complete toric variety, a list of integers (= degree) corresponding to an element
#! of the class group of the variety and two non-negative integers i and l, this method returns a list
#! of column matrices. The columns are of length l and have at position i the monoms of the Coxring of degree 'degree'.
#! @Returns a list of matrices
#! @Arguments vari, degree, i, l
DeclareOperation( "DegreeXLayerVectorsAsColumnMatrices",
                 [ IsToricVariety, IsList, IsPosInt, IsPosInt ] );