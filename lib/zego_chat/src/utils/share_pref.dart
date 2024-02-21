import 'dart:async';
import 'dart:convert';

import 'package:pair_me/zego_chat/src/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:zego_zimkit/src/services/logger_service.dart';

String _encodeString(String value) {
  final encodedBytes = utf8.encode(value);
  final base64String = base64.encode(encodedBytes);
  return base64String;
}

String _decodeString(String value) {
  final decodedBytes = base64.decode(value);
  final decodedString = utf8.decode(decodedBytes);
  return decodedString;
}

Future<void> setPreferenceString(
  String key,
  String value, {
  bool withEncode = false,
}) async {
  var _value = value;
  if (withEncode) {
    _value = _encodeString(value);
  }

  ZIMKitLogger.info('setPreferenceString, key:$key, value:$value.');

  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, _value);
}

Future<String> getPreferenceString(
  String key, {
  bool withDecode = false,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(key);
  if (value?.isEmpty ?? true) {
    return '';
  }

  return withDecode ? _decodeString(value!) : value!;
}

Future<void> removePreferenceValue(String key) async {
  ZIMKitLogger.info('removePreferenceValue, key:$key.');

  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
