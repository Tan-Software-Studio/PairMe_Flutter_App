// import 'dart:async';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:pair_me/helper/App_Colors.dart';
// import 'package:pair_me/helper/Size_page.dart';
// import 'package:pair_me/zego_chat/src/components/messages/widgets/pick_file_button.dart';
// import 'package:pair_me/zego_chat/src/components/messages/widgets/pick_media_button.dart';
// import 'package:pair_me/zego_chat/src/services/services.dart';
// import 'package:zego_zim/zego_zim.dart';
//
// // import 'package:zego_zimkit/src/components/components.dart';
// // import 'package:zego_zimkit/src/services/services.dart';
// bool showCard = false;
//
// class ZIMKitMessageInput extends StatefulWidget {
//   const ZIMKitMessageInput({
//     Key? key,
//     required this.conversationID,
//     this.conversationType = ZIMConversationType.peer,
//     this.onMessageSent,
//     this.preMessageSending,
//     this.editingController,
//     this.showPickFileButton = true,
//     this.showPickMediaButton = true,
//     this.actions = const [],
//     this.inputDecoration,
//     this.theme,
//     this.onMediaFilesPicked,
//     this.sendButtonWidget,
//     this.pickMediaButtonWidget,
//     this.pickFileButtonWidget,
//     this.inputFocusNode,
//     this.inputBackgroundDecoration,
//     this.containerPadding,
//     this.containerDecoration,
//     this.keyboardType,
//     this.maxLines,
//     this.minLines,
//     this.textInputAction,
//     this.textCapitalization,
//   }) : super(key: key);
//
//   /// The conversationID of the conversation to send message.
//   final String conversationID;
//
//   /// The conversationType of the conversation to send message.
//   final ZIMConversationType conversationType;
//
//   /// By default, [ZIMKitMessageInput] will show a button to pick file.
//   /// If you don't want to show this button, set [showPickFileButton] to false.
//   final bool showPickFileButton;
//
//   /// By default, [ZIMKitMessageInput] will show a button to pick media.
//   /// If you don't want to show this button, set [showPickMediaButton] to false.
//   final bool showPickMediaButton;
//
//   /// To add your own action, use the [actions] parameter like this:
//   ///
//   /// use [actions] like this to add your custom actions:
//   ///
//   /// actions: [
//   ///   ZIMKitMessageInputAction.left(IconButton(
//   ///     icon: Icon(
//   ///       Icons.mic,
//   ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
//   ///     ),
//   ///     onPressed: () {},
//   ///   )),
//   ///   ZIMKitMessageInputAction.leftInside(IconButton(
//   ///     icon: Icon(
//   ///       Icons.sentiment_satisfied_alt_outlined,
//   ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
//   ///     ),
//   ///     onPressed: () {},
//   ///   )),
//   ///   ZIMKitMessageInputAction.rightInside(IconButton(
//   ///     icon: Icon(
//   ///       Icons.cabin,
//   ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
//   ///     ),
//   ///     onPressed: () {},
//   ///   )),
//   ///   ZIMKitMessageInputAction.right(IconButton(
//   ///     icon: Icon(
//   ///       Icons.sd,
//   ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
//   ///     ),
//   ///     onPressed: () {},
//   ///   )),
//   /// ],
//   final List<ZIMKitMessageInputAction>? actions;
//
//   /// Called when a message is sent.
//   final void Function(ZIMKitMessage)? onMessageSent;
//
//   /// Called before a message is sent.
//   final FutureOr<ZIMKitMessage> Function(ZIMKitMessage)? preMessageSending;
//
//   final void Function(BuildContext context, List<PlatformFile> files, Function defaultAction)? onMediaFilesPicked;
//
//   /// The TextField's decoration.
//   final InputDecoration? inputDecoration;
//
//   /// The [TextEditingController] to use. if not provided, a default one will be created.
//   final TextEditingController? editingController;
//
//   // theme
//   final ThemeData? theme;
//
//   final Widget? sendButtonWidget;
//
//   final Widget? pickMediaButtonWidget;
//
//   final Widget? pickFileButtonWidget;
//
//   final FocusNode? inputFocusNode;
//
//   final BoxDecoration? inputBackgroundDecoration;
//
//   /// The default config is
//   /// ```dart
//   /// const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
//   /// ```
//   final EdgeInsetsGeometry? containerPadding;
//
//   /// The default config is
//   /// ```dart
//   /// BoxDecoration(
//   ///   color: Theme.of(context).scaffoldBackgroundColor,
//   ///   boxShadow: [
//   ///     BoxShadow(
//   ///       offset: const Offset(0, 4),
//   ///       blurRadius: 32,
//   ///       color: Theme.of(context).primaryColor.withOpacity(0.15),
//   ///     ),
//   ///   ],
//   /// )
//   /// ```
//   final Decoration? containerDecoration;
//
//   /// default is TextInputType.multiline
//   final TextInputType? keyboardType;
//
//   // default is 3
//   final int? maxLines;
//
//   // default is 1
//   final int? minLines;
//
//   // default is TextInputAction.newline
//   final TextInputAction? textInputAction;
//
//   // default is TextCapitalization.sentences
//   final TextCapitalization? textCapitalization;
//
//   @override
//   State<ZIMKitMessageInput> createState() => _ZIMKitMessageInputState();
// }
//
// bool emojiShowing = false;
//
// class _ZIMKitMessageInputState extends State<ZIMKitMessageInput> {
//   // TODO RestorableTextEditingController
//   final TextEditingController _defaultEditingController = TextEditingController();
//
//   TextEditingController get _editingController => widget.editingController ?? _defaultEditingController;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: widget.theme ?? Theme.of(context),
//       child: Container(
//         padding: widget.containerPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: widget.containerDecoration ??
//             BoxDecoration(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               boxShadow: [
//                 BoxShadow(
//                   offset: const Offset(0, 4),
//                   blurRadius: 32,
//                   color: Theme.of(context).primaryColor.withOpacity(0.15),
//                 ),
//               ],
//             ),
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       // ...buildActions(ZIMKitMessageInputActionLocation.left),
//                       const SizedBox(width: 5),
//                       Expanded(
//                         child: Row(
//                           children: [
//                             /*                 ...buildActions(
//                               ZIMKitMessageInputActionLocation.leftInside,
//                             ),
//                             const SizedBox(width: 5),*/
//                             Expanded(
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 margin: EdgeInsets.only(
//                                   right: screenWidth(context, dividedBy: 60),
//                                   left: screenWidth(context, dividedBy: 60),
//                                   top: screenHeight(context, dividedBy: 55),
//                                 ),
//                                 decoration: BoxDecoration(
//                                     color: AppColor.white,
//                                     borderRadius: BorderRadius.circular(9),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.grey,
//                                         offset: Offset(
//                                           1,
//                                           1,
//                                         ),
//                                         blurRadius: 4,
//                                         spreadRadius: 0.0,
//                                       ),
//                                     ]),
//                                 child: TextField(
//                                   keyboardType: widget.keyboardType ?? TextInputType.multiline,
//                                   maxLines: widget.maxLines ?? 3,
//                                   minLines: widget.minLines ?? 1,
//                                   textInputAction: widget.textInputAction ?? TextInputAction.newline,
//                                   textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
//                                   focusNode: widget.inputFocusNode,
//                                   onSubmitted: (value) => sendTextMessage(),
//                                   controller: _editingController,
//                                   decoration: widget.inputDecoration ??
//                                       InputDecoration(
//                                           border: InputBorder.none,
//                                           hintText: 'Message...',
//                                           hintStyle: const TextStyle(
//                                               color: Color(0xff888888),
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w400),
//                                           prefixIcon: IconButton(
//                                             splashRadius: 1,
//                                             style: const ButtonStyle(
//                                                 overlayColor: MaterialStatePropertyAll(Colors.transparent)),
//                                             onPressed: sendTextMessage,
//                                             icon: Container(
//                                               height: screenHeight(context, dividedBy: 30),
//                                               width: screenWidth(context, dividedBy: 20),
//                                               decoration: const BoxDecoration(
//                                                   image: DecorationImage(image: AssetImage('assets/Images/send.png'))),
//                                             ),
//                                           ),
//                                           suffixIcon: Wrap(
//                                             crossAxisAlignment: WrapCrossAlignment.center,
//                                             runAlignment: WrapAlignment.center,
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   emojiShowing = !emojiShowing;
//                                                   FocusManager.instance.primaryFocus?.unfocus();
//                                                   setState(() {});
//                                                 },
//                                                 child: Container(
//                                                   margin: EdgeInsets.only(
//                                                       right: screenWidth(context, dividedBy: 40),
//                                                       left: screenWidth(context, dividedBy: 300)),
//                                                   height: screenHeight(context, dividedBy: 30),
//                                                   width: screenWidth(context, dividedBy: 20),
//                                                   decoration: const BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage('assets/Images/emoji.png'))),
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 10),
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     showCard = !showCard;
//                                                   });
//                                                 },
//                                                 child: Container(
//                                                   height: screenHeight(context, dividedBy: 30),
//                                                   width: screenWidth(context, dividedBy: 20),
//                                                   decoration: const BoxDecoration(
//                                                       image:
//                                                           DecorationImage(image: AssetImage('assets/Images/pin.png'))),
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 10),
//
//                                               /*      Container(
//                                                 margin: EdgeInsets.only(
//                                                     right: screenWidth(context, dividedBy: 30),
//                                                     left: screenWidth(context, dividedBy: 40)),
//                                                 height: screenHeight(context, dividedBy: 30),
//                                                 width: screenWidth(context, dividedBy: 30),
//                                                 decoration: const BoxDecoration(
//                                                     image: DecorationImage(image: AssetImage('assets/Images/mic.png'))),
//                                               ),*/
//                                             ],
//                                           )),
//                                 ),
//                               ),
//                             ),
//                             ValueListenableBuilder<TextEditingValue>(
//                               valueListenable: _editingController,
//                               builder: (context, textEditingValue, child) {
//                                 return Builder(
//                                   builder: (context) {
//                                     if (textEditingValue.text.isNotEmpty || rightInsideActionsIsEmpty) {
//                                       return Container(
//                                         height: 32,
//                                         width: 32,
//                                         decoration: widget.sendButtonWidget == null
//                                             ? BoxDecoration(
//                                                 color: textEditingValue.text.isNotEmpty
//                                                     ? Theme.of(context).primaryColor
//                                                     : Theme.of(context).primaryColor.withOpacity(0.6),
//                                                 shape: BoxShape.circle,
//                                               )
//                                             : null,
//                                         child: IconButton(
//                                           padding: EdgeInsets.zero,
//                                           icon: widget.sendButtonWidget ??
//                                               const Icon(Icons.send, size: 16, color: Colors.white),
//                                           onPressed: textEditingValue.text.isNotEmpty ? sendTextMessage : null,
//                                         ),
//                                       );
//                                     } else {
//                                       return Row(
//                                         children: [
//                                           if (widget.showPickMediaButton)
//                                             ZIMKitPickMediaButton(
//                                               icon: widget.pickMediaButtonWidget,
//                                               onFilePicked: (
//                                                 List<PlatformFile> files,
//                                               ) {
//                                                 void defaultAction() {
//                                                   ZIMKit().sendMediaMessage(
//                                                     widget.conversationID,
//                                                     widget.conversationType,
//                                                     files,
//                                                     onMessageSent: widget.onMessageSent,
//                                                     preMessageSending: widget.preMessageSending,
//                                                   );
//                                                 }
//
//                                                 if (widget.onMediaFilesPicked != null) {
//                                                   widget.onMediaFilesPicked!(context, files, defaultAction);
//                                                 } else {
//                                                   defaultAction();
//                                                 }
//                                               },
//                                             ),
//                                           if (widget.showPickFileButton)
//                                             ZIMKitPickFileButton(
//                                               icon: widget.pickFileButtonWidget,
//                                               onFilePicked: (
//                                                 List<PlatformFile> files,
//                                               ) {
//                                                 void defaultAction() {
//                                                   ZIMKit().sendFileMessage(
//                                                     widget.conversationID,
//                                                     widget.conversationType,
//                                                     files,
//                                                     onMessageSent: widget.onMessageSent,
//                                                     preMessageSending: widget.preMessageSending,
//                                                   );
//                                                 }
//
//                                                 if (widget.onMediaFilesPicked != null) {
//                                                   widget.onMediaFilesPicked!(context, files, defaultAction);
//                                                 } else {
//                                                   defaultAction();
//                                                 }
//                                               },
//                                             ),
//                                           ...buildActions(ZIMKitMessageInputActionLocation.rightInside),
//                                         ],
//                                       );
//                                     }
//                                   },
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       // ...buildActions(ZIMKitMessageInputActionLocation.right),
//                     ],
//                   ),
//                   showCard
//                       ? Container(
//                           margin: EdgeInsets.symmetric(
//                             horizontal: screenWidth(context, dividedBy: 15),
//                           ),
//                           width: screenWidth(context),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               color: AppColor.white,
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.grey,
//                                   offset: Offset(
//                                     1,
//                                     1,
//                                   ),
//                                   blurRadius: 4,
//                                   spreadRadius: 0.0,
//                                 ),
//                               ]),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth(context, dividedBy: 15),
//                                     vertical: screenHeight(context, dividedBy: 100)),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       height: screenHeight(context, dividedBy: 17),
//                                       width: screenWidth(context, dividedBy: 2),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
//                                             height: screenHeight(context, dividedBy: 40),
//                                             width: screenWidth(context, dividedBy: 15),
//                                             decoration: const BoxDecoration(
//                                                 image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
//                                           ),
//                                           const Text(
//                                             'Camera',
//                                             style: TextStyle(
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: AppColor.dropdownfont),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               const Divider(
//                                 height: 0,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth(context, dividedBy: 15),
//                                     vertical: screenHeight(context, dividedBy: 100)),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       height: screenHeight(context, dividedBy: 17),
//                                       width: screenWidth(context, dividedBy: 2),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
//                                             height: screenHeight(context, dividedBy: 40),
//                                             width: screenWidth(context, dividedBy: 15),
//                                             decoration: const BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: AssetImage('assets/Images/placeholder.png'))),
//                                           ),
//                                           const Text(
//                                             'Photos & Videos',
//                                             style: TextStyle(
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: AppColor.dropdownfont),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               const Divider(
//                                 height: 0,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth(context, dividedBy: 15),
//                                     vertical: screenHeight(context, dividedBy: 100)),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       height: screenHeight(context, dividedBy: 17),
//                                       width: screenWidth(context, dividedBy: 2),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Image(
//                                             image: const AssetImage('assets/Images/file.png'),
//                                             height: screenHeight(context, dividedBy: 30),
//                                             width: screenWidth(context, dividedBy: 15),
//                                             color: const Color(0xff5D5D5D),
//                                           ),
//                                           SizedBox(
//                                             width: screenWidth(context, dividedBy: 50),
//                                           ),
//                                           const Text(
//                                             'Document',
//                                             style: TextStyle(
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: AppColor.dropdownfont),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> sendTextMessage() async {
//     ZIMKit().sendTextMessage(
//       widget.conversationID,
//       widget.conversationType,
//       _editingController.text,
//       onMessageSent: widget.onMessageSent,
//       preMessageSending: widget.preMessageSending,
//     );
//     _editingController.clear();
//     // TODO mac auto focus or not
//     // TODO mobile auto focus or not
//   }
//
//   List<Widget> buildActions(ZIMKitMessageInputActionLocation location) {
//     return widget.actions?.where((element) => element.location == location).map((e) => e.child).toList() ?? [];
//   }
//
//   bool get rightInsideActionsIsEmpty =>
//       (widget.actions?.where((element) => element.location == ZIMKitMessageInputActionLocation.rightInside).isEmpty ??
//           true) &&
//       !widget.showPickFileButton &&
//       !widget.showPickMediaButton;
// }
//
// enum ZIMKitMessageInputActionLocation {
//   left,
//   right,
//   leftInside,
//   rightInside,
// }
//
// class ZIMKitMessageInputAction {
//   const ZIMKitMessageInputAction(
//     this.child, [
//     this.location = ZIMKitMessageInputActionLocation.rightInside,
//   ]);
//
//   const ZIMKitMessageInputAction.left(Widget child)
//       : this(
//           child,
//           ZIMKitMessageInputActionLocation.left,
//         );
//
//   const ZIMKitMessageInputAction.right(Widget child)
//       : this(
//           child,
//           ZIMKitMessageInputActionLocation.right,
//         );
//
//   const ZIMKitMessageInputAction.leftInside(Widget child)
//       : this(
//           child,
//           ZIMKitMessageInputActionLocation.leftInside,
//         );
//
//   const ZIMKitMessageInputAction.rightInside(Widget child)
//       : this(
//           child,
//           ZIMKitMessageInputActionLocation.rightInside,
//         );
//
//   final Widget child;
//   final ZIMKitMessageInputActionLocation location;
// }
