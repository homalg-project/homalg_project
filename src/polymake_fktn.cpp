#include "polymake_fktn.h"


Obj REAL_IS_SIMPLICIAL_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif

  int conenumber = INT_INTOBJ( cone );
  iterator MapIt = data->polymake_objects->find(conenumber);
  

#ifdef MORE_TESTS
  if( MapIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = (*MapIt).second;
  data->main_polymake_session->set_application_of(*coneobj);
  bool i;
  coneobj->give("SIMPLICIAL") >> i;
  if(i) return True; return False;

}


Obj REAL_IS_LATTICE_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif

  int conenumber = INT_INTOBJ( cone );
  iterator MapIt = data->polymake_objects->find(conenumber);
  
#ifdef MORE_TESTS
  if( MapIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = (*MapIt).second;
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  coneobj->give("LATTICE") >> i;
  if(i) return True; return False;

}

