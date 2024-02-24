import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class AcceptReqMsgUserState {}

class AcceptReqMsgUserInitials extends AcceptReqMsgUserState {}

class AcceptReqMsgUserLoading extends AcceptReqMsgUserState {}

class AcceptReqMsgUserError extends AcceptReqMsgUserState {}

class AcceptReqMsgUserSuccess extends AcceptReqMsgUserState {}

class AcceptReqMsgUserCubit extends Cubit<AcceptReqMsgUserState> {
  AcceptReqMsgUserCubit() : super(AcceptReqMsgUserInitials());
  final dio = Dio();
  Future<void> AcceptNotification(BuildContext context,{required String id}) async {
    print("id ==> $id");
    emit(AcceptReqMsgUserLoading());
    try {
      Response response = await dio.get('${apis.acceptreqUser}$id',options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }));
      print(response);
      if(response.statusCode == 200 && response.data != null)
      {
        emit(AcceptReqMsgUserSuccess());
        // Navigator.pop(context, "refresh");
        print("passs");
      }
    } on Exception catch (e) {
      emit(AcceptReqMsgUserError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }
  }
}