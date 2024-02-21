import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitFileMessage extends StatelessWidget {
  const ZIMKitFileMessage({
    Key? key,
    required this.message,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final ZIMKitMessage message;
  final void Function(BuildContext context, ZIMKitMessage message, Function defaultAction)? onPressed;
  final void Function(
      BuildContext context, LongPressStartDetails details, ZIMKitMessage message, Function defaultAction)? onLongPress;

  Future<String> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final directory = await getDownloadsDirectory();
      final filePath = '${directory!.path}/${DateTime.now().microsecondsSinceEpoch}.${url.split(".").last}';
      debugPrint("hsfhkdhk$filePath");
      // final File pdfFile = File(filePath);
      // await pdfFile.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to load PDF: ${response.statusCode}');
    }
  }

  downloadPDF({required String url}) async {
    try {
      // showLoadingDialog();
      var data = await Permission.storage.request();
      var test = await Permission.manageExternalStorage.request();
      var progress;
      var response = await Dio().get(
        url,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            progress = "${(received / total * 100).toStringAsFixed(0)}%";
            if (progress == '100%') {
              // toastMessage(
              //   text: "PDF downloaded successfully".tr,
              // );
            }
          }
        },
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("code----${response.statusCode}");
      final directory = await getExternalStorageDirectory();
      File file = File("${directory!.path}/${url.split("_").last}");
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      OpenFile.open("${directory.path}/${url.split("_").last}");
    } catch (e) {
      // toastMessage(text: "Somthing went wrong!", color: AppColors.redColor);
      flutterToast('Something went wrong!', true);
      print(e);
    } finally {
      // hideLoadingDialog();
    }
  }

  Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      flutterToast("Couldn't launch URL", true);
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = message.isMine ? Colors.white : const Color(0xff606164);
    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: message.isMine ? Colors.white : const Color(0xff606164),
    );
    final messageTime = message.info != null
        ? DateTime.fromMillisecondsSinceEpoch(
            message.info.timestamp,
          )
        : null;
    final timeOfMsg = defaultLastMessageTimeBuilder(messageTime);

    return Flexible(
      child: GestureDetector(
        // onTap: () => onPressed?.call(context, message, () {}),
        onTap: () async {
          // /*  String path1 = */ await downloadPDF(url: message.fileContent!.fileDownloadUrl);

          debugPrint("file download url --- ${message.fileContent!.fileDownloadUrl}");
          String? path = await downloadFile(message.fileContent!.fileDownloadUrl);
          debugPrint("Open file====$path");
          try {
            var res = await OpenFile.open(path);
            if (res.type == ResultType.noAppToOpen ||
                res.type == ResultType.fileNotFound ||
                res.type == ResultType.permissionDenied) {
              launchInBrowser(message.fileContent!.fileDownloadUrl);
            }
          } catch (e) {
            debugPrint("enter in catch");

            launchInBrowser(message.fileContent!.fileDownloadUrl);
          }
        },
        onLongPressStart: (details) => onLongPress?.call(context, details, message, () {}),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          decoration: BoxDecoration(
            color: message.isMine ? const Color(0xff437DFF).withOpacity(0.5) : const Color(0xffE8E8E8).withOpacity(0.5),
            borderRadius: message.isMine
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(16), topRight: Radius.circular(16), topLeft: Radius.circular(16))
                : const BorderRadius.only(
                    bottomRight: Radius.circular(16), topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: message.isMine ? const Color(0xff437DFF) : const Color(0xffE8E8E8),
                  borderRadius: message.isMine
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(14), topRight: Radius.circular(14), topLeft: Radius.circular(14))
                      : const BorderRadius.only(
                          bottomRight: Radius.circular(14),
                          topRight: Radius.circular(14),
                          topLeft: Radius.circular(14)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.file_copy, color: color, size: 17),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: message.isNetworkUrl
                            ? [
                                Text(message.fileContent!.fileName,
                                    style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                              ]
                            : [
                                Text(message.fileContent!.fileName,
                                    style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text(
                                  fileSizeFormat(message.fileContent!.fileSize),
                                  style: textStyle,
                                  maxLines: 1,
                                ),
                              ],
                      ),
                    ),
                    Icon(Icons.download, color: color),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
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
        ),
      ),
    );
  }

  String fileSizeFormat(int size) {
    if (size < 1024) {
      return '$size B';
    } else if (size < 1024 * 1024) {
      return '${(size / 1024).ceil()} KB';
    } else if (size < 1024 * 1024 * 1024) {
      return '${(size / 1024 / 1024).ceil()} MB';
    } else {
      return '${(size / 1024 / 1024 / 1024).ceil()} GB';
    }
  }

  defaultLastMessageTimeBuilder(DateTime? messageTime) {
    String formattedDate = messageTime != "" ? DateFormat('h:mm a').format(messageTime!) : "";
    return formattedDate;
  }
}
