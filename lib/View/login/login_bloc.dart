import 'package:flutter_bloc/flutter_bloc.dart';
// import 'login/login_bloc.dart';
import 'package:income_and_expense_tracker/pages/signup_page.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginNavigateToSignupActionEvent>(_onNavigate);
  }

  void _onNavigate(LoginNavigateToSignupActionEvent event , Emitter<LoginState> emit){
    emit(LoginNavigateToSignupActionState());
  }

}
