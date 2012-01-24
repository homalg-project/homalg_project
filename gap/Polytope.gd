#############################################################################
##
##  Polytope.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

DeclareCategory( "IsHomalgPolytope",
                 IsConvexObject );

################################
##
## Basic Properties
##
################################

##  <#GAPDoc Label="IsNotEmpty">
##  <ManSection>
##    <Prop Arg="poly" Name="IsNotEmpty"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is not empty.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNotEmpty",
                 IsHomalgPolytope );

##  <#GAPDoc Label="IsLatticePolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsLatticePolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is a lattice polytope, i.e. all its vertices are lattice points.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLatticePolytope",
                 IsHomalgPolytope );

##  <#GAPDoc Label="IsVeryAmple">
##  <ManSection>
##    <Prop Arg="poly" Name="IsVeryAmple"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is very ample.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsVeryAmple",
                 IsHomalgPolytope );

##  <#GAPDoc Label="IsNormalPolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsNormalPolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is normal.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNormalPolytope",
                 IsHomalgPolytope );

##  <#GAPDoc Label="IsSimplicial">
##  <ManSection>
##    <Prop Arg="poly" Name="IsSimplicial"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is simplicial.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSimplicial",
                 IsHomalgPolytope );

##  <#GAPDoc Label="IsSimplePolytope">
##  <ManSection>
##    <Prop Arg="poly" Name="IsSimplePolytope"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the polytope <A>poly</A> is simple.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSimplePolytope",
                 IsHomalgPolytope );

################################
##
## Attributes
##
################################

##  <#GAPDoc Label="Vertices">
##  <ManSection>
##    <Attr Arg="poly" Name="Vertices"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the vertices of the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Vertices",
                  IsHomalgPolytope );

##  <#GAPDoc Label="LatticePoints">
##  <ManSection>
##    <Attr Arg="poly" Name="LatticePoints"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the lattice points of the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "LatticePoints",
                  IsHomalgPolytope );

##  <#GAPDoc Label="FacetInequalities">
##  <ManSection>
##    <Attr Arg="poly" Name="FacetInequalities"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the facet inequalities for the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FacetInequalities",
                  IsHomalgPolytope );

##  <#GAPDoc Label="VerticesInFacets">
##  <ManSection>
##    <Attr Arg="poly" Name="VerticesInFacets"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the incidence matrix of vertices and facets of the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "VerticesInFacets",
                  IsHomalgPolytope );

##  <#GAPDoc Label="NormalFan">
##  <ManSection>
##    <Attr Arg="poly" Name="NormalFan"/>
##    <Returns>a fan</Returns>
##    <Description>
##      Returns the normal fan of the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NormalFan",
                  IsHomalgPolytope );

##  <#GAPDoc Label="AffineCone">
##  <ManSection>
##    <Attr Arg="poly" Name="AffineCone"/>
##    <Returns>a cone</Returns>
##    <Description>
##      Returns the affine cone of the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineCone",
                  IsHomalgPolytope );

##  <#GAPDoc Label="RelativeInteriorLatticePoints">
##  <ManSection>
##    <Attr Arg="poly" Name="RelativeInteriorLatticePoints"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the lattice points in the relative interior of the polytope <A>poly</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RelativeInteriorLatticePoints",
                  IsHomalgPolytope );

################################
##
## Constructors
##
################################

DeclareOperation( "HomalgPolytope",
                  [ IsHomalgPolytope ] );

DeclareOperation( "HomalgPolytope",
                  [ IsList ] );

DeclareOperation( "HomalgPolytopeByInequalities",
                  [ IsList ] );