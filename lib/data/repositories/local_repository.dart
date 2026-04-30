
// import 'package:isar/isar.dart';
import 'package:income_and_expense_tracker/data/model/transaction_model/transaction_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar_community/isar.dart' as db;
import 'package:isar_community/isar.dart';
import '../model/ledger_model/ledger_model.dart';

class LocalRepository {
  late Future<Isar> db;

  LocalRepository() {
    db = openDB();
  }

  Future<List<TransactionModel>>getTransactionsLocal(int ledgerId) async {
    final isar =await db;

    return await isar.transactionModels.filter().ledgerIdEqualTo(ledgerId).findAll();
  }


  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [LedgerModelSchema, TransactionModelSchema],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> addTransaction({
    required int ledgerId,
    required double amount,
    required bool isExpense,
    required String paidBy,
    required String categories,
    required String paymentMethod,
    required String notes,
})async{
    final isar = await db;
    final transaction = TransactionModel();
    transaction.ledgerId = ledgerId;
    transaction.amount = amount;
    transaction.isExpense = isExpense;
    transaction.paidBy = paidBy;
    transaction.category = categories;
    transaction.paymentMethod = paymentMethod;
    transaction.notes = notes;
    transaction.date = DateTime.now();

    await isar.writeTxn(()async{
      await isar.transactionModels.put(transaction);
    });

  }



  Future<void> saveLedgerLocal(LedgerModel ledger) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.ledgerModels.put(ledger);
    });
  }

  Future<void> deleteLedgerLocal(int id) async{
    final isar = await db;
    await isar.writeTxn(()async{
      await isar.ledgerModels.delete(id);
    });
  }


  Future<List<LedgerModel>> getLedgersLocal() async {
    final isar = await db;
    return await isar.ledgerModels.where().findAll();
  }
}