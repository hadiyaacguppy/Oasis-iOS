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
    static func call(phoneNumber pn : String){
        guard let number = URL(string: "tel://" + pn) else { return }
        UIApplication.shared.open(number)
    }
    
    static func openURL(withString str : String){
        if let url = URL(string: str){
            UIApplication.shared.open(url , options: [:], completionHandler: nil)
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
    struct GoogleMaps {
        static func goToGoogleMapsNavigation(withLongitude long : Double , andLatitude lat : Double){
            goToGoogleMapsNavigation(withLongitude: Float(long), andLatitude: Float(lat))
        }
        static func goToGoogleMapsNavigation(withLongitude long : Float , andLatitude lat : Float){
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?daddr=\(lat),\(long)&directionsmode=driving")! as URL)
                
            } else {
                // if GoogleMap App is not installed
                UIApplication.shared.openURL(NSURL(string:
                    "https://www.google.co.in/maps/dir/?&daddr=\(lat),\(long)&directionsmode=driving")! as URL)
            }
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
        
        var version : Float {
            return  Float(UIDevice.current.systemVersion)!
        }
        

        var height : CGFloat{
           return  UIScreen.main.bounds.size.height
        }
        
        var isIpad : Bool {
           return UIDevice.current.userInterfaceIdiom == .pad
        }
       
        var isIPhone : Bool {
            return UIDevice.current.userInterfaceIdiom == .phone
        }
        var isIphoneX : Bool {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            default:
                 return false
            }
        }
 

     
        
        // MARK: Retina Check
        
     
        // MARK: - International Checks
        
      
    }
    


}




