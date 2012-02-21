#include "polymake_fktn.h"


Obj REAL_IS_SIMPLICIAL_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  bool i;
  coneobj->give("SIMPLICIAL") >> i;
  if(i) return True; return False;

}


Obj REAL_IS_LATTICE_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  coneobj->give("LATTICE") >> i;
  if(i) return True; return False;

}


Obj REAL_IS_NORMAL_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  coneobj->give("NORMAL") >> i;
  if(i) return True; return False;

}


Obj REAL_IS_SMOOTH_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  coneobj->give("SMOOTH") >> i;
  if(i) return True; return False;

}


Obj REAL_IS_VERYAMPLE_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  coneobj->give("VERY_AMPLE") >> i;
  if(i) return True; return False;

}


Obj REAL_OBJECT_HAS_PROPERTY( Polymake_Data* data, Obj cone, const char* prop ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  coneobj->give(prop) >> i;
  if(i) return True; return False;

}

Obj REAL_OBJECT_HAS_INT_PROPERTY( Polymake_Data* data, Obj cone, const char* prop ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  int i;
  coneobj->give(prop) >> i;
  return INTOBJ_INT( i );
}


Obj REAL_POLYMAKE_DRAW( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  coneobj->VoidCallPolymakeMethod("VISUAL");
  return INTOBJ_INT( 0 );

}
