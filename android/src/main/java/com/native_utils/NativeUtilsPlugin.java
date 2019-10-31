package com.example.native_utils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.view.WindowManager;
import android.hardware.SensorManager;
import android.hardware.Sensor;
import android.content.Context;
import java.io.File;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import android.util.Log;

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
    } else if(call.method.equals("checkLightSensor")) {
      result.success(notHasLightSensorManager(registrar.context()));
    } else if(call.method.equals("checkIsRoot")) {
      try {
        Boolean a = isRoot();
        result.success(a);
      }
      catch(Exception e) {
        result.success(false);
      }
    }
      else {
      result.notImplemented();
    }
  }
  /**
   * 判断是否存在光传感器来判断是否为模拟器
   * 部分真机也不存在温度和压力传感器。其余传感器模拟器也存在。
   * @return true 为模拟器
   */
  public static Boolean notHasLightSensorManager(Context context) {
    SensorManager sensorManager = (SensorManager) context.getSystemService(context.SENSOR_SERVICE);
    Sensor sensor8 = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT); //光
    if (null == sensor8) {
      return true;
    } else {
      return false;
    }
  }

  private final static String TAG = "RootUtil";

  public static boolean isRoot() {
    String binPath = "/system/bin/su";
    String xBinPath = "/system/xbin/su";
    if (new File(binPath).exists() && isExecutable(binPath))
      return true;
    if (new File(xBinPath).exists() && isExecutable(xBinPath))
      return true;
    return false;
  }

  private static boolean isExecutable(String filePath) {
    Process p = null;
    try {
      p = Runtime.getRuntime().exec("ls -l " + filePath);
      // 获取返回内容
      BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
      String str = in.readLine();
      Log.i(TAG, str);
      if (str != null && str.length() >= 4) {
        char flag = str.charAt(3);
        if (flag == 's' || flag == 'x')
          return true;
      }
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      if (p != null) {
        p.destroy();
      }
    }
    return false;
  }
}
