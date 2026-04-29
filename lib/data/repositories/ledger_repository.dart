import 'package:income_and_expense_tracker/data/model/transaction_model/transaction_model.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_firestore_repository.dart';

import '../model/ledger_model/ledger_model.dart';
import 'local_repository.dart';

class LedgerRepository {
  final LocalRepository localDataSource;
  final LedgerFirestoreRepository remoteDataSource;

  LedgerRepository({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  Future<void> addTransaction({
    required int ledgerId,
    required double amount,
    required bool isExpense,
    required String paidBy,
    required String category,
    required String paymentMethod,
    required String notes,
  }) async {
    await localDataSource.addTransaction(ledgerId: ledgerId,
        amount: amount,
        isExpense: isExpense,
        paidBy: paidBy,
        categories: category,
        paymentMethod: paymentMethod,
        notes: notes,

    );
        await remoteDataSource.saveTransactionRemote(
          ledgerId: ledgerId,
          amount: amount,
          isExpense: isExpense,
          paidBy: paidBy,
          category: category,
          paymentMethod: paymentMethod,
          notes: notes,

        );
  }


  Future<void> createLedger({
    required String name,
    required String iconLabel,
    required String currency,
    bool isShared = false,
  }) async {
    final newLedger = LedgerModel()
      ..name = name
      ..iconLabel = iconLabel
      ..currency = currency;

    await localDataSource.saveLedgerLocal(newLedger);

    await remoteDataSource.saveLedgerRemote(
      name: name,
      iconLabel: iconLabel,
      currency: currency,
      isShared: isShared,
    );
  }


  Future<List<LedgerModel>> getLedgers() async {
    return await localDataSource.getLedgersLocal();
  }

  Future<void> deleteLedger(int id) async {
    await localDataSource.deleteLedgerLocal(id);
  }

  Future<List<TransactionModel>>getTransactions(int ledgerId) async {
    return await localDataSource.getTransactionsLocal(ledgerId);
  }
  }