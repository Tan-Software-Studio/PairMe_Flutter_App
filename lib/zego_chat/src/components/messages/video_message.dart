import 'package:flutter/material.dart';
import 'package:pair_me/zego_chat/src/components/messages/video_message_player.dart';
import 'package:pair_me/zego_chat/src/components/messages/video_message_preview.dart';
import 'package:pair_me/zego_chat/src/services/logger_service.dart';
import 'package:pair_me/zego_chat/zego_zimkit.dart';
// import 'package:zego_zimkit/src/components/messages/video_message_player.dart';
// import 'package:zego_zimkit/src/components/messages/video_message_preview.dart';
// import 'package:zego_zimkit/src/services/logger_service.dart';
// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitVideoMessage extends StatelessWidget {
  const ZIMKitVideoMessage({
    Key? key,
    this.onPressed,
    this.onLongPress,
    required this.message,
  }) : super(key: key);

  final ZIMKitMessage message;
  final void Function(BuildContext context, ZIMKitMessage message, Function defaultAction)? onPressed;
  final void Function(
      BuildContext context, LongPressStartDetails details, ZIMKitMessage message, Function defaultAction)? onLongPress;

  void _onPressed(BuildContext context, ZIMKitMessage msg) {
    void defaultAction() => playVideo(context);
    if (onPressed != null) {
      onPressed!.call(context, msg, defaultAction);
    } else {
      defaultAction();
    }
  }

  void _onLongPress(
    BuildContext context,
    LongPressStartDetails details,
    ZIMKitMessage msg,
  ) {
    void defaultAction() {
      // TODO popup menu
    }
    if (onLongPress != null) {
      onLongPress!.call(context, details, msg, defaultAction);
    } else {
      defaultAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => _onPressed(context, message),
        onLongPressStart: (details) => _onLongPress(context, details, message),
        child: message.info.sentStatus == ZIMMessageSentStatus.sending
            ? Container(
                color: const Color(0xff606164).withOpacity(0.5),
                height: 220,
                width: 160,
                child: Center(
                  child: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        value: message.videoContent!.uploadProgress?.transferredSize.toDouble()),
                  ),
                ),
              )
            : ZIMKitVideoMessagePreview(
                message,
                key: ValueKey(message.info.messageID),
              ),
      ),
    );
  }

  void playVideo(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => ZIMKitVideoMessagePlayer(message, key: ValueKey(message.info.messageID)),
    ).closed.then((value) {
      ZIMKitLogger.fine('ZIMKitVideoMessage: playVideo end');
    });
  }
}
