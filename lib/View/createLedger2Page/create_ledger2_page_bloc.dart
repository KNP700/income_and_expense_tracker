import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_ledger2_page_event.dart';
part 'create_ledger2_page_state.dart';

class CreateLedger2PageBloc extends Bloc<CreateLedger2PageEvent, CreateLedger2PageState> {
  CreateLedger2PageBloc() : super(CreateLedger2PageInitial()) {
    on<CreateLedger2PageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
