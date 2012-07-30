#############################################################################
##
##  ToolsForHomalg.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for ToolsForHomalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoToolsForHomalg" );
SetInfoLevel( InfoToolsForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariableWithDocumentation( "HOMALG_TOOLS",
                                        "A central place for configurations.",
                                        [ "Basics", "Variables" ]
);

####################################
#
# categories:
#
####################################

# three new categories:

## this is the super super GAP-category which will include the GAP-categories
## IsStructureObjectOrObject and IsHomalgObjectOrMorphism:
DeclareCategoryWithDocumentation( "IsStructureObjectOrObjectOrMorphism",
                                  IsAttributeStoringRep,
                                  "This is the super super GAP-category which will include the GAP-categories IsStructureObjectOrObject and IsHomalgObjectOrMorphism",
                                  [ "Basics", "Categories" ]
                                );

## this is the super GAP-category which will include the GAP-categories
## IsHomalgRing, IsHomalgModule, IsHomalgRingOrModule and IsHomalgComplex
DeclareCategoryWithDocumentation( "IsStructureObjectOrObject",
                                  IsStructureObjectOrObjectOrMorphism,
                                  "This is the super GAP-category which will include the GAP-categories IsHomalgRing, IsHomalgModule, IsHomalgRingOrModule and IsHomalgComplex.",
                                  [ "Basics", "Categories" ]
                                );

## this is the super GAP-category which will include the GAP-categories IsHomalgRing
## we need this GAP-category to define things like Hom(M,R) as easy as Hom(M,N)
## without distinguishing between structure objects (e.g. rings) and objects (e.g. modules)
DeclareCategoryWithDocumentation( "IsStructureObject",
                                  IsStructureObjectOrObject,
                                  Concatenation( "This is the super GAP-category which will include the GAP-categories ",
                                                 "IsHomalgRing we need this GAP-category to define things like Hom(M,R) as easy as Hom(M,N) ",
                                                 "without distinguishing between structure objects (e.g. rings) and objects (e.g. modules)" ),
                                  [ "Basics", "Categories" ]
                                );

## this is the super GAP-category which will include the GAP-categories
## IsHomalgRingMap, etc.
DeclareCategoryWithDocumentation( "IsStructureObjectMorphism",
                                  IsAttributeStoringRep,
                                  "This is the super GAP-category which will include the GAP-categories IsHomalgRingMap, etc.",
                                  [ "Basics", "Categories" ]
                                );

## this is the super GAP-category which will include the GAP-categories
## IsHomalgRing, IsHomalgModule:
DeclareCategory( "IsHomalgRingOrModule",
                 IsStructureObjectOrObject,
                 "This is the super GAP-category which will include the GAP-categories IsHomalgRing, IsHomalgModule.",
                 [ "Basics", "Categories" ]
               );

# a new GAP-category:

DeclareCategory( "IsContainerForWeakPointers",
                 IsComponentObjectRep,
                 "The category for weak pointer objects",
                 [ "Pointers", "Weak_pointer_objects" ]
               );

DeclareCategory( "IsContainerForPointers",
                 IsComponentObjectRep,
                 "The category for pointer objects",
                 [ "Pointers", "Pointer_objects" ]
               );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunctionWithDocumentation( "ContainerForWeakPointers",
                                        "The constructor for lists of weak pointers",
                                        "a list which can store weak pointers",
                                        [ "Pointers", "Weak_pointer_objects" ]
                                       );

DeclareGlobalFunctionWithDocumentation( "homalgTotalRuntimes",
                                        "A tool to compute the runtime of several methods",
                                        "an integer",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "AddLeftRightLogicalImplicationsForHomalg",
                                        "A tool to install equivalence between filters.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "LogicalImplicationsForOneHomalgObject",
                                        "Installs a logical ",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "LogicalImplicationsForTwoHomalgBasicObjects",
                                        "",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallLogicalImplicationsForHomalgBasicObjects",
                                        "",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "LeftRightAttributesForHomalg",
                                        "",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunction( "InstallLeftRightAttributesForHomalg",
                       "",
                       "",
                       [ "Tools", "Functions" ]
);

DeclareGlobalFunction( "MatchPropertiesAndAttributes",
                       "A method to match the properties and attributes of two objects"
                       "",
                       [ "Tools", "Functions" ]
);

DeclareGlobalFunction( "InstallImmediateMethodToPullPropertyOrAttribute","
                       "Installs methods to pull new known properties and attributes from one object to another",
                       "",
                       [ "Tools", "Functions" ]
);

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullPropertyOrAttribute",
                       "Installs methods to pull new known properties and attributes under certain conditions from one object to another",
                       "",
                       [ "Tools", "Functions" ]
);

DeclareGlobalFunction( "InstallImmediateMethodToPullPropertyOrAttributeWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPullPropertiesOrAttributes" );

DeclareGlobalFunction( "InstallImmediateMethodToPullTrueProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullTrueProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPullTruePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPullTrueProperties" );

DeclareGlobalFunction( "InstallImmediateMethodToPullFalseProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullFalseProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPullFalsePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPullFalseProperties" );

DeclareGlobalFunction( "InstallImmediateMethodToPushPropertyOrAttribute" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPushPropertyOrAttribute" );

DeclareGlobalFunction( "InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPushPropertiesOrAttributes" );

DeclareGlobalFunction( "InstallImmediateMethodToPushTrueProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPushTruePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPushTrueProperties" );

DeclareGlobalFunction( "InstallImmediateMethodToPushFalseProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPushFalsePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPushFalseProperties" );

DeclareGlobalFunction( "DeclareAttributeWithCustomGetter" );

DeclareGlobalFunction( "AppendToAhomalgTable" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

DeclareGlobalFunction( "IncreaseExistingCounterInObject" );

DeclareGlobalFunction( "IncreaseExistingCounterInObjectWithTiming" );

DeclareGlobalFunction( "IncreaseCounterInObject" );

DeclareGlobalFunction( "MemoryToString" );

# basic operations:

DeclareOperation( "homalgLaTeX",
        [ IsObject ] );

DeclareOperation( "ExamplesForHomalg",
        [ ] );

DeclareOperation( "ExamplesForHomalg",
        [ IsInt ] );

DeclareOperation( "UpdateContainerOfWeakPointers",
        [ IsContainerForWeakPointers ] );

DeclareGlobalFunction( "_AddElmWPObj_ForHomalg" );

DeclareGlobalFunction( "_AddTwoElmWPObj_ForHomalg" );

DeclareOperation( "_ElmWPObj_ForHomalg",
        [ IsContainerForWeakPointers, IsObject, IsObject ] );

DeclareOperation( "Display",
        [ IsContainerForWeakPointers, IsString ] );

# PointerObject Operations

DeclareGlobalFunction( "ContainerForPointers" );

DeclareOperation( "UpdateContainerOfPointers",
        [ IsContainerForPointers ] );

DeclareGlobalFunction( "_AddElmPObj_ForHomalg" );

DeclareGlobalFunction( "_AddTwoElmPObj_ForHomalg" );

DeclareOperation( "_ElmPObj_ForHomalg",
        [ IsContainerForPointers, IsObject, IsObject ] );

DeclareOperation( "Display",
        [ IsContainerForPointers, IsString ] );
