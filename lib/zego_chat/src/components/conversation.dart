import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';
import 'package:zego_zim/zego_zim.dart';
// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitConversationWidget extends StatelessWidget {
  const ZIMKitConversationWidget({
    Key? key,
    required this.conversation,
    required this.onPressed,
    this.lastMessageTimeBuilder,
    this.lastMessageBuilder,
    required this.onLongPress,
  }) : super(key: key);

  final ZIMKitConversation conversation;

  // ui builder
  final Widget Function(
    BuildContext context,
    DateTime? messageTime,
    Widget defaultWidget,
  )? lastMessageTimeBuilder;

  final Widget Function(
    BuildContext context,
    ZIMKitMessage? message,
    Widget defaultWidget,
  )? lastMessageBuilder;

  // event
  final Function(BuildContext context) onPressed;
  final Function(
    BuildContext context,
    LongPressStartDetails longPressDetails,
  ) onLongPress;

  @override
  Widget build(BuildContext context) {
    final screenWidths = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onPressed(context),
      onLongPressStart: (longPressDetails) => onLongPress(
        context,
        longPressDetails,
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: AppColor.skyBlue)),
                      content: const Text(
                        'Do you want to delete this conversation?',
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ZIMKit().deleteConversation(conversation.id, conversation.type);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: const Color(0xFF2E6FFF),
              foregroundColor: Colors.white,
              icon: Icons.delete_forever_sharp,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: min(screenWidths / 10, 20),
            vertical: 10,
          ),
          child: SizedBox(
            // margin: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 15)),
            height: screenHeight(context, dividedBy: 12),
            width: screenHeight(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight(context, dividedBy: 15),
                  width: screenHeight(context, dividedBy: 15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // image: DecorationImage(image: NetworkImage("${list[index]["image"]}"),fit: BoxFit.cover)
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: conversation.icon,
                ),
                SizedBox(width: screenWidth(context, dividedBy: 30)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth(context, dividedBy: 40)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.name.isNotEmpty ? conversation.name : conversation.id,

                        // userMessage.data?.data?[index].userName ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
                      ),
                      // SizedBox(height: screenHeight(context, dividedBy: 400)),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 2.2),
                        child: Builder(builder: (context) {
                          final defaultWidget = defaultLastMessageBuilder(
                            conversation.lastMessage,
                          );
                          return lastMessageBuilder?.call(
                                context,
                                conversation.lastMessage,
                                defaultWidget,
                              ) ??
                              defaultWidget;
                        }),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth(context, dividedBy: 40)),
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (conversation.lastMessage != null)
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
                          }),
                        conversation.unreadMessageCount != 0
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                width: 20,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  gradient: LinearGradient(
                                    colors: [Color(0xff2E6FFF), Color(0xff6D9AFF)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${conversation.unreadMessageCount > 9999 ? '9999+' : conversation.unreadMessageCount}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget defaultLastMessageBuilder(ZIMKitMessage? message) {
    if (message == null) {
      return const SizedBox.shrink();
    }

    ///-last message
    return Opacity(
      opacity: 0.64,
      child: Text(
        // message.toStringValue(),
        message.type == ZIMMessageType.text
            ? message.toStringValue()
            : message.type == ZIMMessageType.file
                ? message.fileContent!.fileName
                : message.type == ZIMMessageType.image
                    ? "Photo"
                    : message.type == ZIMMessageType.video
                        ? "Video"
                        : "Media",
        maxLines: 1,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
          color: Color(0xff6C6C6C),
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget defaultLastMessageTimeBuilder(DateTime? messageTime) {
    final msgTime = messageTime != "" ? DateFormat('h:mm a').format(messageTime!) : "";
    bool isData = DateFormat("MMMM dd yyyy").format(messageTime!) == DateFormat("MMMM dd yyyy").format(DateTime.now());
    return Opacity(
      opacity: 0.64,
      child: Text(
          isData
              ? msgTime.toLowerCase()
              : DateFormat("MMMM dd yyyy").format(DateTime.now().subtract(const Duration(days: 1))) ==
                      DateFormat("MMMM dd yyyy").format(messageTime)
                  ? "Yesterday"
                  : DateFormat("MMM d, yyyy").format(messageTime),
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12)),
    );
  }
}
