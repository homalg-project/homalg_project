##  <#GAPDoc Label="RandomMatrix:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> S := GradedRing( R );;
##  gap> rand := RandomMatrix( S^1 + S^2, S^2 + S^3 + S^4 );
##  <A 2 x 3 matrix over a graded ring>
##   gap> Display( rand );
##   -3*a-b,                                                  -1,                   
##   -a^2+a*b+2*b^2-2*a*c+2*b*c+c^2,                          -a+c,                 
##   -2*a^3+5*a^2*b-3*b^3+3*a*b*c+3*b^2*c+2*a*c^2+2*b*c^2+c^3,-3*b^2-2*a*c-2*b*c+c^2
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
S := GradedRing( R );;
rand := RandomMatrix( S^1 + S^2, S^2 + S^3 + S^4 );
Display( rand );
