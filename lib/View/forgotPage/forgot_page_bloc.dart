import 'package:bloc/bloc.dart';
import 'package:income_and_expense_tracker/View/signup/signup_bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_page_event.dart';

part 'forgot_page_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordNavigateToSigninActionEvent>(_move);
    on<ForgotPasswordToOtpPageEvent>(navi2Otp);
  }

  void _move(
    ForgotPasswordNavigateToSigninActionEvent event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(ForgotPasswordNavigateToSigninActionState());
  }

  void navi2Otp(
    ForgotPasswordToOtpPageEvent event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(ForgotPasswordToOtpPageState());
  }
}
