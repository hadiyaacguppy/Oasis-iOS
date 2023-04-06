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
    
    private lazy var verifyButton : BaseButton = {
        let button = BaseButton()
        button.style = .init(titleFont: MainFont.bold.with(size: 18),
                             titleColor: .white,
                             backgroundColor: .clear)
        button.setTitle("Verify".localized, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
        addVerifyButton()
        addTopStaticLabel()
        addBackgroundImage()
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
            topStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 46),
            topStaticLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])
    }
    
    private func addVerifyButton(){
        view.addSubview(verifyButton)
        NSLayoutConstraint.activate([
            verifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            verifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 38),
            verifyButton.heightAnchor.constraint(equalToConstant: 58),
            verifyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 66)
        ])
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
        
        let verifyButtonTapped = Observable.combineLatest(firstOTPDigitValidation,secondOTPDigitValidation,thirdOTPDigitValidation,fourthOTPDigitValidation) { first,second,third,fourth in
            return first && second && third && fourth
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
