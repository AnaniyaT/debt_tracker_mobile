part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfile extends EditProfileEvent {
  final ChangeProfileForm changeProfileForm;

  const EditProfile(this.changeProfileForm);

  @override
  List<Object> get props => [changeProfileForm];
}

class ChangePassword extends EditProfileEvent {
  final ChangePasswordForm changePasswordForm;

  const ChangePassword(this.changePasswordForm);

  @override
  List<Object> get props => [changePasswordForm];
}

class DeleteAccount extends EditProfileEvent {}