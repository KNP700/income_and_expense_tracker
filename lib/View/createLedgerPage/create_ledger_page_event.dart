part of 'create_ledger_page_bloc.dart';

@immutable
abstract class CreateLedgerPageEvent {}

class CreateLedgerSubmitted extends CreateLedgerPageEvent {
  final String name;
  final String iconLabel;
  final String currency;
  final bool isShared;

  CreateLedgerSubmitted({
    required this.name,
    required this.iconLabel,
    required this.currency,
    required this.isShared,
  });
}


class CreateLedgerToNewLedgerEvent extends CreateLedgerPageEvent{}