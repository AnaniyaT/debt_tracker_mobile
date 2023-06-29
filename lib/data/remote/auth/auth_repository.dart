import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/data/remote/auth/auth_api.dart';
import 'package:debt_tracker_mobile/domain/auth/auth.dart';
import 'package:debt_tracker_mobile/util/handle_exceptions.dart';
import 'package:debt_tracker_mobile/util/http_exception.dart';

class AuthRepository extends AuthRepositoryInterface {
  final AuthApi _authApi = AuthApi();

  @override
  Future<Either<Failure, AuthResponse>> signup(SignupForm signupForm) async  {
    try {
      final AuthResponse response = await _authApi.signup(signupForm.toJson());
      PreferenceService.setAuthToken(response.token);
      PreferenceService.setUser(response.user);

      return Right(response);
    } 
    
    on HttpException catch (e) {
      return Left(EHandle.handleException(e));
    } 
    
    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signin(SigninForm signinForm) async {
    try {
      final AuthResponse response = await _authApi.signin(signinForm.toJson());
      PreferenceService.setAuthToken(response.token);
      PreferenceService.setUser(response.user);

      return Right(response);
    } 
    
    on HttpException catch (e) {
      return Left(EHandle.handleException(e));
    } 
    
    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> checkUsername(String username) async {
    try {
      await _authApi.checkUsername(username);
      return const Right(unit);
    } 
    
    on HttpException catch (e) {
      return Left(EHandle.handleException(e));
    } 
    
    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  void logout() async {
    PreferenceService.removeAuthToken();
    PreferenceService.removeUser();
  }

}