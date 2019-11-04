import 'dart:async';

import 'package:flutter/services.dart';

import 'dart:io' show Platform;

class NativeUtils {
  static const MethodChannel _channel =
  const MethodChannel('piugins.hjc.com/native_utils');

  static Future<bool> cancelFullScreen() async {
    if(!Platform.isAndroid) {
      return Future.error(null);
    }
    return await _channel.invokeMethod('cancelFullScreen');
  }

  static Future<bool> setFullScreen() async {
    if(!Platform.isAndroid) {
      return Future.error(null);
    }
    return await _channel.invokeMethod('setFullScreen');
  }
  static Future<bool> checkIsRoot() async {
    if(!Platform.isAndroid) {
      return Future.error(null);
    }
    return await _channel.invokeMethod('checkIsRoot');
  }

  static Future<bool> checkLightSensor() async {
    if(!Platform.isAndroid) {
      return Future.error(null);
    }
    return await _channel.invokeMethod('checkLightSensor');
  }
  static Future<bool> getIndent(String action) async {
    if(!Platform.isAndroid) {
      return Future.error(null);
    }
    return await _channel.invokeMethod('getIntent', action);
  }
}