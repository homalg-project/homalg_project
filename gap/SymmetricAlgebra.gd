#############################################################################
##
##  SymmetricAlgebra.gd                                      Modules package
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for symmetric powers.
##
#############################################################################

DeclareAttribute( "SymmetricPowers",
        IsHomalgModule, "mutable" );

##  <#GAPDoc Label="SymmetricPower">
##  <ManSection>
##    <Oper Arg="k, M" Name="SymmetricPower"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      Construct the <A>k</A>-th exterior power of module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation( "SymmetricPower",
        [ IsInt, IsHomalgModule ]);

DeclareOperation( "SymmetricPower",
        [ IsInt, IsHomalgMatrix ]);

DeclareOperation( "SymmetricPower",
        [ IsInt, IsHomalgMorphism ]);

DeclareOperation( "SymmetricPowerOfPresentationMorphism",
        [ IsInt, IsHomalgMorphism ]);

##  <#GAPDoc Label="IsSymmetricPower">
##  <ManSection>
##    <Prop Arg="M" Name="IsSymmetricPower"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Marks a module as an symmetric power of another module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSymmetricPower",
        IsHomalgModule );

##  <#GAPDoc Label="SymmetricPowerExponent">
##  <ManSection>
##    <Attr Arg="M" Name="SymmetricPowerExponent"/>
##    <Returns>an integer</Returns>
##    <Description>
##      The exponent of the symmetric power.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SymmetricPowerExponent",
        IsHomalgModule );

##  <#GAPDoc Label="SymmetricPowerBaseModule">
##  <ManSection>
##    <Attr Arg="M" Name="SymmetricPowerBaseModule"/>
##    <Returns>a homalg module</Returns>
##    <Description>
##      The module that <A>M</A> is an symmetric power of.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SymmetricPowerBaseModule",
        IsHomalgModule );

