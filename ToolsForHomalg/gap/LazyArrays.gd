#! @Chapter Lazy Lists

#! @Section GAP categories

#! @Description
#!  The &GAP; category of lists with attributes.
#! @Arguments L
DeclareCategory( "IsLazyArray",
        IsAttributeStoringRep and IsList );

#! @Section Constructors

#! @Description
#!  Construct a lazy list
#! @Arguments L, func
DeclareGlobalFunction( "LazyArray" );

DeclareAttribute( "ListOfValues", IsLazyArray );

#! @Section Attributes

