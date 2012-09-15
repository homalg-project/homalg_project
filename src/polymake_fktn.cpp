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
  try{
    coneobj->give("SIMPLICIAL") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->give("LATTICE") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->give("NORMAL") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->give("SMOOTH") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->give("VERY_AMPLE") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->give(prop) >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->give(prop) >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
  try{
    coneobj->VoidCallPolymakeMethod("VISUAL");
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  return INTOBJ_INT( 0 );

}


void REAL_SET_PROPERTY_TRUE( Polymake_Data* data, Obj conv, const char* prop){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(conv) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( conv );
  data->main_polymake_session->set_application_of(*coneobj);
  try{
    coneobj->take(prop) << true;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
  }
}
