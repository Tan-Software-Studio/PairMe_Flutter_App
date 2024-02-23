import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/zego_chat/zego_zimkit.dart';

// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitVideoMessagePreview extends StatelessWidget {
  const ZIMKitVideoMessagePreview(this.message, {Key? key}) : super(key: key);

  final ZIMKitMessage message;

  @override
  Widget build(BuildContext context) {
    final color = message.isMine ? Colors.white : const Color(0xff606164);
    return SizedBox(
      // height: message.videoContent!.videoFirstFrameHeight.toDouble(),
      // width: message.videoContent!.videoFirstFrameWidth.toDouble(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: message.videoContent!.videoFirstFrameLocalPath.isNotEmpty
                ? Image.file(
                    File(message.videoContent!.videoFirstFrameLocalPath),
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    key: ValueKey(message.info.messageID),
                    imageUrl: message.videoContent!.videoFirstFrameDownloadUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => Container(
                      color: color,
                      width: 160,
                      height: 90,
                      child: const Icon(Icons.error),
                    ),
                    placeholder: (context, url) => Container(
                      width: 160,
                      height: 90,
                      color: color,
                      child: const Icon(Icons.video_file_outlined),
                    ),
                  ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
