part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection("users");

  static Future<void> updateUser(User user) async {
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguange': user.selectedLanguange,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  // ubah firebaseUser ke User
  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return User(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        profilePicture: snapshot.data['profilePicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguange: snapshot.data['selectedLanguange'],
        name: snapshot.data['name']);
  }
}
