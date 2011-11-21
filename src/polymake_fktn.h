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


// Next lines set some few static Variables
// to handle polymake.
// All of them will be initialized in
// the main method called by gap to
// load the package.

//static polymake::Main *main_polymake_session;
//static polymake::perl::Scope *main_polymake_scope;
//static map<int, pm::perl::Object*> *polymake_objects;
//static int new_polymake_object_number;


#define object_pair pair<int, pm::perl::Object*>
#define perlobj pm::perl::Object
#define iterator map<int, pm::perl::Object*>::iterator

// Just declaring functions. Stay tuned, All Methods get the Polymake_Data
// struct as first argument.

// Method creates cones by raylists
Obj REAL_CREATE_CONE_BY_RAYS( Polymake_Data* , Obj );

// Method creates the dual cone of a cone, if cone is fully dimensional
Obj REAL_CREATE_DUAL_CONE_OF_CONE(  Polymake_Data*, Obj  );

Obj REAL_IS_SIMPLICIAL_CONE( Polymake_Data*, Obj );

Obj REAL_IS_LATTICE_CONE( Polymake_Data*, Obj );

Obj REAL_IS_STRICTLY_CONVEX_CONE( Polymake_Data*, Obj );

Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data*, Obj );





