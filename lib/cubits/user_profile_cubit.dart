import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/city&state.dart';
import 'package:pair_me/Modal/user_profile_modal.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class UserDetailsState {}

class UserDetailsInitials extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsError extends UserDetailsState {}

class UserDetailsSuccess extends UserDetailsState {}

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitials());
  UserProfile userProfile = UserProfile();
  final dio = Dio();
  Future<UserProfile?> GetUserdetails() async {
    emit(UserDetailsLoading());
    try {
      Response response = await dio.get(apis.UserProfile,options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }));
      log("response ===>$response");
      if(response.statusCode == 200 && response.data != null)
      {
        emit(UserDetailsSuccess());
        userProfile = UserProfile.fromJson(response.data);

        print("passs ==> ${userProfile.data?.first.bio}");
      }
      return userProfile;
    } on Exception catch (e) {
      emit(UserDetailsError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }
    return userProfile;
  }

}
