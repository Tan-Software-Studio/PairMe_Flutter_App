import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class UserUpdateState {}

class UserUpdateInitials extends UserUpdateState {}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateError extends UserUpdateState {}

class UserUpdateSuccess extends UserUpdateState {}

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit() : super(UserUpdateInitials());

  Future<void> UserUpdateService(
      {required File photo_1,
        required String firstname,
      required String lastname,
        required String gendar,
        required String dateofbirth,
        required String phonenumber,
        required String email,
        required BuildContext context}) async {
    emit(UserUpdateLoading());
    final dio = Dio();
    countryCodeSelect = countryCodeSelect.replaceAll('+', '');
    Map<String, dynamic> body = {
      "firstName": firstname,
      "lastName": lastname,
      "gender": gendar,
      "dateOfBirth": dateofbirth,
      "phoneNumber":phonenumber,
      "countryCode": countryCodeSelect.trim(),
      "email": email,
    };
    FormData formData = FormData();

    if(photo_1.path.isNotEmpty ){
      print("img 1");
      String? fileName = photo_1.path.split('/').last ;
      formData.files.add(
        MapEntry('photo_1', await MultipartFile.fromFile(photo_1.path ?? "", filename: fileName,contentType: MediaType("image", "jpeg"))),
      );
    }
   firstname.isNotEmpty ? formData.fields.add(MapEntry("firstName", firstname)) : null;
   lastname.isNotEmpty ? formData.fields.add(MapEntry("lastName", lastname)) : null;
   gendar.isNotEmpty ? formData.fields.add(MapEntry("gender", gendar)): null;
   dateofbirth.isNotEmpty ? formData.fields.add(MapEntry("dateOfBirth", dateofbirth)): null;
   phonenumber.isNotEmpty ? formData.fields.add(MapEntry("phoneNumber", phonenumber)): null;
   countryCodeSelect.isNotEmpty ? formData.fields.add(MapEntry("countryCode", countryCodeSelect.trim())): null;
   email.isNotEmpty ? formData.fields.add(MapEntry("email", email)): null;

    print("Body is ${formData.fields}");
    print("Body is ${formData.files}");
    try {
      final response = await dio.post(apis.userupdate,options:  Options(headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }) ,data: formData);
      print("Response ===> ${response.data}");
      final hello = response.data;
      print(hello);
      if (hello['message'] == "UserUpdate Successfully") {
        print("Response ===> ${response.data}");
        emit(UserUpdateSuccess());
        flutterToast(hello['message'], true);
      } else {
        emit(UserUpdateError());
        flutterToast(hello['message'], false);
      }
    } on Exception catch (e) {
      print("fail ====> " +e.toString());
      emit(UserUpdateError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }
}