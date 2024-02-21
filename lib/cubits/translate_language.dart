import 'dart:convert';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class TranslatLanguageState {}

class TranslatLanguageInitials extends TranslatLanguageState {}

class TranslatLanguageLoading extends TranslatLanguageState {}

class TranslatLanguageError extends TranslatLanguageState {}

class TranslatLanguageSuccess extends TranslatLanguageState {}

class TranslatLanguageCubit extends Cubit<TranslatLanguageState> {
  TranslatLanguageCubit() : super(TranslatLanguageInitials());

  Future<String?> TranslatLanguageService(
      {required String array, required BuildContext context}) async {
    emit(TranslatLanguageLoading());
    final dio = Dio();
    String data = '';
    final body = {
      "text": array,
    };
    print("Body is $body");
    try {
      final response = await dio.post(apis.translation,options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }) ,data: jsonEncode(body));
      final hello = response.data;
      data = hello['data'];
      return data;
    } on Exception catch (e) {
      print("fail ====> " +e.toString());
      emit(TranslatLanguageError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }
}
