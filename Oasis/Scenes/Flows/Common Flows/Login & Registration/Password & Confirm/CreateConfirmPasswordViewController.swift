//
//  CreateConfirmPasswordViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol CreateConfirmPasswordViewControllerOutput {
    func register(password: String) -> Single<Void>
}

class CreateConfirmPasswordViewController: BaseViewController {
    
    var interactor: CreateConfirmPasswordViewControllerOutput?
    var router: CreateConfirmPasswordRouter?
    
    
//    private let backgroundImage: UIImageView = {
//        let imageV = UIImageView()
//        imageV.translatesAutoresizingMaskIntoConstraints = false
//        imageV.image = R.image.newBackground()!
//        imageV.contentMode = .scaleAspectFill
//        return imageV
//    }()
    
    
    private lazy var mainStackView = {
        UIStackView()
            .axis(.vertical)
            .spacing(40)
            .autoLayout()
            .distributionMode(.fill)
    }()
    
    private lazy var createPasswordStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var confirmPasswordStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var newPasswordLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 35)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Please enter \nyour password".localized
        return label
    }()
    
    private lazy var confirmPasswordLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 35)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Confirm \nPassword".localized
        return label
    }()
    
    private lazy var newPasswordTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var confirmPasswordTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var registerButton : BaseButton = {
        let button = BaseButton()
        button.style = .init(titleFont: MainFont.bold.with(size: 16),
                           titleColor: .white,
                           backgroundColor: Constants.Colors.appGreen)
        button.roundCorners = .all(radius: 28)
        button.autoLayout()
        button.setTitle("Register".localized, for: .normal)
        button.onTap {
            self.validatePasswords()
        }
        return button
    }()
}

//MARK:- View Lifecycle
extension CreateConfirmPasswordViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CreateConfirmPasswordConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    fileprivate
    func setupUI(){
        addBackgroundImage()
        buildStacks()
        buildNewPasswordStack()
        buildConfirmPasswordStack()
        addRegisterButton()
    }
    
    private func addBackgroundImage(){
//        view.addSubview(backgroundImage)
//        NSLayoutConstraint.activate([
//            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        ])
        
        view.backgroundColor = Constants.Colors.appViolet
    }
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            //mainStackView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 8)
        ])
        mainStackView.addArrangedSubview(createPasswordStackview)
        mainStackView.addArrangedSubview(confirmPasswordStackview)
    }
    
    private func buildNewPasswordStack(){
        createPasswordStackview.addArrangedSubview(newPasswordLabel)
        createPasswordStackview.addArrangedSubview(newPasswordTextfield)
        
        newPasswordTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func buildConfirmPasswordStack(){
        confirmPasswordStackview.addArrangedSubview(confirmPasswordLabel)
        confirmPasswordStackview.addArrangedSubview(confirmPasswordTextfield)
        
        confirmPasswordTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func addRegisterButton(){
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 58),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66)
        ])
    }
    
    private func validatePasswords(){
        guard let newPass = newPasswordTextfield.text, !newPass.isEmpty else{
            showSimpleAlertView("Sorry", message: "Please enter your new password", withCompletionHandler: nil)
            return
        }
        
        guard let confirmPass = confirmPasswordTextfield.text, !confirmPass.isEmpty else{
            showSimpleAlertView("Sorry", message: "Please confirm your password", withCompletionHandler: nil)
            return
        }
        
        if newPass.count > 1 && confirmPass.count > 1 && newPass == confirmPass {
            subscribeForRegisteration(password: newPass)
        }else{
            showSimpleAlertView("Sorry", message: "Your passwords does not match", withCompletionHandler: nil)
        }
    }
}

//MARK:- NavBarAppearance
extension CreateConfirmPasswordViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
        
        let loginBarButton = UIBarButtonItem(title: "Login".localized, style: .plain, target: self, action: #selector(loginBarButtonPressed))
        loginBarButton.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font : MainFont.medium.with(size: 22)
            ], for: .normal)
        self.navigationItem.rightBarButtonItem = loginBarButton
    }
    
    @objc func loginBarButtonPressed(){
        self.router?.redirectToLogin()
    }
}

//MARK:- Callbacks
extension CreateConfirmPasswordViewController{
    fileprivate
    func subscribeForRegisteration(password: String){
        showLoadingProgress()
        self.interactor?.register(password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { _ in
                self.dismissProgress()
                self.router?.redirectToHome()
            }, onError: {(error) in
                self.dismissProgress()
                self.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
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


