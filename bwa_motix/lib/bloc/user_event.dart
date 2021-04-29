part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

// loadUser dan signOut
class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateData extends UserEvent {
  // kenapa cuma nama sm profile image, karena yg bisa diganti cuma itu, email gakbisa.
  final String name;
  final String profileImage;

  UpdateData({this.name, this.profileImage});

  @override
  List<Object> get props => [name, profileImage];
}

class TopUp extends UserEvent {
  final int amount; // jumlah yang ingin di topup

  TopUp(this.amount);

  @override
  // TODO: implement props
  List<Object> get props => [amount];
}

class Purchase extends UserEvent {
  final int amount; // jumlah harga tiket yg dibeli.

  Purchase(this.amount);

  @override
  List<Object> get props => [amount];
}
