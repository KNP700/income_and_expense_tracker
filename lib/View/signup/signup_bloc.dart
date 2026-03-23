import 'package:bloc/bloc.dart';
import 'package:income_and_expense_tracker/View/login/login_bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupNavigateToSigninActionEvent>(_onNavigate);
    }

    void _onNavigate(SignupNavigateToSigninActionEvent event, Emitter<SignupState> emit){
    emit (SignupNavigateToSigninActionState());

  }
}
