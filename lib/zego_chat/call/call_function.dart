import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/constant.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> onUserLogin(id, name) async {
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: zegoCallAppID,
    appSign: zegoCallAppSign,
    userID: id,
    userName: name,
    plugins: [ZegoUIKitSignalingPlugin()],
    notificationConfig: ZegoCallInvitationNotificationConfig(
      androidNotificationConfig: ZegoAndroidNotificationConfig(
        channelID: "ZegoUIKit",
        channelName: "Call Notifications",
        sound: "call",
        icon: "call",
      ),
      iOSNotificationConfig: ZegoIOSNotificationConfig(
        systemCallingIconName: 'CallKitIcon',
      ),
    ),
    requireConfig: (ZegoCallInvitationData data) {
      final config = (data.invitees.length > 1)
          ? ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
              : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

      // config.avatarBuilder = customAvatarBuilder;

      /// support minimizing, show minimizing button
      config.topMenuBar.isVisible = true;
      config.topMenuBar.buttons.insert(0, ZegoCallMenuBarButtonName.minimizingButton);
      config.background = Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey.withGreen(100),
      );
      // config.avatarBuilder = customAvatarBuilder;
      config.useSpeakerWhenJoining = true;
      config.foreground = Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey.withGreen(100),
      );
      return config;
    },
  );
}

Widget sendCallButton({
  required bool isVideoCall,
  required TextEditingController inviteeUsersIDTextCtrl,
  required TextEditingController inviteeUsersNameTextCtrl,
  required String name,
  void Function(String code, String message, List<String>)? onCallFinished,
}) {
  return ValueListenableBuilder<TextEditingValue>(
    valueListenable: inviteeUsersIDTextCtrl,
    builder: (context, inviteeUserID, _) {
      final invitees = getInvitesFromTextCtrl(inviteeUsersIDTextCtrl.text.trim(), inviteeUsersNameTextCtrl.text.trim());

      return ZegoSendCallInvitationButton(
        timeoutSeconds: 600,
        isVideoCall: isVideoCall,
        invitees: invitees,
        resourceID: 'zego_data',
        iconSize: isVideoCall ? const Size(30, 30) : const Size(30, 30),
        icon: ButtonIcon(
            icon: Image(
          image: isVideoCall
              ? const AssetImage('assets/Images/videoCall.png')
              : const AssetImage('assets/Images/call.png'),
        )),
        buttonSize: const Size(30, 30),
        onPressed: onCallFinished,
      );
    },
  );
}

List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText, String textCtrlTextName) {
  List<ZegoUIKitUser> invitees = [];

  var inviteeIDs = textCtrlText.trim().replaceAll('，', '');
  var inviteeNames = textCtrlTextName.trim().replaceAll('，', '');
  inviteeIDs.split(",").forEach((inviteeUserID) {
    if (inviteeUserID.isEmpty) {
      return;
    }

    invitees.add(ZegoUIKitUser(
      id: inviteeUserID,
      name: inviteeNames,
    ));
  });

  return invitees;
}

void onSendCallInvitationFinished(String code, String message, List<String> errorInvitees) {
  if (errorInvitees.isNotEmpty) {
    var userIDs = '';
    for (var index = 0; index < errorInvitees.length; index++) {
      if (index >= 5) {
        userIDs += '... ';
        break;
      }
      final userID = errorInvitees.elementAt(index);
      userIDs += '$userID ';
    }
    if (userIDs.isNotEmpty) {
      userIDs = userIDs.substring(0, userIDs.length - 1);
    }
    var message = "User doesn't exist or is offline: $userIDs";
    if (code.isNotEmpty) {
      message += ', code: $code, message:$message';
      // toastMessage(message, AppColors.primaryColor);+
      debugPrint("message +++ $message");
    }
  } else if (code.isNotEmpty) {
    debugPrint("message --- $message");

    // toastMessage(message, AppColors.primaryColor);
  }
}

Widget customAvatarBuilder(
  BuildContext context,
  Size size,
  ZegoUIKitUser? user,
  Map<String, dynamic> extraInfo,
) {
  return CircleAvatar(
    radius: screenWidth(context, dividedBy: 2.5),
    backgroundColor: Colors.black12,
    child: Center(
      child: CircleAvatar(
        radius: screenWidth(context, dividedBy: 2.9),
        backgroundColor: Colors.black26,
        child: Center(
          child: Container(
            height: screenWidth(context, dividedBy: 1.75),
            width: screenWidth(context, dividedBy: 1.75),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: 'https://your_server/app/avatar/${user?.id}.png',
                // imageUrl: user,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) {
                  ZegoLoggerService.logInfo(
                    '$user avatar url is invalid',
                    tag: 'live audio',
                    subTag: 'live page',
                  );
                  return ZegoAvatar(user: user, avatarSize: size);
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
