import 'package:demoapps/bloc/user_state.dart';
import 'package:demoapps/database/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database_helper.dart';

class UserBloc extends Cubit<UserState> {
  List<User?>? userList = [];

  UserBloc() : super(UsersInitial());

  Future<void> fetchLocalProduct() async {
    try {
      userList = await getAllUsers();
      emit(UsersLoaded(userList ?? []));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void addUpdateUser(User user) async {
    await insertUpdateUser(user);
    userList?.add(user);
    emit(UsersLoaded(userList ?? []));
  }
  void updateUser(User user) async {
    await updateUsers(user);
    userList?.add(user);
    emit(UsersLoaded(userList ?? []));
  }

  void searchUser(String name, String date) async {
    try {
      userList = await getSearchProducts(name, date);
      emit(UsersLoaded(userList ?? []));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }


}
