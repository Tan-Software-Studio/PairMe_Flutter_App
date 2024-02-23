import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/zego_chat/src/pages/message_list_page.dart';

abstract class MessageUserState {}

class MessageUserInitials extends MessageUserState {}

class MessageUserLoading extends MessageUserState {}

class MessageUserError extends MessageUserState {}

class MessageUserSuccess extends MessageUserState {}

class MessageUserCubit extends Cubit<MessageUserState> {
  MessageUserCubit() : super(MessageUserInitials());
  final dio = Dio();
  Future AcceptNotification(BuildContext context,
      {required String id, required String name, required String uid, required String img}) async {
    print("id ==> $id");
    print("id ==> $name");
    print("id ==> $uid");
    print("id ==> $img");
    emit(MessageUserLoading());
    try {
      Response response = await dio.get('${apis.messageUser}$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': Authtoken,
          }));
      print(response);
      final hello = response.data;
      print("hello ==> $hello");
      if (response.statusCode == 200 && response.data != null) {
        emit(MessageUserSuccess());
        debugPrint("**** Going chat page via connection");
        debugPrint("**** user id ==> $id");

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ZIMKitMessageListPage(
            name: 'chatting',
            conversationID: id,
            messageListBackgroundBuilder: (context, defaultWidget) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Background_Img(context),
                  defaultWidget,
                ],
              );
            },
          );
        }));

/*        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Chatting_Page(
              name: 'chatting',
              Username: name,
              image: img,
              id: id,
              uid: uid,
            );
          },
        ));*/
        //Msg_bottom_page
      }
      return null;
    } on Exception catch (e) {
      emit(MessageUserError());
      print("you are fully fail my friend" + e.toString());
      // TODO
    }
    return null;
  }
}
