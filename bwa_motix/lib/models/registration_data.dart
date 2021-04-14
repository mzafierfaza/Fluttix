// NOTE: Model untuk menyimpan data-data yang akan di SignUp
//

part of 'models.dart';

class RegistrationData {
  String name;
  String email;
  String password;
  List<String> selectedGenres;
  String selectedLang;
  File profileImage;

  RegistrationData(
      // Sengaja di buat opsional supaya pas ngisi nya kan bertahap. enggak sekaliguss
      {this.name = "",
      this.email = "",
      this.password = "",
      this.selectedGenres = const [],
      this.selectedLang = "",
      this.profileImage});
}
