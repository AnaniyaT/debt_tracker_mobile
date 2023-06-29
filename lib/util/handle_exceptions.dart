import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/util/http_exception.dart';

class EHandle {
  static Failure handleException(HttpException e) {
    if (e.statusCode == 401) {
      return NotAuthenticatedFailure(e.message);
    } 

    else if (e.statusCode == 403) {
      return NotAuthorizedFailure(e.message);
    } 
    
    else if (e.statusCode == 404) {
      return NotFoundFailure(e.message);
    } 
    
    else if (e.statusCode == 400) {
      return BadRequestFailure(e.message);
    } 
    
    else if (e.statusCode == 500) {
      return ServerFailure(e.message);
    } 
    
    else {
      return ConnectionFailure();
    }
  }
}
