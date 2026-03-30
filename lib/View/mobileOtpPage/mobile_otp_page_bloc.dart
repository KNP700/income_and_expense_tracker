import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mobile_otp_page_event.dart';

part 'mobile_otp_page_state.dart';

class MobileOtpPageBloc extends Bloc<MobileOtpPageEvent, MobileOtpPageState> {
  MobileOtpPageBloc() : super(MobileOtpPageInitial()) {
    on<AfterMobileOtpNavigationEvent>(Navigate);
  }
}

void Navigate(
  AfterMobileOtpNavigationEvent event,
  Emitter<MobileOtpPageState> emit,
) {
  emit(AfterMobileOtpNavigationState());
  // TODO: implement event handler
}
