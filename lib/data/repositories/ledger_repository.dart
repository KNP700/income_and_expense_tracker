import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LedgerRepository {
  static const String TAG = "LedgerRepository";
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createLedger({
    required String name,
    required String iconLabel,
    required String currency,
    required bool isShared,
  }) async {

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
        throw Exception("No authenticated user found.");
      }
    }  catch (e) {
      print("this >>>>>>>>>>>>>>>>:$e");
    }
  }
}