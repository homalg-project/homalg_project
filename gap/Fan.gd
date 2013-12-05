#############################################################################
##
##  Fan.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for ConvexForHomalg.
##
#############################################################################

##  <#GAPDoc Label="IsFan">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsFan"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of a fan. Every fan is a convex object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsFan",
                 IsConvexObject );

####################################
##
## Attributes
##
####################################

##  <#GAPDoc Label="Rays">
##  <ManSection>
##    <Attr Arg="fan" Name="Rays"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the rays of the fan <A>fan</A> as a list of cones.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Rays",
                  IsFan );

##  <#GAPDoc Label="RayGenerators">
##  <ManSection>
##    <Attr Arg="fan" Name="RayGenerators"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the generators rays of the fan <A>fan</A> as a list of of list of integers.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RayGenerators",
                  IsFan );

##  <#GAPDoc Label="RaysInMaximalCones">
##  <ManSection>
##    <Attr Arg="fan" Name="RaysInMaximalCones"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a list of lists, which represent an incidence matrix for the correspondence of the
##      rays and the maximal cones of the fan <A>fan</A>. The ith list in the result represents the ith
##      maximal cone of <A>fan</A>. In such a list, the jth entry is 1 if the jth ray is in the cone, 0 otherwise.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RaysInMaximalCones",
                  IsFan );

##  <#GAPDoc Label="MaximalCones">
##  <ManSection>
##    <Attr Arg="fan" Name="MaximalCones"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the maximal cones of the fan <A>fan</A> as a list of cones.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MaximalCones",
                  IsFan );

DeclareAttribute( "FVector",
                  IsFan );

####################################
##
## Properties
##
####################################

##  <#GAPDoc Label="IsComplete">
##  <ManSection>
##    <Prop Arg="fan" Name="IsComplete"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the fan <A>fan</A> is complete, i. e. if it's support is the whole space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsComplete",
                 IsFan );

##  <#GAPDoc Label="IsPointed">
##  <ManSection>
##    <Prop Arg="fan" Name="IsPointed"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the fan <A>fan</A> is pointed, which means that every cone it contains is strictly convex.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPointed",
                 IsFan );

##  <#GAPDoc Label="IsSmooth">
##  <ManSection>
##    <Prop Arg="fan" Name="IsSmooth"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the fan <A>fan</A> is smooth, i. e. if every cone in the fan is smooth.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSmooth",
                 IsFan );

##  <#GAPDoc Label="IsRegularFan">
##  <ManSection>
##    <Prop Arg="fan" Name="IsRegularFan"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the fan <A>fan</A> is regular, i. e. if it is the normal fan of a polytope.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRegularFan",
                 IsFan );

##  <#GAPDoc Label="IsSimplicial">
##  <ManSection>
##    <Prop Arg="fan" Name="IsSimplicial" Label="for a fan"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the fan <A>fan</A> is simplicial, i. e. if every cone in the fan is simplicial.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSimplicial",
                 IsFan );

##  <#GAPDoc Label="HasConvexSupport">
##  <ManSection>
##    <Prop Arg="fan" Name="HasConvexSupport"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the fan <A>fan</A> is simplicial, i. e. if every cone in the fan is simplicial.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasConvexSupport",
                 IsFan );

####################################
##
## Methods
##
####################################

##  <#GAPDoc Label="FANPROD">
##  <ManSection>
##    <Oper Arg="fan1,fan2" Name="*" Label="for fans"/>
##    <Returns>a fan</Returns>
##    <Description>
##      Returns the product of the fans <A>fan1</A> and <A>fan2</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "\*",
                 [ IsFan, IsFan ] );

DeclareOperation( "ToricStarFan",
                  [ IsFan, IsFan ] );

####################################
##
## Constructors
##
####################################

##  <#GAPDoc Label="FanID">
##  <ManSection>
##    <Oper Arg="fan" Name="Fan" Label="For Fans"/>
##    <Returns>a fan</Returns>
##    <Description>
##      Copy constructor for fans. For completeness reasons.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Fan",
                 [ IsFan ] );

DeclareOperation( "Fan",
                 [ IsExternalObject ] );

DeclareOperation( "Fan",
                 [ IsList ] );

##  <#GAPDoc Label="FanListList">
##  <ManSection>
##    <Oper Arg="rays, cones" Name="Fan" Label="For a list of rays and a list of cones"/>
##    <Returns>a fan</Returns>
##    <Description>
##      Constructs the fan out of the given <A>rays</A> and a list of <A>cones</A> given by a lists of numbers of rays.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Fan",
                 [ IsList, IsList ] );

DeclareOperation( "FanWithFixedRays",
                 [ IsList, IsList ] );

DeclareOperation( "PolymakeFan",
                 [ IsList ] );

DeclareOperation( "PolymakeFan",
                 [ IsList, IsList ] );

DeclareOperation( "PolymakeFanWithFixedRays",
                 [ IsList, IsList ] );

DeclareOperation( "InternalFan",
                 [ IsList ] );

DeclareOperation( "InternalFan",
                 [ IsList, IsList ] );

DeclareOperation( "InternalFanWithFixedRays",
                 [ IsList, IsList ] );
