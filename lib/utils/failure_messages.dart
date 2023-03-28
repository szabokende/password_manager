

import '../core/error/failures.dart';




String SERVER_FAILURE_MESSAGE = 'Server failure';
String ACCESS_DENIED_FAILURE_MESSAGE =
   'acces denied failure';
String CACHE_FAILURE_MESSAGE = 'cache failure';

String mapFailureToPassword(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case AccessDeniedFailure:
      return ACCESS_DENIED_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
