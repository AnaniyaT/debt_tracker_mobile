import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:debt_tracker_mobile/data/remote/user/user.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository = UserRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<GetAllProfiles>((event, emit) async {
      emit(ProfileLoading());

      Either<Failure, List<UserProfile>> result =
          await _userRepository.getAll();

      result.fold(
        (l) => emit(ProfileFailure(l)),
        (r) => emit(ProfileSuccessMultiple(r)),
      );
    });

    on<GetProfileById>((event, emit) async {
      emit(ProfileLoading());

      Either<Failure, UserProfile> result =
          await _userRepository.getById(event.id);

      result.fold(
        (l) => emit(ProfileFailure(l)),
        (r) => emit(ProfileSuccess(r)),
      );
    });

    on<GetProfileByUsername>((event, emit) async {
      emit(ProfileLoading());

      Either<Failure, UserProfile> result =
          await _userRepository.getByUsername(event.username);

      result.fold(
        (l) => emit(ProfileFailure(l)),
        (r) => emit(ProfileSuccess(r)),
      );
    });

    on<SearchUsername> ((event, emit) async {
      emit(ProfileLoading());

      Either<Failure, List<UserProfile>> result =
          await _userRepository.search(event.username);

      result.fold(
        (l) => emit(ProfileFailure(l)),
        (r) => emit(ProfileSuccessMultiple(r)),
      );
    });
  }
}
