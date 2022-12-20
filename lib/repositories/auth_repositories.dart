import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/interfaces/auth_interface.dart';

class AuthRepositories implements AuthInterface {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signIn(String email, String password) async {}

  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<void> signOut() async {}

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
