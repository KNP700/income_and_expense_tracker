import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_otp_page_event.dart';

part 'forgot_otp_page_state.dart';

class ForgotOtpPageBloc extends Bloc<ForgotOtpPageEvent, ForgotOtpPageState> {
  ForgotOtpPageBloc() : super(ForgotOtpPageInitial()) {
    on<ForgotOtpPageToResetEvent>(_Navigate);
  }

  void _Navigate(
    ForgotOtpPageToResetEvent event,
    Emitter<ForgotOtpPageState> emit,
  ) {
    emit(ForgotOtpPageToResetState());
  }

  // TODO: implement event handler
}
