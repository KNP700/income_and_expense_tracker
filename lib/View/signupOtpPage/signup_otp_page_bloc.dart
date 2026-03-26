import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_otp_page_event.dart';

part 'signup_otp_page_state.dart';

class SignupOtpPageBloc extends Bloc<SignupOtpPageEvent, SignupOtpPageState> {
  SignupOtpPageBloc() : super(SignupOtpPageInitial()) {
    on<ContinueToCreateAccActionEvent>(_onNavigate);
  }
}

void _onNavigate(
  ContinueToCreateAccActionEvent event,
  Emitter<SignupOtpPageState> emit,
) {
  emit(ContinueToCreateAccActionState());
}
