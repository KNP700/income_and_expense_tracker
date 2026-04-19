import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ledger_page_event.dart';
part 'ledger_page_state.dart';

class LedgerPageBloc extends Bloc<LedgerPageEvent, LedgerPageState> {
  LedgerPageBloc() : super(LedgerPageInitial()) {
    on<LedgerPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
