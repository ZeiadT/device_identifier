import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_identifier_platform_interface.dart';

/// An implementation of [DeviceIdentifierPlatform] that uses method channels.
class MethodChannelDeviceIdentifier extends DeviceIdentifierPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_identifier');

  @override
  Future<String?> getIdentifier() async {
    try {
      final String? identifier =
          await methodChannel.invokeMethod('getIdentifier');

      if (kDebugMode) {
        print("Device identifier: '$identifier'.");
      }

      return identifier;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get device identifier: '${e.message}'.");
      }
      return null;
    }
  }
}
