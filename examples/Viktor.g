# From: 	viktor.levandovskyy@rwth-aachen.de
# Subject: 	wieder double Ext
# Date: 	February 6, 2008 11:22:12 PM GMT+01:00
#
# ein interessantes Phenomen: betrachten wir I \subset J,
# wobei I = <xd - n> und J = <xd-n, d^{n+1}> in der
# ersten Weyl Algebra und n \in \N (n=1,2,3).
# Dann double Ext von I ist I selbst, aber
# double Ext von J ist <d> (was natuerlich holonom ist).

LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Qx := HomalgFieldOfRationalsInDefaultCAS( ) * "x";
A1 := RingOfDerivations( Qx, "d" );

V := HomalgMatrix( "[ \
x*d-3, \
d^4    \
]", 2, 1, A1 );

V := LeftPresentation( V );

