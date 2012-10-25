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
DeclareCategoryWithDocumentation( "IsHomalgRingOrModule",
                 IsStructureObjectOrObject,
                 "This is the super GAP-category which will include the GAP-categories IsHomalgRing, IsHomalgModule.",
                 [ "Basics", "Categories" ]
               );

# a new GAP-category:

DeclareCategoryWithDocumentation( "IsContainerForWeakPointers",
                 IsComponentObjectRep,
                 "The category for weak pointer objects",
                 [ "Pointers", "Weak_pointer_objects" ]
               );

DeclareCategoryWithDocumentation( "IsContainerForPointers",
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
                                        "The constructor for lists of weak pointers.",
                                        "a list which can store weak pointers",
                                        [ "Pointers", "Weak_pointer_objects" ]
                                       );

DeclareGlobalFunctionWithDocumentation( "homalgTotalRuntimes",
                                        "A tool to compute the runtime of several methods.",
                                        "an integer",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "AddLeftRightLogicalImplicationsForHomalg",
                                        "A tool to install equivalence between filters.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "LogicalImplicationsForOneHomalgObject",
                                        "Installs a logical implication for one type with all it's contrapositions.",
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

DeclareGlobalFunctionWithDocumentation( "InstallLeftRightAttributesForHomalg",
                                        "",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "MatchPropertiesAndAttributes",
                                        "A method to match the properties and attributes of two objects.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullPropertyOrAttribute",
                                        "Installs methods to pull new known properties and attributes from one object to another",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToConditionallyPullPropertyOrAttribute",
                                        "Installs methods to pull new known properties and attributes under certain conditions from one object to another.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullPropertyOrAttributeWithDifferentName",
                                        "Installs an immediate method which can pull a property from one object to another with different names.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullPropertiesOrAttributes",
                                        "Installs an immediate method to pull several properties or attributes from one object to another.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullTrueProperty",
                                        "Installs an immediate method to pull a property if it is true.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToConditionallyPullTrueProperty",
                                        "Installs an immediate method which conditionally pulls a property if it is true.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullTruePropertyWithDifferentName",
                                        "Installs an immediate method which pulls a property with a different name if it is true.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullTrueProperties",
                                        "Installs an immediate method which pulls several properties if they are true",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullFalseProperty",
                                        "Installs an immediate method to pull a property if it is false.",
                                        "",
                                        [ "Tools", "Functions" ]
 );

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToConditionallyPullFalseProperty",
                                        "Installs an immediate method which conditionally pulls a property if it is false.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullFalsePropertyWithDifferentName",
                                        "Installs an immediate method which pulls a property with a different name if it is false.",
                                        "",
                                        [ "Tools", "Functions" ] 
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPullFalseProperties",
                                        "Installs an immediate method which pulls several properties if they are false.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushPropertyOrAttribute",
                                        "Installs an immediate method to push a property from one object to another.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToConditionallyPushPropertyOrAttribute",
                                        "Installs an immediate method to conditionally push a property from one object to another.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName",
                                        "Installs an immediate method which can push a property from one object to another with different names.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushPropertiesOrAttributes",
                                        "Installs an immediate method to push several properties or attributes from one object to another.",
                                        "",
                                        [ "Tools", "Functions" ] 
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushTrueProperty",
                                        "Installs an immediate method to push a property if it is true.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushTruePropertyWithDifferentName",
                                        "Installs an immediate method which pushes a property with a different name if it is true.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushTrueProperties",
                                        "Installs an immediate method which pushes several properties if they are true",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushFalseProperty",
                                        "Installs an immediate method to push a property if it is false.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushFalsePropertyWithDifferentName",
                                        "Installs an immediate method which pushes a property with a different name if it is false.",
                                        "",
                                        [ "Tools", "Functions" ] 
);

DeclareGlobalFunctionWithDocumentation( "InstallImmediateMethodToPushFalseProperties",
                                        "Installs an immediate method which push several properties if they are false.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "DeclareAttributeWithCustomGetter",
                                        "Installs an attribute with a coustom getter function.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "AppendToAhomalgTable",
                                        "Appends an entry to a homalg table.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "homalgNamesOfComponentsToIntLists",
                                        "Creates a list of integers out of the names of components.",
                                        "a list of integers",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "IncreaseExistingCounterInObject",
                                        "Increases an existing counter in an object.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "IncreaseExistingCounterInObjectWithTiming",
                                        "Increases an existiing counter on an object with timing.",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "IncreaseCounterInObject",
                                        "Increases a counter in an object and creates one if it not exists",
                                        "",
                                        [ "Tools", "Functions" ]
);

DeclareGlobalFunctionWithDocumentation( "MemoryToString",
                                        "Converts the current memory state to a string",
                                        "",
                                        [ "Tools", "Functions" ]
);

# basic operations:

DeclareOperationWithDocumentation( "homalgLaTeX",
                                   [ IsObject ],
                                   "",
                                   "",
                                   [ "Tools", "Functions" ]
);

DeclareOperationWithDocumentation( "ExamplesForHomalg",
                                   [ ],
                                   "Runs the examples for homalg if the package is loadable.",
                                   "<C>true</C> or <C>false</C>",
                                   [ "Tools", "Examplefunctions" ]
);

DeclareOperationWithDocumentation( "ExamplesForHomalg",
                                   [ IsInt ],
                                   "Runs the named example for homalg",
                                   "<C>true</C> or <C>false</C>",
                                   [ "Tools", "Examplefunctions" ]
);

DeclareOperationWithDocumentation( "UpdateContainerOfWeakPointers",
                                   [ IsContainerForWeakPointers ],
                                   "Updates the weak pointers in a container and deletes the empty ones",
                                   "",
                                   [ "Pointers", "Weak_pointer_objects" ]
);

DeclareGlobalFunctionWithDocumentation( "_AddElmWPObj_ForHomalg",
                                        "Adds a weak pointer of an objects to a weak pointer list.",
                                        "",
                                        [ "Pointers", "Weak_pointer_objects" ]
);

DeclareGlobalFunctionWithDocumentation( "_AddTwoElmWPObj_ForHomalg",
                                        "Adds a weak pointer which depends on two objects to a list of weak pointers",
                                        "",
                                        [ "Pointers", "Weak_pointer_objects" ]
);

DeclareOperationWithDocumentation( "_ElmWPObj_ForHomalg",
                                   [ IsContainerForWeakPointers, IsObject, IsObject ],
                                   "Creates a weak pointer depending on two objects and adds it to the container.",
                                   "",
                                   [ "Pointers", "Weak_pointer_objects" ]
);

DeclareOperation( "Display",
        [ IsContainerForWeakPointers, IsString ] );

# PointerObject Operations

DeclareGlobalFunctionWithDocumentation( "ContainerForPointers",
                                        "Creates a container for pointers.",
                                        "a container for pointers",
                                        [ "Pointers", "Pointer_objects" ]
);

DeclareOperationWithDocumentation( "UpdateContainerOfPointers",
                                   [ IsContainerForPointers ],
                                   "Updates the container of pointers, removes old.",
                                   "",
                                   [ "Pointers", "Pointer_objects" ]
);

DeclareGlobalFunctionWithDocumentation( "_AddElmPObj_ForHomalg",
                                        "Adds a pointer to an object to a container for pointers.",
                                        "",
                                        [ "Pointers", "Pointer_objects" ]
);

DeclareGlobalFunctionWithDocumentation( "_AddTwoElmPObj_ForHomalg",
                                        "Adds a pointer to two objects to a container for pointers",
                                        "",
                                        [ "Pointers", "Pointer_objects" ]
);

DeclareOperationWithDocumentation( "_ElmPObj_ForHomalg",
                                   [ IsContainerForPointers, IsObject, IsObject ],
                                   "Returns an object which a pointer refers to.",
                                   "an object",
                                   [ "Pointers", "Pointer_objects" ]
);

DeclareOperation( "PositionOfTheDefaultPresentation",
        [ IsObject ] );

DeclareOperation( "Display",
        [ IsContainerForPointers, IsString ] );
