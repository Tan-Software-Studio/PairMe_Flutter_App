import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> onUserLogin(id, name) async {
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 1908055129,
    appSign: 'e66dbfca5b08399304f3ab30e6e925cf29813aaf39cf19d13b91f73accf05be9',
    userID: id,
    userName: name,
    plugins: [
      ZegoUIKitSignalingPlugin(),
    ],
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

      config.avatarBuilder = customAvatarBuilder;

      /// support minimizing, show minimizing button
      config.topMenuBar.isVisible = true;
      config.topMenuBar.buttons.insert(0, ZegoCallMenuBarButtonName.minimizingButton);

      return config;
    },
  );
}

Widget sendCallButton({
  required bool isVideoCall,
  required TextEditingController inviteeUsersIDTextCtrl,
  required String name,
  void Function(String code, String message, List<String>)? onCallFinished,
}) {
  return ValueListenableBuilder<TextEditingValue>(
    valueListenable: inviteeUsersIDTextCtrl,
    builder: (context, inviteeUserID, _) {
      final invitees = getInvitesFromTextCtrl(inviteeUsersIDTextCtrl.text.trim());

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

List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
  List<ZegoUIKitUser> invitees = [];

  var inviteeIDs = textCtrlText.trim().replaceAll('，', '');
  inviteeIDs.split(",").forEach((inviteeUserID) {
    if (inviteeUserID.isEmpty) {
      return;
    }

    invitees.add(ZegoUIKitUser(
      id: inviteeUserID,
      name: 'user_$inviteeUserID',
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
      debugPrint("message +++ ${message}");
    }
  } else if (code.isNotEmpty) {
    debugPrint("message --- ${message}");

    // toastMessage(message, AppColors.primaryColor);
  }
}

Widget customAvatarBuilder(
  BuildContext context,
  Size size,
  ZegoUIKitUser? user,
  Map<String, dynamic> extraInfo,
) {
  return CachedNetworkImage(
    imageUrl: 'https://robohash.org/${user?.id}.png',
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
  );
}
