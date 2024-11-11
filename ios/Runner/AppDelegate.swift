import Flutter
import UIKit
import JWPlayerKit
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      weak var registrar = self.registrar(forPlugin: "plugin-name")
    let factory = FLNativeViewFactory(messenger: registrar!.messenger())
      registrar?.register(
                 factory,
                 withId: "JWPayerView")
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      ChannelHandler.shared.initiate(messenger: controller.binaryMessenger)
      ChannelHandler.shared.setMethodCallHandler()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


class ChannelHandler {
    static let shared = ChannelHandler()
    private let channelName = "jwplayerCallBack"
    private var methodChannel: FlutterMethodChannel!
    func initiate(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: "jwplayerCallBack", binaryMessenger: messenger)
    }
    private init(){}
    
    func setMethodCallHandler() {
        methodChannel.setMethodCallHandler(handle)
    }
    
    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
           switch call.method {
           case "getNetworkStatus":
               break;
//               getNetworkStatus { status in
//                   result(status)
//               }
           default:
               result(FlutterMethodNotImplemented)
           }
       }
    
    func fullScreenDismiss() {
        methodChannel.invokeMethod("fullScreenDismiss", arguments: ["value":true])
    }
}
