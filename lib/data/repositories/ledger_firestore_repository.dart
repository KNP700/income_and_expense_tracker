import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:income_and_expense_tracker/data/model/ledger_model/ledger_model.dart';
import 'package:income_and_expense_tracker/data/model/transaction_model/transaction_model.dart';

class LedgerFirestoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveLedgerRemote({
    required String name,
    required String iconLabel,
    required String currency,
    required bool isShared,
  }) async {
    try {
      String? uid = _auth.currentUser?.uid;

      if (uid != null) {
        await _db.collection('ledgers').add({
          'userId': uid,
          'name': name,
          'icon': iconLabel,
          'currency': currency,
          'isShared': isShared,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> saveTransactionRemote({
    required int ledgerId,
    required double amount,
    required bool isExpense,
    required String paidBy,
    required String category,
    required String paymentMethod,
    required String notes,
  }) async {
    try {
      String? uid = _auth.currentUser?.uid;

      if (uid != null) {
        await _db.collection('transactions').add({
          'userId': uid,
          'ledgerId': ledgerId,
          'amount': amount,
          'isExpense': isExpense,
          'paidBy': paidBy,
          'category': category,
          'paymentMethod': paymentMethod,
          'notes': notes,
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<LedgerModel>> getLedgerFromCloud(String userId) async {
    List<LedgerModel> ledgersList = [];

    try {
      var snapshot = await _db.collection('ledgers').where('userId', isEqualTo: userId).get();

      for (var doc in snapshot.docs) {
        var data = doc.data();

        LedgerModel newLedger = LedgerModel();
        newLedger.name = data['name'] ?? '';
        newLedger.iconLabel = data['icon'] ?? '';
        newLedger.currency = data['currency'] ?? '';

        ledgersList.add(newLedger);
      }
    } catch (e) {
      print("Error: $e");
    }

    return ledgersList;
  }

  Future<List<TransactionModel>> getTransactionsFromCloud(int ledgerId) async {
    List<TransactionModel> transactionsList = [];

    try {
      var snapshot = await _db.collection('transactions').where('ledgerId', isEqualTo: ledgerId).get();

      for (var doc in snapshot.docs) {
        var data = doc.data();

        TransactionModel newTransaction = TransactionModel();
        newTransaction.ledgerId = data['ledgerId'] ?? 0;
        newTransaction.amount = (data['amount'] ?? 0.0).toDouble();
        newTransaction.isExpense = data['isExpense'] ?? false;
        newTransaction.paidBy = data['paidBy'] ?? '';
        newTransaction.category = data['category'] ?? '';
        newTransaction.paymentMethod = data['paymentMethod'] ?? '';
        newTransaction.notes = data['notes'] ?? '';

        transactionsList.add(newTransaction);
      }
    } catch (e) {
      print("Error: $e");
    }

    return transactionsList;
  }
}