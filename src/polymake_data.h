#ifndef POLYMAKEDATA
#define POLYMAKEDATA 1

#include "loadgap.h"


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

#define object_pair pair<int, pm::perl::Object*>
#define perlobj pm::perl::Object
#define iterator map<int, pm::perl::Object*>::iterator

struct Polymake_Data {
   polymake::Main *main_polymake_session;
   polymake::perl::Scope *main_polymake_scope;
   map<int, pm::perl::Object*> *polymake_objects;
   int new_polymake_object_number;
};

#endif
