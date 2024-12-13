import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //geting instence of firebse auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
//google sign in

  // sinInWithGoogle() async {
  //   //popup
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //   //
  //   //ceh
  //   if(gUser==null) return;

  //   final GoogleSignInAuthentication gAuth = await gUser.authentication;
  //   //create new credtional

  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken, idToken: gAuth.idToken);

  //   //sign in

  //   return await _firebaseAuth.signInWithCredential(credential);
  // }

  //sing up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign out

  Future<void> singOut() async {
    return await _firebaseAuth.signOut();
  }
}
