#############################################################################
##
##  ExteriorAlgebra.gd          Modules package              Florian Diebold
##
##  Copyright 2011, Florian Diebold, University of Kaiserslautern
##
##  Declarations of operations for exterior powers.
##
#############################################################################

DeclareAttribute( "ExteriorPowers",
        IsHomalgModule, "mutable" );

DeclareOperation( "ExteriorPower",
        [ IsInt, IsHomalgModule ]);


##  <#GAPDoc Label="IsExteriorPower">
##  <ManSection>
##    <Prop Arg="M" Name="IsExteriorPower"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Marks a module as an exterior power of another module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsExteriorPower",
        IsHomalgModule );

##  <#GAPDoc Label="ExteriorPowerExponent">
##  <ManSection>
##    <Attr Arg="M" Name="ExteriorPowerExponent"/>
##    <Returns>an integer</Returns>
##    <Description>
##      The exponent of the exterior power.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ExteriorPowerExponent",
        IsHomalgModule );

##  <#GAPDoc Label="ExteriorPowerBaseModule">
##  <ManSection>
##    <Attr Arg="M" Name="ExteriorPowerBaseModule"/>
##    <Returns>a homalg module</Returns>
##    <Description>
##      The module that <A>M</A> is an exterior power of.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ExteriorPowerBaseModule",
        IsHomalgModule );


##  <#GAPDoc Label="IsExteriorPowerElement">
##  <ManSection>
##    <Prop Arg="x" Name="IsExteriorPowerElement"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the element <A>x</A> is from an exterior power.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsExteriorPowerElement",
        IsHomalgModuleElement );

DeclareGlobalFunction( "_Homalg_CombinationIndex" );
DeclareGlobalFunction( "_Homalg_IndexCombination" );

DeclareGlobalFunction( "_Homalg_FreeModuleElementFromList" );

DeclareOperation( "Wedge",
        [ IsHomalgModuleElement, IsHomalgModuleElement ] );
DeclareOperation( "ExteriorPowerElementDual",
        [ IsHomalgModuleElement ] );
DeclareOperation( "SingleValueOfExteriorPowerElement",
        [ IsHomalgModuleElement ] );


DeclareOperation( "KoszulComplex",
        [ IsList, IsHomalgModule ] );
DeclareOperation( "GradeSequence",
        [ IsList, IsHomalgModule ] );


##  <#GAPDoc Label="CayleyDeterminant">
##  <ManSection>
##    <Attr Arg="C" Name="CayleyDeterminant"/>
##    <Returns>a ring element</Returns>
##    <Description>
##      Returns the Cayley determinant of the complex <A>C</A>, if it is defined.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CayleyDeterminant",
        IsHomalgComplex );

##  <#GAPDoc Label="Gcd_UsingCayleyDeterminant">
##  <ManSection>
##    <Func Arg="x, y[, ...]" Name="Gcd_UsingCayleyDeterminant"/>
##    <Returns>a ring element</Returns>
##    <Description>
##      Returns the greatest common divisor of the given ring elements,
##      calculated using the Cayley determinant.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "Gcd_UsingCayleyDeterminant" );

