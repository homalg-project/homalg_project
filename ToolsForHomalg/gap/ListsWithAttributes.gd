# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

#! @Chapter Lists with attributes
#!  These are homogeneous lists which still carry enough information of their context even if they are empty.

#! @Section GAP categories

#! @Description
#!  The &GAP; category of lists with attributes.
#! @Arguments L
DeclareCategory( "IsListWithAttributes",
        IsAttributeStoringRep and IsList );

#! @Section Constructors

#! @Description
#!  Construct a list with attributes.
#! @Arguments L, type, attr1, value1, attr2, value2, ...
DeclareGlobalFunction( "TypedListWithAttributes" );

#! @Description
#!  Construct a list with attributes of type TheTypeListWithAttributesRep
#! @Arguments L, attr1, value1, attr2, value2, ...
DeclareGlobalFunction( "ListWithAttributes" );

