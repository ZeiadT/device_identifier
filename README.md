# device_identifier

A cross-platform Flutter plugin to retrieve a unique and persistent device identifier.

On Android: Returns the Settings.Secure.ANDROID_ID. This value remains constant for the lifetime of the device's installation, changing only on factory reset.

On iOS: Generates a UUID and stores it securely in the Keychain. This identifier persists across app uninstalls and is only removed on a factory reset.

## Getting Started

Add this to your package's pubspec.yaml file:

dependencies:
  device_identifier: ^1.0.0 # Use the latest version

Then, run flutter pub get in your terminal.

## Usage

Here is a simple example of how to use the plugin in your Flutter app.

import 'package:flutter/material.dart';
import 'package:device_identifier/device_identifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceIdentifier = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchIdentifier();
  }

  Future<void> _fetchIdentifier() async {
    String? identifier;
    try {
      identifier = await DeviceIdentifier.getIdentifier();
    } catch (e) {
      print('Failed to get identifier: $e');
    }
    
    if (!mounted) return;

    setState(() {
      _deviceIdentifier = identifier ?? 'Failed to get identifier';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Identifier Plugin'),
        ),
        body: Center(
          child: Text('Device ID: $_deviceIdentifier'),
        ),
      ),
    );
  }
}

## Platform Support

Android ✅
iOS ✅

Additional Information
Feel free to file issues, contribute, or give feedback on the GitHub repository. 
https://github.com/ZeiadT/device_identifier.git

