# This test finishes quickly with ordering (dp,c) but takes a very long time
# with ordering dp (which is equivalent to (dp,C)).

LoadPackage("RingsForHomalg");

QQ := HomalgFieldOfRationalsInSingular( );

M := HomalgIdentityMatrix( 1, QQ );
N := UnionOfColumns( ListWithIdenticalEntries( 10000, M ) );

Display( "If this test does not finish, Singular uses a bad ordering..." );

Eval( SyzygiesOfColumns( N ) );
