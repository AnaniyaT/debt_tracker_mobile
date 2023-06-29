class HttpException{
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() {
    return message;
  }
}

class UnauthorizedException extends HttpException {
  UnauthorizedException() : super('Unauthorized. Please login again.', 401);

  @override
  String toString() {
    return message;
  }
}

class TimeOutException {
  final String message = 'Connection timed out. Check your internet connection and try again.';

  TimeOutException();

  @override
  String toString() {
    return message;
  }
}