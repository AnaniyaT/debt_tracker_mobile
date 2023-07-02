import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/data/remote/user/user.dart';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository _userRepository = UserRepository();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfile>((event, emit) async {
      emit(EditProfileLoading());

      Either<Failure, User> result =
          await _userRepository.changeProfile(event.changeProfileForm);

      result.fold(
        (l) => emit(EditProfileFailure(l)),
        (r) => emit(const EditProfileSuccess('Profile Edited Successfully!')),
      );
    });

    on<ChangePassword>((event, emit) async {
      emit(EditProfileLoading());

      Either<Failure, Unit> result =
          await _userRepository.changePassword(event.changePasswordForm);

      result.fold(
        (l) => emit(EditProfileFailure(l)),
        (r) => emit(const EditProfileSuccess('Changed Password Successfully!')),
      );
    });

    on<DeleteAccount>((event, emit) async {
      emit(EditProfileLoading());

      Either<Failure, Unit> result = await _userRepository.deleteAccount();

      result.fold(
        (l) => emit(EditProfileFailure(l)),
        (r) => emit(AccountDeleted()),
      );
    });
  }
}
