import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'create_acc_page_event.dart';
part 'create_acc_page_state.dart';

class CreateAccPageBloc extends Bloc<CreateAccPageEvent, CreateAccPageState> {

  final AuthRepository authRepository;

  CreateAccPageBloc({required this.authRepository}) : super(CreateAccPageInitial()) {
    on<ContinueCreateAccToSignInEvent>(_onNavigate);
    on<ContinueCreateAccToSignIn2Event>(_onNavigate1);
    on<CreateAccDetailsSubmitted>(_onNavigate2);
  }


  void _onNavigate(
      ContinueCreateAccToSignInEvent event,
      Emitter<CreateAccPageState> emit,
      ) {
    emit(ContinueCreateAccToSignInState());
  }

  void _onNavigate1(
      ContinueCreateAccToSignIn2Event event,
      Emitter<CreateAccPageState> emit,
      ) {
    emit(ContinueCreateAccToSignIn2State());
  }


  Future<void> _onNavigate2(
      CreateAccDetailsSubmitted event,
      Emitter<CreateAccPageState> emit,
      ) async {
    emit(CreateAccLoadingState());

    try {

      await authRepository.createAccount(
        firstName: event.firstName,
        lastName: event.lastName,
        username: event.username,
        password: event.password, userName: '',
      );
      emit(CreateAccSuccessState()); // Navigate to Home
    } catch (e) {
      emit(CreateAccErrorState(e.toString()));
    }
  }
}