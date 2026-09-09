import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_localization_platform_interface.dart';

/// A web implementation of the FlutterLocalizationPlatform of the FlutterLocalization plugin.
class FlutterLocalizationWeb extends FlutterLocalizationPlatform {
  /// Constructs a FlutterLocalizationWeb
  FlutterLocalizationWeb();

  static void registerWith(Registrar registrar) {
    FlutterLocalizationPlatform.instance = FlutterLocalizationWeb();
  }

  /// Returns a String containing the version of the platform.
  @override
  Future<String> getPlatformVersion() async {
    return web.window.navigator.userAgent;
  }

  /// Returns a String containing the language locale.
  @override
  Future<String> getPlatformLocale() async {
    return web.window.navigator.language;
  }
}
