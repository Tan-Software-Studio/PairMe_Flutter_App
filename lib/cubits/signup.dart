import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/Screen_Pages/verification_code.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class SignUpState {}

class SignUpInitials extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitials());

  Future<void> signUpService(
      {required String email,
        required String firstname,
        required String lastname,
        required String gender,
        required String dob,
        required String phoneNumber,
        required String password,
        required String confirmPassword,
        required bool terms,
        required BuildContext context}) async {
    emit(SignUpLoading());
    final dio = Dio();
    Map<String, dynamic> body = {
        "firstName": firstname,
        "lastName": lastname,
        "gender": gender,
        "dateOfBirth":dob,
        "phoneNumber": phoneNumber,
        "countryCode": countryCodeSelect,
        "email": email,
        "teamsAndCondition": terms,
        "password": password,
        "confirmPassword": confirmPassword,
        "language":Language
    };
    print("Body is $body");
    try {
      final response = await dio.post(apis.signUp, data: jsonEncode(body));
      print("Response ===> ${response.data}");
      final hello = response.data;
      print(hello);
      if (hello['message'] == "Signup Successfully") {
        print("Response ===> ${response.data}");
        emit(SignUpSuccess());
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return  Verification_code(Forggot: false, Number: phoneNumber,);
        },));
        flutterToast(hello['message'], true);
      } else {
        emit(SignUpError());
        flutterToast(hello['message'], false);
      }
    } on Exception catch (e) {
      print("fail ====> " +e.toString());
      emit(SignUpError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }
}
//Signup Successfully