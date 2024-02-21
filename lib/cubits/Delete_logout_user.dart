import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/city&state.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/cubits/signup.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';


abstract class DeleteUserState {}

class DeleteUserInitials extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserError extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {}

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitials());
  final dio = Dio();
  Future<CityandState?> DeleteService(BuildContext context) async {
    emit(DeleteUserLoading());
    try {
      Response response = await dio.get(apis.delete_user,options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }));
      print("Response ===> ${response.data}");
      final hello = response.data;
      if(hello['code'] == 200 && hello['message'] == "user is deleted")
      {
        emit(DeleteUserSuccess());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return  Login_page();
        },), (route) => false);
      }
      return CityandState.fromJson(response.data);
    } on Exception catch (e) {
      emit(DeleteUserError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }

  }

}

abstract class LogoutUserState {}

class LogoutUserInitials extends LogoutUserState {}

class LogoutUserLoading extends LogoutUserState {}

class LogoutUserError extends LogoutUserState {}

class LogoutUserSuccess extends LogoutUserState {}

class LogoutUserCubit extends Cubit<LogoutUserState> {
  LogoutUserCubit() : super(LogoutUserInitials());
  final dio = Dio();
  SignUpCubit signUpCubit = SignUpCubit();
  SharedPrefsService prefsService = SharedPrefsService();

  Future<CityandState?> LogoutService(BuildContext context) async {
    emit(LogoutUserLoading());
    try {
      Response response = await dio.get(apis.logout,options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }));
      print(response);
      if(response.statusCode == 200 && response.data != null)
      {
        await signUpCubit.signOutGoogle();
        await signUpCubit.signOutFacebook();
        prefsService.clearAll();
        emit(LogoutUserSuccess());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return  Login_page();
        },), (route) => false);
        print("passs");

      }
      return CityandState.fromJson(response.data);
    } on Exception catch (e) {
      emit(LogoutUserError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }

  }

}

