import 'package:bloc/bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:meta/meta.dart';

part 'create_ledger_page_event.dart';
part 'create_ledger_page_state.dart';

class CreateLedgerPageBloc extends Bloc<CreateLedgerPageEvent, CreateLedgerPageState> {
  final LedgerRepository ledgerRepository;

  CreateLedgerPageBloc({required this.ledgerRepository})
      : super(CreateLedgerPageInitial()) {
    on<CreateLedgerSubmitted>((event, emit) async {
      emit(CreateLedgerPageLoading());
      try {
        await ledgerRepository.createLedger(
          name: event.name,
          iconLabel: event.iconLabel,
          currency: event.currency,
          isShared: event.isShared,
        );
        emit(CreateLedgerPageSuccess());
      } catch (e) {
        emit(CreateLedgerPageError(e.toString()));
      }
    });

    on<CreateLedgerToNewLedgerEvent>((event, emit) {
      emit(CreateLedgerToNewLedgerState());
    });
  }
}
