part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
  
  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;
  const EditProfileSuccess(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class EditProfileFailure extends EditProfileState {
  final Failure failure;
  const EditProfileFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class AccountDeleted extends EditProfileState {}