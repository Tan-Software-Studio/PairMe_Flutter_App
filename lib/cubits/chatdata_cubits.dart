import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Modal/chatdata_modal.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class ChatDataState {}

class ChatDataInitials extends ChatDataState {}

class ChatDataLoading extends ChatDataState {}

class ChatDataError extends ChatDataState {}

class ChatDataSuccess extends ChatDataState {}

class ChatDataCubit extends Cubit<ChatDataState> {
  ChatDataCubit() : super(ChatDataInitials());
  ChatData chatData = ChatData();
  Future ChatDataService(
      {required List array,
        required BuildContext context}) async {
    emit(ChatDataLoading());
    final dio = Dio();
    final body = {
      "array": array,
    };
    log("Body is $body");
    try {
      emit(ChatDataLoading());
      final response = await dio.post(apis.chatData,options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }) ,data: jsonEncode(body));
      print("response ==> $response");
      emit(ChatDataSuccess());
      return ;
    } on Exception catch (e) {
      print("fail ====> " +e.toString());
      emit(ChatDataError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
    return null;
  }
}