//
//  OTPVerificationViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 03/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol OTPVerificationViewControllerOutput {
    
}

class OTPVerificationViewController: BaseViewController {
    
    var interactor: OTPVerificationViewControllerOutput?
    var router: OTPVerificationRouter?
    
    private lazy var topStaticLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 33), color: .white, numberOfLines: 3)
        label.text = "Please enter the otp sent to your mobile number".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = R.image.newBackground()!
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var verifyButton : WhiteBorderButton = {
        let button = WhiteBorderButton()
        button.setTitle("Verify".localized, for: .normal)
        button.onTap {
            self.router?.pushToCreatePassword()
        }
        return button
    }()
    
    private lazy var firstOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .numberPad
        txtf.delegate = self
        txtf.textAlignment = .center
        return txtf
    }()
    
    private lazy var secondOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .numberPad
        txtf.delegate = self
        txtf.textAlignment = .center
        return txtf
    }()
    
    private lazy var thirdOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .numberPad
        txtf.delegate = self
        txtf.textAlignment = .center
        return txtf
    }()
    
    private lazy var fourthOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .numberPad
        txtf.delegate = self
        txtf.textAlignment = .center
        return txtf
    }()
    
    private lazy var fifthOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .numberPad
        txtf.delegate = self
        txtf.textAlignment = .center
        return txtf
    }()
    
    private lazy var pinStack = {
        UIStackView()
            .axis(.horizontal)
            .spacing(10)
            .autoLayout()
            .distributionMode(.fillEqually)
    }()
    
    //    lazy var didntReceiveLabel : BaseLabel = {
    //        let lbl = BaseLabel()
    //        lbl.style = .init(font: MainFont.medium.with(size: 20), color: .white)
    //        lbl.text = "Didn't receive?".localized
    //        return lbl
    //    }()
    
    lazy var sendNewOTPLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.numberOfLines = 2

        let attributedString = NSMutableAttributedString(string: "Didn’t receive ?\nSend new OTP", attributes: [
            .font: MainFont.medium.with(size: 20),
            .foregroundColor: UIColor.white,
            .kern: 0.0
        ])
        attributedString.addAttribute(.font,
                                      value: MainFont.bold.with(size: 20),
                                      range: NSRange(location: 17, length: 12))
        
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 17, length: 12))
        lbl.attributedText = attributedString
        
        lbl.onTap {
            
        }
        return lbl
    }()
    
    fileprivate var pin : Int! {
        get {
            let pinString = firstPin! + secondPin! + thirdPin! + fourthPin!
            return Int(pinString)!
        }
    }
    
    fileprivate var firstPin : String?
    fileprivate var secondPin : String?
    fileprivate var thirdPin : String?
    fileprivate var fourthPin : String?
    fileprivate var fifthPin : String?
}

//MARK:- View Lifecycle
extension OTPVerificationViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        OTPVerificationConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        subscribeToOTPCompletion()
        subscribeToPinValue()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    fileprivate
    func setupUI(){
        addBackgroundImage()
        addVerifyButton()
        addTopStaticLabel()
        addTextfieldsStack()
        addSendNewOTPLabel()
    }
    
    private func addBackgroundImage(){
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func addVerifyButton(){
        view.addSubview(verifyButton)
        NSLayoutConstraint.activate([
            verifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyButton.heightAnchor.constraint(equalToConstant: 58),
            verifyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66)
        ])
    }
    
    private func addTopStaticLabel(){
        view.addSubview(topStaticLabel)
        NSLayoutConstraint.activate([
            topStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            topStaticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStaticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            topStaticLabel.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func addTextfieldsStack(){
        view.addSubview(pinStack)
        NSLayoutConstraint.activate([
            pinStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            pinStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinStack.heightAnchor.constraint(equalToConstant: 70),
            pinStack.topAnchor.constraint(equalTo: topStaticLabel.bottomAnchor, constant: 22)
        ])
        
        pinStack.addArrangedSubview(firstOTPTextfield)
        pinStack.addArrangedSubview(secondOTPTextfield)
        pinStack.addArrangedSubview(thirdOTPTextfield)
        pinStack.addArrangedSubview(fourthOTPTextfield)
        pinStack.addArrangedSubview(fifthOTPTextfield)
    }
    
    private func addSendNewOTPLabel(){
        view.addSubview(sendNewOTPLabel)
        NSLayoutConstraint.activate([
            sendNewOTPLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            //sendNewOTPLabel.heightAnchor.constraint(equalToConstant: 60),
            sendNewOTPLabel.topAnchor.constraint(equalTo: pinStack.bottomAnchor, constant: 22)
        ])
        
    }
}

//MARK:- NavBarAppearance
extension OTPVerificationViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension OTPVerificationViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
#warning("Retry Action does not set")
        }
    }
}


extension OTPVerificationViewController{
    fileprivate func subscribeToOTPCompletion(){
        
        let firstOTPDigitValidation = firstOTPTextfield
            .rx
            .textChanged
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        
        let secondOTPDigitValidation = secondOTPTextfield
            .rx
            .textChanged
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let thirdOTPDigitValidation = thirdOTPTextfield
            .rx
            .textChanged
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let fourthOTPDigitValidation = fourthOTPTextfield
            .rx
            .textChanged
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let fifthOTPDigitValidation = fifthOTPTextfield
            .rx
            .textChanged
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let verifyButtonTapped = Observable.combineLatest(firstOTPDigitValidation,secondOTPDigitValidation,thirdOTPDigitValidation,fourthOTPDigitValidation, fifthOTPDigitValidation) { first,second,third,fourth, fifth in
            return first && second && third && fourth && fifth
        }
        
        verifyButtonTapped
            .bind(to:
                    verifyButton
                .rx
                .isEnabledAndHighlighted
            )
            .disposed(by: disposeBag)
    }
    
    
    fileprivate func subscribeToPinValue(){
        self.firstOTPTextfield
            .rx
            .textChanged
            .subscribe(onNext : { value in
                if value != nil {
                    setValuForPin(0, value!)
                }
                
            })
            .disposed(by: disposeBag)
        
        self.secondOTPTextfield
            .rx
            .textChanged
            .subscribe(onNext : { value in
                if value != nil {
                    setValuForPin(1, value!)
                }
                
            })
            .disposed(by: disposeBag)
        
        self.thirdOTPTextfield
            .rx
            .textChanged
            .subscribe(onNext : { value in
                if value != nil {
                    setValuForPin(2, value!)
                }
                
            })
            .disposed(by: disposeBag)
        
        
        self.fourthOTPTextfield
            .rx
            .textChanged
            .subscribe(onNext : { value in
                if value != nil {
                    setValuForPin(3, value!)
                }
                
            })
            .disposed(by: disposeBag)
        
        self.fifthOTPTextfield
            .rx
            .textChanged
            .subscribe(onNext : { value in
                if value != nil {
                    setValuForPin(4, value!)
                }
                
            })
            .disposed(by: disposeBag)
        
        func setValuForPin(_ index : Int ,_ value : String){
            switch index {
            case 0:
                self.firstPin = value
            case 1:
                self.secondPin = value
            case 2:
                self.thirdPin = value
            case 3:
                self.fourthPin = value
            case 4:
                self.fifthPin = value
            default:
                return
            }
        }
    }
}

extension OTPVerificationViewController : UITextFieldDelegate {
  
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool {
            
            if (textField.text!.count < 1) && (string.count > 0) {
                if textField == firstOTPTextfield {
                    secondOTPTextfield.becomeFirstResponder()
                }
                if textField == secondOTPTextfield {
                    thirdOTPTextfield.becomeFirstResponder()
                }
                if textField == thirdOTPTextfield {
                    fourthOTPTextfield.becomeFirstResponder()
                }
                if textField == fourthOTPTextfield {
                    fifthOTPTextfield.becomeFirstResponder()
                }
                if textField == fifthOTPTextfield {
                    fifthOTPTextfield.resignFirstResponder()
                }
                textField.text = string
                return false
            } else if ((textField.text!.count >= 1) && string.count == 0 ) {
                if textField == secondOTPTextfield {
                    firstOTPTextfield.becomeFirstResponder()
                }
                if textField == thirdOTPTextfield {
                    secondOTPTextfield.becomeFirstResponder()
                }
                if textField == fourthOTPTextfield {
                    thirdOTPTextfield.becomeFirstResponder()
                }
                if textField == fifthOTPTextfield {
                    fourthOTPTextfield.becomeFirstResponder()
                }
                if textField == firstOTPTextfield {
                    firstOTPTextfield.resignFirstResponder()
                }
                
                textField.text = ""
                return false
            } else if textField.text!.count >= 1 {
                textField.text = string
                return false
            }
            return true
    }
    
}