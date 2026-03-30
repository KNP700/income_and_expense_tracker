import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_page_event.dart';

part 'reset_password_page_state.dart';

class ResetPasswordPageBloc
    extends Bloc<ResetPasswordPageEvent, ResetPasswordPageState> {
  ResetPasswordPageBloc() : super(ResetPasswordPageInitial()) {
    on<ResetPasswordToLoginEvent>(Navigate);
    on<ResetPasswordLoginButtonToLoginEvent>(Navigate2);

    // TODO: implement event handler
  }

  void Navigate(
    ResetPasswordToLoginEvent event,
    Emitter<ResetPasswordPageState> emit,
  ) {
    emit(ResetPasswordToLoginState());
  }

  void Navigate2(
      ResetPasswordLoginButtonToLoginEvent event,
      Emitter<ResetPasswordPageState>emit,
      ){
    emit(ResetPasswordLoginButtonToLoginState());
  }
}
