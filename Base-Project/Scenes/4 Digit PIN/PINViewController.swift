//
//  PINViewController.swift
//  Base-Project
//
//  Created by Hadi on 1/22/19.
//  Copyright (c) 2019 Tedmob. All rights reserved.
//

//

import UIKit
import RxSwift

protocol PINViewControllerInput {

}

protocol PINViewControllerOutput {
    
    func viewDidFinishedLoading()
    
    func retryLoadingRequested()
}

class PINViewController: BaseViewController, PINViewControllerInput {

    var output: PINViewControllerOutput?
    var router: PINRouter?

    // MARK: IBOutlets

    @IBOutlet weak var topInformativeLabel: UILabel!{
        didSet{
            topInformativeLabel.text = "Please Enter your PIN Code".localized
            topInformativeLabel.textColor = .black
            topInformativeLabel.font = Constants.Fonts.boldSubheadline
        }
    }
    
    @IBOutlet weak var firstBottomView: UIView!{
        didSet{
            firstBottomView.backgroundColor = Constants.Colors.appColor
        }
    }
    @IBOutlet weak var secondBottomView: UIView!{
        didSet{
            secondBottomView.backgroundColor = Constants.Colors.appColor
        }
    }
    @IBOutlet weak var thirdBottomView: UIView!{
        didSet{
            thirdBottomView.backgroundColor = Constants.Colors.appColor
        }
    }
    @IBOutlet weak var fourBottomView: UIView!{
        didSet{
            fourBottomView.backgroundColor = Constants.Colors.appColor
        }
    }
    
    @IBOutlet weak var firstTxtField: UITextField!{
        didSet{
            firstTxtField.font = UIFont.boldSystemFont(ofSize: 20.0)
            firstTxtField.delegate = self
            firstTxtField.keyboardType = .numberPad
            firstTxtField.addToolBar()
        }
    }
    @IBOutlet weak var secondTxtfield: UITextField!{
        didSet{
            secondTxtfield.font = UIFont.boldSystemFont(ofSize: 20.0)
            secondTxtfield.delegate = self
            secondTxtfield.keyboardType = .numberPad
            secondTxtfield.addToolBar()
        }
    }
    @IBOutlet weak var thirdTxtfield: UITextField!{
        didSet{
            thirdTxtfield.font = UIFont.boldSystemFont(ofSize: 20.0)
            thirdTxtfield.delegate = self
            thirdTxtfield.keyboardType = .numberPad
            thirdTxtfield.addToolBar()
        }
    }
    @IBOutlet weak var fourthTxtfield: UITextField!{
        didSet{
            fourthTxtfield.font = UIFont.boldSystemFont(ofSize: 20.0)
            fourthTxtfield.delegate = self
            fourthTxtfield.keyboardType = .numberPad
            fourthTxtfield.addToolBar()
        }
    }
    
    @IBOutlet weak var enterButton: UIButton!{
        didSet{
            enterButton.setTitle("Confirm".localized, for: .normal)
        }
    }
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PINConfigurator.shared.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        output?.viewDidFinishedLoading()
        setupRetryFetchingCallBack()
        self.title = "Verification".localized
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
    
    // MARK: IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        guard sender.text?.count != 0 else {
            if sender.tag != 1{
                self.view.viewWithTag(sender.tag - 1)!.becomeFirstResponder()
            }
            return
        }
        
        if sender.text?.count == 1 && sender.tag != 4{
            self.view.viewWithTag(sender.tag + 1)!.becomeFirstResponder()
        }
        if sender.tag == 4 && sender.text?.count == 1 {
            sender.resignFirstResponder()
        }
    }
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        
    }
}
extension PINViewController: PINPresenterOutput {

}

extension PINViewController: UITextFieldDelegate {
    // MARK: UITextfield Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstTxtField {
            self.secondTxtfield.becomeFirstResponder()
            return true
        }
        if textField == secondTxtfield{
            self.thirdTxtfield.becomeFirstResponder()
            return true
        }
        if textField == thirdTxtfield {
            self.fourthTxtfield.becomeFirstResponder()
            return true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
            // Backspace
            return true
        }
        else {
            // Text
            if textField.text!.count == 0 {
                // Textfield is empty
                return true
            }
            else if textField.text!.count == 1{
                // Textfield has a value
                // New value shouldn't be appended
                textField.text = string
                return false
            } else{
                return true
            }
        }
    }
}

