import 'package:flutter_bloc/flutter_bloc.dart';

// import 'login/login_bloc.dart';
import 'package:income_and_expense_tracker/pages/signup_page.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginNavigateToSignupActionEvent>(_onNavigate);
    on<LoginNavigateToForgotActionEvent>(_onNavigate1);
    on<LoginNavigateIntoHomeEvent>(_onNavigate2);
  }
  // LoginBloc() : super(LoginInitial()){
  //   on<LoginNavigateToForgotActionEvent>(_onNavigate);
}

void _onNavigate(
  LoginNavigateToSignupActionEvent event,
  Emitter<LoginState> emit,
) {
  emit(LoginNavigateToSignupActionState());
}

void _onNavigate1(
  LoginNavigateToForgotActionEvent event,
  Emitter<LoginState> emit,
) {
  emit(LoginNavigateToForgotActionState());
}

void _onNavigate2(LoginNavigateIntoHomeEvent event, Emitter<LoginState> emit) {
  emit(LoginNavigateIntoHomeState());
}
