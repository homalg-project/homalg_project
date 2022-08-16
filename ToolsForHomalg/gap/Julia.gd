# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

DeclareOperation( "ConvertJuliaToGAP",
        [ IsObject ] );

DeclareOperation( "Visualize",
        [ IsString ] );

DeclareGlobalFunction( "IsRunningInJupyter" );

DeclareGlobalFunction( "IsRunningInPluto" );
