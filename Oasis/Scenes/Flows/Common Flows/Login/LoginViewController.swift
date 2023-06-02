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
    func login(id : String, password : String) -> Single<Void>
}

class LoginViewController: BaseViewController {
    
    var interactor: LoginViewControllerOutput?
    var router: LoginRouter?
    
    
   /* private let backgroundImage: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = R.image.newBackground()!
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()*/
    
    /*private lazy var emailStackview = {
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
        label.font = MainFont.medium.with(size: 35)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "What is your Email?".localized
        return label
    }()
    
    private lazy var passwordLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 35)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Password".localized
        return label
    }()
    
    private lazy var emailTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.keyboardType = .emailAddress
        return txtf
    }()*/
    
    /*private lazy var passwordTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        txtf.isSecureTextEntry = true
        return txtf
    }()*/
    private lazy var mainStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var forgotPasswordView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private lazy var loginButton : OasisAquaButton = {
        let button = OasisAquaButton()
        button.setTitle("Login".localized, for: .normal)
        button.autoLayout()
        button.onTap {
            self.checkForValidation()
        }
        return button
    }()
    
    var emailView : TitleWithTextFieldView!
    var passwordView : TitleWithTextFieldView!
    
    var userEmail : String?
    var userPW : String?
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
        self.view.backgroundColor = Constants.Colors.appViolet
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
        addLoginButton()
        buildStacks()
        createTitlewithLabelViews()
        addForgotPwView()
    }
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10)
        ])
    }
    
    private func createTitlewithLabelViews(){
         emailView = TitleWithTextFieldView.init(requestTitle: "What is your Email?",
                                                    textsColor: .white,
                                                    usertext: "",
                                                    textSize: 35,
                                                    isAgeRequest: false,
                                                    labelHeight: 89)
        
         passwordView = TitleWithTextFieldView.init(requestTitle: "Password",
                                                    textsColor: .white,
                                                    usertext: "",
                                                    textSize: 35,
                                                    isAgeRequest: false,
                                                    labelHeight: 89)
        
        mainStackView.addArrangedSubview(emailView)
        mainStackView.addArrangedSubview(passwordView)
        
        emailView.anyTextField.delegate = self
        passwordView.anyTextField.delegate = self
        
        NSLayoutConstraint.activate([
            emailView.heightAnchor.constraint(equalToConstant: 160),
            passwordView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func addForgotPwView(){
        mainStackView.addArrangedSubview(forgotPasswordView)
        
        let fPasswordlabel = BaseLabel()
        fPasswordlabel.style = .init(font: MainFont.medium.with(size: 20), color: .white)
        fPasswordlabel.autoLayout()
        
        let whitelineView = BaseUIView()
        whitelineView.backgroundColor = .white
        whitelineView.autoLayout()
        
        forgotPasswordView.addSubview(fPasswordlabel)
        forgotPasswordView.addSubview(whitelineView)
        
        NSLayoutConstraint.activate([
//            forgotPasswordView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
//            forgotPasswordView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            forgotPasswordView.heightAnchor.constraint(equalToConstant: 50),
            forgotPasswordView.widthAnchor.constraint(equalToConstant: 182),
            
            fPasswordlabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            fPasswordlabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            fPasswordlabel.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            fPasswordlabel.heightAnchor.constraint(equalToConstant: 23),
            
            whitelineView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            whitelineView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            whitelineView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            whitelineView.heightAnchor.constraint(equalToConstant: 1)
        ])
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
    
    private func checkForValidation(){
        guard userEmail.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Email", withCompletionHandler: nil)
            return
        }
        guard userPW.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Password", withCompletionHandler: nil)
            return
        }
        
        subscribeForLogin()
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
        self.router?.redirectToSelectAge()
    }
    
}


extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == emailView{
            self.userEmail = textField.text
        }else{
            self.userPW = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
}

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
    
    private func subscribeForLogin(){
        self.interactor?.login(id: userEmail!, password: userPW!)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (user) in
                self!.display(successMessage: "You are Logged in Successfully")
                self!.router?.redirectToTabbarController()
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}

