import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_with_mobile_page_event.dart';
part 'login_with_mobile_page_state.dart';

class LoginWithMobilePageBloc
    extends Bloc<LoginWithMobilePageEvent, LoginWithMobilePageState> {
  LoginWithMobilePageBloc() : super(LoginWithMobilePageInitial()) {
    on<MobilePageToOtpEvent>(navigate);
  }

  void navigate(
      MobilePageToOtpEvent event,
      Emitter<LoginWithMobilePageState> emit,
      ) {
    emit(MobilePageToOtpState());
  }
}