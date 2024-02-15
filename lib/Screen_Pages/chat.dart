import 'dart:developer';
import 'dart:io';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:custom_gallery_display/custom_gallery_display.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:pair_me/Screen_Pages/image_page.dart';
import 'package:pair_me/Screen_Pages/videocall.dart';
import 'package:pair_me/Screen_Pages/view_pdf.dart';
import 'package:pair_me/Screen_Pages/voice_call.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/cubits/accept_req_msg_user.dart';
import 'package:pair_me/cubits/block_req_msg_user.dart';
import 'package:pair_me/cubits/chatdata_cubits.dart';
import 'package:pair_me/cubits/delete_msg_users.dart';
import 'package:pair_me/cubits/reject_user.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';

class Chatting_Page extends StatefulWidget {
  String name, Username, image, id, uid;

  Chatting_Page({super.key,
    required this.name,
    required this.uid,
    required this.id,
    required this.Username,
    required this.image});

  @override
  State<Chatting_Page> createState() => _Chatting_PageState();
}

class _Chatting_PageState extends State<Chatting_Page> {
  ScrollController scrollController = ScrollController();
  final record = AudioRecorder();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  TextEditingController messageController = TextEditingController();
  RemoveMsgUserCubit removeMsgUserCubit = RemoveMsgUserCubit();
  AcceptReqMsgUserCubit acceptReqMsgUserCubit = AcceptReqMsgUserCubit();
  RejectUserCubit rejectUserCubit = RejectUserCubit();
  BlockUserCubit blockUserCubit = BlockUserCubit();
  ChatDataCubit chatDataCubit = ChatDataCubit();
  late ChatClient agoraChatClient;
  final List messageList = [];
  bool loading = false;
  bool showCard = false;
  bool emojiShowing = false;
  bool audioRecording = false;
  String recordFilePath = '';
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        await [Permission.microphone].request();
      }
    }
    return true;
  }

  Future<String> getFilePath() async {
    int i = 0;
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    i++;
    return "$sdPath/test_$i.mp3";
  }
  Future<void> _startRecording() async {
   await Permission.microphone.request();
      print("start");
      recordFilePath = await getFilePath();
      print("recording === $recordFilePath");
   await record.start(const RecordConfig(encoder: AudioEncoder.pcm16bits), path: recordFilePath);
     // final stream = await record.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
      // RecordMp3.instance.start(recordFilePath, (type) {
      //   setState(() {});
      // });
     audioRecording = true;
    setState(() {});
  }
  void stopRecord() async {
    setState(() {
      audioRecording = false;
    });
    print("stop");
    await record.stop();
   // RecordMp3.instance.stop();
    print("file===> $recordFilePath");
    var msg = ChatMessage.createVoiceSendMessage(
      targetId: widget.id,
      filePath: recordFilePath,
      chatType: ChatType.Chat,
    );
    ChatClient.getInstance.chatManager
        .addMessageEvent(
      "UNIQUE_HANDLER_ID",
      ChatMessageEvent(
        onSuccess: (msgId, msg) {
          ChatVoiceMessageBody body = msg.body as ChatVoiceMessageBody;
          print("voice ===> $body");
          messageList.add(displayvoiceMessage(isSentMessage: true, thumbnail: body.remotePath.toString(), dispalname: body.displayName.toString(),));
          setState(() {
            scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
          });
        },
        onProgress: (msgId, progress) {
          print(" ============================> $msgId");
        },
        onError: (msgId, msg, error) {
          print(" ============================> $error  === $msg");
        },
      ),
    );
    agoraChatClient.chatManager.sendMessage(msg);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatDataCubit = BlocProvider.of<ChatDataCubit>(context);
    setupChatClient();
    setupListeners();
    setState(() {});
  }

  @override
  void dispose() {
    ChatClient.getInstance.chatManager.removeEventHandler('UNIQUE_HANDLER_ID');
    ChatClient.getInstance.chatManager.removeMessageEvent('UNIQUE_HANDLER_ID');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.name == 'chatting'
          ? const SizedBox()
          : Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                blockUserCubit.AcceptNotification(id: widget.id)
                    .then((value) => Navigator.pop(context, "refresh"));
                // rejectUserCubit.GetRejectUser(id: widget.id).then((value) => );
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight(context, dividedBy: 40)),
                height: screenHeight(context, dividedBy: 20),
                width: screenWidth(context, dividedBy: 3.7),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.fontgray,
                        offset: Offset(
                          0,
                          4,
                        ),
                        blurRadius: 11,
                        spreadRadius: 0.0,
                      ),
                    ]),
                child: Text(
                  'Block'.tr(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      color: Color(0xffFF0000)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                removeMsgUserCubit.DeleteReqUser(context, id: widget.id)
                    .then((value) => Navigator.pop(context, "refresh"));
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight(context, dividedBy: 40)),
                height: screenHeight(context, dividedBy: 20),
                width: screenWidth(context, dividedBy: 3.7),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.fontgray,
                        offset: Offset(
                          0,
                          4,
                        ),
                        blurRadius: 11,
                        spreadRadius: 0.0,
                      ),
                    ]),
                child: Text(
                  'Delete'.tr(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      color: Color(0xffFF0000)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                acceptReqMsgUserCubit.AcceptNotification(
                    context, id: widget.id);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight(context, dividedBy: 40)),
                height: screenHeight(context, dividedBy: 20),
                width: screenWidth(context, dividedBy: 3.7),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.fontgray,
                        offset: Offset(
                          0,
                          4,
                        ),
                        blurRadius: 11,
                        spreadRadius: 0.0,
                      ),
                    ]),
                child: Text(
                  'Accept'.tr(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      color: Color(0xff1D1D1D)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          children: [
            Background_Img(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight(context, dividedBy: 9),
                  width: screenWidth(context),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColor.skyBlue, AppColor.whiteskyBlue])),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth(context, dividedBy: 15),
                      right: screenWidth(context, dividedBy: 15),
                      top: screenHeight(context, dividedBy: 25),
                      bottom: screenHeight(context, dividedBy: 60),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColor.white,
                            )),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 35),
                        ),
                        SizedBox(
                          height: screenHeight(context, dividedBy: 17),
                          width: screenHeight(context, dividedBy: 17),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: screenHeight(context, dividedBy: 20),
                                width: screenHeight(context, dividedBy: 20),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${apis.baseurl}/${widget.image}"
                                        ),
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high),
                                    border: Border.all(
                                        color: AppColor.white, width: 1),
                                    shape: BoxShape.circle),
                              ),
                              widget.name == 'Request'
                                  ? const SizedBox()
                                  : Positioned(
                                  bottom: 3.0,
                                  left: 3.0,
                                  child: Container(
                                    height: screenHeight(context,
                                        dividedBy: 80),
                                    width: screenHeight(context,
                                        dividedBy: 80),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff04D364),
                                        border: Border.all(
                                            color: AppColor.white,
                                            width: 1),
                                        shape: BoxShape.circle),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 95),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.Username,
                              style: const TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto'),
                            ),
                            widget.name == 'Request'
                                ? Text(
                              'Just Joined'.tr(),
                              style: const TextStyle(
                                  color: AppColor.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto'),
                            )
                                : Text(
                              'online'.tr(),
                              style: const TextStyle(
                                  color: AppColor.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto'),
                            ),
                          ],
                        ),
                        const Spacer(),
                        widget.name == 'Request'
                            ? const SizedBox()
                            : GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return VoiceCallPage(
                                  img: "${apis.baseurl}/${widget.image}",);
                              },
                            ));
                          },
                          child: Image(
                            image: const AssetImage(
                                'assets/Images/call.png'),
                            height: screenHeight(context, dividedBy: 40),
                            width: screenHeight(context, dividedBy: 40),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 25),
                        ),
                        widget.name == 'Request'
                            ? const SizedBox()
                            : GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const VideoCallPage();
                              },
                            ));
                          },
                          child: Image(
                            image: const AssetImage(
                                'assets/Images/videoCall.png'),
                            height: screenHeight(context, dividedBy: 35),
                            width: screenHeight(context, dividedBy: 30),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                loading ? Expanded(
                  child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          itemBuilder: (_, index) {
                            return messageList[index];
                          },
                          itemCount: messageList.length,
                        ),
                ) : Expanded(child: customLoader()),
                showCard
                    ? Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 15),
                  ),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1,
                            1,
                          ),
                          blurRadius: 4,
                          spreadRadius: 0.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            screenWidth(context, dividedBy: 15),
                            vertical:
                            screenHeight(context, dividedBy: 100)),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(CupertinoDialogRoute(
                                builder: (context) => CustomGalleryDisplay.instagramDisplay(
                                    displaySource: DisplaySource.camera,
                                    pickerSource: PickerSource.image,
                                    multiSelection: true,
                                    cropImage: false,
                                    galleryDisplaySettings: GalleryDisplaySettings(
                                      appTheme: AppTheme(
                                          primaryColor: Colors.black, focusColor: Colors.white),
                                    ),
                                    onDone: (SelectedImagesDetails details) async {
                                      print("details ==>${details.selectedFiles.first.selectedFile.path}");
                                      var msg = ChatMessage.createImageSendMessage(
                                        targetId: widget.id,
                                        filePath: details.selectedFiles.first.selectedFile.path,
                                        sendOriginalImage: true,
                                        chatType: ChatType.Chat,
                                      );
                                      ChatClient.getInstance.chatManager
                                          .addMessageEvent(
                                        "UNIQUE_HANDLER_ID",
                                        ChatMessageEvent(
                                          onSuccess: (msgId, msg) {
                                            ChatImageMessageBody body = msg.body as ChatImageMessageBody;
                                            displayimgMessage(body.remotePath, true);
                                            setState(() {
                                              scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
                                            });
                                          },
                                          onProgress: (msgId, progress) {
                                            print(" ============================> $msgId");
                                          },
                                          onError: (msgId, msg, error) {
                                            print(" ============================> $error  === $msg");
                                          },
                                        ),
                                      );
                                      agoraChatClient.chatManager.sendMessage(msg);
                                      setState(() {});
                                      Navigator.pop(context);
                                    }),
                                context: context));
                          },
                          child: SizedBox(
                            height:
                            screenHeight(context, dividedBy: 17),
                            width: screenWidth(context, dividedBy: 1.2),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth(context,
                                          dividedBy: 40)),
                                  height: screenHeight(context,
                                      dividedBy: 40),
                                  width: screenWidth(context,
                                      dividedBy: 15),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/Images/camera.png'))),
                                ),
                                const Text(
                                  'Camera',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dropdownfont),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            screenWidth(context, dividedBy: 15),
                            vertical:
                            screenHeight(context, dividedBy: 100)),
                        child: GestureDetector(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context, builder: (context) {
                              return MediaPicker(
                                onPicked: (selectedList) {
                                  if(selectedList.single.file!.path.endsWith(".mp4")){
                                    print("video  ===> ${selectedList.first.file!.path}");
                                    var msg = ChatMessage.createVideoSendMessage(
                                      targetId: widget.id,
                                      filePath: selectedList.first.file!.path,
                                      chatType: ChatType.Chat,
                                    );
                                    ChatClient.getInstance.chatManager
                                        .addMessageEvent(
                                      "UNIQUE_HANDLER_ID",
                                      ChatMessageEvent(
                                        onSuccess: (msgId, msg) {
                                          ChatImageMessageBody body = msg.body as ChatImageMessageBody;
                                        //  displayimgMessage(body.remotePath, true);
                                        //   setState(() {
                                        //     scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
                                        //   });
                                        },
                                        onProgress: (msgId, progress) {
                                          print(" ============================> $msgId");
                                        },
                                        onError: (msgId, msg, error) {
                                          print("error ============================> $error  === $msg");
                                        },
                                      ),
                                    );
                                    agoraChatClient.chatManager.sendMessage(msg);
                                  }else{
                                    print("image");
                                    var msg = ChatMessage.createImageSendMessage(
                                      targetId: widget.id,
                                      filePath: selectedList.first.file!.path,
                                      thumbnailLocalPath: selectedList.first.thumbnail.toString(),
                                      sendOriginalImage: true,
                                      chatType: ChatType.Chat,
                                    );
                                    ChatClient.getInstance.chatManager
                                        .addMessageEvent(
                                      "UNIQUE_HANDLER_ID",
                                      ChatMessageEvent(
                                        onSuccess: (msgId, msg) {
                                          ChatImageMessageBody body = msg.body as ChatImageMessageBody;
                                          displayimgMessage(body.remotePath, true);
                                          setState(() {
                                            scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
                                          });
                                        },
                                        onProgress: (msgId, progress) {
                                          print(" ============================> $msgId");
                                        },
                                        onError: (msgId, msg, error) {
                                          print(" ============================> $error  === $msg");
                                        },
                                      ),
                                    );
                                    agoraChatClient.chatManager.sendMessage(msg);

                                  }

                                },
                                onCancel: () => print('Canceled'),
                                mediaCount: MediaCount.single,
                                decoration: PickerDecoration(),
                                mediaList: const [],
                              );
                            },);
                          },
                          child: SizedBox(
                            height:
                            screenHeight(context, dividedBy: 17),
                            width: screenWidth(context, dividedBy: 1.2),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth(context,
                                          dividedBy: 40)),
                                  height: screenHeight(context,
                                      dividedBy: 40),
                                  width: screenWidth(context,
                                      dividedBy: 15),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/Images/placeholder.png'))),
                                ),
                                const Text(
                                  'Photos & Videos',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dropdownfont),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            screenWidth(context, dividedBy: 15),
                            vertical:
                            screenHeight(context, dividedBy: 100)),
                        child: GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                            await FilePicker
                                .platform
                                .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'pdf',
                                'doc'
                              ],
                            );
                            print("fille1 ======> " + result!.count.toString());
                            var msg = ChatMessage.createFileSendMessage(
                              targetId: widget.id,
                              filePath: result.files[0].path!,
                              fileSize: 5000,
                              chatType: ChatType.Chat,
                            );
                            ChatClient.getInstance.chatManager
                                .addMessageEvent(
                              "UNIQUE_HANDLER_ID",
                              ChatMessageEvent(
                                onSuccess: (msgId, msg) {
                                  ChatImageMessageBody body = msg.body as ChatImageMessageBody;
                                  //  displayimgMessage(body.remotePath, true);
                                  //   setState(() {
                                  //     scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
                                  //   });
                                },
                                onProgress: (msgId, progress) {
                                  print(" ============================> $msgId");
                                },
                                onError: (msgId, msg, error) {
                                  print("error ============================> $error  === $msg");
                                },
                              ),
                            );
                            agoraChatClient.chatManager.sendMessage(msg);
                            setState(() {});
                          },
                          child: SizedBox(
                            height:
                            screenHeight(context, dividedBy: 17),
                            width: screenWidth(context, dividedBy: 1.2),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/Images/file.png'),
                                  height: screenHeight(context,
                                      dividedBy: 30),
                                  width: screenWidth(context,
                                      dividedBy: 15),
                                  color: const Color(0xff5D5D5D),
                                ),
                                SizedBox(
                                  width: screenWidth(context,
                                      dividedBy: 50),
                                ),
                                const Text(
                                  'Document',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dropdownfont),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : const SizedBox(),
                widget.name == 'Request'
                    ? const SizedBox()
                    : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    right: screenWidth(context, dividedBy: 15),
                    left: screenWidth(context, dividedBy: 15),
                    bottom: screenHeight(context, dividedBy: 30),
                    top: screenHeight(context, dividedBy: 55),
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1,
                            1,
                          ),
                          blurRadius: 4,
                          spreadRadius: 0.0,
                        ),
                      ]),
                  child: TextField(
                    onTap: () {
                      emojiShowing = false;
                      setState(() {});
                    },
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message...',
                        hintStyle: const TextStyle(
                            color: Color(0xff888888),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400),
                        prefixIcon: IconButton(
                          splashRadius: 1,
                          style: const ButtonStyle(
                              overlayColor: MaterialStatePropertyAll(
                                  Colors.transparent)),
                          onPressed: sendMessage,
                         // onPressed:() async => await ChatClient.getInstance.chatManager.deleteRemoteConversation(widget.id),
                          icon: Container(
                            height: screenHeight(context, dividedBy: 30),
                            width: screenWidth(context, dividedBy: 20),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/Images/send.png'))),
                          ),
                        ),
                        suffixIcon: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                emojiShowing = !emojiShowing;
                                FocusManager.instance.primaryFocus
                                    ?.unfocus();
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: screenWidth(context,
                                        dividedBy: 40),
                                    left: screenWidth(context,
                                        dividedBy: 300)),
                                height:
                                screenHeight(context, dividedBy: 30),
                                width:
                                screenWidth(context, dividedBy: 20),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/emoji.png'))),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showCard = !showCard;
                                });
                              },
                              child: Container(
                                height:
                                screenHeight(context, dividedBy: 30),
                                width:
                                screenWidth(context, dividedBy: 20),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/pin.png'))),
                              ),
                            ),
                            audioRecording ? GestureDetector(
                              onTap: () => stopRecord(),
                              child: Container(
                                margin: EdgeInsets.only(
                                    right:
                                    screenWidth(context, dividedBy: 30),
                                    left: screenWidth(context,
                                        dividedBy: 40)),
                                height:
                                screenHeight(context, dividedBy: 30),
                                width: screenWidth(context, dividedBy: 30),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/recording.png'))),
                              ) ,
                            ) :
                            GestureDetector(
                              onTap: () => _startRecording(),
                              child: Container(
                                margin: EdgeInsets.only(
                                    right:
                                    screenWidth(context, dividedBy: 30),
                                    left: screenWidth(context,
                                        dividedBy: 40)),
                                height:
                                screenHeight(context, dividedBy: 30),
                                width: screenWidth(context, dividedBy: 30),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/mic.png'))),
                              ) ,
                            )
                          ],
                        )),
                  ),
                ),
                Offstage(
                    offstage: !emojiShowing,
                    child: SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          textEditingController: messageController,
                        ))),
              ],
            ),
          ],
        ),
      ),
    ) ;
  }
  void setupChatClient() async {
    print("id===> ${widget.id}");
    print("id===> ${widget.uid}");
    ChatOptions options = ChatOptions(
      appKey: AgoraAppkey,
      autoLogin: false,
    );
    agoraChatClient = ChatClient.getInstance;
    await agoraChatClient.init(options);
    await ChatClient.getInstance.startCallback();
    try {
      await agoraChatClient.login(widget.uid, "123");
      print("Logged in successfully as ${widget.uid}");

    } on ChatError catch (e) {
      if (e.code == 200) {
        // Already logged in
      } else {
        print("Login failed, code: ${e.code}, desc: ${e.description}");
      }
    }
    Getdata();
  }
  void setupListeners() {
    agoraChatClient.addConnectionEventHandler(
      "CONNECTION_HANDLER",
      ConnectionEventHandler(
          onConnected: onConnected,
          onDisconnected: onDisconnected,
          onTokenWillExpire: onTokenWillExpire,
          onTokenDidExpire: onTokenDidExpire),
    );

    agoraChatClient.
    chatManager.addEventHandler(
      "MESSAGE_HANDLER",
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );
    setState(() {});
  }
  void onMessagesReceived(List<ChatMessage> messages) {
    log("message ===>? $messages");
    for (var msg in messages) {
      if (msg.to == widget.uid && msg.from == widget.id) {
        print("message ====> ${msg.to}");
        if (msg.body.type == MessageType.TXT) {
          ChatTextMessageBody body = msg.body as ChatTextMessageBody;
          displayMessage(body.content, false);
          setState(() {
            scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
          });
         // showLog("Message from ${msg.from}");
        } else if(msg.body.type == MessageType.IMAGE){
          ChatImageMessageBody body = msg.body as ChatImageMessageBody;
          displayimgMessage(body.remotePath, false);
          setState(() {
            scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
          });
         // showLog("Message from ${msg.from}");
        }else{
          String msgType = msg.body.type.name;
          log("Received $msgType message, from ${msg}");
        }
      }
    }
  }
  void onTokenWillExpire() {
    // The token is about to expire. Get a new token
    // from the token server and renew the token.
  }
  void onTokenDidExpire() {
    // The token has expired
  }
  void onDisconnected() {
    // Disconnected from the Chat server
  }
  void onConnected() {
    print("Connected");
  }
  void displayMessage(String text, bool isSentMessage) {
    messageList.add(Row(
      mainAxisAlignment:
      isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
                top: screenHeight(context, dividedBy: 100),
                right: isSentMessage == false ? screenWidth(context, dividedBy: 5) : 15,
                left: isSentMessage ? screenWidth(context, dividedBy: 5) : 15),
            decoration: BoxDecoration(
                borderRadius: isSentMessage
                    ? const BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                    topLeft: Radius.circular(26))
                    : const BorderRadius.only(
                    bottomRight: Radius.circular(26),
                    topRight: Radius.circular(26),
                    topLeft: Radius.circular(26)),
                color: isSentMessage ? AppColor.skyBlue : AppColor.gray),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 30),
                  vertical: screenWidth(context, dividedBy: 50)),
              child: Column(
                crossAxisAlignment: isSentMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if(text.length >= 25 )...[
                    Text(text,style: TextStyle(
                        fontSize: 17,
                        // height: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: isSentMessage
                            ? AppColor.white
                            : AppColor.dropdownfont),),
                    Text('01:32 pm',style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: isSentMessage
                            ? AppColor.white
                            : AppColor.dropdownfont),),
                  ]else ...[
                     RichText(text: TextSpan(
                      children: [
                        TextSpan(text: text, style:
                        TextStyle(
                            fontSize: 17,
                            // height: 1,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: isSentMessage
                                ? AppColor.white
                                : AppColor.dropdownfont)
                        ),
                        TextSpan(text:'   ', style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: isSentMessage
                                ? AppColor.white
                                : AppColor.dropdownfont),),
                        TextSpan(text: '01:32 PM', style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: isSentMessage
                                ? AppColor.white
                                : AppColor.dropdownfont),),
                      ],

                    ))
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    ));

  }
  void displayimgMessage(final thumbnail, bool isSentMessage) {
    messageList.add(InkWell(
      onTap: () =>  Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Image_Screen(
            image: thumbnail,
          );
        },
      )),
      child: Row(
        mainAxisAlignment:
        isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              //alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  top: screenHeight(context, dividedBy: 100),
                  right: 15,
                  left: isSentMessage ? screenWidth(context, dividedBy: 7) : 15),
              //width: screenWidth(context, dividedBy: 1.5),
              decoration: BoxDecoration(
                  borderRadius: isSentMessage
                      ? const BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                      topLeft: Radius.circular(26))
                      : const BorderRadius.only(
                      bottomRight: Radius.circular(26),
                      topRight: Radius.circular(26),
                      topLeft: Radius.circular(26)),
                  color: isSentMessage ? AppColor.skyBlue : AppColor.gray),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: isSentMessage
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: screenHeight(context, dividedBy: 5),
                      width: screenWidth(context, dividedBy: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(thumbnail), fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(height: 3,),
                    Text(
                      '01:32 PM',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: isSentMessage
                              ? AppColor.white
                              : AppColor.dropdownfont),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
    // setState(() {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
    // });
  }
  void displayvideoMessage(final thumbnail, bool isSentMessage) {
    // VideoPlayerController _controller = VideoPlayerController.network(thumbnail)
    //   ..initialize();
    // setState(() {
    //   _controller.setVolume(0);
    //    _controller.pause();
    //   _controller.setLooping(true);
    // });
    messageList.add(InkWell(
      onTap: () =>  Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Image_Screen(
            image: thumbnail,
          );
        },
      )),
      child: Row(
        mainAxisAlignment:
        isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                  top: screenHeight(context, dividedBy: 100),
                  right: 15,
                  left: isSentMessage ? screenWidth(context, dividedBy: 7) : 15),
              decoration: BoxDecoration(
                  borderRadius: isSentMessage
                      ? const BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                      topLeft: Radius.circular(26))
                      : const BorderRadius.only(
                      bottomRight: Radius.circular(26),
                      topRight: Radius.circular(26),
                      topLeft: Radius.circular(26)),
                  color: isSentMessage ? AppColor.skyBlue : AppColor.gray),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: isSentMessage
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: screenHeight(context, dividedBy: 5),
                      width: screenWidth(context, dividedBy: 2),
                       child: // _controller.value.isInitialized
                      //     ?
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: VideoPlayer(VideoPlayerController.network(thumbnail)
                              ..initialize()),
                          ),
                          const Center(child: CircleAvatar(backgroundColor: Colors.black54,child: Icon(Icons.play_arrow,color: Colors.white,)),)
                        ],
                      )
                         // : Center(child: customLoader(),),
                    ),
                    const SizedBox(height: 3,),
                    Text(
                      '01:32 PM',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: isSentMessage
                              ? AppColor.white
                              : AppColor.dropdownfont),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
    // setState(() {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
    // });
  }
  void displayfileMessage(final thumbnail,String dispalname, bool isSentMessage) {
    messageList.add(InkWell(
      onTap: () {
        print("thumbnail ===> $thumbnail");
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) {
                return Pdfview(
                    pdfUrl:
                    thumbnail);
              },
            ));
      },
      child: Row(
        mainAxisAlignment:
        isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            //alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
                top: screenHeight(context, dividedBy: 100),
                right: 15,
                left: isSentMessage ? screenWidth(context, dividedBy: 7) : 15
                ),
            width: screenWidth(context, dividedBy: 2.1),
            decoration: BoxDecoration(
                borderRadius: isSentMessage
                    ? const BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                    topLeft: Radius.circular(26))
                    : const BorderRadius.only(
                    bottomRight: Radius.circular(26),
                    topRight: Radius.circular(26),
                    topLeft: Radius.circular(26)),
                color: isSentMessage ? AppColor.skyBlue : AppColor.gray),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context,dividedBy: 40),
                vertical: screenHeight(context,dividedBy: 100)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Image(image: AssetImage("assets/Images/file.png"),height: 30,width: 30,color: Colors.white,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: isSentMessage ? CrossAxisAlignment.end :CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth(context,dividedBy: 3),
                          child: Text(dispalname,maxLines: 1,style: TextStyle(
                              fontSize: 17,
                              overflow: TextOverflow.ellipsis,
                              // height: 1,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: isSentMessage
                                  ? AppColor.white
                                  : AppColor.dropdownfont),)),
                      Text(
                        '01:32 PM',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: isSentMessage
                                ? AppColor.white
                                : AppColor.dropdownfont),
                      )
                    ],
                  ),
                )
              ],),
            ),
          ),
        ],
      ),
    ));
    // setState(() {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
    // });
  }

  void sendMessage() async {
    print("call me");
    if (messageController.text.isNotEmpty) {
      var msg = ChatMessage.createTxtSendMessage(

        targetId: widget.id,
        content: messageController.text,
        chatType: ChatType.Chat,
      );
      ChatClient.getInstance.chatManager.addMessageEvent(
        "UNIQUE_HANDLER_ID",
        ChatMessageEvent(

          onSuccess: (msgId, msg) {
            print(" ============================> $msgId");
            print(" ============================> $msg");
            print(msg);
            displayMessage(messageController.text, true);
            scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
            messageController.clear();
            setState(() {});
            // messageBoxController.clear();
            // _addLogToConsole("on message succeed");
          },
          onProgress: (msgId, progress) {
            print(" ============================> $msgId");
            //_addLogToConsole("on message progress");
          },
          onError: (msgId, msg, error) {
            print(" ============================> $error  === $msg");
            // _addLogToConsole(
            //   "on message failed, code: ${error.code}, desc: ${error.description}",
            // );
          },
        ),
      );
      // ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
      agoraChatClient.chatManager.sendMessage(msg);

    }
  }
  Future Getdata() async {
    final result =
    await ChatClient.getInstance.chatManager.fetchHistoryMessages(
       conversationId: widget.id,
      pageSize: 50
    );
    setState(() {
      loading = true;
    });
    log("data ===> ${result.data}");
    for(int i=0;i < result.data.length;i++){
      if(result.data[i].body.type == MessageType.TXT){
        ChatTextMessageBody body = result.data[i].body as ChatTextMessageBody;
        displayMessage(body.content,result.data[i].from == widget.uid ? true : false);
      }
      if(result.data[i].body.type == MessageType.IMAGE){
        ChatImageMessageBody body = result.data[i].body as ChatImageMessageBody;
        displayimgMessage(body.remotePath, result.data[i].from == widget.uid ? true : false);
      }
      if(result.data[i].body.type == MessageType.VIDEO){
         ChatVideoMessageBody body = result.data[i].body as ChatVideoMessageBody;
        displayvideoMessage(body.remotePath, result.data[i].from == widget.uid ? true : false);
        print('data ===> $body');
      }
      if(result.data[i].body.type == MessageType.FILE){
         ChatFileMessageBody body = result.data[i].body as ChatFileMessageBody;
        displayfileMessage(body.remotePath,body.displayName.toString() ,result.data[i].from == widget.uid ? true : false);
      }
      if(result.data[i].body.type == MessageType.VOICE){
        ChatVoiceMessageBody body = result.data[i].body as ChatVoiceMessageBody;
        print("voice ===> $body");
        messageList.add(displayvoiceMessage(isSentMessage: result.data[i].from == widget.uid ? true : false, thumbnail: body.remotePath.toString(), dispalname: body.displayName.toString(),));
       // displayvoiceMessage(body.remotePath,body.displayName.toString() ,result.data[i].from == widget.uid ? true : false);
      }
    }
  }
}
class displayvoiceMessage extends StatefulWidget {
  String thumbnail,dispalname;
  bool isSentMessage;
   displayvoiceMessage({super.key,required this.isSentMessage,required this.thumbnail,required this.dispalname});

  @override
  State<displayvoiceMessage> createState() => _displayvoiceMessageState();
}

class _displayvoiceMessageState extends State<displayvoiceMessage> {
  final player = FlutterSoundPlayer();

  bool play = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      widget.isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          //alignment: Alignment.centerRight,
          margin: EdgeInsets.only(
              top: screenHeight(context, dividedBy: 100),
              right: 15,
              left: widget.isSentMessage ? screenWidth(context, dividedBy: 7) : 15
          ),
          width: screenWidth(context, dividedBy: 2.1),
          decoration: BoxDecoration(
              borderRadius: widget.isSentMessage
                  ? const BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                  topLeft: Radius.circular(26))
                  : const BorderRadius.only(
                  bottomRight: Radius.circular(26),
                  topRight: Radius.circular(26),
                  topLeft: Radius.circular(26)),
              color: widget.isSentMessage ? AppColor.skyBlue : AppColor.gray),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context,dividedBy: 40),
                vertical: screenHeight(context,dividedBy: 100)
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                play ?
                InkWell(onTap: () async {
                  print("pause");
                  setState(() {
                    play = false;
                  });
                   await player.closePlayer();
                }, child: const Icon(Icons.pause,color: Colors.black)) :
                InkWell(onTap: () async {
                  print("play");
                  setState(() {
                    play = true;
                  });
                  await player.startPlayer(fromURI: widget.thumbnail);
                }, child: const Icon(Icons.play_arrow,color: Colors.black,)),
                Text(widget.dispalname,maxLines: 1,style: TextStyle(
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                    // height: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    color: widget.isSentMessage
                        ? AppColor.white
                        : AppColor.dropdownfont),),
                SizedBox(width: screenWidth(context,dividedBy: 80),),
                Text(
                  '01:32 PM',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: widget.isSentMessage
                          ? AppColor.white
                          : AppColor.dropdownfont),
                )
                // const Image(image: AssetImage("assets/Images/file.png"),height: 30,width: 30,color: Colors.white,),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: widget.isSentMessage ? CrossAxisAlignment.end :CrossAxisAlignment.start,
                //     children: [
                //
                //
                //     ],
                //   ),
                // )
              ],),
          ),
        ),
      ],
    );
  }
}





