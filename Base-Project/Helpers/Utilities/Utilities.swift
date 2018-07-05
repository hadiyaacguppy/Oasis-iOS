//
//  Utilities.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SVProgressHUD
import SystemConfiguration
import MobileCoreServices

struct Utilities  {
    
    struct  CollectionView {
        static public func setHorizontalLayout(forCollectionView collectionView: UICollectionView) {
            
            let layout = UICollectionViewFlowLayout()
            
            layout.scrollDirection = .horizontal
            
            collectionView.collectionViewLayout = layout
        }
    }
    
    struct AlertViews {
        static func showAlertView(_ title: String, message: String, actions: [UIAlertAction], withPresenter presenter: UIViewController, withCompletionHandler handler: (() -> Void)?) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                alertController.addAction(action)
            }
            OperationQueue.main.addOperation {
                presenter.present(alertController, animated: true) {
                    handler?()
                }
            }
        }
        
        static func showSimpleAlertView(_ title: String, message: String, withPresneter presenter: UIViewController, withCompletionHandler handler: (() -> Void)?) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .default, handler: nil))
            OperationQueue.main.addOperation {
                presenter.present(alertController, animated: true) {
                    handler?()
                }
            }
        }
        
        static func showNoInternetAlertView(withPresenter presenter: UIViewController) {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Internet connection is not available", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .default, handler: nil))
            OperationQueue.main.addOperation {
                presenter.present(alertController, animated: true, completion: nil)
            }
        }
        
        static func showServerErrorAlertView(withPresenter presenter: UIViewController) {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("A server error has occured. please try again later", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .default, handler: nil))
            OperationQueue.main.addOperation {
                presenter.present(alertController, animated: true, completion: nil)
            }
        }
        
        static func showActionSheet(wthTitle title: String?, withMessage message: String?, havingOptions actions: [UIAlertAction], withPresenter presenter: UIViewController, withCompletionHandler handler: (() -> Void)?) {
            let actionSheet = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .actionSheet)
            for action in actions {
                actionSheet.addAction(action)
            }
            OperationQueue.main.addOperation {
                presenter.present(actionSheet, animated: true) {
                    handler?()
                }
            }
        }
        
        static func showTokenExpiryAlertController (presenter : AppDelegate){
            let alertVC = UIAlertController(title: NSLocalizedString("Session Expired", comment: ""), message: NSLocalizedString("You Have to Login", comment: ""), preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .cancel, handler: nil)
            let loginButton = UIAlertAction(title: NSLocalizedString("Login", comment: ""), style: .default) { (action) in
                //DataManager.instance.signOut()
            }
            
            alertVC.addAction(cancelButton)
            alertVC.addAction(loginButton)
            presenter.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    struct ViewControllers {
        
        static func redirectTo(viewWithIdentifier iden: String, fromStoryBoardWithName sname: String) {
            let view = Utilities.ViewControllers.viewControllerWith(iden, fromStoryboard: sname)
            DispatchQueue.main.async {
                UIApplication.shared.windows.first!.rootViewController = view
            }
        }
        
        static func  viewControllerWith(_ identifier: String, fromStoryboard storyboardName: String) -> UIViewController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
        }
        
    }
    
    struct TapGestures {
        static public func initiateTapGesture(addToView view: UIView, withTarget target: Any, andAction action: Selector) {
            let tap = UITapGestureRecognizer(target: target, action: action)
            tap.numberOfTapsRequired = 1
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tap)
        }
    }
    
    struct  TextFields {
        
        static func addDoneButton(toTextField textView: UITextField, withViewController vc : UIViewController){
            let  barButton = UIBarButtonItem(barButtonSystemItem: .done, target: textView, action: #selector(vc.resignFirstResponder))
            let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.width, height: 44))
            
            toolbar.items = [flexibleItem , barButton]
            textView.inputAccessoryView = toolbar
        }
    }
    
    struct TextViews {
        static func addDoneButton(toTextView textView: UITextView, withViewController vc : UIViewController){
            let  barButton = UIBarButtonItem(barButtonSystemItem: .done, target: textView, action: #selector(vc.resignFirstResponder))
            let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.width, height: 44))
            
            toolbar.items = [flexibleItem , barButton]
            textView.inputAccessoryView = toolbar
        }
    }
    
    struct Location {
        enum LocationServiesAccessPermissionError : String, Error {
            case locationServicesNotEnabled  = "Please Enable Location Services"
            case notDetermined  = "Not Determined."
            case restricted = "restricted"
            case denied = "Denied"
        }
        
        static func checkLocationServicesStatus() throws {
            guard CLLocationManager.locationServicesEnabled()  else {
                throw LocationServiesAccessPermissionError.locationServicesNotEnabled
            }
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                throw LocationServiesAccessPermissionError.notDetermined
            case .denied :
                throw LocationServiesAccessPermissionError.denied
            case .restricted :
                throw LocationServiesAccessPermissionError.restricted
            case .authorizedAlways, .authorizedWhenInUse:
                return
            }
        }
    }
    
    struct ProgressHUD {
        static func showLoading(){
            SVProgressHUD.show()
        }
        static func showLoading(withMessage msg : String ){
            SVProgressHUD.show(withStatus: msg )
        }
        static func showSuccess(withMessage msg : String ){
            SVProgressHUD.showSuccess(withStatus: msg)
        }
        static func showError(withMessage msg : String ){
            SVProgressHUD.showError(withStatus: msg)
        }
        static func dismissLoading(){
            SVProgressHUD.dismiss()
        }
    }
    
    struct File {
        // MARK: File
        static func getFileURL(_ fileName: String) -> String? {
            let fileURL = FileManager().urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
            
            return (fileURL?.appendingPathComponent(fileName).path)
        }
    }
    
    struct Conversions {
        /**
         transforms a unix time to a Date or String
         
         - parameter unixtimeInterval: The epochTime value as 128312087
         - parameter returnTypeYouAreAimingFor: the type you want this function to return, "Date" or "String", default is Date
         - parameter stringFormat: The date format, default is yyyy-MM-dd
         
         - returns: Any, need to cast as String || Date
         */
        static func stringFromUnix(_ unixtimeInterval: Int,_ returnTypeYouAreAimingFor: String?,_ stringFormat: String?) -> Any {
            
            let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
            if returnTypeYouAreAimingFor == "Date" {//Return the date as Date Type if user wanted it as date
                return date
            }else{//Return the date as String
                let dateFormatter = DateFormatter()
                //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
                //dateFormatter.locale = NSLocale.current
                
                if stringFormat == nil {//Return the default one
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                }else{//Or if passed return the format the user wants
                    dateFormatter.dateFormat = stringFormat
                }
                
                let strDate = dateFormatter.string(from: date)
                
                return strDate
            }
        }
    }
    
    // MARK: - Device Structure
    /// Helper functions to detect current device, screen sizes, debug or release, iOS Version and more..
    struct Device {
        
        // MARK: - Singletons
        
        static var TheCurrentDevice: UIDevice {
            struct Singleton {
                static let device = UIDevice.current
            }
            return Singleton.device
        }
        
        static var TheCurrentDeviceVersion: Float {
            struct Singleton {
                static let version = Float(UIDevice.current.systemVersion)
            }
            return Singleton.version!
        }
        
        static var TheCurrentDeviceHeight: CGFloat {
            struct Singleton {
                static let height = UIScreen.main.bounds.size.height
            }
            return Singleton.height
        }
        
        // MARK: - Device Idiom Checks
        
        static var PHONE_OR_PAD: String {
            if isPhone() {
                return "iPhone"
            } else if isPad() {
                return "iPad"
            }
            return "Not iPhone nor iPad"
        }
        
        static var DEBUG_OR_RELEASE: String {
            #if DEBUG
            return "Debug"
            #else
            return "Release"
            #endif
        }
        
        static var SIMULATOR_OR_DEVICE: String {
            #if (arch(i386) || arch(x86_64)) && os(iOS)
            return "Simulator"
            #else
            return "Device"
            #endif
        }
        
        //    static var CURRENT_DEVICE: String {
        //        return GBDeviceInfo.deviceInfo().modelString
        //    }
        
        static func isPhone() -> Bool {
            return TheCurrentDevice.userInterfaceIdiom == .phone
        }
        
        static func isPad() -> Bool {
            return TheCurrentDevice.userInterfaceIdiom == .pad
        }
        
        static func isDebug() -> Bool {
            return DEBUG_OR_RELEASE == "Debug"
        }
        
        static func isRelease() -> Bool {
            return DEBUG_OR_RELEASE == "Release"
        }
        
        static func isSimulator() -> Bool {
            return SIMULATOR_OR_DEVICE == "Simulator"
        }
        
        static func isDevice() -> Bool {
            return SIMULATOR_OR_DEVICE == "Device"
        }
        
        // MARK: - Device Version Checks
        
        enum Versions: Float {
            case Five = 5.0
            case Six = 6.0
            case Seven = 7.0
            case Eight = 8.0
            case Nine = 9.0
        }
        
        static func isVersion(version: Versions) -> Bool {
            return TheCurrentDeviceVersion >= version.rawValue && TheCurrentDeviceVersion < (version.rawValue + 1.0)
        }
        
        static func isVersionOrLater(version: Versions) -> Bool {
            return TheCurrentDeviceVersion >= version.rawValue
        }
        
        static func isVersionOrEarlier(version: Versions) -> Bool {
            return TheCurrentDeviceVersion < (version.rawValue + 1.0)
        }
        
        static var CURRENT_VERSION: String {
            return "\(TheCurrentDeviceVersion)"
        }
        
        // MARK: iOS 5 Checks
        
        static func IS_OS_5() -> Bool {
            return isVersion(version: .Five)
        }
        
        static func IS_OS_5_OR_LATER() -> Bool {
            return isVersionOrLater(version: .Five)
        }
        
        static func IS_OS_5_OR_EARLIER() -> Bool {
            return isVersionOrEarlier(version: .Five)
        }
        
        // MARK: iOS 6 Checks
        
        static func IS_OS_6() -> Bool {
            return isVersion(version: .Six)
        }
        
        static func IS_OS_6_OR_LATER() -> Bool {
            return isVersionOrLater(version: .Six)
        }
        
        static func IS_OS_6_OR_EARLIER() -> Bool {
            return isVersionOrEarlier(version: .Six)
        }
        
        // MARK: iOS 7 Checks
        
        static func IS_OS_7() -> Bool {
            return isVersion(version: .Seven)
        }
        
        static func IS_OS_7_OR_LATER() -> Bool {
            return isVersionOrLater(version: .Seven)
        }
        
        static func IS_OS_7_OR_EARLIER() -> Bool {
            return isVersionOrEarlier(version: .Seven)
        }
        
        // MARK: iOS 8 Checks
        
        static func IS_OS_8() -> Bool {
            return isVersion(version: .Eight)
        }
        
        static func IS_OS_8_OR_LATER() -> Bool {
            return isVersionOrLater(version: .Eight)
        }
        
        static func IS_OS_8_OR_EARLIER() -> Bool {
            return isVersionOrEarlier(version: .Eight)
        }
        
        // MARK: iOS 9 Checks
        
        static func IS_OS_9() -> Bool {
            return isVersion(version: .Nine)
        }
        
        static func IS_OS_9_OR_LATER() -> Bool {
            return isVersionOrLater(version: .Nine)
        }
        
        static func IS_OS_9_OR_EARLIER() -> Bool {
            return isVersionOrEarlier(version: .Nine)
        }
        
        // MARK: - Device Size Checks
        
        enum Heights: CGFloat {
            case Inches_3_5 = 480
            case Inches_4 = 568
            case Inches_4_7 = 667
            case Inches_5_5 = 736
        }
        
        static func isSize(height: Heights) -> Bool {
            return TheCurrentDeviceHeight == height.rawValue
        }
        
        static func isSizeOrLarger(height: Heights) -> Bool {
            return TheCurrentDeviceHeight >= height.rawValue
        }
        
        static func isSizeOrSmaller(height: Heights) -> Bool {
            return TheCurrentDeviceHeight <= height.rawValue
        }
        
        static var CURRENT_SIZE: String {
            if IS_3_5_INCHES() {
                return "3.5 Inches"
            } else if IS_4_INCHES() {
                return "4 Inches"
            } else if IS_4_7_INCHES() {
                return "4.7 Inches"
            } else if IS_5_5_INCHES() {
                return "5.5 Inches"
            }
            return "\(TheCurrentDeviceHeight) Points"
        }
        
        // MARK: Retina Check
        
        static func IS_RETINA() -> Bool {
            return UIScreen.main.responds(to: "scale")
        }
        
        // MARK: 3.5 Inch Checks
        
        static func IS_3_5_INCHES() -> Bool {
            return isPhone() && isSize(height: .Inches_3_5)
        }
        
        static func IS_3_5_INCHES_OR_LARGER() -> Bool {
            return isPhone() && isSizeOrLarger(height: .Inches_3_5)
        }
        
        static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
            return isPhone() && isSizeOrSmaller(height: .Inches_3_5)
        }
        
        // MARK: 4 Inch Checks
        
        static func IS_4_INCHES() -> Bool {
            return isPhone() && isSize(height: .Inches_4)
        }
        
        static func IS_4_INCHES_OR_LARGER() -> Bool {
            return isPhone() && isSizeOrLarger(height: .Inches_4)
        }
        
        static func IS_4_INCHES_OR_SMALLER() -> Bool {
            return isPhone() && isSizeOrSmaller(height: .Inches_4)
        }
        
        // MARK: 4.7 Inch Checks
        
        static func IS_4_7_INCHES() -> Bool {
            return isPhone() && isSize(height: .Inches_4_7)
        }
        
        static func IS_4_7_INCHES_OR_LARGER() -> Bool {
            return isPhone() && isSizeOrLarger(height: .Inches_4_7)
        }
        
        static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
            return isPhone() && isSizeOrLarger(height: .Inches_4_7)
        }
        
        // MARK: 5.5 Inch Checks
        
        static func IS_5_5_INCHES() -> Bool {
            return isPhone() && isSize(height: .Inches_5_5)
        }
        
        static func IS_5_5_INCHES_OR_LARGER() -> Bool {
            return isPhone() && isSizeOrLarger(height: .Inches_5_5)
        }
        
        static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
            return isPhone() && isSizeOrLarger(height: .Inches_5_5)
        }
        
        // MARK: - International Checks
        
        static var CURRENT_REGION: String {
            return NSLocale.current.regionCode!
        }
        
        // Gets Device Unique UDID
        static func getDeviceUDID() -> String {
            return UIDevice.current.identifierForVendor!.uuidString
        }
    }
    
    struct Network {
        /**
         Checks if the device is connected to the internet
         
         - returns: True if connected. False if not
         */
        
        static func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else {
                return false
            }
            
            var flags: SCNetworkReachabilityFlags = []
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            return (isReachable && !needsConnection)
        }
    }

}




