abstract class AuthInterface{
  Future<void> signUp(String email, String password, String username);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> signInWithGoogle();
}