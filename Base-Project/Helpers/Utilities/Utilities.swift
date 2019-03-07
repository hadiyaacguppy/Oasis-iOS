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
import RxSwift
import MessageUI

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
    
    static func canOpen(url : URL?)
        ->Bool{
            if url == nil { return false }
            return UIApplication.shared.canOpenURL(url!)
    }
    
    static func openAppSettings(){
        if self.canOpen(url: URL(string:UIApplicationOpenSettingsURLString)){
            self.openURL(withString: UIApplicationOpenSettingsURLString)
        }
    }
    
    static func sendEmail(To to : String,
                          withSubject subject : String?,
                          andContent content : String?,
                          withPresentingViewController vc : (UIViewController & MFMailComposeViewControllerDelegate))  {
        
        let actionSheet = UIAlertController(title: "Choose email".localized,
                                            message: "",
                                            preferredStyle: .actionSheet)
        
        var actionArray = [TDAlertAction]()
        
        let gmailSchema = Constants.URLSchemas.MailApps.gmail.rawValue
        let sparkSchema = Constants.URLSchemas.MailApps.spark.rawValue
        let outlookSchema = Constants.URLSchemas.MailApps.outlook.rawValue
        let inboxGmailSchema = Constants.URLSchemas.MailApps.inboxGmail.rawValue
        
        
        if canOpen(url: "mailto:".asURL()){
            let mail = TDAlertAction.handlerSavingAlertAction(title: "Mail".localized,
                                                              style: .default,
                                                              completionHandler: { (alert) in
                                                                let composeVC = MFMailComposeViewController()
                                                                composeVC.mailComposeDelegate = vc
                                                                composeVC.setToRecipients([to])
                                                                if subject != nil { composeVC.setSubject(subject!) }
                                                                if content != nil { composeVC.setMessageBody(content!, isHTML: true) }
                                                                vc.present(composeVC, animated: true, completion: nil)
            })
            actionArray.append(mail)
        }
        
        if canOpen(url: gmailSchema.asURL()){
            let gmail = TDAlertAction.handlerSavingAlertAction(title: "Gmail".localized,
                                                               style: .default,
                                                               completionHandler: { (alert) in
                                                                let urlToOpen = gmailSchema + "co?subject=\(subject ?? "")&body=\(content ?? "")&to=\(to)"
                                                                openURL(withString: urlToOpen)
            })
            actionArray.append(gmail)
        }
        
        if canOpen(url: outlookSchema.asURL()){
            let outlook = TDAlertAction.handlerSavingAlertAction(title: "Outlook".localized,
                                                                 style: .default,
                                                                 completionHandler: { (alert) in
                                                                    let urlToOpen = outlookSchema + "compose?to=\(to)&subject=\(subject ?? "")&body=\(content ?? "")"
                                                                    openURL(withString: urlToOpen)
            })
            actionArray.append(outlook)
        }
        
        if canOpen(url: sparkSchema.asURL()){
            let spark = TDAlertAction.handlerSavingAlertAction(title: "Spark".localized,
                                                               style: .default,
                                                               completionHandler: { (alert) in
                                                                let urlToOpen = sparkSchema + "compose?subject=\(subject ?? "")&body=\(content ?? "")&recipient=\(to)"
                                                                openURL(withString: urlToOpen)
            })
            actionArray.append(spark)
        }
        
        if canOpen(url: inboxGmailSchema.asURL()){
            let inbox = TDAlertAction.handlerSavingAlertAction(title: "Inbox".localized,
                                                               style: .default,
                                                               completionHandler: { (alert) in
                                                                let urlToOpen = inboxGmailSchema + "co?to=\(to)&subject=\(subject ?? "")&body=\(content ?? "")"
                                                                openURL(withString: urlToOpen)
            })
            actionArray.append(inbox)
        }
        if actionArray.count == 0 { return }
        if actionArray.count == 1 {
            let action = actionArray[0]
            if let handler = action.completionHandler{
                handler(action)
                return
            }
        }
        actionArray.forEach{actionSheet.addAction($0)}
        
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized,
                                            style: .cancel,
                                            handler: nil))
        
        vc.present(actionSheet,
                   animated: true,
                   completion: nil)
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
        
        static func showSimpleAlertView(_ title: String, message: String, withPresneter presenter: UIViewController, withCompletionHandler handler: (() -> Void)? ,andDismissHandler dimiss :  (() -> Void)? = nil ) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default) { action in 
                dimiss?()
            })
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
        
        static func showActivityController(withLinkToShare link : String ,andWithPresenter presenter: UIViewController) {
            let activityItems = [link]
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            presenter.present(activityController, animated: true, completion: nil)
        }
        
        static func showChangeLanguageInformativeAlertView(withPresenter presenter: UIViewController){
            self.showSimpleAlertView("Change Language Guide".localized,
                                                     message: "In Order to change the language of the app, you to need change the language of the device, Open Settings -> Tap General -> Select Language & Region -> Tap Device language -> Select your language once your device rebooted, reopen the app.".localized,
                                                     withPresneter: presenter,
                                                     withCompletionHandler: nil)
        }
        
    }
    
    struct Font{
        
        /// This function will apply the symbolic traits i.e(<i> ,<strong>.. tags) from the original font to the newely created Font.
        ///
        /// - Parameters:
        ///   - fromFont: Original Font
        ///   - toFont: Custom font to be used
        /// - Returns: New font with the original font traits
        static func copySymbolicTraits(from fromFont : UIFont,
                                       to toFont : UIFont) -> UIFont?{
            let fromFontSymbolicTraits = fromFont.fontDescriptor.symbolicTraits
            guard let toFontWithSymbolicTraits = toFont.fontDescriptor.withSymbolicTraits(fromFontSymbolicTraits) else {
                return nil
            }
            return UIFont(descriptor: toFontWithSymbolicTraits,
                          size: 0
            )
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
            if Utilities.canOpen(url: URL(string:"comgooglemaps://")){
                Utilities.openURL(withString: "comgooglemaps://?daddr=\(lat),\(long)&directionsmode=driving")
            } else {
                // if GoogleMap App is not installed
                Utilities.openURL(withString: "https://www.google.co.in/maps/dir/?&daddr=\(lat),\(long)&directionsmode=driving")
            }
        }
    }
    struct Enviroment {
        var isProduction : Bool {
            #if DEBUG
            return false
            #elseif ADHOC
            return false
            #else
            return true
            #endif
        }
        var isDebug : Bool {
            return !isProduction
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
            SVProgressHUD.setDefaultStyle(Constants.ProgressHud.style)
            SVProgressHUD.setDefaultAnimationType(Constants.ProgressHud.animationType)
            SVProgressHUD.show()
        }
        static func showLoading(withMessage msg : String ){
            SVProgressHUD.setDefaultStyle(Constants.ProgressHud.style)
            SVProgressHUD.setDefaultAnimationType(Constants.ProgressHud.animationType)
            SVProgressHUD.show(withStatus: msg )
        }
        static func showSuccess(withMessage msg : String ){
            SVProgressHUD.setDefaultStyle(Constants.ProgressHud.style)
            SVProgressHUD.setDefaultAnimationType(Constants.ProgressHud.animationType)
            SVProgressHUD.showSuccess(withStatus: msg)
        }
        static func showError(withMessage msg : String ){
            SVProgressHUD.setDefaultStyle(Constants.ProgressHud.style)
            SVProgressHUD.setDefaultAnimationType(Constants.ProgressHud.animationType)
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
    
    struct Web {
        
        /// Present an action sheet that displays the browser's app that can open the given link
        ///
        /// - Parameter url: the string that represent the url top be openned.
        static func openLink(forURL url : String){
            guard let urlToOpen = URL(string: url)  else { return }
            
            var actionArray = [TDAlertAction]()
            
            let actionSheet = UIAlertController(title: "Where do you want to open it".localized,
                                                message: "",
                                                preferredStyle: .actionSheet)
            
            if UIApplication.shared.canOpenURL(urlToOpen) {
                let safari = TDAlertAction.handlerSavingAlertAction(title: "Safari".localized,
                                                                    style: .default,
                                                                    completionHandler: {
                                                                        (alert: UIAlertAction!) -> Void in
                                                                        UIApplication.shared.open(URL(string: url)!,
                                                                                                  options: [:],
                                                                                                  completionHandler: nil)
                })
                actionArray.append(safari)
            }
            
            var chromeSchema : String?
            var chromeURL : URL?
            
            var fireFoxSchema : String?
            var fireFoxURL : URL?
            
            var operaSchema : String?
            var operaURL : URL?
            
            if urlToOpen.isHTTPSSchema{
                chromeSchema = Constants.URLSchemas.Browsers.securedChrome.rawValue
                fireFoxSchema = Constants.URLSchemas.Browsers.securedFireFox.rawValue
                operaSchema = Constants.URLSchemas.Browsers.securedOpera.rawValue
                
            }else{
                chromeSchema = Constants.URLSchemas.Browsers.notSecuredChrome.rawValue
                fireFoxSchema = Constants.URLSchemas.Browsers.notSecuredFireFox.rawValue
                operaSchema = Constants.URLSchemas.Browsers.notSecuredOpera.rawValue
            }
            
            
            if chromeSchema != nil {
                if let host  = urlToOpen.host{
                    chromeURL = URL(string:chromeSchema! + host)
                    if chromeURL != nil {
                        if UIApplication.shared.canOpenURL(chromeURL!) {
                            let chrome = TDAlertAction.handlerSavingAlertAction(title: "Chrome".localized,
                                                                                style: .default,
                                                                                completionHandler: {
                                                                                    (alert: UIAlertAction!) -> Void in
                                                                                    UIApplication.shared.open(chromeURL!,
                                                                                                              options: [:],
                                                                                                              completionHandler: nil)
                            })
                            actionArray.append(chrome)
                        }
                    }
                }
                
            }
            
            if fireFoxSchema != nil {
                if let host = urlToOpen.host{
                    fireFoxURL = URL(string: fireFoxSchema! + host)
                    if fireFoxURL != nil{
                        if UIApplication.shared.canOpenURL(fireFoxURL!) {
                            let firefox = TDAlertAction.handlerSavingAlertAction(title: "FireFox".localized,
                                                                                 style: .default,
                                                                                 completionHandler: {
                                                                                    (alert: UIAlertAction!) -> Void in
                                                                                    UIApplication.shared.open(fireFoxURL!,
                                                                                                              options: [:],
                                                                                                              completionHandler: nil)
                            })
                            actionArray.append(firefox)
                        }
                    }
                }
            }
            
            
            if operaSchema != nil {
                if let host = urlToOpen.host{
                    operaURL = URL(string: operaSchema! + host)
                    if operaURL != nil{
                        if UIApplication.shared.canOpenURL(operaURL!) {
                            let opera = TDAlertAction.handlerSavingAlertAction(title: "Opera".localized,
                                                                               style: .default,
                                                                               completionHandler: {
                                                                                (alert: UIAlertAction!) -> Void in
                                                                                UIApplication.shared.open(operaURL!,
                                                                                                          options: [:],
                                                                                                          completionHandler: nil)
                            })
                            actionArray.append(opera)
                        }
                    }
                }
            }
            
            
            if actionArray.count == 0 { return }
            if actionArray.count == 1 {
                let action = actionArray[0]
                if let handler = action.completionHandler{
                    handler(action)
                    return
                }
            }
            actionArray.forEach{actionSheet.addAction($0)}
            
            actionSheet.addAction(UIAlertAction(title: "Cancel".localized,
                                                style: .cancel,
                                                handler: nil))
            
            guard let topViewController = UIApplication.topViewController() else { return }
            topViewController.present(actionSheet, animated: true, completion: nil)
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
        
        var width : CGFloat{
            return  UIScreen.main.bounds.size.width
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
        
        
    }
    
    
    struct Timer{
        
        /// A simple count down timer using RxSwift
        ///
        /// - Parameters:
        ///   - from: Start value
        ///   - to: end value
        /// - Returns: Observable of the countDown
        static func countDown(from: Int,
                              to: Int,
                              interval : Double)
            -> Observable<Int> {
                return Observable<Int>
                    .timer( 1, period: interval, scheduler: MainScheduler.instance)
                    .take(from - to + 1)
                    .map { from - $0 }
        }
    }
    
    struct Storage {
        static func deviceRemainingFreeSpaceInBytes() -> Int64? {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
            guard
                let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
                let freeSize = systemAttributes[.systemFreeSize] as? NSNumber
                else {
                    // something failed
                    return nil
            }
            return freeSize.int64Value
        }
        
        static func deviceTotalSpaceInBytes() -> Int64? {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
            guard
                let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
                let freeSize = systemAttributes[.systemSize] as? NSNumber
                else {
                    // something failed
                    return nil
            }
            return freeSize.int64Value
        }
    }
}
