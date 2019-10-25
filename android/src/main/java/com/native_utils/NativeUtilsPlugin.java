package com.example.native_utils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.view.WindowManager;

/** NativeUtilsPlugin */
public class NativeUtilsPlugin implements MethodCallHandler {


  Registrar mRegistrar;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "piugins.hjc.com/native_utils");
    final NativeUtilsPlugin NativeUtilsPlugin = new NativeUtilsPlugin(registrar);
    channel.setMethodCallHandler(NativeUtilsPlugin);
  }
  private NativeUtilsPlugin(Registrar mRegistrar) {
    this.mRegistrar = mRegistrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("setFullScreen")) {
      int flag = WindowManager.LayoutParams.FLAG_FULLSCREEN;
      mRegistrar.activity().getWindow().setFlags(flag, flag);
      result.success(true);
    } else if (call.method.equals("cancelFullScreen")) {
      mRegistrar.activity().getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
      result.success(true);
    }else {
      result.notImplemented();
    }
  }
}
