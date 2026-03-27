import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_acc_page_event.dart';

part 'create_acc_page_state.dart';

class CreateAccPageBloc extends Bloc<CreateAccPageEvent, CreateAccPageState> {
  CreateAccPageBloc() : super(CreateAccPageInitial()) {
    on<ContinueCreateAccToSignInEvent>(_onNavigate);
    on<ContinueCreateAccToSignIn2Event>(_onNavigate1);
  }
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
