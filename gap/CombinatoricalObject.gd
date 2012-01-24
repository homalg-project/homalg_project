#############################################################################
##
##  CombinatoricalObject.gd               ConvexForHomalg package       Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Main Object to be viewed, is almost everything that has a number ;).
##
#############################################################################

##  <#GAPDoc Label="IsConvexObject">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsConvexObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of convex objects, the main category of this package.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsConvexObject", 
                 IsObject );


DeclareRepresentation( "IsExternalConvexObjectRep",
                      IsConvexObject and IsAttributeStoringRep,
                      [ "WeakPointerToExternalObject" ]
                     );


################################
##
## Attributes
##
################################

##  <#GAPDoc Label="Dimension">
##  <ManSection>
##    <Attr Arg="conv" Name="Dimension"/>
##    <Returns>an integer</Returns>
##    <Description>
##      Returns the combinatorical dimension of the convex object <A>conv</A>. This is the
##      dimension of the smallest space i which <A>conv</A> can be embedded.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
                  IsConvexObject );

##  <#GAPDoc Label="AmbientSpaceDimension">
##  <ManSection>
##    <Attr Arg="conv" Name="AmbientSpaceDimension"/>
##    <Returns>an integer</Returns>
##    <Description>
##      Returns the dimension of the ambient space of the object <A>conv</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientSpaceDimension",
                  IsConvexObject );

##  <#GAPDoc Label="ContainingGrid">
##  <ManSection>
##    <Attr Arg="conv" Name="ContainingGrid"/>
##    <Returns>a homalg module</Returns>
##    <Description>
##      Returns the ambient space of the object <A>conv</A> as a homalg module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ContainingGrid",
                  IsConvexObject );

################################
##
## Properties
##
################################

##  <#GAPDoc Label="IsFullDimensional">
##  <ManSection>
##    <Prop Arg="conv" Name="IsFullDimensional"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the combinatorical dimension of the convex object <A>conv</A> is the same
##      as the dimension of the ambient space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsFullDimensional",
                 IsConvexObject );

################################
##
## Methods
##
################################

##  <#GAPDoc Label="DrawObject">
##  <ManSection>
##    <Oper Arg="conv" Name="DrawObject"/>
##    <Returns>0</Returns>
##    <Description>
##      Draws a nice picture of the object <A>conv</A>, if your computer supports java.
##      As a side effect, you might not be able to exit &GAP; anymore.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DrawObject",
                  [ IsConvexObject ] );

################################
##
## Basics
##
################################

##  <#GAPDoc Label="WeakPointerToExternalObject">
##  <ManSection>
##    <Oper Arg="conv" Name="WeakPointerToExternalObject"/>
##    <Returns>a pointer</Returns>
##    <Description>
##      Returns a pointer to an external object which is the basis of <A>conv</A>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "WeakPointerToExternalObject",
        [ IsExternalConvexObjectRep ] );
