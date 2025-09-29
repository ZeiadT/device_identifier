import 'package:flutter_test/flutter_test.dart';
import 'package:device_identifier/device_identifier.dart';
import 'package:device_identifier/device_identifier_platform_interface.dart';
import 'package:device_identifier/device_identifier_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceIdentifierPlatform
    with MockPlatformInterfaceMixin
    implements DeviceIdentifierPlatform {
  @override
  Future<String> getIdentifier() => Future.value('42');
}

void main() {
  final DeviceIdentifierPlatform initialPlatform =
      DeviceIdentifierPlatform.instance;

  test('$MethodChannelDeviceIdentifier is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceIdentifier>());
  });

  test('getPlatformVersion', () async {
    DeviceIdentifier deviceIdentifierPlugin = DeviceIdentifier();
    MockDeviceIdentifierPlatform fakePlatform = MockDeviceIdentifierPlatform();
    DeviceIdentifierPlatform.instance = fakePlatform;

    expect(await deviceIdentifierPlugin.getIdentifier(), '42');
  });
}
