# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Implementations
#

##  Implementation stuff for ModulesForHomalg.

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_MODULES,
        rec(
            category := rec(
                            ## do not place records here as they won't be copied
                            ## when this record is shallow-copied in HomalgCategory
                            description := "f.p. modules and their maps over computable rings",
                            short_description := "_for_fp_modules",
                            MorphismConstructor := HomalgMap,
                            TryPostDivideWithoutAids := true, # see homalg/ToolFunctors.gi
                            InternalHom := Hom,
                            InternalExt := Ext,
                            ),
            
            ByASmallerPresentationDoesNotDecideZero := false,
            
            Intersect_uses_ReducedBasisOfModule := true,
            
           )
);
