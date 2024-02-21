import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';

abstract class TranslationState {}

class TranslationInitials extends TranslationState {}

class TranslationLoading extends TranslationState {}

class TranslationError extends TranslationState {}

class TranslationSuccess extends TranslationState {}

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(TranslationInitials());

  translationService({required String text, required BuildContext context}) async {
    emit(TranslationLoading());
    final dio = Dio();
    Map<String, dynamic> body = {"text": text};
    // print("Body is $body");
    try {
      final response = await dio.post(apis.translation,
          data: jsonEncode(body),
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': Authtoken,
          }));
      // print("Response ===> ${response.data}");

      if (response.statusCode == 200) {
        emit(TranslationSuccess());
        debugPrint("Translation response --- ${response.data['data']}");
        return response.data['data'];
      } else {
        return text;
      }
    } on Exception catch (e) {
      print("fail ====> $e");
      emit(TranslationError());
      flutterToast("Something went wrong!", false);
    }
  }

  Future<void> changeLanguage({
    required String language,
  }) async {
    emit(TranslationLoading());
    final dio = Dio();
    Map<String, dynamic> body = {
      "language": language,
    };
    print("Body is $body");
    try {
      final response = await dio.post(apis.languageUpdate,
          data: jsonEncode(body),
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': Authtoken,
          }));
      final hello = response.data;
      print(hello);
      if (hello['status'] == true) {
        print("Response ===> ${response.data}");
        emit(TranslationSuccess());
        flutterToast(hello['message'], true);
      } else {
        emit(TranslationError());
        flutterToast(hello['message'], false);
      }
    } on Exception catch (e) {
      emit(TranslationError());
      flutterToast("Something went wrong!", false);
    }
  }
}
