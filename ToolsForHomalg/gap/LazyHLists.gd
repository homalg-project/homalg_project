# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

#! @Chapter Lazy homogeneous lists

#! @Section GAP categories

#! @Description
#!  The &GAP; category of lazy homogeneous lists.
#! @Arguments L
DeclareCategory( "IsLazyHList",
        IsComponentObjectRep and IsList );

#! @Section Constructors

#! @Description
#!  Construct a lazy list
#! @Arguments L, func
DeclareGlobalFunction( "LazyHList" );

#! @Section Operations

DeclareOperation( "ListOfValues", [ IsLazyHList ] );
