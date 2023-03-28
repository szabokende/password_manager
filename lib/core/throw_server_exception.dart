

import 'error/exceptions.dart';

void throwException (Exception exception){
  print('throwException runs');
  if(exception is Exception){
    print('throwException runs if FirebaseException');
   if(exception == 'permission-denied'){
     print('Access Denied Exception runs');
     throw AccessDeniedException();
   }

   else {
     print('Server Exception runs');

     ServerException();
   }
  }
}
