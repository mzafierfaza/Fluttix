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
}

// class untuk dapetin hasil nya.
class SignInSignUpResult {
  User user;
  String message;

  SignInSignUpResult({this.user, this.message});
}
