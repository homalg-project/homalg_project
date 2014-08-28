#include "polymake_cone.h"


Obj REAL_CREATE_CONE_BY_RAYS( Polymake_Data* data, Obj rays ){
  
  if( ! IS_PLIST( rays ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int len = LEN_PLIST( rays );
  Obj akt = ELM_PLIST( rays, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "first ray is not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Integer* ratarray = new pm::Integer[(len)*(len_elem)];
  
  for(int i=0;i<len;i++){
      akt = ELM_PLIST( rays, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        delete [] ratarray;
        ErrorMayQuit( "one ray is not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        delete [] ratarray;
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          delete [] ratarray;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[ ( i * len_elem ) + j] = static_cast<pm::Integer>(INT_INTOBJ( elem ));
      }
      
  }
  
  pm::Matrix<pm::Integer>* matr = new pm::Matrix<pm::Integer>(len,len_elem,ratarray);
  delete [] ratarray;
  perlobj* p = new perlobj("Cone");
  p->take("INPUT_RAYS") << *matr;
  
  delete matr;
  
  elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);

  POLYMAKEOBJ_SET_PERLOBJ(elem, p);
  
  return elem;
}


Obj REAL_CREATE_CONE_BY_RAYS_UNSAVE( Polymake_Data* data, Obj rays ){
  
  if( ! IS_PLIST( rays ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int len = LEN_PLIST( rays );
  Obj akt = ELM_PLIST( rays, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "first ray is not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Integer* ratarray;
  ratarray = new pm::Integer[(len)*(len_elem)];
  
  for(int i=0;i<len;i++){
      akt = ELM_PLIST( rays, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        delete [] ratarray;
        ErrorMayQuit( "one ray is not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        delete [] ratarray;
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          delete [] ratarray;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[ ( i * len_elem ) + j] = INT_INTOBJ( elem );
      }
      
  }
  
  pm::Matrix<pm::Integer>* matr = new pm::Matrix<pm::Integer>(len,len_elem,ratarray);
  delete [] ratarray;
  perlobj* p = new perlobj("Cone");
  p->take("RAYS") << *matr;
  delete matr;
  elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);

  POLYMAKEOBJ_SET_PERLOBJ(elem, p);

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
  
  pm::Integer* ratarray;
  ratarray = new pm::Integer[(len)*(len_elem)];
  
  for(int i=0;i<len;i++){
      akt = ELM_PLIST( rays, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        delete [] ratarray;
        ErrorMayQuit( "not a plain list 3", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        delete [] ratarray;
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          delete [] ratarray;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[ ( i * len_elem ) + j] = INT_INTOBJ( elem );
      }
      
  }

  pm::Matrix<pm::Integer>* matr = new pm::Matrix<pm::Integer>(len,len_elem,ratarray);
  delete [] ratarray;
  perlobj* p = new perlobj("Cone");
  p->take("INEQUALITIES") << *matr; 
  //this needs to be fixed!!
  delete matr;
  elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);
  POLYMAKEOBJ_SET_PERLOBJ(elem, p);
  return elem;
}


Obj REAL_CREATE_DUAL_CONE_OF_CONE(  Polymake_Data* data, Obj cone ){
  
#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ(cone);
  
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr;
  try
  {
     pm::Matrix<pm::Rational> matr_temp = coneobj->give("FACETS"); //That is the ugliest solution 
     matr = matr_temp;
  }
  catch( std::exception err ){
      ErrorMayQuit( " an error occured during computation of facets.",0,0 );
      return NULL;
  }
  perlobj* p;
  p = new perlobj("Cone<Rational>");
  pm::Matrix<pm::Rational> matr2;
  try
  {
    pm::Matrix<pm::Rational> matr2_temp = coneobj->give("LINEAR_SPAN");
    matr2 = matr2_temp;
  }
  catch( std::exception err ){
      ErrorMayQuit( " an error occured during computation of linear span.",0,0 );
      return NULL;
  }
  pm::Matrix<pm::Rational>* matr3 = new pm::Matrix<pm::Rational>(matr.rows()+2*matr2.rows(), matr.cols());
  for(int i = 0; i < matr.rows(); i++)
    matr3->row(i) = matr.row(i);
  for(int i = 0; i < matr2.rows(); i++)
    matr3->row(matr.rows()+i) = matr2.row(i);
  for(int i = 0; i < matr2.rows(); i++)
    matr3->row(matr.rows()+matr2.rows()+i) = -(matr2.row(i));
  p->take("INPUT_RAYS") << *matr3;
  delete matr3;
  
  Obj elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_CONE );
  
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );
  
  return elem;
  
}


// Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data* data, Obj cone){
// 
// #ifdef MORE_TESTS
//   if( ( ! IS_POLYMAKE_CONE(cone) ) && ( ! IS_POLYMAKE_FAN(cone) ) ){
//     ErrorMayQuit(" parameter is not a cone or fan.",0,0);
//     return NULL;
//   }
// #endif
//
//   perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
//   data->main_polymake_session->set_application_of(*coneobj);
//   pm::Matrix<pm::Rational> matr = coneobj->give("RAYS");
//   Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
//   SET_LEN_PLIST( RETLI , matr.rows()  );
//   Obj LIZeil;
//   pm::Rational nenner;
//   pm::Rational dentemp;
//   for(int i = 0;i<matr.rows();i++){
//     LIZeil = NEW_PLIST( T_PLIST, matr.cols());
//     SET_LEN_PLIST( LIZeil , matr.cols() );
//     nenner = 1;
//     for(int j = 0;j<matr.cols();j++){
//       CallPolymakeFunction("denominator",matr(i,j)) >> dentemp;
//       CallPolymakeFunction("lcm",nenner, dentemp ) >> nenner;
//     }
//     for(int j = 0;j<matr.cols();j++){
//       SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)*nenner));
//     }
//     SET_ELM_PLIST(RETLI,i+1,LIZeil);
//     CHANGED_BAG(RETLI);
//   }
//   return RETLI;
// }


Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr;
  try{
      pm::Matrix<pm::Rational> matr_temp = coneobj->give("RAYS");
      matr = matr_temp;
  }
  catch( std::exception err ){
      ErrorMayQuit( " an error occured during computation of rays.",0,0 );
      return NULL;
  }
  pm::Matrix<pm::Rational> matr2;
  try{
     pm::Matrix<pm::Rational> matr2_temp  = coneobj->give("LINEALITY_SPACE");
     matr2 = matr2_temp;
  }
  catch( std::exception err ){
      ErrorMayQuit( " an error occured during computation of linear span.",0,0 );
      return NULL;
  }
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows() + 2*matr2.rows());
  UInt lenght_RETLI = matr.rows() + 2*matr2.rows();
  SET_LEN_PLIST( RETLI , lenght_RETLI );
  
  polymake::common::primitive( matr );
  polymake::common::primitive( matr2 );
  
  Obj LIZeil;
  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT( (matr(i,j)).to_int() ));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  
  UInt matr2_cols = matr2.cols();
  
  for(int i = 0;i<matr2.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr2.cols());
    SET_LEN_PLIST( LIZeil ,matr2_cols );
    for(int j = 0;j<matr2.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT( (matr2(i,j)).to_int() ));
    }
    SET_ELM_PLIST(RETLI,matr.rows() + i +1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  
  for(int i = 0;i<matr2.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr2.cols());
    SET_LEN_PLIST( LIZeil ,matr2_cols);
    for(int j = 0;j<matr2.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT( (-matr2(i,j)).to_int() ));
    }
    SET_ELM_PLIST(RETLI,matr.rows() + matr2.rows() + i +1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
}


Obj REAL_LINEALITY_SPACE_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if( ( ! IS_POLYMAKE_CONE(cone) ) ){
    ErrorMayQuit(" parameter is not a cone or fan.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr;
  try
  {
      pm::Matrix<pm::Rational> matr_temp = coneobj->give("LINEALITY_SPACE");
      matr = matr_temp;
  }
  catch( std::exception err )
  {
      ErrorMayQuit( " an error occured during computation of linear span.",0,0 );
      return NULL;
  }
  
  polymake::common::primitive( matr );
  
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  Obj LIZeil;
  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT( (matr(i,j)).to_int() ));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
}


Obj REAL_HILBERT_BASIS_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" parameter is not a cone.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr;
  try
  {
     pm::Array<pm::Matrix<pm::Rational> > matr_temp = coneobj->give("HILBERT_BASIS_GENERATORS");
     matr = matr_temp[0];
  }
  catch( std::exception& err ){
      cerr << err.what();
      ErrorMayQuit(" an error occured during computation of hilbert basis in polymake.",0,0 );
      return NULL;
  }
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  Obj LIZeil;
  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil ,matr_cols);
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT((matr(i,j)).to_int()));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}

Obj REAL_RAYS_IN_FACETS( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if( ( ! IS_POLYMAKE_CONE(cone) ) and ( ! IS_POLYMAKE_POLYTOPE( cone ) ) ){
    ErrorMayQuit("parameter is not a cone.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  pm::IncidenceMatrix<pm::NonSymmetric> matr;
  try
  {
      pm::IncidenceMatrix<pm::NonSymmetric> matr_temp = coneobj->give("RAYS_IN_FACETS");
      matr = matr_temp;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  Obj LIZeil;
  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
  
}


Obj REAL_DEFINING_INEQUALITIES_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit("parameter is not a polymake cone",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Integer> matr;
  pm::Matrix<pm::Integer> matr2;
  
  try{
    coneobj->give("FACETS") >> matr;
    coneobj->give("LINEAR_SPAN") >> matr2;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during ray and linear span computation.",0,0);
    return NULL;
  }
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows() + 2*matr2.rows());
  UInt lenght_RETLI = matr.rows() + 2*matr2.rows();
  SET_LEN_PLIST( RETLI , lenght_RETLI );
  Obj LIZeil;

  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil, j+1, INTOBJ_INT( matr(i,j).to_int() ) );
      CHANGED_BAG( LIZeil );
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  
  UInt matr2_cols = matr2.cols();
  
  Obj LIZeil2;
  
  for(int i = 0;i<matr2.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr2.cols());
    LIZeil2 = NEW_PLIST( T_PLIST, matr2.cols() );
    SET_LEN_PLIST( LIZeil , matr2_cols );
    SET_LEN_PLIST( LIZeil2, matr2_cols );
    for(int j = 0;j<matr2.cols();j++){
      SET_ELM_PLIST( LIZeil,  j+1, INTOBJ_INT( matr2(i,j).to_int() ));
      CHANGED_BAG( LIZeil );
      SET_ELM_PLIST( LIZeil2, j+1, INTOBJ_INT( -matr2(i,j).to_int() ) );
      CHANGED_BAG( LIZeil2 );
      
    }
    SET_ELM_PLIST(RETLI,matr.rows() + i +1 ,LIZeil);
    CHANGED_BAG(RETLI);
    SET_ELM_PLIST(RETLI, matr.rows() + matr2.rows() + i + 1, LIZeil2 );
    CHANGED_BAG(RETLI);
  }
  return RETLI;
  
}

Obj REAL_INTERSECTION_OF_CONES( Polymake_Data* data, Obj cone1, Obj cone2){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone1) || ! IS_POLYMAKE_CONE(cone2) ){
    ErrorMayQuit(" parameter is not a cone.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj1 = PERLOBJ_POLYMAKEOBJ( cone1 );
  perlobj* coneobj2 = PERLOBJ_POLYMAKEOBJ( cone2 );

  data->main_polymake_session->set_application_of( *coneobj1 );

  perlobj intersec;

  CallPolymakeFunction( "intersection", *coneobj1, *coneobj2 ) >> intersec;

  perlobj* returnobj = new perlobj(intersec);

  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);
  
  POLYMAKEOBJ_SET_PERLOBJ( elem, returnobj );
  
  return elem;
  
}

Obj REAL_EQUALITIES_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr = coneobj->give("LINEAR_SPAN");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows() );
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI ,matr_rows);
  Obj LIZeil;
  polymake::common::primitive( matr );
  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT( (matr(i,j)).to_int() ));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
}

Obj REAL_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES( Polymake_Data* data, Obj eqs, Obj ineqs ){
  
  if( ! IS_PLIST( eqs ) || ! IS_PLIST( ineqs ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int numberofrays = LEN_PLIST( eqs );
  Obj akt;
  Obj elem;
  Obj numb;
  data->main_polymake_session->set_application("polytope");
  int dimension = LEN_PLIST( ELM_PLIST( eqs, 1 ) );
  pm::Integer* ratarray;
  ratarray = new pm::Integer[ numberofrays*dimension ];
  for(int i=0;i<numberofrays;i++){
      akt = ELM_PLIST( eqs, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) || LEN_PLIST( akt ) != dimension ){
        delete [] ratarray;
        ErrorMayQuit( "one ray is not a plain list", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j<dimension; j++){
        numb = ELM_PLIST( akt, j+1 );
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( numb ) ){
          delete [] ratarray;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[(i*dimension)+j] = INT_INTOBJ( numb );
      }
  }
  int numberofcones = LEN_PLIST( ineqs );
  pm::Integer* incMatr = new pm::Integer[numberofcones*dimension];
  for(int i=0;i<numberofcones;i++){
      akt = ELM_PLIST( ineqs, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) || LEN_PLIST( akt ) != dimension ){
        delete [] incMatr;
        ErrorMayQuit( "one ray is not a plain list", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j<dimension; j++){
        numb = ELM_PLIST( akt, j+1 );
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( numb ) ){
          delete [] incMatr;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        incMatr[(i*dimension)+j] = INT_INTOBJ( numb );
      }
  }
  
  pm::Matrix<pm::Integer>* matr = new pm::Matrix<pm::Integer>(numberofrays,dimension,ratarray);
  pm::Matrix<pm::Integer>* matr2 = new pm::Matrix<pm::Integer>(numberofcones,dimension,incMatr);
  perlobj* q = new perlobj("Cone<Rational>");
  q->take("EQUATIONS") << *matr;
  q->take("INEQUALITIES") << *matr2;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_CONE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q);
  delete [] ratarray;
  delete [] incMatr;
  delete matr;
  delete matr2;
  return elem;
}
