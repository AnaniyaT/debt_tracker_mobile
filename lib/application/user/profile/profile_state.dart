part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState{}

class ProfileSuccessMultiple extends ProfileState {
  final List<UserProfile> profiles;
  const ProfileSuccessMultiple(this.profiles);

  @override
  List<Object> get props => [profiles];
}

class ProfileSuccess extends ProfileState {
  final UserProfile profile;
  const ProfileSuccess(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileFailure extends ProfileState {
  final Failure failure;
  const ProfileFailure(this.failure);

  @override
  List<Object> get props => [failure];
}