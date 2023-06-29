import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'auth.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, AuthResponse>> signup(SignupForm signupForm);
  Future<Either<Failure, AuthResponse>> signin(SigninForm signinForm);
  Future<Either<Failure, Unit>> checkUsername(String username);
  void logout();
}