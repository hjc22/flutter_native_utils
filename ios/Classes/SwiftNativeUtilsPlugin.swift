import Flutter
import UIKit
import StoreKit;



public class SwiftNativeUtilsPlugin: NSObject, FlutterPlugin {
  
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "piugins.hjc.com/native_utils", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
    var result: FlutterResult?;

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if "insideOpenAppStore" == call.method {
        let appid: String;
        if call.arguments is String {
           appid = call.arguments as! String
            if !appid.isEmpty  {
               self.result = result
               insideOpenAppStore(appId: appid)
            }
        }
    }
    else if "openAppStore" == call.method {
        let appid: String;
        if call.arguments is String {
           appid = call.arguments as! String
            if !appid.isEmpty  {
                openAppStore(appId: appid)
                result(true);
            }
        }
    }
    else {
        result(FlutterMethodNotImplemented)
    }
  }
    
  private func controller() -> UIViewController? {
    guard let window = UIApplication.shared.keyWindow else { print("no window"); return nil }
    guard let rvc = window.rootViewController else { print("no rvc"); return nil }
    guard let fvc = rvc as? FlutterViewController else { return nil }
    window.rootViewController = fvc as UIViewController?
    return fvc
  }
    
    public func openAppStore (appId: String) {
        let app = UIApplication.shared;
        let url = URL(string: "itms-apps://itunes.apple.com/app/id" + appId)
        
        if #available(iOS 10.0, *) {
            app.open(url!, options: [:], completionHandler: {(success: Bool) in
                if success {
                    print("Launching \(url!) was successful")
                }})
        }
        else {
          app.openURL(url!);
        }
        
  }
    
}

extension SwiftNativeUtilsPlugin {
    public func insideOpenAppStore(appId: String){
              let productView = SKStoreProductViewController()
      let parametersDictionary = [SKStoreProductParameterITunesItemIdentifier: appId];
      
      productView.delegate = self
        
     let controller = self.controller();
        
     guard controller != nil else {
            self.result?(FlutterError(code: "NO_CONTROLLER", message: "Error Method openAppStore", details: nil));
            self.result = nil;
            return
     }
    
      productView.loadProduct(withParameters: parametersDictionary, completionBlock: {[unowned self] (result: Bool, error: Error?) in
      if result {
        if controller!.presentingViewController != nil {
            controller!.presentingViewController?.dismiss(animated: false, completion: nil)
        }
        controller!.present(productView, animated: true, completion: {
              self.result?(true);
              self.result = nil;
          })
      } else {
          if let error = error {
              print("Error: \(error.localizedDescription)")
              self.result?(FlutterError(code: "OPEN_APPSTORE_FAIL", message: "Error Method openAppStore", details: error.localizedDescription));
              self.result = nil;
          }
      }})
      
    }
}

extension SwiftNativeUtilsPlugin: SKStoreProductViewControllerDelegate {
    /// Used to dismiss the store view controller.
     public func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.presentingViewController?.dismiss(animated: true, completion: {
            self.result?(false);
            self.result = nil;
            print("The store view controller was dismissed.")
        })
    }
}
