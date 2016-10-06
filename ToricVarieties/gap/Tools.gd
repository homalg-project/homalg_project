#############################################################################
##
##  Tools.gd         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Tools for toric varieties
##
#############################################################################

#######################
##
## Methods
##
#######################

##  <#GAPDoc Label="DefaultFieldForToricVarieties">
##  <ManSection>
##    <Oper Arg="" Name="DefaultFieldForToricVarieties"/>
##    <Returns>a field of rationals</Returns>
##    <Description>
##      A method to get the default field for the current &ToricVarieties; session.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DefaultFieldForToricVarieties",
                  [ ] );

DeclareOperation( "DefaultGradedFieldForToricVarieties",
                  [ ] );

##  <#GAPDoc Label="InstallMethodsForSubvarieties">
##  <ManSection>
##    <Oper Arg="" Name="InstallMethodsForSubvarieties"/>
##    <Returns>true</Returns>
##    <Description>
##      Installs methods for the category ToricSubvariety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "InstallMethodsForSubvarieties",
                  [ ] );

DeclareOperation( "ProjectiveSpace",
                  [ IsInt ] );

DeclareOperation( "AffineSpace",
                  [ IsInt ] );

DeclareOperation( "HirzebruchSurface",
                  [ IsInt ] );

## They told me that this is part of the new gap.
## Apparently not.
## Ask Mohamed about it.
# # DeclareOperation( "InstallFalseMethod",
# #                   [ IsFunction, IsFunction ] );
