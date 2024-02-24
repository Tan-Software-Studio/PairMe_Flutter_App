import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/Step_Screens.dart';
import 'package:pair_me/Screen_Pages/bottom_bar/home_screen.dart';
import 'package:pair_me/Screen_Pages/creat_new_password.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';


abstract class LoginState {}

class LoginInitials extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitials());

  Future<void> LoginService(
      {required String phoneNumber,
        required String otp,
        required BuildContext context}) async {
    emit(LoginLoading());
    final dio = Dio();
    SharedPrefsService prefsService = SharedPrefsService();
    Map<String, dynamic> body = {
      "phoneNumber": phoneNumber,
      "countryCode": countryCodeSelect,
      "password": otp,
    };
    // print("Body is $body");
    try {
      Response response = await dio.post(apis.Login, data: jsonEncode(body));
      final hello = response.data;
      print(hello);
      if (hello['message'] == 'Login Successfully') {
        print("Response ===> ${response.data}");
        emit(LoginSuccess());
        Authtoken = "Bearer ${hello['Token']}";
        prefsService.setStringData("Authtoken", Authtoken);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home_screen(),), (route) => false);
        flutterToast(hello['message'], true);
      } else {
        emit(LoginError());
        flutterToast(hello['message'], false);
      }
    } on Exception catch (e) {
      print("fail ====> $e");
      emit(LoginError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }
}