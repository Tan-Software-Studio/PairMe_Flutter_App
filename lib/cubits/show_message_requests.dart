import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/alluserprofile.dart';
import 'package:pair_me/Modal/message_request.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';


abstract class AllMessageRequestState {}

class AllMessageRequestInitials extends AllMessageRequestState {}

class AllMessageRequestLoading extends AllMessageRequestState {}

class AllMessageRequestError extends AllMessageRequestState {}

class AllMessageRequestSuccess extends AllMessageRequestState {}

class AllMessageRequestCubit extends Cubit<AllMessageRequestState> {
  AllMessageRequestCubit() : super(AllMessageRequestInitials());
  final dio = Dio();
  UserMssageReq userMssageReq = UserMssageReq();
 // AllMessageRequest AllMessageRequest = AllMessageRequest();
  Future GetAllMessageRequest() async {
    emit(AllMessageRequestLoading());
    try {
      Response response = await dio.get(apis.showmsgrequst,options:  Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': Authtoken,
      }));
      log("response ====> $response");
      final hello = response.data;
      print("hello ==> $hello");
      if(hello['data'] != null)
      {
        userMssageReq = UserMssageReq.fromJson(response.data);
        emit(AllMessageRequestSuccess());
        print("passs");
      } else {
        emit(AllMessageRequestError());
      }
      return userMssageReq;
    } on Exception catch (e) {
      emit(AllMessageRequestError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }
    return null;
  }

}
