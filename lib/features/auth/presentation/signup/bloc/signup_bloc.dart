import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/domain/usecases/signup_user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;
  final SignUpUser signUpUser;

  SignupBloc({required this.authRepository})
      : signUpUser = SignUpUser(authRepository),
        super(SignupInitial()) {
    on<SignupButtonPressed>(_signupButtonPressedEventHandler);
  }

  Future<void> _signupButtonPressedEventHandler(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    // Call the use case
    final result = await signUpUser(event.email, event.password);

    if (result.isSuccess) {
      emit(SignupSuccess(userEntity: result.data!));
    } else {
      emit(SignupError(message: result.error!));
    }
  }
}
