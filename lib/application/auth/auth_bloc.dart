import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/domain/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/auth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignin>((event, emit) async {
      emit(AuthLoading());
      print("signin event dispatched");

      Either<Failure, AuthResponse> result =
          await _authRepository.signin(event.signinForm);

      result.fold(
        (l) => emit(AuthFailure(l.toString())),
        (r) => emit(AuthSuccess()),
      );
    });

    on<AuthSignup>((event, emit) async {
      emit(AuthLoading());

      Either<Failure, AuthResponse> result =
          await _authRepository.signup(event.signupForm);

      result.fold(
        (l) => emit(AuthFailure(l.toString())),
        (r) => emit(AuthSuccess()),
      );
    });

    on<AuthCheckUsername>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, Unit> result =
          await _authRepository.checkUsername(event.username);

      result.fold(
        (l) => emit(AuthUsernameFailure(l.toString())),
        (r) => emit(AuthUsernameAvailable()),
      );
    });
  }
}
