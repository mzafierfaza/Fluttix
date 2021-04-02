part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

// UserLoaded ini adalah state dimana data2 user sudah ke load sama kita.
class UserLoaded extends UserState {
  final User user; // user yang akan kita gunakan menyimpan data user

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}
