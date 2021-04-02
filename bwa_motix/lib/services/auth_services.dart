part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // method untuk sign up
  static Future<SignInSignUpResult> signUp(
      String email,
      String password,
      String name,
      List<String> selectedGenres,
      String selectedLanguange) async {
    try {
      // daftarkan email dan password ke firebase auth
      // nanti createUserWithEmail itu akan mengembalikan auth result / firebase user.
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // kalau berhasil nanti di unobject kan user nyaa. kalau gagal akan mengembalikan null.
      // kita akan buat lagi data user yg berhasil tadi ke firestore. nama, email, dll.
      // convert firebase user ke User
      User user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguange: selectedLanguange);

      // setelah jadi user , kita kirim ke firestore
      await UserServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  // method untuk signIn
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // kalau berhasil mengubah firebaseUser ke User.
      User user = await result.user.fromFirestore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
      // split (',') itu untuk memisahkan log error dari firebase supaya jadi lebih ke user friendly, dan 1 itu index ke 1 dari kata2 nya.
    }
  }

  // method untuk sign Out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // method stream untuk kalo sudah login pindah ke main_page, kalo log out pindah ke splash screen dst.
  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
  // onAuthStateChanged yang akan kasih tau kita kalau ada perubahan status pada firebase Auth
}

// class untuk dapetin hasil nya.
class SignInSignUpResult {
  User user;
  String message;

  SignInSignUpResult({this.user, this.message});
}
