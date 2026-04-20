import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_ledger_page_event.dart';
part 'create_ledger_page_state.dart';

class CreateLedgerPageBloc extends Bloc<CreateLedgerPageEvent, CreateLedgerPageState> {
  CreateLedgerPageBloc() : super(CreateLedgerPageInitial()) {
    on<CreateLedgerPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
