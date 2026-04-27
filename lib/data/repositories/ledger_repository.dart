import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_community/isar.dart' as db;
import 'package:path_provider/path_provider.dart';

import '../model/ledger_model/ledger_model.dart';

class LedgerRepository {
  static const String TAG = "LedgerRepository";
  final FirebaseFirestore _db= FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<Isar> db;

  LedgerRepository() {
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

  Future<void> createLedger({
    required String name,
    required String iconLabel,
    required String currency,
  }) async {
    final isar = await db;
    final newLedger = LedgerModel()
      ..name = name
      ..iconLabel = iconLabel
      ..currency = currency;

    await isar.writeTxn(() async {
      await isar.ledgerModels.put(newLedger);
    });
  }

  Future<List<LedgerModel>> getLedgers() async {
    final isar = await db;
    return await isar.ledgerModels.where().findAll();
    return [];
  }
//
// Future<void> createLedger({
//   required String name,
//   required String iconLabel,
//   required String currency,
//   required bool isShared,
// }) async {
//   try {
//     User? user = _auth.currentUser;
//
//     if (user != null)
//     {
//       await _db.collection.add({
//         'userId': user.uid,
//         'name': name,
//         'icon': iconLabel,
//         'currency': currency,
//         'isShared': isShared,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     } else {
//   throw Exception("No authenticated user found.");
//   }
//   } catch (e) {
//   print("this >>>>>>>>>>>>>>>>:$e");
//   }
}
