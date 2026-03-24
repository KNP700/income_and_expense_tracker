import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_otp_page_event.dart';
part 'forgot_otp_page_state.dart';

class ForgotOtpPageBloc extends Bloc<ForgotOtpPageEvent, ForgotOtpPageState> {
  ForgotOtpPageBloc() : super(ForgotOtpPageInitial()) {
    on<ForgotOtpPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
