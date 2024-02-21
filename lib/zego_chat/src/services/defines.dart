import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pair_me/zego_chat/src/services/extensions/flutter_extension.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
// import 'package:zego_zimkit/src/services/extensions/extensions.dart';

typedef ZIMKitMessageNotifier = ValueNotifier<ZIMKitMessage>;
typedef ZIMKitMessageListNotifier = ListNotifier<ZIMKitMessageNotifier>;
typedef ZIMKitConversationNotifier = ValueNotifier<ZIMKitConversation>;
typedef ZIMKitConversationListNotifier = ListNotifier<ZIMKitConversationNotifier>;

class ZIMKitConversation {
  ZIMConversationType type = ZIMConversationType.peer;

  // conversation
  String id = '';
  String name = '';
  String avatarUrl = '';
  ZIMConversationNotificationStatus notificationStatus = ZIMConversationNotificationStatus.notify;
  int unreadMessageCount = 0;
  int orderKey = 0;
  bool disable = false;
  ZIMKitMessage? lastMessage;
}

class ZIMKitGroupInfo {
  String notice = "";
  Map<String, String> attributes = {};
  ZIMGroupState state = ZIMGroupState.enter;
  ZIMGroupEvent event = ZIMGroupEvent.created;
}

typedef ZIMKitMessageType = ZIMMessageType;

class ZIMKitMessage {
  ZIMKitMessageType type = ZIMKitMessageType.unknown;

  ZIMKitMessageBaseInfo info = ZIMKitMessageBaseInfo();

  ZIMKitMessageImageContent? imageContent;
  ZIMKitMessageVideoContent? videoContent;
  ZIMKitMessageAudioContent? audioContent;
  ZIMKitMessageFileContent? fileContent;
  ZIMKitMessageTextContent? textContent;
  ZIMKitMessageSystemContent? systemContent;
  ZIMKitMessageCustomContent? customContent;

  ListNotifier<ZIMMessageReaction> reactions = ListNotifier([]);

  ValueNotifier<String> localExtendedData = ValueNotifier('');

  Map zimkitExtraInfo = {}; // ZIMKit Internal Use Only.
  ZIMMessage zim = ZIMMessage(); // ZIMKit Internal Use Only.
}

class ZIMKitMessageTextContent {
  late String text;
}

class ZIMKitMessageBaseInfo {
  int messageID = 0;
  int localMessageID = 0;
  String senderUserID = '';
  String conversationID = '';
  ZIMMessageDirection direction = ZIMMessageDirection.send;
  ZIMMessageSentStatus sentStatus = ZIMMessageSentStatus.sending;
  ZIMConversationType conversationType = ZIMConversationType.peer;
  int timestamp = 0;
  int conversationSeq = 0;
  int orderKey = 0;
  bool isUserInserted = false;
  PlatformException? error;
  ZIMMessageReceiptStatus receiptStatus = ZIMMessageReceiptStatus.none;
}

class ZIMKitMessageImageContent {
  late String fileLocalPath;
  String fileDownloadUrl = '';
  String fileUID = '';
  String fileName = '';
  int fileSize = 0;
  MediaTransferProgress? uploadProgress;
  MediaTransferProgress? downloadProgress;

  // image
  String thumbnailDownloadUrl = '';
  String thumbnailLocalPath = '';
  String largeImageDownloadUrl = '';
  String largeImageLocalPath = '';
  int originalImageWidth = 0;
  int originalImageHeight = 0;
  int largeImageWidth = 0;
  int largeImageHeight = 0;
  int thumbnailWidth = 0;
  int thumbnailHeight = 0;

  double get aspectRatio =>
      (originalImageWidth / originalImageHeight) > 0 ? (originalImageWidth / originalImageHeight) : 1.0;
}

class ZIMKitMessageVideoContent {
  late String fileLocalPath;
  String fileDownloadUrl = '';
  String fileUID = '';
  String fileName = '';
  int fileSize = 0;
  MediaTransferProgress? uploadProgress;
  MediaTransferProgress? downloadProgress;

  // video
  int videoDuration = 0;
  String videoFirstFrameDownloadUrl = '';
  String videoFirstFrameLocalPath = '';
  int videoFirstFrameWidth = 0;
  int videoFirstFrameHeight = 0;

  double get aspectRatio =>
      (videoFirstFrameWidth / videoFirstFrameHeight) > 0 ? (videoFirstFrameWidth / videoFirstFrameHeight) : 1.0;
}

class ZIMKitMessageAudioContent {
  late String fileLocalPath;
  String fileDownloadUrl = '';
  String fileUID = '';
  String fileName = '';
  int fileSize = 0;
  MediaTransferProgress? uploadProgress;
  MediaTransferProgress? downloadProgress;

  int audioDuration = 0;
}

class ZIMKitMessageFileContent {
  late String fileLocalPath;
  String fileDownloadUrl = '';
  String fileUID = '';
  String fileName = '';
  int fileSize = 0;
  MediaTransferProgress? uploadProgress;
  MediaTransferProgress? downloadProgress;
}

class ZIMKitMessageSystemContent {
  late String info;
}

class ZIMKitMessageCustomContent {
  late String message;
  late int type;
  late String searchedContent;
}

class MediaTransferProgress {
  int totalSize = 0;
  int transferredSize = 0;
  double get progress => totalSize == 0 ? 0 : transferredSize / totalSize;
}
