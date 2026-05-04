part of 'ledger_page_bloc.dart';

@immutable
class LedgerPageEvent {}

class LoadLedger extends LedgerPageEvent {}

class LedgerSelect extends LedgerPageEvent {
  late final int ledgerId;

  LedgerSelect(this.ledgerId);
  }
