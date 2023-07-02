part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileById extends ProfileEvent {
  final String id;
  const GetProfileById(this.id);

  @override
  List<Object> get props => [id];
}

class GetProfileByUsername extends ProfileEvent {
  final String username;
  const GetProfileByUsername(this.username);

  @override
  List<Object> get props => [username];
}

class GetAllProfiles extends ProfileEvent {}

