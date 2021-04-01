part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // method untuk sign up
  static Future signUp(String email, String password, String name,
      List<String> selectedGenres, String selectedLanguange) async {
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

    } catch (e) {}
  }
}
