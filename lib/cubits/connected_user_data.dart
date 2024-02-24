import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/alluserprofile.dart';
import 'package:pair_me/Modal/connected_user_data_modal.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class ConnectedUsersState {}

class ConnectedUsersInitials extends ConnectedUsersState {}

class ConnectedUsersLoading extends ConnectedUsersState {}

class ConnectedUsersError extends ConnectedUsersState {}

class ConnectedUsersSuccess extends ConnectedUsersState {}

class ConnectedUsersCubit extends Cubit<ConnectedUsersState> {
  ConnectedUsersCubit() : super(ConnectedUsersInitials());
  ConnectedUsers connectedUsers = ConnectedUsers();
  final dio = Dio();
  List data = [];
  Future<ConnectedUsers?> GetConnectedUsers() async {
    emit(ConnectedUsersLoading());
    try {
      Response response = await dio.get(apis.connectedUser,options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }));
      final hello = response.data;
      if(hello['code'] == 200 && hello['data'] != null)
      {
        connectedUsers = ConnectedUsers.fromJson(response.data);
        data = hello['data'] ?? [];
        print(connectedUsers);
        print("hello ===> $data ");
        emit(ConnectedUsersSuccess());
      } else {
        emit(ConnectedUsersError());
      }
      return connectedUsers;
    } on Exception catch (e) {
      emit(ConnectedUsersError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }
    return null;
  }

}
