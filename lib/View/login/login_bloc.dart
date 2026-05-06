import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart'; // Make sure this path is correct!

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginNavigateToSignupActionEvent>(_onNavigate);
    on<LoginNavigateToForgotActionEvent>(_onNavigate1);
    on<LoginNavigateIntoHomeEvent>(_onNavigate2);
    on<LoginWithMobileToMobileEvent>(_onNavigate3);

    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<GoogleSignInEvent>(_onGoogleSignIn);
  }

  void _onNavigate(
      LoginNavigateToSignupActionEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToSignupActionState());
  }

  void _onNavigate1(
      LoginNavigateToForgotActionEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToForgotActionState());
  }

  void _onNavigate2(
      LoginNavigateIntoHomeEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateIntoHomeState());
  }

  void _onNavigate3(
      LoginWithMobileToMobileEvent event, Emitter<LoginState> emit) {
    emit(LoginWithMobileToMobileState());
  }

  void _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final userCredential = await authRepository.signInWithGoogle();

      if (userCredential != null) {
        emit(LoginSuccessState());
      } else {
        emit(LoginFailureState("Google Sign-In Failed."));
      }
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> _onLoginSubmitted(
      LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      await authRepository.loginWithEmailAndPassword(
        event.email,
        event.password,
      );

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }
}
