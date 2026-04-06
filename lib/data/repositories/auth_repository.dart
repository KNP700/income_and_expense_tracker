import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

      final res =  await _firebaseAuth.signInWithCredential(credential);
      print(res.toString());
      return res;
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>>>>$e");
      throw Exception(e.toString());
    }
  }

Future<void> signUp({required String email, required String password}) async {
  try {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }on FirebaseAuthException catch(e){



  } catch (e) {
    throw Exception(e.toString());
  }
}
}
