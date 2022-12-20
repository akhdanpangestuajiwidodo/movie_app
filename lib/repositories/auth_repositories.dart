import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/interfaces/auth_interface.dart';

class AuthRepositories implements AuthInterface {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        throw Exception('User not found');
      } else if (e.code == 'wrong-password') {
        throw Exception('The password is wrong');
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password is weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The email already exists');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
