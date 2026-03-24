import 'package:bloc/bloc.dart';
import 'package:income_and_expense_tracker/View/login/login_bloc.dart';


part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupNavigateToSigninActionEvent>(_onNavigate);
    on<SignupNavigateToOtpActionEvent>(_onNavigate1);
  }
}

void _onNavigate(
  SignupNavigateToSigninActionEvent event,
  Emitter<SignupState> emit,
) {
  emit(SignupNavigateToSigninActionState());
}

void _onNavigate1(
  SignupNavigateToOtpActionEvent event,
  Emitter<SignupState> emit,
) {
  emit(SignupNavigateToOtpActionState());
}
