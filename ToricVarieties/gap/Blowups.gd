################################################################################################
##
##  BlowupsOfToricVarieties.gd        ToricVarieties package
##
##  Copyright 2019                    Martin Bies,       ULB Brussels
##
#! @Chapter Blowups of toric varieties
##
################################################################################################

########################
##
#! @Section Constructors
##
########################

#! @Description
#! The arguments are a toric variety vari, a string s which specifies the locus to be blown up and
#! a string which specifies how to name the new blowup coordinate. Based on this,
#! this method creates the blowup of a toric variety. This process rests on a star sub-division
#! of the fan (c.f. 3.3.17 in Cox-Little-Schenk)
#! @Returns a variety
#! @Arguments a toric variety, a list and a string
DeclareOperation( "BlowupOfToricVariety",
                  [ IsToricVariety, IsList, IsString ] );

#! @Description
#! The arguments are a toric variety vari and a list of lists. Each entry of this list must
#! contain the information for one blowup, i.e. be made up of the two lists used as input for
#! the method BlowupOfToricVariety. This method then performs this sequence of blowups
#! and returns the corresponding toric variety.
#! @Returns a variety
#! @Arguments a toric variety and a list
DeclareOperation( "SequenceOfBlowupsOfToricVariety",
                  [ IsToricVariety, IsList ] );
