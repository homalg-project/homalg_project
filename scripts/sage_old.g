Read( "start.g" );

R := RingForHomalgInSage("ZZ",IsIntegersForHomalg);

M := CreateExternalCohomologyMatrix(ot,ss,R);;

Read( "finish.g" );
