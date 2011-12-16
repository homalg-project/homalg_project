// The usual Header.
#include "loadgap.h"
#include "polymake_data.h"

#include <polymake/Main.h>
#include <polymake/Matrix.h>
#include <polymake/Rational.h>

#include <iostream>
#include <map>
#include <utility>

using std::cerr;
using std::endl;
using std::string;
using std::map;
using std::pair;

// Method creates cones by raylists
Obj REAL_CREATE_CONE_BY_RAYS( Polymake_Data* , Obj );

// This method might need some words
// Inequalities are given by lists of integers.
// [a,b,..] means the cone contains all points
// which are of the form ax+by+...>=0.
// The lists so are raygenerators of the dual cone.
Obj REAL_CREATE_CONE_BY_INEQUALITIES( Polymake_Data*, Obj );

// Method creates the dual cone of a cone
Obj REAL_CREATE_DUAL_CONE_OF_CONE(  Polymake_Data*, Obj  );

Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data*, Obj );

Obj REAL_HILBERT_BASIS_OF_CONE( Polymake_Data*, Obj );

Obj REAL_RAYS_IN_FACETS( Polymake_Data*, Obj );