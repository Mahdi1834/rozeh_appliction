import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

/// 📱 کلاس عمومی برای دریافت اطلاعات دستگاه در Flutter
class DeviceInfoHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// 🧭 دریافت فقط نام دستگاه (ساده)
  static Future<String> getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return "${info.manufacturer} ${info.model}";
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return info.name ?? "iPhone";
      } else if (Platform.isWindows) {
        final info = await _deviceInfo.windowsInfo;
        return info.computerName;
      } else if (Platform.isMacOS) {
        final info = await _deviceInfo.macOsInfo;
        return info.computerName;
      } else if (Platform.isLinux) {
        final info = await _deviceInfo.linuxInfo;
        return info.prettyName ?? "Linux Device";
      } else {
        return "Unknown Device";
      }
    } catch (e) {
      return "Unknown Device";
    }
  }

  /// 🌍 دریافت نسخه سیستم عامل (OS Version)
  static Future<String> getOsVersion() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return "Android ${info.version.release}";
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return "iOS ${info.systemVersion}";
      } else if (Platform.isWindows) {
        final info = await _deviceInfo.windowsInfo;
        return "Windows ${info.majorVersion}.${info.minorVersion}";
      } else if (Platform.isMacOS) {
        final info = await _deviceInfo.macOsInfo;
        return "macOS ${info.osRelease}";
      } else if (Platform.isLinux) {
        final info = await _deviceInfo.linuxInfo;
        return info.version ?? "Linux";
      } else {
        return "Unknown OS";
      }
    } catch (e) {
      return "Unknown OS";
    }
  }

  /// 🔑 دریافت شناسه‌ی یونیک دستگاه (مثلاً Android ID یا IdentifierForVendor)
  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return info.id ?? "Unknown Android ID";
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return info.identifierForVendor ?? "Unknown iOS ID";
      } else {
        return "Unknown Device ID";
      }
    } catch (e) {
      return "Unknown Device ID";
    }
  }

  /// 🧩 ترکیب تمام اطلاعات دستگاه (مثلاً برای ارسال به سرور)
  static Future<Map<String, String>> getFullDeviceInfo() async {
    final name = await getDeviceName();
    final os = await getOsVersion();
    final id = await getDeviceId();

    return {
      "name": name,
      "os_version": os,
      "device_id": id,
    };
  }
}
