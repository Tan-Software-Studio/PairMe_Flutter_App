import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class UpdateLanguageState {}

class UpdateLanguageInitials extends UpdateLanguageState {}

class UpdateLanguageLoading extends UpdateLanguageState {}

class UpdateLanguageError extends UpdateLanguageState {}

class UpdateLanguageSuccess extends UpdateLanguageState {}

class UpdateLanguageCubit extends Cubit<UpdateLanguageState> {
  UpdateLanguageCubit() : super(UpdateLanguageInitials());

  Future<void> UpdateLanguageService(
      {required String array,
        required BuildContext context}) async {
    emit(UpdateLanguageLoading());
    final dio = Dio();
    final body = {
      "language": array,
    };
    print("Body is $body");
    try {
      final response = await dio.post(apis.languageUpdate,options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }) ,data: jsonEncode(body));
      print("Response ===> ${response.data}");
    } on Exception catch (e) {
      print("fail ====> " +e.toString());
      emit(UpdateLanguageError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }
}