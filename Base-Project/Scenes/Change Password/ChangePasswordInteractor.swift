//
//  ChangePasswordInteractor.swift
//  Base-Project
//
//  Created by Mhmd Rizk on 10/19/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation
import RxSwift

protocol ChangePasswordInteractorInput {
    
}

protocol ChangePasswordInteractorOutput {
    
    func apiCallFailed(withError error : ErrorResponse) -> ErrorViewModel
    
}

protocol ChangePasswordDataSource {
    
}

protocol ChangePasswordDataDestination {
    
}

class ChangePasswordInteractor: ChangePasswordInteractorInput, ChangePasswordDataSource, ChangePasswordDataDestination {
    
    var output: ChangePasswordInteractorOutput?
    
    // MARK: Business logic
    
    var currentPassword : String?
    
    var newPassword : String?
    
    var confirmationNewPassword : String?
    
    
    
}

extension ChangePasswordInteractor: ChangePasswordViewControllerOutput, ChangePasswordRouterDataSource, ChangePasswordRouterDataDestination {
    
    
    func saveButtonTapped() {
        guard currentPassword != nil else{
            Utilities.ProgressHUD.showError(withMessage: "Please enter your current password first.".localized)
            return
        }
        
        guard newPassword != nil else{
            Utilities.ProgressHUD.showError(withMessage: "Please enter your new password first.".localized)
            return
        }
        
        guard confirmationNewPassword != nil, newPassword == confirmationNewPassword else{
            Utilities.ProgressHUD.showError(withMessage: "You must enter the same password twice in order \nto confirm it.".localized)
            return
        }
        
        
        /*fetch passwords here !!*/
        

    }
    
    func currentPasswordTextFieldValue(_ text: String) {
        self.currentPassword = text
    }
    
    func newPasswordTextFieldValue(_ text: String) {
        self.newPassword = text
    }
    
    func confirmationPasswordTextFieldValue(_ text: String) {
        self.confirmationNewPassword = text
    }
    
    
    func viewDidFinishedLoading(){
        
    }
    
    func retryLoadingRequested(){
        
    }
}
