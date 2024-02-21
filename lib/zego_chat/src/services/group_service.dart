part of 'zimkit_services.dart';

mixin ZIMKitGroupService {
  // return the new group's conversationID
  // If you specify an ID, the group will be created using the ID you specified.
  Future<String?> createGroup(String name, List<String> inviteUserIDs, {String id = ''}) async {
    return ZIMKitCore.instance.createGroup(name, inviteUserIDs, id: id);
  }

  // Return error code. 0 means success.
  Future<int> joinGroup(String conversationID) async {
    return ZIMKitCore.instance.joinGroup(conversationID);
  }

  // Return error code. 0 means success.
  Future<int> addUersToGroup(String conversationID, List<String> userIDs) async {
    return ZIMKitCore.instance.addUsersToGroup(conversationID, userIDs);
  }

  Future<int> removeUesrsFromGroup(String conversationID, List<String> userIDs) async {
    return ZIMKitCore.instance.removeUsersFromGroup(conversationID, userIDs);
  }

  // Return error code. 0 means success.
  Future<int> leaveGroup(String conversationID) async {
    return ZIMKitCore.instance.leaveGroup(conversationID);
  }

  ValueNotifier<ZIMKitGroupInfo> queryGroupInfo(String conversationID) {
    return ZIMKitCore.instance.queryGroupInfo(conversationID);
  }

  // Return error code. 0 means success.
  Future<int> disbandGroup(String conversationID) async {
    return ZIMKitCore.instance.disbandGroup(conversationID);
  }

  // Return error code. 0 means success.
  Future<int> transferGroupOwner(String conversationID, String toUserID) async {
    return ZIMKitCore.instance.transferGroupOwner(conversationID, toUserID);
  }

  Future<ZIMGroupMemberInfo?> queryGroupMemberInfo(String conversationID, String userID) async {
    return ZIMKitCore.instance.queryGroupMemberInfo(conversationID, userID);
  }

  ValueNotifier<ZIMGroupMemberInfo?> queryGroupOwner(String conversationID) {
    return ZIMKitCore.instance.queryGroupOwner(conversationID);
  }

  ListNotifier<ZIMGroupMemberInfo> queryGroupMemberList(String conversationID) {
    return ZIMKitCore.instance.queryGroupMemberList(conversationID);
  }

  ValueNotifier<int> queryGroupMemberCount(String conversationID) {
    return ZIMKitCore.instance.queryGroupMemberCount(conversationID);
  }

  // Events
  Stream<ZIMKitEventGroupStateChanged> getGroupStateChangedEventStream() {
    return ZIMKitCore.instance.onGroupStateChangedEventController.stream;
  }

  Stream<ZIMKitEventGroupNameUpdated> getGroupNameUpdatedEventStream() {
    return ZIMKitCore.instance.onGroupNameUpdatedEventController.stream;
  }

  Stream<ZIMKitEventGroupAvatarUrlUpdated> getGroupAvatarUrlUpdatedEventStream() {
    return ZIMKitCore.instance.onGroupAvatarUrlUpdatedEventController.stream;
  }

  Stream<ZIMKitEventGroupNoticeUpdated> getGroupNoticeUpdatedEventStream() {
    return ZIMKitCore.instance.onGroupNoticeUpdatedEventController.stream;
  }

  Stream<ZIMKitEventGroupAttributesUpdated> getGroupAttributesUpdatedEventStream() {
    return ZIMKitCore.instance.onGroupAttributesUpdatedEventController.stream;
  }

  Stream<ZIMKitEventGroupMemberStateChanged> getGroupMemberStateChangedEventStream() {
    return ZIMKitCore.instance.onGroupMemberStateChangedEventController.stream;
  }

  Stream<ZIMKitEventGroupMemberInfoUpdated> getGroupMemberInfoUpdatedEventStream() {
    return ZIMKitCore.instance.onGroupMemberInfoUpdatedEventController.stream;
  }
}
