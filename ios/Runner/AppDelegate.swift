import UIKit
import Flutter
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.example.analytics", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "sendAnalyticsEvent" {
        if let args = call.arguments as? [String: Any],
           let event = args["event"] as? String,
           let parameters = args["parameters"] as? [String: String] {
          self.sendAnalyticsEvent(event: event, parameters: parameters)
          result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func sendAnalyticsEvent(event: String, parameters: [String: String]) {
    let analytics = Analytics.analytics()
    analytics.logEvent(event, parameters: parameters)
  }
}

