class DHttpException{
  final String message;
  final int statusCode;

  DHttpException(this.message, this.statusCode);

  @override
  String toString() {
    return message;
  }
}

class UnauthorizedException extends DHttpException {
  UnauthorizedException() : super('Unauthorized. Please login again.', 401);

  @override
  String toString() {
    return message;
  }
}

class TimeOutException {
  final String message = 'Connection timed out. ere oooooo Check your internet connection and try again.';

  TimeOutException();

  @override
  String toString() {
    return message;
  }
}