import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final res = await _firebaseAuth.signInWithCredential(credential);
      print(res.toString());
      return res;
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>>>>$e");
      throw Exception(e.toString());
    }
  }

  // Future<void> signUp({required String email, required String password}) async {
  //   try {
  //     FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

// Future<void> sendOtpToEmail (String email, String Otp)async{
//     await Future.delayed(const Duration(seconds: 2));
//     print("Sending Otp to $email");
// }

  Future<void> createAccount({
    required String userName,
    required String firstName,
    required String lastName,
    required String password, required String username,
  }) async {
    User? user = _auth.currentUser;

    if (user != null) {
      await user.updateDisplayName("$firstName $lastName");

      await user.updatePassword(password);

      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'firstName': firstName,
        'lastName': lastName,
        'username': userName,
        'createdAt': FieldValue.serverTimestamp(), // save with time in firestore cloud
      });
    }
  }





  Future<void> sendEmailLink(String email) async {
    var acs = ActionCodeSettings(
      url: 'https://income_and_expense_tracker.com',
      handleCodeInApp: true,
      iOSBundleId: 'com.example.incomeAndExpenseTracker',
      androidPackageName: 'com.example.income_and_expense_tracker',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );

    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );
    } catch (e) {
      print("Error from email >>>>>>>>>>>>>>>>>>> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<bool> isSignInWithEmailLink(String link) async {
    return _auth.isSignInWithEmailLink(link);
  }

  Future<UserCredential> signInWithEmailLink(String email, String link) async {
    return await _auth.signInWithEmailLink(email: email, emailLink: link);
  }
}
