import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_identifier_method_channel.dart';

abstract class DeviceIdentifierPlatform extends PlatformInterface {
  /// Constructs a DeviceIdentifierPlatform.
  DeviceIdentifierPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceIdentifierPlatform _instance = MethodChannelDeviceIdentifier();

  /// The default instance of [DeviceIdentifierPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceIdentifier].
  static DeviceIdentifierPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceIdentifierPlatform] when
  /// they register themselves.
  static set instance(DeviceIdentifierPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getIdentifier() async {
    throw UnimplementedError('getIdentifier() has not been implemented.');
  }
}
