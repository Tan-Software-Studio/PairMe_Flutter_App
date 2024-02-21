import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/zego_chat/src/components/components.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';
import 'package:zego_zim/zego_zim.dart';
// import 'package:zego_zimkit/src/components/components.dart';
// import 'package:zego_zimkit/src/services/services.dart';

// featureList
class ZIMKitMessageListView extends StatefulWidget {
  const ZIMKitMessageListView({
    Key? key,
    required this.conversationID,
    this.conversationType = ZIMConversationType.peer,
    this.onPressed,
    this.itemBuilder,
    this.messageContentBuilder,
    this.backgroundBuilder,
    this.loadingBuilder,
    this.onLongPress,
    this.errorBuilder,
    this.scrollController,
    this.theme,
  }) : super(key: key);

  final String conversationID;
  final ZIMConversationType conversationType;

  final ScrollController? scrollController;

  final void Function(BuildContext context, ZIMKitMessage message, Function defaultAction)? onPressed;
  final void Function(
      BuildContext context, LongPressStartDetails details, ZIMKitMessage message, Function defaultAction)? onLongPress;
  final Widget Function(BuildContext context, ZIMKitMessage message, Widget defaultWidget)? itemBuilder;
  final Widget Function(BuildContext context, ZIMKitMessage message, Widget defaultWidget)? messageContentBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)? errorBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)? loadingBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)? backgroundBuilder;

  // theme
  final ThemeData? theme;

  @override
  State<ZIMKitMessageListView> createState() => _ZIMKitMessageListViewState();
}

class _ZIMKitMessageListViewState extends State<ZIMKitMessageListView> {
  final ScrollController _defaultScrollController = ScrollController();

  ScrollController get _scrollController => widget.scrollController ?? _defaultScrollController;

  Completer? _loadMoreCompleter;

  @override
  void initState() {
    ZIMKit().clearUnreadCount(widget.conversationID, widget.conversationType);
    _scrollController.addListener(scrollControllerListener);

    super.initState();
  }

  @override
  void dispose() {
    ZIMKit().clearUnreadCount(widget.conversationID, widget.conversationType);
    _scrollController.removeListener(scrollControllerListener);

    super.dispose();
  }

  Future<void> scrollControllerListener() async {
    if (_loadMoreCompleter == null || _loadMoreCompleter!.isCompleted) {
      if (_scrollController.position.pixels >= 0.8 * _scrollController.position.maxScrollExtent) {
        _loadMoreCompleter = Completer();
        if (0 == await ZIMKit().loadMoreMessage(widget.conversationID, widget.conversationType)) {
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
      child: Expanded(
        child: FutureBuilder(
          future: ZIMKit().getMessageListNotifier(
            widget.conversationID,
            widget.conversationType,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ValueListenableBuilder(
                valueListenable: snapshot.data! as ZIMKitMessageListNotifier,
                builder: (
                  BuildContext context,
                  List<ValueNotifier<ZIMKitMessage>> messageList,
                  Widget? child,
                ) {
                  ZIMKit().clearUnreadCount(
                    widget.conversationID,
                    widget.conversationType,
                  );
                  return listview(
                    messageList: messageList.reversed.toList(),
                  );
                },
              );
            } else if (snapshot.hasError) {
              // TODO 未实现加载失败
              // defaultWidget
              final Widget defaultWidget = Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState(() {}),
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                    Text(snapshot.error.toString()),
                    const Text('Load failed, please click to retry'),
                  ],
                ),
              );

              // customWidget
              return GestureDetector(
                onTap: () => setState(() {}),
                child: widget.errorBuilder?.call(context, defaultWidget) ?? defaultWidget,
              );
            } else {
              // defaultWidget
              const Widget defaultWidget = Center(child: CircularProgressIndicator());

              // customWidget
              return widget.loadingBuilder?.call(context, defaultWidget) ?? defaultWidget;
            }
          },
        ),
      ),
    );
  }

  Widget listview({
    required List<ValueNotifier<ZIMKitMessage>> messageList,
  }) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Stack(
        children: [
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: widget.backgroundBuilder?.call(context, const SizedBox.shrink()) ?? const SizedBox.shrink(),
          ),
          ListView.builder(
            cacheExtent: constraints.maxHeight * 3,
            reverse: true,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              final reversedIndex = index;
              final messageNotifier = messageList[reversedIndex];

              String chatDate = messageList.length - 1 != reversedIndex &&
                      DateFormat("dd MMMM yyyy").format(
                              DateTime.fromMillisecondsSinceEpoch(messageList[reversedIndex].value.info.timestamp)) ==
                          DateFormat("dd MMMM yyyy").format(
                              DateTime.fromMillisecondsSinceEpoch(messageList[reversedIndex + 1].value.info.timestamp))
                  ? ""
                  : DateFormat("dd MMMM yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(messageList[reversedIndex].value.info.timestamp));

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chatDate != "")
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.skyBlue,
                      ),
                      child: Text(
                        DateFormat("dd MMMM yyyy").format(DateTime.now()) == chatDate
                            ? "Today"
                            : DateFormat("dd MMMM yyyy").format(DateTime.now().subtract(const Duration(days: 1))) ==
                                    chatDate
                                ? "Yesterday"
                                : chatDate,
                        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ValueListenableBuilder(
                    valueListenable: messageNotifier,
                    builder: (
                      BuildContext context,
                      ZIMKitMessage message,
                      Widget? child,
                    ) {
                      final defaultWidget = defaultMessageWidget(
                        chatDate: chatDate,
                        message: message,
                        constraints: constraints,
                      );
                      return /*widget.itemBuilder?.call(
                            context,
                            message,
                            defaultWidget,
                          ) ??*/
                          defaultWidget;
                    },
                  ),
                ],
              );
            },
          ),
        ],
      );
    });
  }

  Widget defaultMessageWidget(
      {required ZIMKitMessage message, required BoxConstraints constraints, required String chatDate}) {
    return SizedBox(
      width: constraints.maxWidth,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: constraints.maxWidth,
          maxHeight: message.type == ZIMMessageType.text ? double.maxFinite : constraints.maxHeight * 0.5,
        ),
        child: ZIMKitMessageWidget(
          key: ValueKey(message.hashCode),
          message: message,
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          messageContentBuilder: widget.messageContentBuilder,
        ),
      ),
    );
  }
}
