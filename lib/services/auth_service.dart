import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream lắng nghe trạng thái đăng nhập
  Stream<User?> get user => _auth.authStateChanges();

  // Đăng nhập bằng Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Lỗi đăng nhập Google: $e");
      return null;
    }
  }

  // Đăng nhập nặc danh (Guest)
  Future<User?> signInAnonymously() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print("Lỗi đăng nhập Guest: $e");
      return null;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    await _auth.signOut();
  }
}
