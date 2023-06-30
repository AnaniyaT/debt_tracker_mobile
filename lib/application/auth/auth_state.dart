part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthUsernameAvailable extends AuthState {}

class AuthUsernameFailure extends AuthState {
  final String message;

  const AuthUsernameFailure(this.message);

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}
