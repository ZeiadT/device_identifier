package com.example.device_identifier

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.annotation.SuppressLint
import android.provider.Settings


/** DeviceIdentifierPlugin */
class DeviceIdentifierPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var binding: FlutterPlugin.FlutterPluginBinding? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_identifier")
    channel.setMethodCallHandler(this)
    binding = flutterPluginBinding
  }

  @SuppressLint("HardwareIds")
  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getIdentifier") {
       val context = binding?.applicationContext
       if (context == null) {
           result.error("UNAVAILABLE", "Context is not available.", null)
           return
       }
       val androidId = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
       if (androidId != null) {
            result.success(androidId)
       } else {
            result.error("UNAVAILABLE", "Android ID is not available.", null)
       }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    this.binding = null
  }
}
