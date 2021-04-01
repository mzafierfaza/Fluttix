part of 'models.dart';

class User extends Equatable {
  final String id; // id akan di generate firebase auth otomatis
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguange;
  final int balance;

  User(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.balance,
      this.selectedGenres,
      this.selectedLanguange});

  @override
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguange,
        balance
      ];
}
