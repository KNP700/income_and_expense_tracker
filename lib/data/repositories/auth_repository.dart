import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
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

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createAccount({
    required String username,
    required String firstName,
    required String lastName,
    required String password,
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
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception("No authenticated user found.");
    }
  }

  Future<bool> checkIfUserAlreadyLogged(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendEmailLink(String email) async {
    var acs = ActionCodeSettings(
      url: 'https://income-and-expense-track-1e04c.firebaseapp.com/',
      handleCodeInApp: true,
      iOSBundleId: 'com.example.incomeAndExpenseTracker',
      androidPackageName: 'com.example.income_and_expense_tracker',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );

    await FirebaseAuth.instance.currentUser?.sendEmailVerification(acs);

    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );
    } catch (e) {
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
