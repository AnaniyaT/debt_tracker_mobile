import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:debt_tracker_mobile/common/failure.dart';

abstract class UserRepositoryInterface {
  Future<Either<Failure, List<UserProfile>>> getAll();
  Future<Either<Failure, User>> getMe();
  Future<Either<Failure, UserProfile>> getById(String id);
  Future<Either<Failure, UserProfile>> getByUsername(String username);
  Future<Either<Failure, List<UserProfile>>> search(String query);
  Future<Either<Failure, User>> changeProfile(ChangeProfileForm changeProfileForm);
  Future<Either<Failure, Unit>> changePassword(ChangePasswordForm changePasswordForm);
  Future<Either<Failure, Unit>> deleteAccount();
}