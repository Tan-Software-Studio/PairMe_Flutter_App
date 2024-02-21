import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pair_me/cubits/translation_cubit.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';

// import 'package:zego_zimkit/src/components/messages/widgets/message_pointer.dart';
// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitTextMessage extends StatefulWidget {
  ZIMKitTextMessage({
    super.key,
    required this.message,
    this.onPressed,
    this.onLongPress,
  });

  final ZIMKitMessage message;
  final void Function(BuildContext context, ZIMKitMessage message, Function defaultAction)? onPressed;
  final void Function(
      BuildContext context, LongPressStartDetails details, ZIMKitMessage message, Function defaultAction)? onLongPress;

  @override
  State<ZIMKitTextMessage> createState() => _ZIMKitTextMessageState();
}

class _ZIMKitTextMessageState extends State<ZIMKitTextMessage> {
  TranslationCubit translationCubit = TranslationCubit();

  bool isTranslation = false;

  String translatedText = '';

  @override
  Widget build(BuildContext context) {
    final messageTime = widget.message.info != null
        ? DateTime.fromMillisecondsSinceEpoch(
            widget.message.info.timestamp,
          )
        : null;
    final timeOfMsg = defaultLastMessageTimeBuilder(messageTime);

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: widget.message.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => widget.onPressed?.call(context, widget.message, () {}),
            onLongPressStart: (details) => widget.onLongPress?.call(
              context,
              details,
              widget.message,
              () {
                Clipboard.setData(ClipboardData(text: widget.message.textContent!.text));
              },
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7, minWidth: 1),
              decoration: BoxDecoration(
                color: widget.message.isMine ? const Color(0xff437DFF) : const Color(0xffE8E8E8),
                borderRadius: widget.message.isMine
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(16), topRight: Radius.circular(16), topLeft: Radius.circular(16))
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(16), topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              ),
              // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 20, top: 10, bottom: 25),
                    child: Text(
                      isTranslation ? translatedText : widget.message.textContent!.text,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: widget.message.isMine ? Colors.white : const Color(0xff606164),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Text(
                      timeOfMsg.toString().toLowerCase(),
                      style: TextStyle(
                        color: widget.message.isMine ? Colors.white : const Color(0xff606164),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
              onTap: () async {
                //1122445566
                isTranslation = !isTranslation;
                var textData = await translationCubit.translationService(
                    context: context, text: widget.message.textContent!.text.trim());
                translatedText = textData;
                setState(() {});
              },
              splashColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6),
                child: Text(!isTranslation ? 'See translation' : 'See original',
                    style: const TextStyle(fontSize: 12, color: AppColor.skyBlue, fontWeight: FontWeight.w400)),
              ))
        ],
      ),
    );
  }
}

/*

Builder(builder: (context) {
final messageTime = conversation.lastMessage != null
? DateTime.fromMillisecondsSinceEpoch(
conversation.lastMessage!.info.timestamp,
)
    : null;
final defaultWidget = defaultLastMessageTimeBuilder(messageTime);
return lastMessageTimeBuilder?.call(
context,
messageTime,
defaultWidget,
) ??
defaultWidget;
}),*/
defaultLastMessageTimeBuilder(DateTime? messageTime) {
  String formattedDate = messageTime != "" ? DateFormat('h:mm a').format(messageTime!) : "";
  return formattedDate;
}

class TimeAgo {
  static String timeAgoSinceDate(DateTime currentTime, DateTime date, {bool numericDates = true}) {
    final difference = currentTime.difference(date);
    if (difference.inDays > 8) {
      return DateFormat.yMMMd().format(date);
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} h';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min.';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min.' : 'A min.';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec';
    } else {
      return 'Just now';
    }
  }
}
