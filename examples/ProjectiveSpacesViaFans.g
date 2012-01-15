LoadPackage( "ToricVarieties" );

P1:=HomalgFan([[[1]],[[-1]]]);
P2:=HomalgFan([[[1,0],[-1,-1]],[[0,1],[-1,-1]],[[1,0],[0,1]]]);

P1 := ToricVariety(P1);
P2 := ToricVariety(P2);
P1P1 := P1*P1;
P1P2 := P1*P2;

ClassGroup( P1 );
ClassGroup( P2 );
ClassGroup( P1P1 );
ClassGroup( P1P2 );