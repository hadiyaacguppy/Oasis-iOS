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

public struct Utilities  {
    
    /// calls a certain phone number. don't include tel://
    ///
    /// - Parameter pn: the phone number to call/ 96170777111
    static func call(phoneNumber pn : String){
        guard let number = URL(string: "tel://" + pn) else { return }
        UIApplication.shared.open(number)
    }
    
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
    
    static func canOpen(url : URL?)
        ->Bool{
            if url == nil { return false }
            return UIApplication.shared.canOpenURL(url!)
    }
    
    /// Opens a certain URL in safari
    ///
    /// - Parameter str: The url to open as string
    public static func openURL(withString str : String){
        if let url = URL(string: str){
            UIApplication.shared.open(url , options: [:], completionHandler: nil)
        }
    }
    
    
    
    /// Sends an email. Checks all available mail apps.
    ///
    /// - Parameters:
    ///   - to: recipient
    ///   - subject: the subject of the email
    ///   - content: the body of the email
    ///   - vc: the ViewController that will present the MailComposeViewController. IT SHOULD CONFORM TO MFMailComposeViewControllerDelegate
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
    
    /// A simple count down timer using RxSwift
    ///
    /// - Parameters:
    ///   - from: Start value
    ///   - to: end value
    /// - Returns: Observable of the countDown
    static func countDown(from: Int,
                          to: Int,
                          interval : Int)
        -> Observable<Int> {
            return Observable<Int>
                .interval(.seconds(1), scheduler: MainScheduler.instance)
                .take(from - to + 1)
                .map { from - $0 }
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
    
    // DO NOT use this on UIViewController. Rely on self.showLoading() instead
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
    
}
