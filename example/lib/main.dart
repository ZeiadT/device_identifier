import 'package:device_identifier/device_identifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceIdentifier = 'Unknown';
  final _deviceIdentifierPlugin = DeviceIdentifier();

  @override
  void initState() {
    super.initState();
    initIdentifierState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initIdentifierState() async {
    String? deviceIdentifier;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      deviceIdentifier = await _deviceIdentifierPlugin.getIdentifier();
    } on PlatformException {
      if (kDebugMode) {
        print(
          'Failed to get platform version. Device Identifier: $deviceIdentifier',
        );
      }
      deviceIdentifier = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceIdentifier = deviceIdentifier!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('Device Identifier: $_deviceIdentifier\n')),
      ),
    );
  }
}
