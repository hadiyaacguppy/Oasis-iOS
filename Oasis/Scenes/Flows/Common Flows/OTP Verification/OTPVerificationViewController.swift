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
        return button
    }()
    
    private lazy var firstOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var secondOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var thirdOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var fourthOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var fifthOTPTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var pinStack = {
        UIStackView()
            .axis(.horizontal)
            .spacing(10)
            .autoLayout()
            .distributionMode(.fillEqually)
    }()
    
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
    
    private func addTopStaticLabel(){
        view.addSubview(topStaticLabel)
        NSLayoutConstraint.activate([
            topStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            topStaticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStaticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
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
}

//MARK:- NavBarAppearance
extension OTPVerificationViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
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
}
