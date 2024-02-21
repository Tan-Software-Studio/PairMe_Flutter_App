import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as imagePicker;
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/zego_chat/call/call_function.dart';
import 'package:pair_me/zego_chat/src/components/components.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';
import 'package:zego_zim/zego_zim.dart';

// import 'package:zego_zimkit/src/components/components.dart';
// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitMessageListPage extends StatefulWidget {
  const ZIMKitMessageListPage({
    Key? key,
    required this.conversationID,
    this.conversationType = ZIMConversationType.peer,
    this.appBarBuilder,
    this.appBarActions,
    // this.messageInputActions,
    this.onMessageSent,
    this.preMessageSending,
    this.inputDecoration,
    this.showPickFileButton = true,
    this.showPickMediaButton = true,
    this.editingController,
    this.messageListScrollController,
    this.onMessageItemPressed,
    this.onMessageItemLongPress,
    this.messageItemBuilder,
    this.messageContentBuilder,
    this.messageListErrorBuilder,
    this.messageListLoadingBuilder,
    this.messageListBackgroundBuilder,
    this.theme,
    this.onMediaFilesPicked,
    this.sendButtonWidget,
    this.pickMediaButtonWidget,
    this.pickFileButtonWidget,
    this.inputFocusNode,
    this.inputBackgroundDecoration,
    this.messageInputContainerPadding,
    this.messageInputContainerDecoration,
    this.messageInputKeyboardType,
    this.messageInputMaxLines,
    this.messageInputMinLines,
    this.messageInputTextInputAction,
    this.messageInputTextCapitalization,
  }) : super(key: key);

  /// this page's conversationID
  final String conversationID;

  /// this page's conversationType
  final ZIMConversationType conversationType;

  /// if you just want add some actions to the appBar, use [appBarActions].
  ///
  /// use it like this:
  /// appBarActions:[
  ///   IconButton(icon: const Icon(Icons.local_phone), onPressed: () {}),
  ///   IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
  /// ],
  final List<Widget>? appBarActions;

  // if you want customize the appBar, use appBarBuilder return your custom appBar
  // if you don't want use appBar, return null
  final AppBar? Function(BuildContext context, AppBar defaultAppBar)? appBarBuilder;

  /// To add your own action, use the [messageInputActions] parameter like this:
  ///
  /// use [messageInputActions] like this to add your custom actions:
  ///
  /// actions: [
  ///   ZIMKitMessageInputAction.left(
  ///     IconButton(icon: Icon(Icons.mic), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.leftInside(
  ///     IconButton(icon: Icon(Icons.sentiment_satisfied_alt_outlined), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.rightInside(
  ///     IconButton(icon: Icon(Icons.cabin), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.right(
  ///     IconButton(icon: Icon(Icons.sd), onPressed: () {})
  ///   ),
  /// ],
  // final List<ZIMKitMessageInputAction>? messageInputActions;

  /// Called when a message is sent.
  final void Function(ZIMKitMessage)? onMessageSent;

  /// Called before a message is sent.
  final FutureOr<ZIMKitMessage> Function(ZIMKitMessage)? preMessageSending;

  /// By default, [ZIMKitMessageInput] will show a button to pick file.
  /// If you don't want to show this button, set [showPickFileButton] to false.
  final bool showPickFileButton;

  /// By default, [ZIMKitMessageInput] will show a button to pick media.
  /// If you don't want to show this button, set [showPickMediaButton] to false.
  final bool showPickMediaButton;

  /// The TextField's decoration.
  final InputDecoration? inputDecoration;

  /// The [TextEditingController] to use.
  /// if not provided, a default one will be created.
  final TextEditingController? editingController;

  /// The [ScrollController] to use.
  /// if not provided, a default one will be created.
  final ScrollController? messageListScrollController;

  /// The default config is
  /// ```dart
  /// const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
  /// ```
  final EdgeInsetsGeometry? messageInputContainerPadding;

  /// The default config is
  /// ```dart
  /// BoxDecoration(
  ///   color: Theme.of(context).scaffoldBackgroundColor,
  ///   boxShadow: [
  ///     BoxShadow(
  ///       offset: const Offset(0, 4),
  ///       blurRadius: 32,
  ///       color: Theme.of(context).primaryColor.withOpacity(0.15),
  ///     ),
  ///   ],
  /// )
  /// ```
  final Decoration? messageInputContainerDecoration;

  /// default is TextInputType.multiline
  final TextInputType? messageInputKeyboardType;

  // default is 3
  final int? messageInputMaxLines;

  // default is 1
  final int? messageInputMinLines;

  // default is TextInputAction.newline
  final TextInputAction? messageInputTextInputAction;

  // default is TextCapitalization.sentences
  final TextCapitalization? messageInputTextCapitalization;

  final void Function(BuildContext context, ZIMKitMessage message, Function defaultAction)? onMessageItemPressed;
  final void Function(
          BuildContext context, LongPressStartDetails details, ZIMKitMessage message, Function defaultAction)?
      onMessageItemLongPress;
  final Widget Function(BuildContext context, ZIMKitMessage message, Widget defaultWidget)? messageItemBuilder;
  final Widget Function(BuildContext context, ZIMKitMessage message, Widget defaultWidget)? messageContentBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)? messageListErrorBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)? messageListLoadingBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)? messageListBackgroundBuilder;

  final void Function(BuildContext context, List<PlatformFile> files, Function defaultAction)? onMediaFilesPicked;

  // theme
  final ThemeData? theme;

  final Widget? sendButtonWidget;

  final Widget? pickMediaButtonWidget;

  final Widget? pickFileButtonWidget;

  final FocusNode? inputFocusNode;

  final BoxDecoration? inputBackgroundDecoration;

  @override
  State<ZIMKitMessageListPage> createState() => _ZIMKitMessageListPageState();
}

class _ZIMKitMessageListPageState extends State<ZIMKitMessageListPage> {
  TextEditingController editingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  bool showCard = false;
  bool emojiShowing = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme ?? Theme.of(context),
      child: Scaffold(
        // appBar: widget.appBarBuilder?.call(context, buildAppBar(context)) ?? buildAppBar(context),
        body: GestureDetector(
          onTap: () {
            if (showCard) {
              setState(() {
                showCard = false;
              });
            }
          },
          child: Column(
            children: [
              Opacity(
                opacity: showCard ? 0.5 : 1.0,
                child: Container(
                  // height: screenHeight(context, dividedBy: 9),
                  width: screenWidth(context),
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColor.skyBlue, AppColor.whiteskyBlue])),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth(context, dividedBy: 15),
                      right: screenWidth(context, dividedBy: 15),
                      top: screenHeight(context, dividedBy: 20),
                      bottom: screenHeight(context, dividedBy: 60),
                    ),
                    child: ValueListenableBuilder<ZIMKitConversation>(
                      valueListenable: ZIMKit().getConversation(
                        widget.conversationID,
                        widget.conversationType,
                      ),
                      builder: (context, conversation, child) {
                        return Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColor.white,
                                )),
                            SizedBox(width: screenWidth(context, dividedBy: 35)),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 17),
                              width: screenHeight(context, dividedBy: 17),
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, border: Border.all(color: AppColor.white, width: 1)),
                                    child: Container(
                                      height: screenHeight(context, dividedBy: 20),
                                      width: screenHeight(context, dividedBy: 20),
                                      decoration: const BoxDecoration(
                                          /*     image: DecorationImage(
                                            image: NetworkImage("${apis.baseurl}/${widget.image}"),
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high),*/
                                          shape: BoxShape.circle),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: conversation.icon,
                                    ),
                                  ),
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
                                  conversation.name,
                                  style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
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
                            conversation.name == 'Request'
                                ? const SizedBox()
                                : sendCallButton(
                                    isVideoCall: false,
                                    inviteeUsersIDTextCtrl: TextEditingController(text: conversation.id),
                                    onCallFinished: onSendCallInvitationFinished,
                                    name: conversation.name,
                                  ),
                            SizedBox(width: screenWidth(context, dividedBy: 25)),
                            conversation.name == 'Request'
                                ? const SizedBox()
                                : sendCallButton(
                                    isVideoCall: true,
                                    inviteeUsersIDTextCtrl: TextEditingController(text: conversation.id),
                                    onCallFinished: onSendCallInvitationFinished,
                                    name: conversation.name,
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              ZIMKitMessageListView(
                key: ValueKey(
                  'ZIMKitMessageListView:${Object.hash(
                    widget.conversationID,
                    widget.conversationType,
                  )}',
                ),
                conversationID: widget.conversationID,
                conversationType: widget.conversationType,
                onPressed: widget.onMessageItemPressed,
                itemBuilder: widget.messageItemBuilder,
                messageContentBuilder: widget.messageContentBuilder,
                onLongPress: widget.onMessageItemLongPress,
                loadingBuilder: widget.messageListLoadingBuilder,
                errorBuilder: widget.messageListErrorBuilder,
                scrollController: widget.messageListScrollController,
                theme: widget.theme,
                backgroundBuilder: widget.messageListBackgroundBuilder,
              ),
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
                          GestureDetector(
                            onTap: () async {
                              final imagePicker.XFile? image =
                                  await imagePicker.ImagePicker().pickImage(source: imagePicker.ImageSource.camera);

                              setState(() {
                                showCard = false;
                              });
                              if (image != null) {
                                PlatformFile platformFile = PlatformFile(
                                  name: image.name,
                                  path: image.path,
                                  size: await image.length(),
                                  bytes: await image.readAsBytes(),
                                );

                                /*   await ZIMKitCore.instance.sendMediaMessage(
                                  widget.conversationID,
                                  widget.conversationType,
                                  platformFile.path!,
                                  ZIMKit().getMessageTypeByFileExtension(platformFile),
                                  onMessageSent: widget.onMessageSent,
                                  preMessageSending: widget.preMessageSending,
                                );*/

                                void defaultAction() {
                                  ZIMKit().sendMediaMessage(
                                    widget.conversationID,
                                    widget.conversationType,
                                    [platformFile],
                                    onMessageSent: widget.onMessageSent,
                                    preMessageSending: widget.preMessageSending,
                                  );
                                }

                                if (widget.onMediaFilesPicked != null) {
                                  widget.onMediaFilesPicked!(context, [platformFile], defaultAction);
                                } else {
                                  defaultAction();
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context, dividedBy: 15),
                                  vertical: screenHeight(context, dividedBy: 100)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight(context, dividedBy: 17),
                                    width: screenWidth(context, dividedBy: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                          height: screenHeight(context, dividedBy: 40),
                                          width: screenWidth(context, dividedBy: 15),
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
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
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          GestureDetector(
                            onTap: () {
                              ZIMKit().pickFiles(type: FileType.media).then((value) {
                                void defaultAction() {
                                  ZIMKit().sendMediaMessage(
                                    widget.conversationID,
                                    widget.conversationType,
                                    value,
                                    onMessageSent: widget.onMessageSent,
                                    preMessageSending: widget.preMessageSending,
                                  );
                                  setState(() {
                                    showCard = false;
                                  });
                                }

                                if (widget.onMediaFilesPicked != null) {
                                  widget.onMediaFilesPicked!(context, value, defaultAction);
                                } else {
                                  defaultAction();
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context, dividedBy: 15),
                                  vertical: screenHeight(context, dividedBy: 100)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight(context, dividedBy: 17),
                                    width: screenWidth(context, dividedBy: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                          height: screenHeight(context, dividedBy: 40),
                                          width: screenWidth(context, dividedBy: 15),
                                          decoration: const BoxDecoration(
                                              image:
                                                  DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
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
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(height: 0),
                          GestureDetector(
                            onTap: () {
                              ZIMKit().pickFiles(type: FileType.any).then(
                                (value) {
                                  void defaultAction() {
                                    ZIMKit().sendFileMessage(
                                      widget.conversationID,
                                      widget.conversationType,
                                      value,
                                      onMessageSent: widget.onMessageSent,
                                      preMessageSending: widget.preMessageSending,
                                    );
                                  }

                                  setState(() {
                                    showCard = false;
                                  });
                                  if (widget.onMediaFilesPicked != null) {
                                    widget.onMediaFilesPicked!(context, value, defaultAction);
                                  } else {
                                    defaultAction();
                                  }
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context, dividedBy: 15),
                                  vertical: screenHeight(context, dividedBy: 100)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight(context, dividedBy: 17),
                                    width: screenWidth(context, dividedBy: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage('assets/Images/file.png'),
                                          height: screenHeight(context, dividedBy: 30),
                                          width: screenWidth(context, dividedBy: 15),
                                          color: const Color(0xff5D5D5D),
                                        ),
                                        SizedBox(
                                          width: screenWidth(context, dividedBy: 50),
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Container(
                padding:
                    widget.messageInputContainerPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: widget.messageInputContainerDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 32,
                          color: Theme.of(context).primaryColor.withOpacity(0.15),
                        ),
                      ],
                    ),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    right: screenWidth(context, dividedBy: 60),
                    left: screenWidth(context, dividedBy: 60),
                    top: screenHeight(context, dividedBy: 55),
                    bottom: screenHeight(context, dividedBy: 30),
                  ),
                  decoration:
                      BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(9), boxShadow: const [
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
                  child: TextFormField(
                    keyboardType: widget.messageInputKeyboardType ?? TextInputType.multiline,
                    focusNode: _focusNode,
                    maxLines: widget.messageInputMaxLines ?? 3,
                    minLines: widget.messageInputMaxLines ?? 1,
                    textInputAction: widget.messageInputTextInputAction ?? TextInputAction.newline,
                    textCapitalization: widget.messageInputTextCapitalization ?? TextCapitalization.sentences,
                    // focusNode: widget.inputFocusNode,
                    // onSubmitted: (value) => sendTextMessage(),
                    // onFieldSubmitted: (value) => sendTextMessage(),
                    controller: editingController,
                    onTap: () {
                      setState(() {
                        emojiShowing = false;
                        showCard = false;
                      });
                      // debugPrint("--- New done");
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message...',
                        hintStyle: const TextStyle(
                            color: Color(0xff888888), fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                        prefixIcon: IconButton(
                          splashRadius: 1,
                          style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
                          onPressed: sendTextMessage,
                          icon: Container(
                            height: screenHeight(context, dividedBy: 30),
                            width: screenWidth(context, dividedBy: 20),
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/Images/send.png'))),
                          ),
                        ),
                        suffixIcon: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                emojiShowing = !emojiShowing;
                                if (showCard) {
                                  showCard = false;
                                }
                                if (emojiShowing) {
                                  _focusNode.unfocus();
                                } else {
                                  _focusNode.requestFocus();
                                }
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: screenWidth(context, dividedBy: 40),
                                    left: screenWidth(context, dividedBy: 300)),
                                height: screenHeight(context, dividedBy: 30),
                                width: screenWidth(context, dividedBy: 20),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/Images/emoji.png'))),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showCard = !showCard;
                                });
                                /* showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: screenHeight(context, dividedBy: 10)),
                                            child: Container(
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
                                              child: Material(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                  ),
                                                  child: ,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );*/
                              },
                              child: Container(
                                height: screenHeight(context, dividedBy: 30),
                                width: screenWidth(context, dividedBy: 20),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/Images/pin.png'))),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        )),
                  ),
                ),
              ),
              Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        textEditingController: editingController,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: ValueListenableBuilder<ZIMKitConversation>(
        valueListenable: ZIMKit().getConversation(
          widget.conversationID,
          widget.conversationType,
        ),
        builder: (context, conversation, child) {
          const avatarNameFontSize = 16.0;
          return Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: conversation.icon,
              ),
              child!,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.name,
                    style: const TextStyle(
                      fontSize: avatarNameFontSize,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  // Text(conversation.id,
                  //     style: const TextStyle(fontSize: 12),
                  //     overflow: TextOverflow.clip)
                ],
              )
            ],
          );
        },
        child: const SizedBox(width: 20 * 0.75),
      ),
      actions: widget.appBarActions,
    );
  }

  Future<void> sendTextMessage() async {
    ZIMKit().sendTextMessage(
      widget.conversationID,
      widget.conversationType,
      editingController.text.trim(),
      onMessageSent: widget.onMessageSent,
      preMessageSending: widget.preMessageSending,
    );
    editingController.clear();
  }
}
