# Native Services Implementation Guide

This document details the implementation of native Android services in Flutter using MethodChannels. It covers Developer Mode detection, Battery Level monitoring, and Screen Security (preventing screenshots/recording).

---

# 1. Developer Mode Detection
Detects if "Developer Mode" is enabled on the Android device.

## Implementation Overview
1.  **Android Native (Kotlin)**: Communicates with Android System Settings API (`Settings.Global.DEVELOPMENT_SETTINGS_ENABLED`).
2.  **Flutter (Dart)**: Invokes the native method via a specific `MethodChannel`.

## Android Native Implementation
**File**: `android/app/src/main/kotlin/com/example/ready_made_services/MainActivity.kt`

We set up a channel `dev_mode_channel`. When called, it checks the global system settings.

```kotlin
private val devModeChannel = "dev_mode_channel"

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
                    result.success(value == 1) // Returns true if enabled
                }
                else -> result.notImplemented()
            }
        }
}
```

## Flutter Implementation
**File**: `lib/native_services.dart`

```dart
static const MethodChannel _devModeChannel = MethodChannel('dev_mode_channel');

/// 🔍 Check Developer Mode Enabled or not
static Future<bool> isDevModeEnabled() async {
  try {
    final result = await _devModeChannel.invokeMethod('getDevModeStatus');
    return result == true;
  } catch (e) {
    return false;
  }
}
```

---

# 2. Battery Level Detection
Retrieves the current battery percentage of the device.

## Implementation Overview
1.  **Android Native (Kotlin)**: Uses the `BatteryManager` system service to query the battery capacity property.
2.  **Flutter (Dart)**: Invokes the native method to get the integer level.

## Android Native Implementation
**File**: `android/app/src/main/kotlin/com/example/ready_made_services/MainActivity.kt`

Channel: `battery_channel`

```kotlin
private val batteryChannel = "battery_channel"

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
```

## Flutter Implementation
**File**: `lib/native_services.dart`

```dart
static const MethodChannel _batteryChannel = MethodChannel('battery_channel');

/// 🔋 Get Battery Level
static Future<int?> getBatteryLevel() async {
  try {
    return await _batteryChannel.invokeMethod('getBatteryLevel');
  } catch (_) {
    return null;
  }
}
```

---

# 3. Screen Security
Prevents the app from being screenshotted or recorded while active.

## Implementation Overview
1.  **Android Native (Kotlin)**: Toggles the `FLAG_SECURE` window flag.
2.  **Flutter (Dart)**: Provides methods to enable or disable this flag dynamically.

## Android Native Implementation
**File**: `android/app/src/main/kotlin/com/example/ready_made_services/MainActivity.kt`

Channel: `screen_secure_channel`

```kotlin
private val screenSecureChannel = "screen_secure_channel"

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
```

## Flutter Implementation
**File**: `lib/native_services.dart`

```dart
static const MethodChannel _screenSecureChannel = MethodChannel('screen_secure_channel');

/// 🔒 Enable secure screen (prevent screenshot)
static Future<void> enableSecureScreen() async {
  try {
    await _screenSecureChannel.invokeMethod("enableSecure");
  } catch (_) {}
}

/// 🔓 Disable secure screen (allow screenshot)
static Future<void> disableSecureScreen() async {
  try {
    await _screenSecureChannel.invokeMethod("disableSecure");
  } catch (_) {}
}
```

---

# Checklist for Usage

1.  **Channel Names**: Ensure the channel names (e.g., `'dev_mode_channel'`) match **exactly** in both `MainActivity.kt` and `native_services.dart`. A mismatch will result in a `MissingPluginException`.
2.  **Android Context**: These implementations rely on standard Android APIs (`Settings`, `BatteryManager`, `WindowManager`). They act on the existing Activity context.
3.  **App Restart**: If you modify the `MainActivity.kt` file, you must **stop and rebuild** the app (full restart). Hot Reload/Restart is often insufficient for native Kotlin changes.
4.  **Platform Check**: These services are implemented for Android. Running them on iOS without a corresponding `AppDelegate.swift` implementation will throw an error or do nothing (caught by try-catch blocks in Dart).
