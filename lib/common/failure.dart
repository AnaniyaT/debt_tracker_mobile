class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class BadRequestFailure extends Failure {
  BadRequestFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure(String message) : super(message);
}

class NotAuthenticatedFailure extends Failure {
  NotAuthenticatedFailure(String message) : super(message);
}

class NotAuthorizedFailure extends Failure {
  NotAuthorizedFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure() : super("Something Went Wrong");
}