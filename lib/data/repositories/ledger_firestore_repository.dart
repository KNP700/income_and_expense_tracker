import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LedgerFirestoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveLedgerRemote({
    required String name,
    required String iconLabel,
    required String currency,
    required bool isShared,
  })
  async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {

        await _db.collection('ledgers').add({
          'userId': user.uid,
          'name': name,
          'icon': iconLabel,
          'currency': currency,
          'isShared': isShared,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        print("Warning: No authenticated user found. Cannot save to Firestore.");
      }
    } catch (e) {
      print("Firestore Error >>>>>>>>>>>>>>>>: $e");
    }
  }
  
  
  Future<void>saveTransactionRemote({
    required int ledgerId,
    required double amount,
    required bool isExpense,
    required String paidBy,
    required String category,
    required String paymentMethod,
    required String notes,
})
async {
    try{
      User? user = _auth.currentUser;
      
      if(user != null){
        await _db.collection('transactions').add({
          'userId': user.uid,
          'ledgerId': ledgerId,
          'amount':amount,
          'isExpense':isExpense,
          'paidBy': paidBy,
          'category': category,
          'paymentMethod': paymentMethod,
          'notes': notes,

        });
      }
    }catch(e){
      print
        ("-------------------->Error-----------------$e");
    }
}
}

