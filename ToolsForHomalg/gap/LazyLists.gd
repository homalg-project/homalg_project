# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

#! @Chapter Lazy Lists

#! @Section GAP categories

#! @Description
#!  The &GAP; category of lazy lists.
#! @Arguments L
DeclareCategory( "IsLazyList",
        IsComponentObjectRep and IsList );

#! @Section Constructors

#! @Description
#!  Construct a lazy list
#! @Arguments L, func
DeclareGlobalFunction( "LazyList" );

#! @Section Operations

DeclareOperation( "ListOfValues", [ IsLazyList ] );
