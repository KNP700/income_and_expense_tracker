
// import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar_community/isar.dart' as db;
import 'package:path_provider/path_provider.dart';
import 'package:isar_community/isar.dart';
import '../model/ledger_model/ledger_model.dart';

class LocalRepository {
  late Future<Isar> db;

  LocalRepository() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [LedgerModelSchema],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
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