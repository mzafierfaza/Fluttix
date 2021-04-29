import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_motix/bloc/blocs.dart';
import 'package:bwa_motix/models/models.dart';
import 'package:bwa_motix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      // kalau dia loadUser kita akan mengambil data dari Firestore.
      User user = await UserServices.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      User updatedUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is TopUp) {
      // pastikan terlebih dahulu user nya udah ke load ato blm.
      if (state is UserLoaded) {
        try {
          User updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);

          await UserServices.updateUser(updatedUser);

          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      // pastikan terlebih dahulu user nya udah ke load ato blm.
      if (state is UserLoaded) {
        try {
          User updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);

          await UserServices.updateUser(updatedUser);

          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}

// ticket bloc ini berfungsi untuk menyimpan state dari ticket yang kita beli.
// kalo di ecommerce ini bisa dibilang "keranjang belanja".
//
