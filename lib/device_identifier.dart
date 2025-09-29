import 'package:flutter/services.dart';

import 'device_identifier_platform_interface.dart';

class DeviceIdentifier {
  static const MethodChannel _channel = MethodChannel('device_identifier');

  static Future<String?> getIdentifier() async {
    try {
      final String? identifier = await _channel.invokeMethod('getIdentifier');
      return identifier;
    } on PlatformException catch (e) {
      print("Failed to get device identifier: '${e.message}'.");
      return null;
    }
  }

  Future<String?> getPlatformVersion() {
    return DeviceIdentifierPlatform.instance.getPlatformVersion();
  }
}
