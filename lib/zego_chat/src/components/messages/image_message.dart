import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/image_page.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';

// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitImageMessage extends StatelessWidget {
  const ZIMKitImageMessage({
    super.key,
    required this.message,
    this.onPressed,
    this.onLongPress,
  });

  final ZIMKitMessage message;

  final void Function(
    BuildContext context,
    ZIMKitMessage message,
    Function defaultAction,
  )? onPressed;

  final void Function(
    BuildContext context,
    LongPressStartDetails details,
    ZIMKitMessage message,
    Function defaultAction,
  )? onLongPress;

  @override
  Widget build(BuildContext context) {
    final messageTime = message.info != null
        ? DateTime.fromMillisecondsSinceEpoch(
            message.info.timestamp,
          )
        : null;

    final timeOfMsg = defaultLastMessageTimeBuilder(messageTime);

    final color = message.isMine ? Colors.white : const Color(0xff606164).withOpacity(0.5);

    return Flexible(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Image_Screen(
              image: message.isNetworkUrl
                  ? message.imageContent!.fileDownloadUrl
                  : message.imageContent!.largeImageDownloadUrl,
              name: 'image',
            );
          }));
        },
        child: AspectRatio(
          aspectRatio: message.imageContent!.aspectRatio,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  message.isMine
                      ? FutureBuilder(
                          future: File(message.imageContent!.fileLocalPath).exists(),
                          builder: (context, snapshot) {
                            return snapshot.hasData && (snapshot.data! as bool)
                                ? Container(
                                    height: message.imageContent!.originalImageHeight.toDouble(),
                                    width: message.imageContent!.originalImageWidth.toDouble(),
                                    color: color,
                                    child: Image.file(
                                      File(message.imageContent!.fileLocalPath),
                                      cacheHeight: constraints.maxHeight.floor(),
                                      cacheWidth: constraints.maxWidth.floor(),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    height: message.imageContent!.originalImageHeight.toDouble(),
                                    width: message.imageContent!.originalImageWidth.toDouble(),
                                    imageUrl: message.isNetworkUrl
                                        ? message.imageContent!.fileDownloadUrl
                                        : message.imageContent!.largeImageDownloadUrl,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) =>
                                        Container(color: color, child: const Icon(Icons.image_not_supported_outlined)),
                                    placeholder: (context, url) =>
                                        Container(color: color, child: const Icon(Icons.image_outlined)),
                                    memCacheHeight: constraints.maxHeight.floor(),
                                    memCacheWidth: constraints.maxWidth.floor(),
                                  );
                          },
                        )
                      : CachedNetworkImage(
                          height: message.imageContent!.originalImageHeight.toDouble(),
                          width: message.imageContent!.originalImageWidth.toDouble(),
                          imageUrl: message.isNetworkUrl
                              ? message.imageContent!.fileDownloadUrl
                              : message.imageContent!.largeImageDownloadUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) =>
                              Container(color: color, child: const Icon(Icons.image_not_supported_outlined)),
                          placeholder: (context, url) =>
                              Container(color: color, child: const Icon(Icons.image_outlined)),
                          memCacheHeight: constraints.maxHeight.floor(),
                          memCacheWidth: constraints.maxWidth.floor(),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Text(
                      timeOfMsg.toString().toLowerCase(),
                      style: TextStyle(
                        color: message.isMine ? Colors.white : const Color(0xff606164),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  defaultLastMessageTimeBuilder(DateTime? messageTime) {
    String formattedDate = messageTime != "" ? DateFormat('h:mm a').format(messageTime!) : "";
    return formattedDate;
  }
}
