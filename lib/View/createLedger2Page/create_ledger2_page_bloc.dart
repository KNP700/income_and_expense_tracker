import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_ledger2_page_event.dart';

part 'create_ledger2_page_state.dart';

class CreateLedger2PageBloc
    extends Bloc<CreateLedger2PageEvent, CreateLedger2PageState> {
  CreateLedger2PageBloc() : super(CreateLedger2PageInitial()) {
    on<createLegerToAddTransactionEvent>(_onNavigate);
  }

  void _onNavigate(createLegerToAddTransactionEvent event,
      Emitter<CreateLedger2PageState> emit) {
    emit(createLegerToAddTransactionState());
  }
}
