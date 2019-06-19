//
//  PhoneContactService.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import ContactsUI



class PhoneContactsService: NSObject,CNContactPickerDelegate{
    
    
    /// The CNContact property keys to display in the contact detail card.
    /// If not set all properties are displayed.
    var displayedPropertyKeys: [String]?
    
    /// The predicate to determine if a contact is selectable in the list.
    /// If not set all contacts are selectable.
    var predicateForEnablingContact: NSPredicate? // e.g. emailAddresses.@count > 0
    
    /// The predicate to control the selection of a contact.
    /// It determines whether a selected contact should be returned (predicate evaluates to TRUE)
    /// or if the contact detail card should be displayed (evaluates to FALSE).
    /// If not set the picker displays the contact detail card when the contact is selected.
    var predicateForSelectionOfContact: NSPredicate? // e.g. emailAddresses.@count == 1
    
    
    /// The predicate to control the selection of a property.
    /// It determines whether a selected property should be returned (predicate evaluates to TRUE)
    /// or if the default action for the property should be performed (predicate evaluates to FALSE).
    /// If not set the picker returns the first selected property.
    /// The predicate is evaluated on the CNContactProperty that is being selected.
    var predicateForSelectionOfProperty: NSPredicate? // e.g. (key == 'emailAddresses') AND (value LIKE '*@apple.com')
    
    /// Called after a contact has been selected by the user.
    var didContactSelected : ((CNContact) -> ())?
    
    /// Called when picker dismissed
    var contactPickerWasDissmised : (() -> ())?
    
    /// Called when a property of the contact has been selected by the user.
    var didContactPropertySelected : (( CNContactProperty) -> () )?
    
    /// Called after contacts have been selected by the user.
    var didContactsSelected : (([CNContact]) -> ())?
    
    
    /// Create and open ContactPicker ViewController
    func openContactsPicker(){
        let contactVC = CNContactPickerViewController()
        contactVC.delegate = self
        DispatchQueue.main.async {
            if let topVc = UIApplication.topViewController(){
                topVc.present(contactVC, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    /// Request Access to contacts data and it will show a Alert that access is needed to continue
    /// If status is denied
    /// - Parameter completionHandler: Bool value that indicated if access granted or not. 
    func requestContactAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void){
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
            
        case .denied:
            DispatchQueue.main.async {
                self.showAlertContactAccessNeeded()
                completionHandler(false)
            }
        case .restricted, .notDetermined:
            let contactsStore = CNContactStore()
            contactsStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                        self.showAlertContactAccessNeeded()
                        completionHandler(false)
                    }
                }
            }
        @unknown default:
            return
        }
    }
    
    private
    func showAlertContactAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: Constants.PHContactService.alertTitle ,
            message: Constants.PHContactService.alertMessage,
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: Constants.PHContactService.alertCancelButtonTitle, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.PHContactService.alertOpenSettingsButtonTitle,
                                      style: .cancel,
                                      handler: { (alert) -> Void in
                                        UIApplication.shared.open(settingsAppURL,
                                                                  options: [:],
                                                                  completionHandler: nil)
        }))
        
        DispatchQueue.main.async {
            if let topVc = UIApplication.topViewController(){
                topVc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contact: CNContact) {
        self.didContactSelected?(contact)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contactProperty: CNContactProperty) {
        self.didContactPropertySelected?(contactProperty)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contacts: [CNContact]) {
        self.didContactsSelected?(contacts)
    }
    
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        DispatchQueue.main.async {
            if let topVc = UIApplication.topViewController(){
                topVc.dismiss(animated: true, completion: nil)
                self.contactPickerWasDissmised?()
            }
        }
    }
    
}
