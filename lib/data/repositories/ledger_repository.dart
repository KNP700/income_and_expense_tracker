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

  Future<void> deleteLedger(int id)async{
    await localDataSource.deleteLedgerLocal(id);
  }
}