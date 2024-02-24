import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/message_request.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/header_space.dart';
import 'package:pair_me/cubits/show_message_requests.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/zego_chat/src/components/components.dart';
import 'package:pair_me/zego_chat/src/pages/message_list_page.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';
import 'package:zego_zim/zego_zim.dart';

// import 'package:zego_zimkit/src/components/components.dart';
// import 'package:zego_zimkit/src/pages/message_list_page.dart';
// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitConversationListView extends StatefulWidget {
  const ZIMKitConversationListView({
    super.key,
    this.filter,
    this.sorter,
    this.onPressed,
    this.onLongPress,
    this.itemBuilder,
    this.lastMessageTimeBuilder,
    this.lastMessageBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.scrollController,
    this.theme,
  });

  // logic function
  final List<ZIMKitConversationNotifier> Function(
    BuildContext context,
    List<ZIMKitConversationNotifier>,
  )? filter;
  final List<ZIMKitConversationNotifier> Function(
    BuildContext context,
    List<ZIMKitConversationNotifier>,
  )? sorter;

  // item event
  final void Function(
    BuildContext context,
    ZIMKitConversation conversation,
    Function defaultAction,
  )? onPressed;
  final void Function(
    BuildContext context,
    ZIMKitConversation conversation,
    LongPressStartDetails longPressDetails,
    Function defaultAction,
  )? onLongPress;

  // ui builder
  final Widget Function(
    BuildContext context,
    Widget defaultWidget,
  )? errorBuilder;
  final Widget Function(
    BuildContext context,
    Widget defaultWidget,
  )? emptyBuilder;
  final Widget Function(
    BuildContext context,
    Widget defaultWidget,
  )? loadingBuilder;

  // item ui builder
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

  // item builder
  final Widget Function(
    BuildContext context,
    ZIMKitConversation conversation,
    Widget defaultWidget,
  )? itemBuilder;

  // scroll controller
  final ScrollController? scrollController;

  // theme
  final ThemeData? theme;

  @override
  State<ZIMKitConversationListView> createState() => _ZIMKitConversationListViewState();
}

class _ZIMKitConversationListViewState extends State<ZIMKitConversationListView> {
  final ScrollController _defaultScrollController = ScrollController();

  ScrollController get _scrollController => widget.scrollController ?? _defaultScrollController;
  Completer? _loadMoreCompleter;
  AllMessageRequestCubit messageRequestCubit = AllMessageRequestCubit();

  @override
  void initState() {
    _scrollController.addListener(scrollControllerListener);
    getRequests();
    super.initState();
  }

  List requestIdList = [];
  List connectionIdList = [];

  getRequests() async {
    await messageRequestCubit.GetAllMessageRequest();

    setState(() {
      requestIdList.clear();
      connectionIdList.clear();
      messageRequestCubit.userMssageReq.data!.withoutConnect!.forEach((element) {
        requestIdList.add(element.id);
      });
      messageRequestCubit.userMssageReq.data!.data!.forEach((element) {
        connectionIdList.add(element.id);
      });
    });
    debugPrint("requestId --- ${requestIdList}");
    debugPrint("connectionIdList --- ${connectionIdList}");
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollControllerListener);
    super.dispose();
  }

  Future<void> scrollControllerListener() async {
    if (_loadMoreCompleter == null || _loadMoreCompleter!.isCompleted) {
      if (_scrollController.position.pixels >= 0.8 * _scrollController.position.maxScrollExtent) {
        _loadMoreCompleter = Completer();
        if (0 == await ZIMKit().loadMoreConversation()) {
          _scrollController.removeListener(scrollControllerListener);
        }
        _loadMoreCompleter!.complete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme ?? Theme.of(context),
      child: FutureBuilder(
        future: ZIMKit().getConversationListNotifier(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Stack(
                children: [
                  Background_Img(context),
                  Column(
                    children: [
                      Header_Space(context),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth(context, dividedBy: 15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_header(text: 'Message'),
                            messageRequestCubit.userMssageReq.data != null
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const MessageRequest();
                                        },
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Requests'.tr(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.skyBlue),
                                        ),
                                        Text(
                                          '(${messageRequestCubit.userMssageReq.data?.withoutConnect?.length ?? 0})',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.skyBlue),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: snapshot.data!,
                          builder: (
                            BuildContext context,
                            List<ZIMKitConversationNotifier> conversationList,
                            Widget? child,
                          ) {
                            if (conversationList.isEmpty || connectionIdList.isEmpty) {
                              return Center(
                                child: Container(
                                  height: screenHeight(context, dividedBy: 7),
                                  width: screenHeight(context, dividedBy: 7),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/Images/nomsg.png'))),
                                ),
                              );
                            }

                            conversationList = widget.filter?.call(
                                  context,
                                  conversationList,
                                ) ??
                                conversationList;
                            conversationList = widget.sorter?.call(
                                  context,
                                  conversationList,
                                ) ??
                                conversationList;

                            return LayoutBuilder(
                              builder: (
                                context,
                                BoxConstraints constraints,
                              ) {
                                return ListView.builder(
                                  cacheExtent: constraints.maxHeight * 3,
                                  controller: _scrollController,
                                  itemCount: conversationList.length,
                                  itemBuilder: (context, index) {
                                    final conversation = conversationList[index];

                                    return ValueListenableBuilder(
                                      valueListenable: conversation,
                                      builder: (
                                        BuildContext context,
                                        ZIMKitConversation conversation,
                                        Widget? child,
                                      ) {
                                        final Widget defaultWidget = ZIMKitConversationWidget(
                                          conversation: conversation,
                                          lastMessageTimeBuilder: widget.lastMessageTimeBuilder,
                                          lastMessageBuilder: widget.lastMessageBuilder,
                                          onLongPress: (
                                            BuildContext context,
                                            LongPressStartDetails longPressDetails,
                                          ) {
                                            void onLongPressDefaultAction() {
                                              _onLongPressDefaultAction(
                                                context,
                                                longPressDetails,
                                                conversation.id,
                                                conversation.type,
                                              );
                                            }

                                            if (widget.onLongPress != null) {
                                              widget.onLongPress!(
                                                context,
                                                conversation,
                                                longPressDetails,
                                                onLongPressDefaultAction,
                                              );
                                            } else {
                                              onLongPressDefaultAction();
                                            }
                                          },
                                          onPressed: (BuildContext context) {
                                            Future<void> onPressedDefaultAction() async {
                                              // await onUserLogin(userID.text, userName.text);

                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) {
                                                  return ZIMKitMessageListPage(
                                                    name: 'chatting',
                                                    conversationID: conversation.id,
                                                    conversationType: conversation.type,
                                                    theme: widget.theme,
                                                  );
                                                },
                                              ));
                                            }

                                            if (widget.onPressed != null) {
                                              widget.onPressed!(
                                                context,
                                                conversation,
                                                onPressedDefaultAction,
                                              );
                                            } else {
                                              onPressedDefaultAction();
                                            }
                                          },
                                        );
                                        debugPrint("chat id --- ${conversation.id}");

                                        // customWidget
                                        return requestIdList.contains(conversation.id)
                                            ? const SizedBox()
                                            : !connectionIdList.contains(conversation.id)
                                                ? const SizedBox()
                                                : defaultWidget;
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // defaultWidget
            final Widget defaultWidget = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {}),
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                  const Text('Load failed, please click to retry'),
                ],
              ),
            );

            // customWidget
            return GestureDetector(
              onTap: () => setState(() {}),
              child: widget.errorBuilder?.call(
                    context,
                    defaultWidget,
                  ) ??
                  defaultWidget,
            );
          } else {
            // defaultWidget
            const Widget defaultWidget = Center(
              child: CircularProgressIndicator(),
            );

            // customWidget
            return widget.loadingBuilder?.call(
                  context,
                  defaultWidget,
                ) ??
                defaultWidget;
          }
        },
      ),
    );
  }

  void _onLongPressDefaultAction(
    BuildContext context,
    LongPressStartDetails longPressDetails,
    String conversationID,
    ZIMConversationType conversationType,
  ) {
    final conversationBox = context.findRenderObject()! as RenderBox;
    final offset = conversationBox.localToGlobal(Offset(0, conversationBox.size.height / 2));
    final position = RelativeRect.fromLTRB(
      longPressDetails.globalPosition.dx,
      offset.dy,
      longPressDetails.globalPosition.dx,
      offset.dy,
    );

    showMenu(context: context, position: position, items: [
      const PopupMenuItem(value: 0, child: Text('Delete')),
      if (conversationType == ZIMConversationType.group) const PopupMenuItem(value: 1, child: Text('Quit'))
    ]).then((value) {
      switch (value) {
        case 0:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Confirm'),
                content: const Text('Do you want to delete this conversation?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ZIMKit().deleteConversation(conversationID, conversationType);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          break;
        case 1:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Confirm'),
                content: const Text('Do you want to leave this group?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ZIMKit().leaveGroup(conversationID);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          break;
      }
    });
  }
}

// TODO Pass the messageListPage config
