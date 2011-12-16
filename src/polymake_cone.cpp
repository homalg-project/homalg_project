#include "polymake_cone.h"


Obj REAL_CREATE_CONE_BY_RAYS( Polymake_Data* data, Obj rays ){
  
  if( ! IS_PLIST( rays ) ){
    ErrorMayQuit( "not a plain list 1", 0, 0);
    return NULL;
  }
  
  int len = LEN_PLIST( rays );
  Obj akt = ELM_PLIST( rays, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list 2", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Rational ratarray[(len)*(len_elem)];
  
  for(int i=0;i<len;i++){
      akt = ELM_PLIST( rays, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "not a plain list 3", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[ ( i * len_elem ) + j] = INT_INTOBJ( elem );
      }
      
  }

  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>(len,len_elem,ratarray);
  perlobj* p = new perlobj("Cone"); //Maybe Name the Polytope by the Number
  p->take("INPUT_RAYS") << *matr; // This Matrix creates a memory leak, aks Thomas!
  //this needs to be fixed!!
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, p ) );
  elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
}



Obj REAL_CREATE_CONE_BY_INEQUALITIES( Polymake_Data* data, Obj rays ){
  
  if( ! IS_PLIST( rays ) ){
    ErrorMayQuit( "not a plain list 1", 0, 0);
    return NULL;
  }
  
  int len = LEN_PLIST( rays );
  Obj akt = ELM_PLIST( rays, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list 2", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Rational ratarray[(len)*(len_elem)];
  
  for(int i=0;i<len;i++){
      akt = ELM_PLIST( rays, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "not a plain list 3", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[ ( i * len_elem ) + j] = INT_INTOBJ( elem );
      }
      
  }

  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>(len,len_elem,ratarray);
  perlobj* p = new perlobj("Cone"); //Maybe Name the Polytope by the Number
  p->take("INEQUALITIES") << *matr; // This Matrix creates a memory leak, aks Thomas!
  //this needs to be fixed!!
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, p ) );
  elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
}


Obj REAL_CREATE_DUAL_CONE_OF_CONE(  Polymake_Data* data, Obj cone ){
  
  #ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  
  int conenumber = INT_INTOBJ( cone );
  iterator TestIt = data->polymake_objects->find(conenumber);
  
#ifdef MORE_TESTS
  if( TestIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = (*TestIt).second;
  
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr = coneobj->give("FACETS");
  perlobj* p = new perlobj("Cone<Rational>"); //Maybe Name the Polytope by the Number
  pm::Matrix<pm::Rational> matr2 = coneobj->give("LINEAR_SPAN");
  
  pm::Matrix<pm::Rational>* matr3 = new pm::Matrix<pm::Rational>(matr.rows()+2*matr2.rows(), matr.cols()); //THIS CAUSES A MEMORY LEAK!!!!
  for(int i = 0; i < matr.rows(); i++)
    matr3->row(i) = matr.row(i);
  for(int i = 0; i < matr2.rows(); i++)
    matr3->row(matr.rows()+i) = matr2.row(i);
  for(int i = 0; i < matr2.rows(); i++)
    matr3->row(matr.rows()+matr2.rows()+i) = -(matr2.row(i));
  p->take("INPUT_RAYS") << *matr3;
  delete matr3;
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, p ) );
  Obj elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
  
}


Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data* data, Obj cone){

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

  pm::Matrix<pm::Rational> matr = coneobj->give("RAYS");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows()  );
  Obj LIZeil;
  pm::Rational nenner;
  pm::Rational dentemp;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr.cols() );
    nenner = 1;
    for(int j = 0;j<matr.cols();j++){
      CallPolymakeFunction("denominator",matr(i,j)) >> dentemp;
      CallPolymakeFunction("lcm",nenner, dentemp ) >> nenner;
    }
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)*nenner));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}


Obj REAL_HILBERT_BASIS_OF_CONE( Polymake_Data* data, Obj cone){

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
  pm::Matrix<pm::Rational> matr = coneobj->give("HILBERT_BASIS");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows()  );
  Obj LIZeil;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr.cols() );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}

Obj REAL_RAYS_IN_FACETS( Polymake_Data* data, Obj cone){

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
  pm::IncidenceMatrix<pm::NonSymmetric> matr = coneobj->give("RAYS_IN_FACETS");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows()  );
  Obj LIZeil;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr.cols() );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}
