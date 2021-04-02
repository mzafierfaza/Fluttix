part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection("users");

  static Future<void> updateUser(User user) async {
    String genres = "";

    for (var genre in user.selectedGenres) {
      genres += genre + ((genre != user.selectedGenres.last) ? ',' : "");
    } // split list genre jadi satu buah string (katanya)

    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguange': user.selectedLanguange,
      'profilePicture': user.profilePicture ?? ""
    });
  }
}
