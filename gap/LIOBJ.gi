#############################################################################
##
##  LIOBJ.gi                    LIOBJ subpackage             Mohamed Barakat
##
##         LIOBJ = Logical Implications for homalg static OBJects
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIOBJ subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIOBJ,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ 
              "IsZero",
              "IsProjective",
              "IsReflexive",
              "IsTorsionFree",
              "IsArtinian",
              "IsTorsion",
              "IsPure",
              "IsInjective",
              "IsInjectiveCogenerator",
              ],
            intrinsic_attributes :=
            [ 
              "RankOfObject",
              "ProjectiveDimension",
              "DegreeOfTorsionFreeness",
              "AbsoluteDepth",
              "PurityFiltration",
              "CodegreeOfPurity",
              ],
            )
        );

##
InstallValue( LogicalImplicationsForHomalgStaticObjects,
        [ 
          ## IsInjective(Cogenerator):
          
          [ IsInjectiveCogenerator,
            "implies", IsInjective ],
          
          [ IsZero,
            "implies", IsInjective ],
          
	  ## IsTorsionFree:
          
          [ IsZero,
            "implies", IsProjective ],
          
          [ IsProjective,
            "implies", IsReflexive ],
          
          [ IsReflexive,
            "implies", IsTorsionFree ],
          
          [ IsTorsionFree,
            "implies", IsPure ],
          
          ## IsTorsion:
          
          [ IsZero,
            "implies", IsArtinian ],
          
          [ IsZero,
            "implies", IsTorsion ],
          
          ## IsCyclic:
          
          [ IsZero,
            "implies", IsCyclic ],
          
          ## IsZero:
          
          [ IsTorsion, "and", IsTorsionFree,
            "imply", IsZero ]
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgStaticObjects, IsHomalgStaticObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIOBJ.intrinsic_properties, ValueGlobal ),
        IsStaticFinitelyPresentedSubobjectRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIOBJ.intrinsic_attributes, ValueGlobal ),
        IsStaticFinitelyPresentedSubobjectRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

####################################
#
# methods for attributes:
#
####################################


