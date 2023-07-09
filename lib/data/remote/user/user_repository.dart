import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/data/remote/user/user.dart';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:debt_tracker_mobile/util/util.dart';

class UserRepository extends UserRepositoryInterface {
  final UserApi _userApi = UserApi();

  @override
  Future<Either<Failure, List<UserProfile>>> getAll() async {
    try {
      List<UserProfile> profiles = await _userApi.getUsers();
      return right(profiles);
    } 
    on DHttpException catch (e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getMe() async {
    try {
      User user = await _userApi.getMe();
      return right(user);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getById(String id) async {
    try {
      UserProfile user = await _userApi.getUserById(id);
      return right(user);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getByUsername(String username) async {
    try {
      UserProfile user = await _userApi.getUserByUsername(username);
      return right(user);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserProfile>>> search(String query) async {
    try {
      List<UserProfile> profiles = await _userApi.searchUsername(query);
      return right(profiles);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, User>> changeProfile(ChangeProfileForm changeProfileForm) async {
    try {
      User user = await _userApi.changeProfile(changeProfileForm.toJson());
      PreferenceService.setUser(user);
      return right(user);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword(ChangePasswordForm changePasswordForm) async {
    try {
      await _userApi.changePassword(changePasswordForm.toJson());
      return right(unit);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    try {
      await _userApi.deleteAccount();
      PreferenceService.removeUser();
      PreferenceService.removeAuthToken();
      return right(unit);
    }
    on DHttpException catch(e) {
      return left(EHandle.handleException(e));
    }
    catch (e) {
      return left(ConnectionFailure());
    }
  }

}