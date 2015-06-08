# From: 	viktor.levandovskyy@rwth-aachen.de
# Subject: 	double Ext
# Date: 	December 10, 2007 9:42:07 PM GMT+01:00
#
# wir fangen an mit F = x2-y3,
# betrachten:
# ideal I = Dx*(x2-y3),Dy*(x2-y3);
# was nicht holonom ist.
# ...
# Die Lokalisierung liefert das Ideal von
# 3*x*Dx+2*y*Dy+12, 3*y^2*Dx+2*x*Dy, y^3*Dy-x^2*Dy+6*y^2

LoadPackage( "RingsForHomalg" );

Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
A2 := RingOfDerivations( Qxy, "Dx,Dy" );

M1 := HomalgMatrix( "[ \
Dx, \
Dy  \
]", 2, 1, A2 );

M2 := HomalgMatrix( "[ \
x^2 - y^3 \
]", 1, 1, A2 );

N := HomalgMatrix( "[ \
3*x*Dx+2*y*Dy+12,   \
3*y^2*Dx+2*x*Dy,    \
y^3*Dy-x^2*Dy+6*y^2 \
]", 3, 1, A2 );

M := LeftPresentation( M1 * M2 );

N := LeftPresentation( N );

