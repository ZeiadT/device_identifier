import Flutter
import UIKit
import Security

public class DeviceIdentifierPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_identifier", binaryMessenger: registrar.messenger())
    let instance = DeviceIdentifierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getIdentifier":
      let identifier = getDeviceIdentifier()
      result(identifier)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    // Manages getting the identifier from the Keychain
  private func getDeviceIdentifier() -> String {
    // Define a unique identifier for your keychain entry
    let service = Bundle.main.bundleIdentifier ?? "com.flutter.deviceIdentifier"
    let account = "uniqueDeviceIdentifier"

    // 1. Try to load an existing identifier
    if let existingIdentifier = load(service: service, account: account) {
      return existingIdentifier
    }

    // 2. If none exists, create a new one
    let newIdentifier = UUID().uuidString

    // 3. Save the new identifier to the Keychain
    save(service: service, account: account, data: newIdentifier)
    
    return newIdentifier
  }

  // Saves a string to the Keychain
  private func save(service: String, account: String, data: String) {
    guard let dataFromString = data.data(using: .utf8, allowLossyConversion: false) else {
      return
    }

    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecValueData as String: dataFromString
    ]

    // Delete any existing item to avoid duplicates
    SecItemDelete(query as CFDictionary)
    
    // Add the new item
    SecItemAdd(query as CFDictionary, nil)
  }

  // Loads a string from the Keychain
  private func load(service: String, account: String) -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecReturnData as String: kCFBooleanTrue!,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]

    var dataTypeRef: AnyObject?
    let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
      return String(data: retrievedData, encoding: .utf8)
    } else {
      return nil
    }
  }
}
