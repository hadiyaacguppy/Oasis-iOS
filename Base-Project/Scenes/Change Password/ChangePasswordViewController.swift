//
//  ChangePasswordViewController.swift
//  Base-Project
//
//  Created by Mhmd Rizk on 10/19/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//
import UIKit
import RxSwift
import RxGesture
protocol ChangePasswordViewControllerInput {

}

protocol ChangePasswordViewControllerOutput {
    
    func viewDidFinishedLoading()
    
    func retryLoadingRequested()
    
    func saveButtonTapped()

    func currentPasswordTextFieldValue(_ text : String)
    
    func newPasswordTextFieldValue(_ text : String)
    
    func confirmationPasswordTextFieldValue(_ text : String)
    
}



class ChangePasswordViewController: BaseTableViewController, ChangePasswordViewControllerInput {
    
    @IBOutlet weak var currentPasswordTextField: UITextField!{
        didSet{
            currentPasswordTextField.delegate = self
            currentPasswordTextField.becomeFirstResponder()
            currentPasswordTextField
                .rx
                .controlEvent(.editingChanged)
                .withLatestFrom(currentPasswordTextField.rx.text.orEmpty)
                .subscribe(onNext: { (text) in
                    self.output?.currentPasswordTextFieldValue(text)
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var newPasswordTextField: UITextField!{
        didSet{
            newPasswordTextField.delegate = self
            newPasswordTextField
                .rx
                .controlEvent(.editingChanged)
                .withLatestFrom(newPasswordTextField.rx.text.orEmpty)
                .subscribe(onNext: { (text) in
                    self.output?.newPasswordTextFieldValue(text)
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var confirmationPasswordTextField: UITextField!{
        didSet{
            confirmationPasswordTextField.delegate = self
            confirmationPasswordTextField
                .rx
                .controlEvent(.editingChanged)
                .withLatestFrom(confirmationPasswordTextField.rx.text.orEmpty)
                .subscribe(onNext: { (text) in
                    self.output?.confirmationPasswordTextFieldValue(text)
                })
                .disposed(by: disposeBag)
            
        }
    }
    
    @IBOutlet weak var showCurrentPasswordButton: UIButton!{
        didSet{
            showCurrentPasswordButton
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext : {_ in
                    self.showCurrentPasswordButtonTapped(self.showCurrentPasswordButton)
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var showNewPasswordButton: UIButton!{
        didSet{
            showNewPasswordButton
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext : {_ in
                    self.showNewPasswordButtonTapped(self.showNewPasswordButton)
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var showConfirmationPasswordButton: UIButton!{
        didSet{
            showConfirmationPasswordButton
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext : { _ in
                    self.showConfirmationPasswordButtonTapped(self.showConfirmationPasswordButton)
                })
                .disposed(by: disposeBag)
        }
    }
    

    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext : { _ in
                    self.output?.saveButtonTapped()
                })
                .disposed(by: self.disposeBag )
        }
    }
    
    
    var output: ChangePasswordViewControllerOutput?
    var router: ChangePasswordRouter?

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        ChangePasswordConfigurator.shared.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change Password"
        output?.viewDidFinishedLoading()
        setupRetryFetchingCallBack()
    }
    
    // MARK: Requests
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = {
            
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            
            self.output?.retryLoadingRequested()
        }
    }
    
    
    
    
    // MARK: Display logic
    
    fileprivate func showCurrentPasswordButtonTapped(_ sender : UIButton){
        if sender.imageView?.image == UIImage(named : "RegistrationNotView") {
            sender.setImage(UIImage(named : "RegistrationView")!, for: .normal)
            self.currentPasswordTextField.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named : "RegistrationNotView")!, for: .normal)
            self.currentPasswordTextField.isSecureTextEntry = true
        }
    }
    
    fileprivate func showNewPasswordButtonTapped(_ sender : UIButton){
        if sender.imageView?.image == UIImage(named : "RegistrationNotView") {
            sender.setImage(UIImage(named : "RegistrationView")!, for: .normal)
            self.newPasswordTextField.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named : "RegistrationNotView")!, for: .normal)
            self.newPasswordTextField.isSecureTextEntry = true
        }
    }
    
    fileprivate func showConfirmationPasswordButtonTapped(_ sender : UIButton){
        if sender.imageView?.image == UIImage(named : "RegistrationNotView") {
            sender.setImage(UIImage(named : "RegistrationView")!, for: .normal)
            self.confirmationPasswordTextField.isSecureTextEntry = false
        }else{
            sender.setImage(UIImage(named : "RegistrationNotView")!, for: .normal)
            self.confirmationPasswordTextField.isSecureTextEntry = true
        }
    }


}
extension ChangePasswordViewController: ChangePasswordPresenterOutput {
    
}


extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



