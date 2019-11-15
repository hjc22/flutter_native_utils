import 'dart:async';

import 'package:flutter/services.dart';

import 'dart:io' show Platform;

class NativeUtils {
  static const MethodChannel _channel =
  const MethodChannel('piugins.hjc.com/native_utils');

  static bool _isInsideOpenAppStore = false;

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

  static Future<bool> insideOpenAppStore(String appId) async {
    if(!Platform.isIOS || _isInsideOpenAppStore) {
      return Future.error(null);
    }
    try {
      _isInsideOpenAppStore = true;
      bool result = await _channel.invokeMethod('insideOpenAppStore', appId).timeout(const Duration(seconds: 6));
      return result;
    }
    catch(err) {
      return Future.error(err);
    }
    finally {
      _isInsideOpenAppStore = false;
    }
  }

  static Future<bool> openAppStore(String appId) async {
    if(!Platform.isIOS) {
      return Future.error(null);
    }
    return await _channel.invokeMethod('openAppStore', appId);
  }

}