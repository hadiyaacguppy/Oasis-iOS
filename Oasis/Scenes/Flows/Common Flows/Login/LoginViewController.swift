//
//  LoginViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginViewControllerOutput {
    
}

class LoginViewController: BaseViewController {
    
    var interactor: LoginViewControllerOutput?
    var router: LoginRouter?
    
    
    private let backgroundImage: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = R.image.newBackground()!
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var mainStackView = {
        UIStackView()
            .axis(.vertical)
            .spacing(40)
            .autoLayout()
            .distributionMode(.fill)
    }()
    
    private lazy var emailStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var passwordStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var emailLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 22)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Email".localized
        return label
    }()
    
    private lazy var passwordLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 22)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Password".localized
        return label
    }()
    
    private lazy var emailTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .emailAddress
        return txtf
    }()
    
    private lazy var passwordTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.isSecureTextEntry = true
        return txtf
    }()
    
    private lazy var loginButton : WhiteBorderButton = {
        let button = WhiteBorderButton()
        button.setTitle("Login".localized, for: .normal)
        button.onTap {
            self.router?.redirectToHome()
        }
        return button
    }()
}

//MARK:- View Lifecycle
extension LoginViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LoginConfigurator.shared.configure(viewController: self)
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
        buildEmailStack()
        buildPasswordStack()
        addLoginButton()
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
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            //mainStackView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 8)
        ])
        mainStackView.addArrangedSubview(emailStackview)
        mainStackView.addArrangedSubview(passwordStackview)
    }
    
    private func buildEmailStack(){
        emailStackview.addArrangedSubview(emailLabel)
        emailStackview.addArrangedSubview(emailTextfield)
        
        emailTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func buildPasswordStack(){
        passwordStackview.addArrangedSubview(passwordLabel)
        passwordStackview.addArrangedSubview(passwordTextfield)
        
        passwordTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func addLoginButton(){
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 58),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66)
        ])
    }
}

//MARK:- NavBarAppearance
extension LoginViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
        
        let registerBarButton = UIBarButtonItem(title: "Register".localized, style: .plain, target: self, action: #selector(registerBarButtonPressed))
        registerBarButton.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font : MainFont.medium.with(size: 22)
            ], for: .normal)
        self.navigationItem.rightBarButtonItem = registerBarButton
    }
    
    @objc func registerBarButtonPressed(){
        self.router?.redirectToRegistration()
    }}

//MARK:- Callbacks
extension LoginViewController{
    
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


