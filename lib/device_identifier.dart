import 'device_identifier_platform_interface.dart';

class DeviceIdentifier {
  Future<String> getIdentifier() async {
    return await DeviceIdentifierPlatform.instance.getIdentifier();
  }
}
