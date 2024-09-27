import 'package:flutter/services.dart';

abstract class AnalyticsService {
  Future<void> sendAnalyticsEvent(String event, Map<String, String> parameters);
}

class AnalyticsServiceImpl implements AnalyticsService {
  static const platform = MethodChannel('com.example.analytics');

  @override
  Future<void> sendAnalyticsEvent(String event, Map<String, String> parameters) async {
    try {
      await platform.invokeMethod('sendAnalyticsEvent', {
        'event': event,
        'parameters': parameters,
      });
    } on PlatformException catch (e) {
      print("Failed to send analytics event: '${e.message}'.");
    }
  }
}