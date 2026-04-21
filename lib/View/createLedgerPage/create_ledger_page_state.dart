part of 'create_ledger_page_bloc.dart';

@immutable
sealed class CreateLedgerPageState {}

final class CreateLedgerPageInitial extends CreateLedgerPageState {}

final class CreateLedgerPageLoading extends CreateLedgerPageState {}

final class CreateLedgerPageSuccess extends CreateLedgerPageState {}

final class CreateLedgerPageError extends CreateLedgerPageState {
  final String error;
  CreateLedgerPageError(this.error);
}

final class CreateLedgerToNewLedgerState extends CreateLedgerPageState {}
