part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable  {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignin extends AuthEvent {
  final SigninForm signinForm;

  const AuthSignin(this.signinForm);

  @override
  List<Object> get props => [signinForm];
}

class AuthSignup extends AuthEvent {
  final SignupForm signupForm;

  const AuthSignup(this.signupForm);

  @override
  List<Object> get props => [signupForm];
}

class AuthCheckUsername extends AuthEvent {
  final String username;

  const AuthCheckUsername(this.username);

  @override
  List<Object> get props => [username];
}

