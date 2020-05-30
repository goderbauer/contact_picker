import Flutter
import UIKit
import ContactsUI

public class SwiftContactPickerPlugin: NSObject, FlutterPlugin, CNContactPickerDelegate {
    
    var _result: FlutterResult?;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "contact_picker", binaryMessenger: registrar.messenger())
        let instance = SwiftContactPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if("selectContact" == call.method) {
            if(_result != nil) {
                _result?(FlutterError(code: "multiple_requests", message: "Cancelled by a second request.", details: nil));
                _result = nil;
            }
            _result = result;
            
            if #available(iOS 9.0, *) {
                let contactPicker = CNContactPickerViewController()
                contactPicker.delegate = self
                contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
                
                let viewController = UIApplication.shared.windows.first?.rootViewController
                viewController?.present(contactPicker, animated: true, completion: nil)
                
                
            } else {
                _result?(FlutterError(code: "unsupported_platform_version", message: "Please use at least ios 9.0 to get this feature", details: nil));
            };
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    @available(iOS 9.0, *)
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        var data = Dictionary<String, Any>()
        data["fullName"] = CNContactFormatter.string(from: contact, style: CNContactFormatterStyle.fullName)
        
        let numbers: Array<String> = contact.phoneNumbers.compactMap { $0.value.stringValue as String }
        data["phoneNumbers"] = numbers
        
        _result?(data)
        _result = nil
    }
    
    @available(iOS 9.0, *)
    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        _result?(nil)
        _result = nil
    }
}
