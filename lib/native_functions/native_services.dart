import 'package:flutter/services.dart';

class NativeServices {
  static const MethodChannel _devModeChannel = MethodChannel(
    'dev_mode_channel',
  );
  static const MethodChannel _batteryChannel = MethodChannel('battery_channel');
  static const MethodChannel _screenSecureChannel = MethodChannel(
    'screen_secure_channel',
  );

  /// 🔍 Check Developer Mode Enabled or not
  static Future<bool> isDevModeEnabled() async {
    try {
      final result = await _devModeChannel.invokeMethod('getDevModeStatus');
      return result == true;
    } catch (e) {
      return false;
    }
  }

  /// 🔋 Get Battery Level
  static Future<int?> getBatteryLevel() async {
    try {
      return await _batteryChannel.invokeMethod('getBatteryLevel');
    } catch (_) {
      return null;
    }
  }

  /// 🔒 Enable secure screen
  static Future<void> enableSecureScreen() async {
    try {
      await _screenSecureChannel.invokeMethod("enableSecure");
    } catch (_) {}
  }

  /// 🔓 Disable secure screen
  static Future<void> disableSecureScreen() async {
    try {
      await _screenSecureChannel.invokeMethod("disableSecure");
    } catch (_) {}
  }
}


// =========== MainActivity.kt ===========
/*package com.example.ready_made_services

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.os.BatteryManager
import android.view.WindowManager

class MainActivity : FlutterActivity() {

    private val devModeChannel = "dev_mode_channel"
    private val batteryChannel = "battery_channel"
    private val screenSecureChannel = "screen_secure_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        setupDevModeChannel(flutterEngine)
        setupBatteryChannel(flutterEngine)
        setupScreenSecurityChannel(flutterEngine)
    }

    /** 🔍 Developer mode channel **/
    private fun setupDevModeChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, devModeChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getDevModeStatus" -> {
                        val value = Settings.Global.getInt(
                            contentResolver,
                            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
                            0
                        )
                        result.success(value == 1)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /** 🔋 Battery channel **/
    private fun setupBatteryChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, batteryChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getBatteryLevel" -> {
                        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                        val level = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                        result.success(level)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /** 🔒 Screen Security channel **/
    private fun setupScreenSecurityChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, screenSecureChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "enableSecure" -> {
                        window.setFlags(
                            WindowManager.LayoutParams.FLAG_SECURE,
                            WindowManager.LayoutParams.FLAG_SECURE
                        )
                        result.success(true)
                    }

                    "disableSecure" -> {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }
}
*/